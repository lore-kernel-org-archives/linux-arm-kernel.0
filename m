From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Nov 2015 15:18:22 +0100
Subject: [PATCH] dma: at_hdmac: use %pad format string for dma_addr_t
Message-ID: <3938068.0vDFThTK2h@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dma_addr_t may be defined as 32 or 64 bit depending on configuration,
so it cannot be printed using the normal format strings, as
gcc correctly warns:

drivers/dma/at_hdmac.c: In function 'atc_prep_dma_interleaved':
drivers/dma/at_hdmac.c:731:28: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'dma_addr_t {aka long long unsigned int}' [-Wformat=]

This changes the format strings to use the special "%pad" format
string that prints a dma_addr_t, and changes the arguments so we
pass the address by reference as required.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Found on ARM multi_v7_defconfig build with LPAE enabled

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 4e55239c7a30..53d22eb73b56 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -729,8 +729,8 @@ atc_prep_dma_interleaved(struct dma_chan *chan,
 		return NULL;
 
 	dev_info(chan2dev(chan),
-		 "%s: src=0x%08x, dest=0x%08x, numf=%d, frame_size=%d, flags=0x%lx\n",
-		__func__, xt->src_start, xt->dst_start, xt->numf,
+		 "%s: src=%pad, dest=%pad, numf=%d, frame_size=%d, flags=0x%lx\n",
+		__func__, &xt->src_start, &xt->dst_start, xt->numf,
 		xt->frame_size, flags);
 
 	/*
@@ -824,8 +824,8 @@ atc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	u32			ctrla;
 	u32			ctrlb;
 
-	dev_vdbg(chan2dev(chan), "prep_dma_memcpy: d0x%x s0x%x l0x%zx f0x%lx\n",
-			dest, src, len, flags);
+	dev_vdbg(chan2dev(chan), "prep_dma_memcpy: d%pad s%pad l0x%zx f0x%lx\n",
+			&dest, &src, len, flags);
 
 	if (unlikely(!len)) {
 		dev_dbg(chan2dev(chan), "prep_dma_memcpy: length is zero!\n");
@@ -938,8 +938,8 @@ atc_prep_dma_memset(struct dma_chan *chan, dma_addr_t dest, int value,
 	void __iomem		*vaddr;
 	dma_addr_t		paddr;
 
-	dev_vdbg(chan2dev(chan), "%s: d0x%x v0x%x l0x%zx f0x%lx\n", __func__,
-		dest, value, len, flags);
+	dev_vdbg(chan2dev(chan), "%s: d%pad v0x%x l0x%zx f0x%lx\n", __func__,
+		&dest, value, len, flags);
 
 	if (unlikely(!len)) {
 		dev_dbg(chan2dev(chan), "%s: length is zero!\n", __func__);
@@ -1022,8 +1022,8 @@ atc_prep_dma_memset_sg(struct dma_chan *chan,
 		dma_addr_t dest = sg_dma_address(sg);
 		size_t len = sg_dma_len(sg);
 
-		dev_vdbg(chan2dev(chan), "%s: d0x%08x, l0x%zx\n",
-			 __func__, dest, len);
+		dev_vdbg(chan2dev(chan), "%s: d%pad, l0x%zx\n",
+			 __func__, &dest, len);
 
 		if (!is_dma_fill_aligned(chan->device, dest, 0, len)) {
 			dev_err(chan2dev(chan), "%s: buffer is not aligned\n",
@@ -1439,9 +1439,9 @@ atc_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 	unsigned int		periods = buf_len / period_len;
 	unsigned int		i;
 
-	dev_vdbg(chan2dev(chan), "prep_dma_cyclic: %s buf at 0x%08x - %d (%d/%d)\n",
+	dev_vdbg(chan2dev(chan), "prep_dma_cyclic: %s buf@%pad - %d (%d/%d)\n",
 			direction == DMA_MEM_TO_DEV ? "TO DEVICE" : "FROM DEVICE",
-			buf_addr,
+			&buf_addr,
 			periods, buf_len, period_len);
 
 	if (unlikely(!atslave || !buf_len || !period_len)) {
diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h
index d1cfc8c876f9..7f58f06157f6 100644
--- a/drivers/dma/at_hdmac_regs.h
+++ b/drivers/dma/at_hdmac_regs.h
@@ -385,9 +385,9 @@ static void vdbg_dump_regs(struct at_dma_chan *atchan) {}
 static void atc_dump_lli(struct at_dma_chan *atchan, struct at_lli *lli)
 {
 	dev_crit(chan2dev(&atchan->chan_common),
-		 "  desc: s0x%x d0x%x ctrl0x%x:0x%x l0x%x\n",
-		 lli->saddr, lli->daddr,
-		 lli->ctrla, lli->ctrlb, lli->dscr);
+		 "  desc: s%pad d%pad ctrl0x%x:0x%x l0x%pad\n",
+		 &lli->saddr, &lli->daddr,
+		 lli->ctrla, lli->ctrlb, &lli->dscr);
 }
 
 
