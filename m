From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 20 May 2017 23:42:53 +0200
Subject: [PATCH 4/5 v2] dma: pl08x: Add support for Faraday Technology
 FTDMAC020
In-Reply-To: <20170520214254.21541-1-linus.walleij@linaro.org>
References: <20170520214254.21541-1-linus.walleij@linaro.org>
Message-ID: <20170520214254.21541-4-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After reading the specs for the Faraday Technology FTDMAC020 found
in the Gemini platform, it becomes pretty evident that this is just
another PL08x derivative, and should be handled like such by simply
extending the existing PL08x driver to handle the quirks in this
hardware.

This patch makes memcpy work and has been tested on the Gemini and
also regression-tested on the Nomadik NHK15 using dmatest with
10 threads per channel without a hinch for hours.

I have not implemented slave DMA in those codepaths, because this
device (Gemini) does not use slave DMA, and it seems like devices
using FTDMAC020 for device DMA have a slightly different register
layout so some real hardware is needed to proceed with this. I
left some FIXME etc in the code for this.

I had to do some refactorings of some helper functions, but I have
not split those into separate patches because these refactorings
do not make much sense without the increased complexity of handling
the FTDMAC020.

The DMA test would hang the platform on me on the Gemini after a
few thousand iterations, however after turning of the caches the
problem immediately disappeared and I could run the DMA engine
with 10 threads pers physical channel for days in a row without
a crash. I think there is no problem with the DMA driver: instead
it is something fishy in the FA526 cache handling code that get
pretty heavily exercised by the DMA engine and we need to go and
fix that instead.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- No changes, just reposting.
---
 drivers/dma/Kconfig        |   6 +-
 drivers/dma/amba-pl08x.c   | 767 ++++++++++++++++++++++++++++++++++++---------
 include/linux/amba/pl080.h |  83 ++++-
 3 files changed, 698 insertions(+), 158 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 24e8597b2c3e..67ab15aa98c3 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -62,8 +62,10 @@ config AMBA_PL08X
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-	  Platform has a PL08x DMAC device
-	  which can provide DMA engine support
+	  Say yes if your platform has a PL08x DMAC device which can
+	  provide DMA engine support. This includes the original ARM
+	  PL080 and PL081, Samsungs PL080 derivative and Faraday
+	  Technology's FTDMAC020 PL080 derivative.
 
 config AMCC_PPC440SPE_ADMA
 	tristate "AMCC PPC440SPe ADMA support"
diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 6ddb029dac50..13cc95c0474c 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1,9 +1,10 @@
 /*
  * Copyright (c) 2006 ARM Ltd.
  * Copyright (c) 2010 ST-Ericsson SA
+ * Copyirght (c) 2017 Linaro Ltd.
  *
  * Author: Peter Pearse <peter.pearse@arm.com>
- * Author: Linus Walleij <linus.walleij@stericsson.com>
+ * Author: Linus Walleij <linus.walleij@linaro.org>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the Free
@@ -110,11 +111,12 @@ struct pl08x_driver_data;
  * @channels: the number of channels available in this variant
  * @signals: the number of request signals available from the hardware
  * @dualmaster: whether this version supports dual AHB masters or not.
- * @nomadik: whether the channels have Nomadik security extension bits
- *	that need to be checked for permission before use and some registers are
- *	missing
- * @pl080s: whether this version is a PL080S, which has separate register and
- *	LLI word for transfer size.
+ * @nomadik: whether this variant is a ST Microelectronics Nomadik, where the
+ *	channels have Nomadik security extension bits that need to be checked
+ *	for permission before use and some registers are missing
+ * @pl080s: whether this variant is a Samsung PL080S, which has separate
+ *	register and LLI word for transfer size.
+ * @ftdmac020: whether this variant is a Faraday Technology FTDMAC020
  * @max_transfer_size: the maximum single element transfer size for this
  *	PL08x variant.
  */
@@ -125,6 +127,7 @@ struct vendor_data {
 	bool dualmaster;
 	bool nomadik;
 	bool pl080s;
+	bool ftdmac020;
 	u32 max_transfer_size;
 };
 
@@ -148,19 +151,34 @@ struct pl08x_bus_data {
  * @id: physical index to this channel
  * @base: memory base address for this physical channel
  * @reg_config: configuration address for this physical channel
+ * @reg_control: control address for this physical channel
+ * @reg_src: transfer source address register
+ * @reg_dst: transfer destination address register
+ * @reg_lli: transfer LLI address register
+ * @reg_busy: if the variant has a special per-channel busy register,
+ * this contains a pointer to it
  * @lock: a lock to use when altering an instance of this struct
  * @serving: the virtual channel currently being served by this physical
  * channel
  * @locked: channel unavailable for the system, e.g. dedicated to secure
  * world
+ * @ftdmac020: channel is on a FTDMAC020
+ * @pl080s: channel is on a PL08s
  */
 struct pl08x_phy_chan {
 	unsigned int id;
 	void __iomem *base;
 	void __iomem *reg_config;
+	void __iomem *reg_control;
+	void __iomem *reg_src;
+	void __iomem *reg_dst;
+	void __iomem *reg_lli;
+	void __iomem *reg_busy;
 	spinlock_t lock;
 	struct pl08x_dma_chan *serving;
 	bool locked;
+	bool ftdmac020;
+	bool pl080s;
 };
 
 /**
@@ -362,10 +380,24 @@ static int pl08x_phy_channel_busy(struct pl08x_phy_chan *ch)
 {
 	unsigned int val;
 
+	/* If we have a special busy register, take a shortcut */
+	if (ch->reg_busy) {
+		val = readl(ch->reg_busy);
+		return !!(val & BIT(ch->id));
+	}
 	val = readl(ch->reg_config);
 	return val & PL080_CONFIG_ACTIVE;
 }
 
+/*
+ * pl08x_write_lli() - Write an LLI into the DMA controller.
+ *
+ * The PL08x derivatives support linked lists, but the first item of the
+ * list containing the source, destination, control word and next LLI is
+ * ignored. Instead the driver has to write those values directly into the
+ * SRC, DST, LLI and control registers. On FTDMAC020 also the SIZE
+ * register need to be set up for the first transfer.
+ */
 static void pl08x_write_lli(struct pl08x_driver_data *pl08x,
 		struct pl08x_phy_chan *phychan, const u32 *lli, u32 ccfg)
 {
@@ -383,11 +415,112 @@ static void pl08x_write_lli(struct pl08x_driver_data *pl08x,
 			phychan->id, lli[PL080_LLI_SRC], lli[PL080_LLI_DST],
 			lli[PL080_LLI_LLI], lli[PL080_LLI_CCTL], ccfg);
 
-	writel_relaxed(lli[PL080_LLI_SRC], phychan->base + PL080_CH_SRC_ADDR);
-	writel_relaxed(lli[PL080_LLI_DST], phychan->base + PL080_CH_DST_ADDR);
-	writel_relaxed(lli[PL080_LLI_LLI], phychan->base + PL080_CH_LLI);
-	writel_relaxed(lli[PL080_LLI_CCTL], phychan->base + PL080_CH_CONTROL);
+	writel_relaxed(lli[PL080_LLI_SRC], phychan->reg_src);
+	writel_relaxed(lli[PL080_LLI_DST], phychan->reg_dst);
+	writel_relaxed(lli[PL080_LLI_LLI], phychan->reg_lli);
 
+	/*
+	 * The FTMAC020 has a different layout in the CCTL word of the LLI
+	 * and the CCTL register which is split in CSR and SIZE registers.
+	 * Convert the LLI item CCTL into the proper values to write into
+	 * the CSR and SIZE registers.
+	 */
+	if (phychan->ftdmac020) {
+		u32 llictl = lli[PL080_LLI_CCTL];
+		u32 val = 0;
+
+		/* Write the transfer size (12 bits) to the size register */
+		writel_relaxed(llictl & FTDMAC020_LLI_TRANSFER_SIZE_MASK,
+			       phychan->base + FTDMAC020_CH_SIZE);
+		/*
+		 * Then write the control bits 28..16 to the control register
+		 * by shuffleing the bits around to where they are in the
+		 * main register. The mapping is as follows:
+		 * Bit 28: TC_MSK - mask on all except last LLI
+		 * Bit 27..25: SRC_WIDTH
+		 * Bit 24..22: DST_WIDTH
+		 * Bit 21..20: SRCAD_CTRL
+		 * Bit 19..17: DSTAD_CTRL
+		 * Bit 17: SRC_SEL
+		 * Bit 16: DST_SEL
+		 */
+		if (llictl & FTDMAC020_LLI_TC_MSK)
+			val |= FTDMAC020_CH_CSR_TC_MSK;
+		val |= ((llictl  & FTDMAC020_LLI_SRC_WIDTH_MSK) >>
+			(FTDMAC020_LLI_SRC_WIDTH_SHIFT -
+			 FTDMAC020_CH_CSR_SRC_WIDTH_SHIFT));
+		val |= ((llictl  & FTDMAC020_LLI_DST_WIDTH_MSK) >>
+			(FTDMAC020_LLI_DST_WIDTH_SHIFT -
+			 FTDMAC020_CH_CSR_DST_WIDTH_SHIFT));
+		val |= ((llictl  & FTDMAC020_LLI_SRCAD_CTL_MSK) >>
+			(FTDMAC020_LLI_SRCAD_CTL_SHIFT -
+			 FTDMAC020_CH_CSR_SRCAD_CTL_SHIFT));
+		val |= ((llictl  & FTDMAC020_LLI_DSTAD_CTL_MSK) >>
+			(FTDMAC020_LLI_DSTAD_CTL_SHIFT -
+			 FTDMAC020_CH_CSR_DSTAD_CTL_SHIFT));
+		if (llictl & FTDMAC020_LLI_SRC_SEL)
+			val |= FTDMAC020_CH_CSR_SRC_SEL;
+		if (llictl & FTDMAC020_LLI_DST_SEL)
+			val |= FTDMAC020_CH_CSR_DST_SEL;
+
+		/*
+		 * Set up the bits that exist in the CSR but are not
+		 * part the LLI, i.e. only gets written to the control
+		 * register right here.
+		 *
+		 * FIXME: do not just handle memcpy, also handle slave DMA.
+		 */
+		switch (pl08x->pd->memcpy_burst_size) {
+		default:
+		case PL08X_BURST_SZ_1:
+			val |= PL080_BSIZE_1 <<
+				FTDMAC020_CH_CSR_SRC_SIZE_SHIFT;
+			break;
+		case PL08X_BURST_SZ_4:
+			val |= PL080_BSIZE_4 <<
+				FTDMAC020_CH_CSR_SRC_SIZE_SHIFT;
+			break;
+		case PL08X_BURST_SZ_8:
+			val |= PL080_BSIZE_8 <<
+				FTDMAC020_CH_CSR_SRC_SIZE_SHIFT;
+			break;
+		case PL08X_BURST_SZ_16:
+			val |= PL080_BSIZE_16 <<
+				FTDMAC020_CH_CSR_SRC_SIZE_SHIFT;
+			break;
+		case PL08X_BURST_SZ_32:
+			val |= PL080_BSIZE_32 <<
+				FTDMAC020_CH_CSR_SRC_SIZE_SHIFT;
+			break;
+		case PL08X_BURST_SZ_64:
+			val |= PL080_BSIZE_64 <<
+				FTDMAC020_CH_CSR_SRC_SIZE_SHIFT;
+			break;
+		case PL08X_BURST_SZ_128:
+			val |= PL080_BSIZE_128 <<
+				FTDMAC020_CH_CSR_SRC_SIZE_SHIFT;
+			break;
+		case PL08X_BURST_SZ_256:
+			val |= PL080_BSIZE_256 <<
+				FTDMAC020_CH_CSR_SRC_SIZE_SHIFT;
+			break;
+		}
+
+		/* Protection flags */
+		if (pl08x->pd->memcpy_prot_buff)
+			val |= FTDMAC020_CH_CSR_PROT2;
+		if (pl08x->pd->memcpy_prot_cache)
+			val |= FTDMAC020_CH_CSR_PROT3;
+		/* We are the kernel, so we are in privileged mode */
+		val |= FTDMAC020_CH_CSR_PROT1;
+
+		writel_relaxed(val, phychan->reg_control);
+	} else {
+		/* Bits are just identical */
+		writel_relaxed(lli[PL080_LLI_CCTL], phychan->reg_control);
+	}
+
+	/* Second control word on the PL080s */
 	if (pl08x->vd->pl080s)
 		writel_relaxed(lli[PL080S_LLI_CCTL2],
 				phychan->base + PL080S_CH_CONTROL2);
@@ -425,11 +558,25 @@ static void pl08x_start_next_txd(struct pl08x_dma_chan *plchan)
 		cpu_relax();
 
 	/* Do not access config register until channel shows as inactive */
-	val = readl(phychan->reg_config);
-	while ((val & PL080_CONFIG_ACTIVE) || (val & PL080_CONFIG_ENABLE))
+	if (phychan->ftdmac020) {
+		val = readl(phychan->reg_config);
+		while (val & FTDMAC020_CH_CFG_BUSY)
+			val = readl(phychan->reg_config);
+
+		val = readl(phychan->reg_control);
+		while (val & FTDMAC020_CH_CSR_EN)
+			val = readl(phychan->reg_control);
+
+		writel(val | FTDMAC020_CH_CSR_EN,
+		       phychan->reg_control);
+	} else {
 		val = readl(phychan->reg_config);
+		while ((val & PL080_CONFIG_ACTIVE) ||
+		       (val & PL080_CONFIG_ENABLE))
+			val = readl(phychan->reg_config);
 
-	writel(val | PL080_CONFIG_ENABLE, phychan->reg_config);
+		writel(val | PL080_CONFIG_ENABLE, phychan->reg_config);
+	}
 }
 
 /*
@@ -447,6 +594,14 @@ static void pl08x_pause_phy_chan(struct pl08x_phy_chan *ch)
 	u32 val;
 	int timeout;
 
+	if (ch->ftdmac020) {
+		/* Use the enable bit on the FTDMAC020 */
+		val = readl(ch->reg_control);
+		val &= ~FTDMAC020_CH_CSR_EN;
+		writel(val, ch->reg_control);
+		return;
+	}
+
 	/* Set the HALT bit and wait for the FIFO to drain */
 	val = readl(ch->reg_config);
 	val |= PL080_CONFIG_HALT;
@@ -466,6 +621,14 @@ static void pl08x_resume_phy_chan(struct pl08x_phy_chan *ch)
 {
 	u32 val;
 
+	/* Use the enable bit on the FTDMAC020 */
+	if (ch->ftdmac020) {
+		val = readl(ch->reg_control);
+		val |= FTDMAC020_CH_CSR_EN;
+		writel(val, ch->reg_control);
+		return;
+	}
+
 	/* Clear the HALT bit */
 	val = readl(ch->reg_config);
 	val &= ~PL080_CONFIG_HALT;
@@ -481,25 +644,68 @@ static void pl08x_resume_phy_chan(struct pl08x_phy_chan *ch)
 static void pl08x_terminate_phy_chan(struct pl08x_driver_data *pl08x,
 	struct pl08x_phy_chan *ch)
 {
-	u32 val = readl(ch->reg_config);
+	u32 val;
+
+	/* The layout for the FTDMAC020 is different */
+	if (ch->ftdmac020) {
+		/* Disable all interrupts */
+		val = readl(ch->reg_config);
+		val |= (FTDMAC020_CH_CFG_INT_ABT_MASK |
+			FTDMAC020_CH_CFG_INT_ERR_MASK |
+			FTDMAC020_CH_CFG_INT_TC_MASK);
+		writel(val, ch->reg_config);
+
+		/* Abort and disable channel */
+		val = readl(ch->reg_control);
+		val &= ~FTDMAC020_CH_CSR_EN;
+		val |= FTDMAC020_CH_CSR_ABT;
+		writel(val, ch->reg_control);
+
+		/* Clear ABT and ERR interrupt flags */
+		writel(BIT(ch->id) | BIT(ch->id + 16),
+		       pl08x->base + PL080_ERR_CLEAR);
+		writel(BIT(ch->id), pl08x->base + PL080_TC_CLEAR);
 
+		return;
+	}
+
+	val = readl(ch->reg_config);
 	val &= ~(PL080_CONFIG_ENABLE | PL080_CONFIG_ERR_IRQ_MASK |
 		 PL080_CONFIG_TC_IRQ_MASK);
-
 	writel(val, ch->reg_config);
 
 	writel(BIT(ch->id), pl08x->base + PL080_ERR_CLEAR);
 	writel(BIT(ch->id), pl08x->base + PL080_TC_CLEAR);
 }
 
-static inline u32 get_bytes_in_cctl(u32 cctl)
+static u32 get_bytes_in_phy_channel(struct pl08x_phy_chan *ch)
 {
-	/* The source width defines the number of bytes */
-	u32 bytes = cctl & PL080_CONTROL_TRANSFER_SIZE_MASK;
+	u32 val;
+	u32 bytes;
+
+	if (ch->ftdmac020) {
+		bytes = readl(ch->base + FTDMAC020_CH_SIZE);
+
+		val = readl(ch->reg_control);
+		val &= FTDMAC020_CH_CSR_SRC_WIDTH_MSK;
+		val >>= FTDMAC020_CH_CSR_SRC_WIDTH_SHIFT;
+	} else if (ch->pl080s) {
+		val = readl(ch->base + PL080S_CH_CONTROL2);
+		bytes = val & PL080S_CONTROL_TRANSFER_SIZE_MASK;
 
-	cctl &= PL080_CONTROL_SWIDTH_MASK;
+		val = readl(ch->reg_control);
+		val &= PL080_CONTROL_SWIDTH_MASK;
+		val >>= PL080_CONTROL_SWIDTH_SHIFT;
+	} else {
+		/* Plain PL08x */
+		val = readl(ch->reg_control);
+		bytes = val & PL080_CONTROL_TRANSFER_SIZE_MASK;
+
+		val &= PL080_CONTROL_SWIDTH_MASK;
+		val >>= PL080_CONTROL_SWIDTH_SHIFT;
+	}
 
-	switch (cctl >> PL080_CONTROL_SWIDTH_SHIFT) {
+	switch (val) {
 	case PL080_WIDTH_8BIT:
 		break;
 	case PL080_WIDTH_16BIT:
@@ -512,14 +718,35 @@ static inline u32 get_bytes_in_cctl(u32 cctl)
 	return bytes;
 }
 
-static inline u32 get_bytes_in_cctl_pl080s(u32 cctl, u32 cctl1)
+static u32 get_bytes_in_lli(struct pl08x_phy_chan *ch, const u32 *llis_va)
 {
-	/* The source width defines the number of bytes */
-	u32 bytes = cctl1 & PL080S_CONTROL_TRANSFER_SIZE_MASK;
+	u32 val;
+	u32 bytes;
+
+	if (ch->ftdmac020) {
+		val = llis_va[PL080_LLI_CCTL];
+		bytes = val & FTDMAC020_LLI_TRANSFER_SIZE_MASK;
+
+		val = llis_va[PL080_LLI_CCTL];
+		val &= FTDMAC020_LLI_SRC_WIDTH_MSK;
+		val >>= FTDMAC020_LLI_SRC_WIDTH_SHIFT;
+	} else if (ch->pl080s) {
+		val = llis_va[PL080S_LLI_CCTL2];
+		bytes = val & PL080S_CONTROL_TRANSFER_SIZE_MASK;
+
+		val = llis_va[PL080_LLI_CCTL];
+		val &= PL080_CONTROL_SWIDTH_MASK;
+		val >>= PL080_CONTROL_SWIDTH_SHIFT;
+	} else {
+		/* Plain PL08x */
+		val = llis_va[PL080_LLI_CCTL];
+		bytes = val & PL080_CONTROL_TRANSFER_SIZE_MASK;
 
-	cctl &= PL080_CONTROL_SWIDTH_MASK;
+		val &= PL080_CONTROL_SWIDTH_MASK;
+		val >>= PL080_CONTROL_SWIDTH_SHIFT;
+	}
 
-	switch (cctl >> PL080_CONTROL_SWIDTH_SHIFT) {
+	switch (val) {
 	case PL080_WIDTH_8BIT:
 		break;
 	case PL080_WIDTH_16BIT:
@@ -554,15 +781,10 @@ static u32 pl08x_getbytes_chan(struct pl08x_dma_chan *plchan)
 	 * Follow the LLIs to get the number of remaining
 	 * bytes in the currently active transaction.
 	 */
-	clli = readl(ch->base + PL080_CH_LLI) & ~PL080_LLI_LM_AHB2;
+	clli = readl(ch->reg_lli) & ~PL080_LLI_LM_AHB2;
 
 	/* First get the remaining bytes in the active transfer */
-	if (pl08x->vd->pl080s)
-		bytes = get_bytes_in_cctl_pl080s(
-				readl(ch->base + PL080_CH_CONTROL),
-				readl(ch->base + PL080S_CH_CONTROL2));
-	else
-		bytes = get_bytes_in_cctl(readl(ch->base + PL080_CH_CONTROL));
+	bytes = get_bytes_in_phy_channel(ch);
 
 	if (!clli)
 		return bytes;
@@ -583,12 +805,7 @@ static u32 pl08x_getbytes_chan(struct pl08x_dma_chan *plchan)
 	llis_va_limit = llis_va + llis_max_words;
 
 	for (; llis_va < llis_va_limit; llis_va += pl08x->lli_words) {
-		if (pl08x->vd->pl080s)
-			bytes += get_bytes_in_cctl_pl080s(
-						llis_va[PL080_LLI_CCTL],
-						llis_va[PL080S_LLI_CCTL2]);
-		else
-			bytes += get_bytes_in_cctl(llis_va[PL080_LLI_CCTL]);
+		bytes += get_bytes_in_lli(ch, llis_va);
 
 		/*
 		 * A LLI pointer going backward terminates the LLI list
@@ -748,9 +965,30 @@ static void pl08x_phy_free(struct pl08x_dma_chan *plchan)
  * LLI handling
  */
 
-static inline unsigned int pl08x_get_bytes_for_cctl(unsigned int coded)
+static inline unsigned int
+pl08x_get_bytes_for_lli(struct pl08x_driver_data *pl08x,
+			u32 cctl,
+			bool source)
 {
-	switch (coded) {
+	u32 val;
+
+	if (pl08x->vd->ftdmac020) {
+		if (source)
+			val = (cctl & FTDMAC020_LLI_SRC_WIDTH_MSK) >>
+				FTDMAC020_LLI_SRC_WIDTH_SHIFT;
+		else
+			val = (cctl & FTDMAC020_LLI_DST_WIDTH_MSK) >>
+				FTDMAC020_LLI_DST_WIDTH_SHIFT;
+	} else {
+		if (source)
+			val = (cctl & PL080_CONTROL_SWIDTH_MASK) >>
+				PL080_CONTROL_SWIDTH_SHIFT;
+		else
+			val = (cctl & PL080_CONTROL_DWIDTH_MASK) >>
+				PL080_CONTROL_DWIDTH_SHIFT;
+	}
+
+	switch (val) {
 	case PL080_WIDTH_8BIT:
 		return 1;
 	case PL080_WIDTH_16BIT:
@@ -764,49 +1002,106 @@ static inline unsigned int pl08x_get_bytes_for_cctl(unsigned int coded)
 	return 0;
 }
 
-static inline u32 pl08x_cctl_bits(u32 cctl, u8 srcwidth, u8 dstwidth,
-				  size_t tsize)
+static inline u32 pl08x_lli_control_bits(struct pl08x_driver_data *pl08x,
+					 u32 cctl,
+					 u8 srcwidth, u8 dstwidth,
+					 size_t tsize)
 {
 	u32 retbits = cctl;
 
-	/* Remove all src, dst and transfer size bits */
-	retbits &= ~PL080_CONTROL_DWIDTH_MASK;
-	retbits &= ~PL080_CONTROL_SWIDTH_MASK;
-	retbits &= ~PL080_CONTROL_TRANSFER_SIZE_MASK;
+	/*
+	 * Remove all src, dst and transfer size bits, then set the
+	 * width and size according to the parameters. The bit offsets
+	 * are different in the FTDMAC020 so we need to accound for this.
+	 */
+	if (pl08x->vd->ftdmac020) {
+		retbits &= ~FTDMAC020_LLI_DST_WIDTH_MSK;
+		retbits &= ~FTDMAC020_LLI_SRC_WIDTH_MSK;
+		retbits &= ~FTDMAC020_LLI_TRANSFER_SIZE_MASK;
+
+		switch (srcwidth) {
+		case 1:
+			retbits |= PL080_WIDTH_8BIT <<
+				FTDMAC020_LLI_SRC_WIDTH_SHIFT;
+			break;
+		case 2:
+			retbits |= PL080_WIDTH_16BIT <<
+				FTDMAC020_LLI_SRC_WIDTH_SHIFT;
+			break;
+		case 4:
+			retbits |= PL080_WIDTH_32BIT <<
+				FTDMAC020_LLI_SRC_WIDTH_SHIFT;
+			break;
+		default:
+			BUG();
+			break;
+		}
 
-	/* Then set the bits according to the parameters */
-	switch (srcwidth) {
-	case 1:
-		retbits |= PL080_WIDTH_8BIT << PL080_CONTROL_SWIDTH_SHIFT;
-		break;
-	case 2:
-		retbits |= PL080_WIDTH_16BIT << PL080_CONTROL_SWIDTH_SHIFT;
-		break;
-	case 4:
-		retbits |= PL080_WIDTH_32BIT << PL080_CONTROL_SWIDTH_SHIFT;
-		break;
-	default:
-		BUG();
-		break;
-	}
+		switch (dstwidth) {
+		case 1:
+			retbits |= PL080_WIDTH_8BIT <<
+				FTDMAC020_LLI_DST_WIDTH_SHIFT;
+			break;
+		case 2:
+			retbits |= PL080_WIDTH_16BIT <<
+				FTDMAC020_LLI_DST_WIDTH_SHIFT;
+			break;
+		case 4:
+			retbits |= PL080_WIDTH_32BIT <<
+				FTDMAC020_LLI_DST_WIDTH_SHIFT;
+			break;
+		default:
+			BUG();
+			break;
+		}
 
-	switch (dstwidth) {
-	case 1:
-		retbits |= PL080_WIDTH_8BIT << PL080_CONTROL_DWIDTH_SHIFT;
-		break;
-	case 2:
-		retbits |= PL080_WIDTH_16BIT << PL080_CONTROL_DWIDTH_SHIFT;
-		break;
-	case 4:
-		retbits |= PL080_WIDTH_32BIT << PL080_CONTROL_DWIDTH_SHIFT;
-		break;
-	default:
-		BUG();
-		break;
+		tsize &= FTDMAC020_LLI_TRANSFER_SIZE_MASK;
+		retbits |= tsize << FTDMAC020_LLI_TRANSFER_SIZE_SHIFT;
+	} else {
+		retbits &= ~PL080_CONTROL_DWIDTH_MASK;
+		retbits &= ~PL080_CONTROL_SWIDTH_MASK;
+		retbits &= ~PL080_CONTROL_TRANSFER_SIZE_MASK;
+
+		switch (srcwidth) {
+		case 1:
+			retbits |= PL080_WIDTH_8BIT <<
+				PL080_CONTROL_SWIDTH_SHIFT;
+			break;
+		case 2:
+			retbits |= PL080_WIDTH_16BIT <<
+				PL080_CONTROL_SWIDTH_SHIFT;
+			break;
+		case 4:
+			retbits |= PL080_WIDTH_32BIT <<
+				PL080_CONTROL_SWIDTH_SHIFT;
+			break;
+		default:
+			BUG();
+			break;
+		}
+
+		switch (dstwidth) {
+		case 1:
+			retbits |= PL080_WIDTH_8BIT <<
+				PL080_CONTROL_DWIDTH_SHIFT;
+			break;
+		case 2:
+			retbits |= PL080_WIDTH_16BIT <<
+				PL080_CONTROL_DWIDTH_SHIFT;
+			break;
+		case 4:
+			retbits |= PL080_WIDTH_32BIT <<
+				PL080_CONTROL_DWIDTH_SHIFT;
+			break;
+		default:
+			BUG();
+			break;
+		}
+
+		tsize &= PL080_CONTROL_TRANSFER_SIZE_MASK;
+		retbits |= tsize << PL080_CONTROL_TRANSFER_SIZE_SHIFT;
 	}
 
-	tsize &= PL080_CONTROL_TRANSFER_SIZE_MASK;
-	retbits |= tsize << PL080_CONTROL_TRANSFER_SIZE_SHIFT;
 	return retbits;
 }
 
@@ -827,13 +1122,35 @@ struct pl08x_lli_build_data {
  * - prefers the destination bus if both available
  * - prefers bus with fixed address (i.e. peripheral)
  */
-static void pl08x_choose_master_bus(struct pl08x_lli_build_data *bd,
-	struct pl08x_bus_data **mbus, struct pl08x_bus_data **sbus, u32 cctl)
+static void pl08x_choose_master_bus(struct pl08x_driver_data *pl08x,
+				    struct pl08x_lli_build_data *bd,
+				    struct pl08x_bus_data **mbus,
+				    struct pl08x_bus_data **sbus,
+				    u32 cctl)
 {
-	if (!(cctl & PL080_CONTROL_DST_INCR)) {
+	bool dst_incr;
+	bool src_incr;
+
+	/*
+	 * The FTDMAC020 only supports memory-to-memory transfer, so
+	 * source and destination always increase.
+	 */
+	if (pl08x->vd->ftdmac020) {
+		dst_incr = true;
+		src_incr = true;
+	} else {
+		dst_incr = !!(cctl & PL080_CONTROL_DST_INCR);
+		src_incr = !!(cctl & PL080_CONTROL_SRC_INCR);
+	}
+
+	/*
+	 * If either bus is not advancing, i.e. it is a peripheral, that
+	 * one becomes master
+	 */
+	if (!dst_incr) {
 		*mbus = &bd->dstbus;
 		*sbus = &bd->srcbus;
-	} else if (!(cctl & PL080_CONTROL_SRC_INCR)) {
+	} else if (!src_incr) {
 		*mbus = &bd->srcbus;
 		*sbus = &bd->dstbus;
 	} else {
@@ -871,10 +1188,16 @@ static void pl08x_fill_lli_for_desc(struct pl08x_driver_data *pl08x,
 	if (pl08x->vd->pl080s)
 		llis_va[PL080S_LLI_CCTL2] = cctl2;
 
-	if (cctl & PL080_CONTROL_SRC_INCR)
+	if (pl08x->vd->ftdmac020) {
+		/* FIXME: only memcpy so far so both increase */
 		bd->srcbus.addr += len;
-	if (cctl & PL080_CONTROL_DST_INCR)
 		bd->dstbus.addr += len;
+	} else {
+		if (cctl & PL080_CONTROL_SRC_INCR)
+			bd->srcbus.addr += len;
+		if (cctl & PL080_CONTROL_DST_INCR)
+			bd->dstbus.addr += len;
+	}
 
 	BUG_ON(bd->remainder < len);
 
@@ -885,12 +1208,12 @@ static inline void prep_byte_width_lli(struct pl08x_driver_data *pl08x,
 			struct pl08x_lli_build_data *bd, u32 *cctl, u32 len,
 			int num_llis, size_t *total_bytes)
 {
-	*cctl = pl08x_cctl_bits(*cctl, 1, 1, len);
+	*cctl = pl08x_lli_control_bits(pl08x, *cctl, 1, 1, len);
 	pl08x_fill_lli_for_desc(pl08x, bd, num_llis, len, *cctl, len);
 	(*total_bytes) += len;
 }
 
-#ifdef VERBOSE_DEBUG
+#if 1
 static void pl08x_dump_lli(struct pl08x_driver_data *pl08x,
 			   const u32 *llis_va, int num_llis)
 {
@@ -955,14 +1278,10 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 	cctl = txd->cctl;
 
 	/* Find maximum width of the source bus */
-	bd.srcbus.maxwidth =
-		pl08x_get_bytes_for_cctl((cctl & PL080_CONTROL_SWIDTH_MASK) >>
-				       PL080_CONTROL_SWIDTH_SHIFT);
+	bd.srcbus.maxwidth = pl08x_get_bytes_for_lli(pl08x, cctl, true);
 
 	/* Find maximum width of the destination bus */
-	bd.dstbus.maxwidth =
-		pl08x_get_bytes_for_cctl((cctl & PL080_CONTROL_DWIDTH_MASK) >>
-				       PL080_CONTROL_DWIDTH_SHIFT);
+	bd.dstbus.maxwidth = pl08x_get_bytes_for_lli(pl08x, cctl, false);
 
 	list_for_each_entry(dsg, &txd->dsg_list, node) {
 		total_bytes = 0;
@@ -974,7 +1293,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 		bd.srcbus.buswidth = bd.srcbus.maxwidth;
 		bd.dstbus.buswidth = bd.dstbus.maxwidth;
 
-		pl08x_choose_master_bus(&bd, &mbus, &sbus, cctl);
+		pl08x_choose_master_bus(pl08x, &bd, &mbus, &sbus, cctl);
 
 		dev_vdbg(&pl08x->adev->dev,
 			"src=0x%08llx%s/%u dst=0x%08llx%s/%u len=%zu\n",
@@ -1011,8 +1330,14 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 		 *   supported. Thus, we can't have scattered addresses.
 		 */
 		if (!bd.remainder) {
-			u32 fc = (txd->ccfg & PL080_CONFIG_FLOW_CONTROL_MASK) >>
-				PL080_CONFIG_FLOW_CONTROL_SHIFT;
+			u32 fc;
+
+			/* FTDMAC020 only does memory-to-memory */
+			if (pl08x->vd->ftdmac020)
+				fc = PL080_FLOW_MEM2MEM;
+			else
+				fc = (txd->ccfg & PL080_CONFIG_FLOW_CONTROL_MASK) >>
+					PL080_CONFIG_FLOW_CONTROL_SHIFT;
 			if (!((fc >= PL080_FLOW_SRC2DST_DST) &&
 					(fc <= PL080_FLOW_SRC2DST_SRC))) {
 				dev_err(&pl08x->adev->dev, "%s sg len can't be zero",
@@ -1029,8 +1354,9 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 				return 0;
 			}
 
-			cctl = pl08x_cctl_bits(cctl, bd.srcbus.buswidth,
-					bd.dstbus.buswidth, 0);
+			cctl = pl08x_lli_control_bits(pl08x, cctl,
+					bd.srcbus.buswidth, bd.dstbus.buswidth,
+					0);
 			pl08x_fill_lli_for_desc(pl08x, &bd, num_llis++,
 					0, cctl, 0);
 			break;
@@ -1109,8 +1435,9 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 					"size 0x%08zx (remainder 0x%08zx)\n",
 					__func__, lli_len, bd.remainder);
 
-				cctl = pl08x_cctl_bits(cctl, bd.srcbus.buswidth,
-					bd.dstbus.buswidth, tsize);
+				cctl = pl08x_lli_control_bits(pl08x, cctl,
+					bd.srcbus.buswidth, bd.dstbus.buswidth,
+					tsize);
 				pl08x_fill_lli_for_desc(pl08x, &bd, num_llis++,
 						lli_len, cctl, tsize);
 				total_bytes += lli_len;
@@ -1153,7 +1480,10 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 		/* The final LLI terminates the LLI. */
 		last_lli[PL080_LLI_LLI] = 0;
 		/* The final LLI element shall also fire an interrupt. */
-		last_lli[PL080_LLI_CCTL] |= PL080_CONTROL_TC_IRQ_EN;
+		if (pl08x->vd->ftdmac020)
+			last_lli[PL080_LLI_CCTL] &= ~FTDMAC020_LLI_TC_MSK;
+		else
+			last_lli[PL080_LLI_CCTL] |= PL080_CONTROL_TC_IRQ_EN;
 	}
 
 	pl08x_dump_lli(pl08x, llis_va, num_llis);
@@ -1319,14 +1649,25 @@ static const struct burst_table burst_sizes[] = {
  * will be routed to each port.  We try to have source and destination
  * on separate ports, but always respect the allowable settings.
  */
-static u32 pl08x_select_bus(u8 src, u8 dst)
+static u32 pl08x_select_bus(bool ftdmac020, u8 src, u8 dst)
 {
 	u32 cctl = 0;
+	u32 dst_ahb2;
+	u32 src_ahb2;
+
+	/* The FTDMAC020 use different bits to indicate src/dst bus */
+	if (ftdmac020) {
+		dst_ahb2 = FTDMAC020_LLI_DST_SEL;
+		src_ahb2 = FTDMAC020_LLI_SRC_SEL;
+	} else {
+		dst_ahb2 = PL080_CONTROL_DST_AHB2;
+		src_ahb2 = PL080_CONTROL_SRC_AHB2;
+	}
 
 	if (!(dst & PL08X_AHB1) || ((dst & PL08X_AHB2) && (src & PL08X_AHB1)))
-		cctl |= PL080_CONTROL_DST_AHB2;
+		cctl |= dst_ahb2;
 	if (!(src & PL08X_AHB1) || ((src & PL08X_AHB2) && !(dst & PL08X_AHB2)))
-		cctl |= PL080_CONTROL_SRC_AHB2;
+		cctl |= src_ahb2;
 
 	return cctl;
 }
@@ -1414,50 +1755,14 @@ static struct pl08x_txd *pl08x_get_txd(struct pl08x_dma_chan *plchan)
 {
 	struct pl08x_txd *txd = kzalloc(sizeof(*txd), GFP_NOWAIT);
 
-	if (txd) {
+	if (txd)
 		INIT_LIST_HEAD(&txd->dsg_list);
-
-		/* Always enable error and terminal interrupts */
-		txd->ccfg = PL080_CONFIG_ERR_IRQ_MASK |
-			    PL080_CONFIG_TC_IRQ_MASK;
-	}
 	return txd;
 }
 
-/*
- * Initialize a descriptor to be used by memcpy submit
- */
-static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
-		struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
-		size_t len, unsigned long flags)
+static u32 pl08x_memcpy_cctl(struct pl08x_driver_data *pl08x)
 {
-	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
-	struct pl08x_driver_data *pl08x = plchan->host;
-	struct pl08x_txd *txd;
-	struct pl08x_sg *dsg;
 	u32 cctl = 0;
-	int ret;
-
-	txd = pl08x_get_txd(plchan);
-	if (!txd) {
-		dev_err(&pl08x->adev->dev,
-			"%s no memory for descriptor\n", __func__);
-		return NULL;
-	}
-
-	dsg = kzalloc(sizeof(struct pl08x_sg), GFP_NOWAIT);
-	if (!dsg) {
-		pl08x_free_txd(pl08x, txd);
-		return NULL;
-	}
-	list_add_tail(&dsg->node, &txd->dsg_list);
-
-	dsg->src_addr = src;
-	dsg->dst_addr = dest;
-	dsg->len = len;
-
-	/* Set platform data for m2m */
-	txd->ccfg |= PL080_FLOW_MEM2MEM << PL080_CONFIG_FLOW_CONTROL_SHIFT;
 
 	/* Conjure cctl */
 	switch (pl08x->pd->memcpy_burst_size) {
@@ -1531,10 +1836,95 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
 	cctl |= PL080_CONTROL_SRC_INCR | PL080_CONTROL_DST_INCR;
 
 	if (pl08x->vd->dualmaster)
-		cctl |= pl08x_select_bus(pl08x->mem_buses,
+		cctl |= pl08x_select_bus(false,
+					 pl08x->mem_buses,
+					 pl08x->mem_buses);
+
+	return cctl;
+}
+
+static u32 pl08x_ftdmac020_memcpy_cctl(struct pl08x_driver_data *pl08x)
+{
+	u32 cctl = 0;
+
+	/* Conjure cctl */
+	switch (pl08x->pd->memcpy_bus_width) {
+	default:
+		dev_err(&pl08x->adev->dev,
+			"illegal bus width for memcpy, set to 8 bits\n");
+		/* Fall through */
+	case PL08X_BUS_WIDTH_8_BITS:
+		cctl |= PL080_WIDTH_8BIT << FTDMAC020_LLI_SRC_WIDTH_SHIFT |
+			PL080_WIDTH_8BIT << FTDMAC020_LLI_DST_WIDTH_SHIFT;
+		break;
+	case PL08X_BUS_WIDTH_16_BITS:
+		cctl |= PL080_WIDTH_16BIT << FTDMAC020_LLI_SRC_WIDTH_SHIFT |
+			PL080_WIDTH_16BIT << FTDMAC020_LLI_DST_WIDTH_SHIFT;
+		break;
+	case PL08X_BUS_WIDTH_32_BITS:
+		cctl |= PL080_WIDTH_32BIT << FTDMAC020_LLI_SRC_WIDTH_SHIFT |
+			PL080_WIDTH_32BIT << FTDMAC020_LLI_DST_WIDTH_SHIFT;
+		break;
+	}
+
+	/*
+	 * By default mask the TC IRQ on all LLIs, it will be unmasked on
+	 * the last LLI item by other code.
+	 */
+	cctl |= FTDMAC020_LLI_TC_MSK;
+
+	/*
+	 * Both to be incremented so leave bits FTDMAC020_LLI_SRCAD_CTL
+	 * and FTDMAC020_LLI_DSTAD_CTL as zero
+	 */
+	if (pl08x->vd->dualmaster)
+		cctl |= pl08x_select_bus(true,
+					 pl08x->mem_buses,
 					 pl08x->mem_buses);
 
-	txd->cctl = cctl;
+	return cctl;
+}
+
+/*
+ * Initialize a descriptor to be used by memcpy submit
+ */
+static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
+		struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
+		size_t len, unsigned long flags)
+{
+	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
+	struct pl08x_driver_data *pl08x = plchan->host;
+	struct pl08x_txd *txd;
+	struct pl08x_sg *dsg;
+	int ret;
+
+	txd = pl08x_get_txd(plchan);
+	if (!txd) {
+		dev_err(&pl08x->adev->dev,
+			"%s no memory for descriptor\n", __func__);
+		return NULL;
+	}
+
+	dsg = kzalloc(sizeof(struct pl08x_sg), GFP_NOWAIT);
+	if (!dsg) {
+		pl08x_free_txd(pl08x, txd);
+		return NULL;
+	}
+	list_add_tail(&dsg->node, &txd->dsg_list);
+
+	dsg->src_addr = src;
+	dsg->dst_addr = dest;
+	dsg->len = len;
+	if (pl08x->vd->ftdmac020) {
+		/* Writing CCFG zero ENABLES all interrupts */
+		txd->ccfg = 0;
+		txd->cctl = pl08x_ftdmac020_memcpy_cctl(pl08x);
+	} else {
+		txd->ccfg = PL080_CONFIG_ERR_IRQ_MASK |
+			PL080_CONFIG_TC_IRQ_MASK |
+			PL080_FLOW_MEM2MEM << PL080_CONFIG_FLOW_CONTROL_SHIFT;
+		txd->cctl = pl08x_memcpy_cctl(pl08x);
+	}
 
 	ret = pl08x_fill_llis_for_desc(plchan->host, txd);
 	if (!ret) {
@@ -1598,7 +1988,7 @@ static struct pl08x_txd *pl08x_init_txd(
 		return NULL;
 	}
 
-	txd->cctl = cctl | pl08x_select_bus(src_buses, dst_buses);
+	txd->cctl = cctl | pl08x_select_bus(false, src_buses, dst_buses);
 
 	if (plchan->cfg.device_fc)
 		tmp = (direction == DMA_MEM_TO_DEV) ? PL080_FLOW_MEM2PER_PER :
@@ -1607,7 +1997,9 @@ static struct pl08x_txd *pl08x_init_txd(
 		tmp = (direction == DMA_MEM_TO_DEV) ? PL080_FLOW_MEM2PER :
 			PL080_FLOW_PER2MEM;
 
-	txd->ccfg |= tmp << PL080_CONFIG_FLOW_CONTROL_SHIFT;
+	txd->ccfg = PL080_CONFIG_ERR_IRQ_MASK |
+		PL080_CONFIG_TC_IRQ_MASK |
+		tmp << PL080_CONFIG_FLOW_CONTROL_SHIFT;
 
 	ret = pl08x_request_mux(plchan);
 	if (ret < 0) {
@@ -1884,6 +2276,11 @@ static void pl08x_ensure_on(struct pl08x_driver_data *pl08x)
 	/* The Nomadik variant does not have the config register */
 	if (pl08x->vd->nomadik)
 		return;
+	/* The FTDMAC020 variant does this in another register */
+	if (pl08x->vd->ftdmac020) {
+		writel(PL080_CONFIG_ENABLE, pl08x->base + FTDMAC020_CSR);
+		return;
+	}
 	writel(PL080_CONFIG_ENABLE, pl08x->base + PL080_CONFIG);
 }
 
@@ -2310,7 +2707,7 @@ static inline int pl08x_of_probe(struct amba_device *adev,
 static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	struct pl08x_driver_data *pl08x;
-	const struct vendor_data *vd = id->data;
+	struct vendor_data *vd = id->data;
 	struct device_node *np = adev->dev.of_node;
 	u32 tsfr_size;
 	int ret = 0;
@@ -2336,6 +2733,34 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 	pl08x->adev = adev;
 	pl08x->vd = vd;
 
+	pl08x->base = ioremap(adev->res.start, resource_size(&adev->res));
+	if (!pl08x->base) {
+		ret = -ENOMEM;
+		goto out_no_ioremap;
+	}
+
+	if (vd->ftdmac020) {
+		u32 val;
+
+		val = readl(pl08x->base + FTDMAC020_REVISION);
+		dev_info(&pl08x->adev->dev, "FTDMAC020 %d.%d rel %d\n",
+			 (val >> 16) & 0xff, (val >> 8) & 0xff, val & 0xff);
+		val = readl(pl08x->base + FTDMAC020_FEATURE);
+		dev_info(&pl08x->adev->dev, "FTDMAC020 %d channels, "
+			 "%s built-in bridge, %s, %s linked lists\n",
+			 (val >> 12) & 0x0f,
+			 (val & BIT(10)) ? "no" : "has",
+			 (val & BIT(9)) ? "AHB0 and AHB1" : "AHB0",
+			 (val & BIT(8)) ? "supports" : "does not support");
+
+		/* Vendor data from feature register */
+		if (!(val & BIT(8)))
+			dev_warn(&pl08x->adev->dev,
+				 "linked lists not supported, required\n");
+		vd->channels = (val >> 12) & 0x0f;
+		vd->dualmaster = !!(val & BIT(9));
+	}
+
 	/* Initialize memcpy engine */
 	dma_cap_set(DMA_MEMCPY, pl08x->memcpy.cap_mask);
 	pl08x->memcpy.dev = &adev->dev;
@@ -2352,6 +2777,9 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 	pl08x->memcpy.dst_addr_widths = PL80X_DMA_BUSWIDTHS;
 	pl08x->memcpy.directions = BIT(DMA_MEM_TO_MEM);
 	pl08x->memcpy.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
+	if (vd->ftdmac020)
+		pl08x->memcpy.copy_align = DMAENGINE_ALIGN_4_BYTES;
+
 
 	/*
 	 * Initialize slave engine, if the block has no signals, that means
@@ -2422,19 +2850,18 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 		goto out_no_lli_pool;
 	}
 
-	pl08x->base = ioremap(adev->res.start, resource_size(&adev->res));
-	if (!pl08x->base) {
-		ret = -ENOMEM;
-		goto out_no_ioremap;
-	}
-
 	/* Turn on the PL08x */
 	pl08x_ensure_on(pl08x);
 
-	/* Attach the interrupt handler */
-	writel(0x000000FF, pl08x->base + PL080_ERR_CLEAR);
+	/* Clear any pending interrupts */
+	if (vd->ftdmac020)
+		/* This variant has error IRQs in bits 16-19 */
+		writel(0x0000FFFF, pl08x->base + PL080_ERR_CLEAR);
+	else
+		writel(0x000000FF, pl08x->base + PL080_ERR_CLEAR);
 	writel(0x000000FF, pl08x->base + PL080_TC_CLEAR);
 
+	/* Attach the interrupt handler */
 	ret = request_irq(adev->irq[0], pl08x_irq, 0, DRIVER_NAME, pl08x);
 	if (ret) {
 		dev_err(&adev->dev, "%s failed to request interrupt %d\n",
@@ -2455,7 +2882,25 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 
 		ch->id = i;
 		ch->base = pl08x->base + PL080_Cx_BASE(i);
-		ch->reg_config = ch->base + vd->config_offset;
+		if (vd->ftdmac020) {
+			/* FTDMA020 has a special channel busy register */
+			ch->reg_busy = ch->base + FTDMAC020_CH_BUSY;
+			ch->reg_config = ch->base + FTDMAC020_CH_CFG;
+			ch->reg_control = ch->base + FTDMAC020_CH_CSR;
+			ch->reg_src = ch->base + FTDMAC020_CH_SRC_ADDR;
+			ch->reg_dst = ch->base + FTDMAC020_CH_DST_ADDR;
+			ch->reg_lli = ch->base + FTDMAC020_CH_LLP;
+			ch->ftdmac020 = true;
+		} else {
+			ch->reg_config = ch->base + vd->config_offset;
+			ch->reg_control = ch->base + PL080_CH_CONTROL;
+			ch->reg_src = ch->base + PL080_CH_SRC_ADDR;
+			ch->reg_dst = ch->base + PL080_CH_DST_ADDR;
+			ch->reg_lli = ch->base + PL080_CH_LLI;
+		}
+		if (vd->pl080s)
+			ch->pl080s = true;
+
 		spin_lock_init(&ch->lock);
 
 		/*
@@ -2537,11 +2982,11 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 out_no_phychans:
 	free_irq(adev->irq[0], pl08x);
 out_no_irq:
-	iounmap(pl08x->base);
-out_no_ioremap:
 	dma_pool_destroy(pl08x->pool);
 out_no_lli_pool:
 out_no_platdata:
+	iounmap(pl08x->base);
+out_no_ioremap:
 	kfree(pl08x);
 out_no_pl08x:
 	amba_release_regions(adev);
@@ -2582,6 +3027,12 @@ static struct vendor_data vendor_pl081 = {
 	.max_transfer_size = PL080_CONTROL_TRANSFER_SIZE_MASK,
 };
 
+static struct vendor_data vendor_ftdmac020 = {
+	.config_offset = PL080_CH_CONFIG,
+	.ftdmac020 = true,
+	.max_transfer_size = PL080_CONTROL_TRANSFER_SIZE_MASK,
+};
+
 static struct amba_id pl08x_ids[] = {
 	/* Samsung PL080S variant */
 	{
@@ -2607,6 +3058,12 @@ static struct amba_id pl08x_ids[] = {
 		.mask	= 0x00ffffff,
 		.data	= &vendor_nomadik,
 	},
+	/* Faraday Technology FTDMAC020 */
+	{
+		.id	= 0x0003b080,
+		.mask	= 0x000fffff,
+		.data	= &vendor_ftdmac020,
+	},
 	{ 0, 0 },
 };
 
diff --git a/include/linux/amba/pl080.h b/include/linux/amba/pl080.h
index 580b5323a717..10124c9f9db5 100644
--- a/include/linux/amba/pl080.h
+++ b/include/linux/amba/pl080.h
@@ -44,7 +44,14 @@
 
 #define PL080_SYNC				(0x34)
 
-/* Per channel configuration registers */
+/* The Faraday Technology FTDMAC020 variant registers */
+#define FTDMAC020_CH_BUSY			(0x20)
+/* Identical to PL080_CONFIG */
+#define FTDMAC020_CSR				(0x24)
+/* Identical to PL080_SYNC */
+#define FTDMAC020_SYNC				(0x2C)
+#define FTDMAC020_REVISION			(0x30)
+#define FTDMAC020_FEATURE			(0x34)
 
 /* Per channel configuration registers */
 #define PL080_Cx_BASE(x)			((0x100 + (x * 0x20)))
@@ -55,6 +62,13 @@
 #define PL080_CH_CONFIG				(0x10)
 #define PL080S_CH_CONTROL2			(0x10)
 #define PL080S_CH_CONFIG			(0x14)
+/* The Faraday FTDMAC020 derivative shuffles the registers around */
+#define FTDMAC020_CH_CSR			(0x00)
+#define FTDMAC020_CH_CFG			(0x04)
+#define FTDMAC020_CH_SRC_ADDR			(0x08)
+#define FTDMAC020_CH_DST_ADDR			(0x0C)
+#define FTDMAC020_CH_LLP			(0x10)
+#define FTDMAC020_CH_SIZE			(0x14)
 
 #define PL080_LLI_ADDR_MASK			(0x3fffffff << 2)
 #define PL080_LLI_ADDR_SHIFT			(2)
@@ -119,6 +133,73 @@
 #define PL080_FLOW_PER2MEM_PER			(0x6)
 #define PL080_FLOW_SRC2DST_SRC			(0x7)
 
+#define FTDMAC020_CH_CSR_TC_MSK			BIT(31)
+/* Later versions have a threshold in bits 24..26,  */
+#define FTDMAC020_CH_CSR_FIFOTH_MSK		(0x7 << 24)
+#define FTDMAC020_CH_CSR_FIFOTH_SHIFT		(24)
+#define FTDMAC020_CH_CSR_CHPR1_MSK		(0x3 << 22)
+#define FTDMAC020_CH_CSR_PROT3			BIT(21)
+#define FTDMAC020_CH_CSR_PROT2			BIT(20)
+#define FTDMAC020_CH_CSR_PROT1			BIT(19)
+#define FTDMAC020_CH_CSR_SRC_SIZE_MSK		(0x7 << 16)
+#define FTDMAC020_CH_CSR_SRC_SIZE_SHIFT		(16)
+#define FTDMAC020_CH_CSR_ABT			BIT(15)
+#define FTDMAC020_CH_CSR_SRC_WIDTH_MSK		(0x7 << 11)
+#define FTDMAC020_CH_CSR_SRC_WIDTH_SHIFT	(11)
+#define FTDMAC020_CH_CSR_DST_WIDTH_MSK		(0x7 << 8)
+#define FTDMAC020_CH_CSR_DST_WIDTH_SHIFT	(8)
+#define FTDMAC020_CH_CSR_MODE			BIT(7)
+/* 00 = increase, 01 = decrease, 10 = fix */
+#define FTDMAC020_CH_CSR_SRCAD_CTL_MSK		(0x3 << 5)
+#define FTDMAC020_CH_CSR_SRCAD_CTL_SHIFT	(5)
+#define FTDMAC020_CH_CSR_DSTAD_CTL_MSK		(0x3 << 3)
+#define FTDMAC020_CH_CSR_DSTAD_CTL_SHIFT	(3)
+#define FTDMAC020_CH_CSR_SRC_SEL		BIT(2)
+#define FTDMAC020_CH_CSR_DST_SEL		BIT(1)
+#define FTDMAC020_CH_CSR_EN			BIT(0)
+
+/* FIFO threshold setting */
+#define FTDMAC020_CH_CSR_FIFOTH_1		(0x0)
+#define FTDMAC020_CH_CSR_FIFOTH_2		(0x1)
+#define FTDMAC020_CH_CSR_FIFOTH_4		(0x2)
+#define FTDMAC020_CH_CSR_FIFOTH_8		(0x3)
+#define FTDMAC020_CH_CSR_FIFOTH_16		(0x4)
+/* The FTDMAC020 supports 64bit wide transfers */
+#define FTDMAC020_WIDTH_64BIT			(0x3)
+/* Address can be increased, decreased or fixed */
+#define FTDMAC020_CH_CSR_SRCAD_CTL_INC		(0x0)
+#define FTDMAC020_CH_CSR_SRCAD_CTL_DEC		(0x1)
+#define FTDMAC020_CH_CSR_SRCAD_CTL_FIXED	(0x2)
+
+#define FTDMAC020_CH_CFG_LLP_CNT_MASK		(0xf << 16)
+#define FTDMAC020_CH_CFG_LLP_CNT_SHIFT		(16)
+#define FTDMAC020_CH_CFG_BUSY			BIT(8)
+#define FTDMAC020_CH_CFG_INT_ABT_MASK		BIT(2)
+#define FTDMAC020_CH_CFG_INT_ERR_MASK		BIT(1)
+#define FTDMAC020_CH_CFG_INT_TC_MASK		BIT(0)
+
+/* Inside the LLIs, the applicable CSR fields are mapped differently */
+#define FTDMAC020_LLI_TC_MSK			BIT(28)
+#define FTDMAC020_LLI_SRC_WIDTH_MSK		(0x7 << 25)
+#define FTDMAC020_LLI_SRC_WIDTH_SHIFT		(25)
+#define FTDMAC020_LLI_DST_WIDTH_MSK		(0x7 << 22)
+#define FTDMAC020_LLI_DST_WIDTH_SHIFT		(22)
+#define FTDMAC020_LLI_SRCAD_CTL_MSK		(0x3 << 20)
+#define FTDMAC020_LLI_SRCAD_CTL_SHIFT		(20)
+#define FTDMAC020_LLI_DSTAD_CTL_MSK		(0x3 << 18)
+#define FTDMAC020_LLI_DSTAD_CTL_SHIFT		(18)
+#define FTDMAC020_LLI_SRC_SEL			BIT(17)
+#define FTDMAC020_LLI_DST_SEL			BIT(16)
+#define FTDMAC020_LLI_TRANSFER_SIZE_MASK	(0xfff << 0)
+#define FTDMAC020_LLI_TRANSFER_SIZE_SHIFT	(0)
+
+#define FTDMAC020_CFG_LLP_CNT_MASK		(0x0f << 16)
+#define FTDMAC020_CFG_LLP_CNT_SHIFT		(16)
+#define FTDMAC020_CFG_BUSY			BIT(8)
+#define FTDMAC020_CFG_INT_ABT_MSK		BIT(2)
+#define FTDMAC020_CFG_INT_ERR_MSK		BIT(1)
+#define FTDMAC020_CFG_INT_TC_MSK		BIT(0)
+
 /* DMA linked list chain structure */
 
 struct pl080_lli {
-- 
2.9.4
