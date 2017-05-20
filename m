From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 20 May 2017 23:42:50 +0200
Subject: [PATCH 1/5 v2] ARM/dma: pl08x: pass reasonable memcpy settings
Message-ID: <20170520214254.21541-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We cannot use bits from configuration registers as API between
platforms and driver like this, abstract it out to two enums
and mimic the stuff passed as device tree data.

This is done to make it possible for the driver to generate the
ccfg word on-the-fly so we can support more PL08x derivatives.

Acked-by: Olof Johansson <olof@lixom.net>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Add in ACKs from the ARM SoC maintainers.
---
 arch/arm/mach-lpc32xx/phy3250.c |   3 +
 arch/arm/mach-s3c64xx/pl080.c   |  28 +++------
 arch/arm/mach-spear/spear3xx.c  |  14 ++---
 arch/arm/mach-spear/spear6xx.c  |  14 ++---
 drivers/dma/amba-pl08x.c        | 131 ++++++++++++++++++++++++++++------------
 include/linux/amba/pl08x.h      |  30 +++++++--
 6 files changed, 138 insertions(+), 82 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index 6c52bd32610e..e48cc06c2aec 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -137,6 +137,9 @@ static void pl08x_put_signal(const struct pl08x_channel_data *cd, int ch)
 }
 
 static struct pl08x_platform_data pl08x_pd = {
+	/* Some reasonable memcpy defaults */
+	.memcpy_burst_size = PL08X_BURST_SZ_256,
+	.memcpy_bus_width = PL08X_BUS_WIDTH_32_BITS,
 	.slave_channels = &pl08x_slave_channels[0],
 	.num_slave_channels = ARRAY_SIZE(pl08x_slave_channels),
 	.get_xfer_signal = pl08x_get_signal,
diff --git a/arch/arm/mach-s3c64xx/pl080.c b/arch/arm/mach-s3c64xx/pl080.c
index 261820a855ec..66fc774b70ec 100644
--- a/arch/arm/mach-s3c64xx/pl080.c
+++ b/arch/arm/mach-s3c64xx/pl080.c
@@ -137,16 +137,10 @@ static const struct dma_slave_map s3c64xx_dma0_slave_map[] = {
 };
 
 struct pl08x_platform_data s3c64xx_dma0_plat_data = {
-	.memcpy_channel = {
-		.bus_id = "memcpy",
-		.cctl_memcpy =
-			(PL080_BSIZE_4 << PL080_CONTROL_SB_SIZE_SHIFT |
-			PL080_BSIZE_4 << PL080_CONTROL_DB_SIZE_SHIFT |
-			PL080_WIDTH_32BIT << PL080_CONTROL_SWIDTH_SHIFT |
-			PL080_WIDTH_32BIT << PL080_CONTROL_DWIDTH_SHIFT |
-			PL080_CONTROL_PROT_BUFF | PL080_CONTROL_PROT_CACHE |
-			PL080_CONTROL_PROT_SYS),
-	},
+	.memcpy_burst_size = PL08X_BURST_SZ_4,
+	.memcpy_bus_width = PL08X_BUS_WIDTH_32_BITS,
+	.memcpy_prot_buff = true,
+	.memcpy_prot_cache = true,
 	.lli_buses = PL08X_AHB1,
 	.mem_buses = PL08X_AHB1,
 	.get_xfer_signal = pl08x_get_xfer_signal,
@@ -238,16 +232,10 @@ static const struct dma_slave_map s3c64xx_dma1_slave_map[] = {
 };
 
 struct pl08x_platform_data s3c64xx_dma1_plat_data = {
-	.memcpy_channel = {
-		.bus_id = "memcpy",
-		.cctl_memcpy =
-			(PL080_BSIZE_4 << PL080_CONTROL_SB_SIZE_SHIFT |
-			PL080_BSIZE_4 << PL080_CONTROL_DB_SIZE_SHIFT |
-			PL080_WIDTH_32BIT << PL080_CONTROL_SWIDTH_SHIFT |
-			PL080_WIDTH_32BIT << PL080_CONTROL_DWIDTH_SHIFT |
-			PL080_CONTROL_PROT_BUFF | PL080_CONTROL_PROT_CACHE |
-			PL080_CONTROL_PROT_SYS),
-	},
+	.memcpy_burst_size = PL08X_BURST_SZ_4,
+	.memcpy_bus_width = PL08X_BUS_WIDTH_32_BITS,
+	.memcpy_prot_buff = true,
+	.memcpy_prot_cache = true,
 	.lli_buses = PL08X_AHB1,
 	.mem_buses = PL08X_AHB1,
 	.get_xfer_signal = pl08x_get_xfer_signal,
diff --git a/arch/arm/mach-spear/spear3xx.c b/arch/arm/mach-spear/spear3xx.c
index 23394ac76cf2..8537fcffe5a8 100644
--- a/arch/arm/mach-spear/spear3xx.c
+++ b/arch/arm/mach-spear/spear3xx.c
@@ -44,16 +44,10 @@ struct pl022_ssp_controller pl022_plat_data = {
 
 /* dmac device registration */
 struct pl08x_platform_data pl080_plat_data = {
-	.memcpy_channel = {
-		.bus_id = "memcpy",
-		.cctl_memcpy =
-			(PL080_BSIZE_16 << PL080_CONTROL_SB_SIZE_SHIFT | \
-			PL080_BSIZE_16 << PL080_CONTROL_DB_SIZE_SHIFT | \
-			PL080_WIDTH_32BIT << PL080_CONTROL_SWIDTH_SHIFT | \
-			PL080_WIDTH_32BIT << PL080_CONTROL_DWIDTH_SHIFT | \
-			PL080_CONTROL_PROT_BUFF | PL080_CONTROL_PROT_CACHE | \
-			PL080_CONTROL_PROT_SYS),
-	},
+	.memcpy_burst_size = PL08X_BURST_SZ_16,
+	.memcpy_bus_width = PL08X_BUS_WIDTH_32_BITS,
+	.memcpy_prot_buff = true,
+	.memcpy_prot_cache = true,
 	.lli_buses = PL08X_AHB1,
 	.mem_buses = PL08X_AHB1,
 	.get_xfer_signal = pl080_get_signal,
diff --git a/arch/arm/mach-spear/spear6xx.c b/arch/arm/mach-spear/spear6xx.c
index ccf3573b831c..c5fc110134ba 100644
--- a/arch/arm/mach-spear/spear6xx.c
+++ b/arch/arm/mach-spear/spear6xx.c
@@ -322,16 +322,10 @@ static struct pl08x_channel_data spear600_dma_info[] = {
 };
 
 static struct pl08x_platform_data spear6xx_pl080_plat_data = {
-	.memcpy_channel = {
-		.bus_id = "memcpy",
-		.cctl_memcpy =
-			(PL080_BSIZE_16 << PL080_CONTROL_SB_SIZE_SHIFT | \
-			PL080_BSIZE_16 << PL080_CONTROL_DB_SIZE_SHIFT | \
-			PL080_WIDTH_32BIT << PL080_CONTROL_SWIDTH_SHIFT | \
-			PL080_WIDTH_32BIT << PL080_CONTROL_DWIDTH_SHIFT | \
-			PL080_CONTROL_PROT_BUFF | PL080_CONTROL_PROT_CACHE | \
-			PL080_CONTROL_PROT_SYS),
-	},
+	.memcpy_burst_size = PL08X_BURST_SZ_16,
+	.memcpy_bus_width = PL08X_BUS_WIDTH_32_BITS,
+	.memcpy_prot_buff = true,
+	.memcpy_prot_cache = true,
 	.lli_buses = PL08X_AHB1,
 	.mem_buses = PL08X_AHB1,
 	.get_xfer_signal = pl080_get_signal,
diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 6bb8813ca275..d3d660a36ad7 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1433,6 +1433,7 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
 	struct pl08x_driver_data *pl08x = plchan->host;
 	struct pl08x_txd *txd;
 	struct pl08x_sg *dsg;
+	u32 cctl = 0;
 	int ret;
 
 	txd = pl08x_get_txd(plchan);
@@ -1455,15 +1456,83 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
 
 	/* Set platform data for m2m */
 	txd->ccfg |= PL080_FLOW_MEM2MEM << PL080_CONFIG_FLOW_CONTROL_SHIFT;
-	txd->cctl = pl08x->pd->memcpy_channel.cctl_memcpy &
-			~(PL080_CONTROL_DST_AHB2 | PL080_CONTROL_SRC_AHB2);
+
+	/* Conjure cctl */
+	switch (pl08x->pd->memcpy_burst_size) {
+	default:
+		dev_err(&pl08x->adev->dev,
+			"illegal burst size for memcpy, set to 1\n");
+		/* Fall through */
+	case PL08X_BURST_SZ_1:
+		cctl |= PL080_BSIZE_1 << PL080_CONTROL_SB_SIZE_SHIFT |
+			PL080_BSIZE_1 << PL080_CONTROL_DB_SIZE_SHIFT;
+		break;
+	case PL08X_BURST_SZ_4:
+		cctl |= PL080_BSIZE_4 << PL080_CONTROL_SB_SIZE_SHIFT |
+			PL080_BSIZE_4 << PL080_CONTROL_DB_SIZE_SHIFT;
+		break;
+	case PL08X_BURST_SZ_8:
+		cctl |= PL080_BSIZE_8 << PL080_CONTROL_SB_SIZE_SHIFT |
+			PL080_BSIZE_8 << PL080_CONTROL_DB_SIZE_SHIFT;
+		break;
+	case PL08X_BURST_SZ_16:
+		cctl |= PL080_BSIZE_16 << PL080_CONTROL_SB_SIZE_SHIFT |
+			PL080_BSIZE_16 << PL080_CONTROL_DB_SIZE_SHIFT;
+		break;
+	case PL08X_BURST_SZ_32:
+		cctl |= PL080_BSIZE_32 << PL080_CONTROL_SB_SIZE_SHIFT |
+			PL080_BSIZE_32 << PL080_CONTROL_DB_SIZE_SHIFT;
+		break;
+	case PL08X_BURST_SZ_64:
+		cctl |= PL080_BSIZE_64 << PL080_CONTROL_SB_SIZE_SHIFT |
+			PL080_BSIZE_64 << PL080_CONTROL_DB_SIZE_SHIFT;
+		break;
+	case PL08X_BURST_SZ_128:
+		cctl |= PL080_BSIZE_128 << PL080_CONTROL_SB_SIZE_SHIFT |
+			PL080_BSIZE_128 << PL080_CONTROL_DB_SIZE_SHIFT;
+		break;
+	case PL08X_BURST_SZ_256:
+		cctl |= PL080_BSIZE_256 << PL080_CONTROL_SB_SIZE_SHIFT |
+			PL080_BSIZE_256 << PL080_CONTROL_DB_SIZE_SHIFT;
+		break;
+	}
+
+	switch (pl08x->pd->memcpy_bus_width) {
+	default:
+		dev_err(&pl08x->adev->dev,
+			"illegal bus width for memcpy, set to 8 bits\n");
+		/* Fall through */
+	case PL08X_BUS_WIDTH_8_BITS:
+		cctl |= PL080_WIDTH_8BIT << PL080_CONTROL_SWIDTH_SHIFT |
+			PL080_WIDTH_8BIT << PL080_CONTROL_DWIDTH_SHIFT;
+		break;
+	case PL08X_BUS_WIDTH_16_BITS:
+		cctl |= PL080_WIDTH_16BIT << PL080_CONTROL_SWIDTH_SHIFT |
+			PL080_WIDTH_16BIT << PL080_CONTROL_DWIDTH_SHIFT;
+		break;
+	case PL08X_BUS_WIDTH_32_BITS:
+		cctl |= PL080_WIDTH_32BIT << PL080_CONTROL_SWIDTH_SHIFT |
+			PL080_WIDTH_32BIT << PL080_CONTROL_DWIDTH_SHIFT;
+		break;
+	}
+
+	/* Protection flags */
+	if (pl08x->pd->memcpy_prot_buff)
+		cctl |= PL080_CONTROL_PROT_BUFF;
+	if (pl08x->pd->memcpy_prot_cache)
+		cctl |= PL080_CONTROL_PROT_CACHE;
+
+	/* We are the kernel, so we are in privileged mode */
+	cctl |= PL080_CONTROL_PROT_SYS;
 
 	/* Both to be incremented or the code will break */
-	txd->cctl |= PL080_CONTROL_SRC_INCR | PL080_CONTROL_DST_INCR;
+	cctl |= PL080_CONTROL_SRC_INCR | PL080_CONTROL_DST_INCR;
 
 	if (pl08x->vd->dualmaster)
-		txd->cctl |= pl08x_select_bus(pl08x->mem_buses,
-					      pl08x->mem_buses);
+		cctl |= pl08x_select_bus(pl08x->mem_buses,
+					 pl08x->mem_buses);
+
+	txd->cctl = cctl;
 
 	ret = pl08x_fill_llis_for_desc(plchan->host, txd);
 	if (!ret) {
@@ -1925,9 +1994,16 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 			chan->signal = i;
 			pl08x_dma_slave_init(chan);
 		} else {
-			chan->cd = &pl08x->pd->memcpy_channel;
+			chan->cd = kzalloc(sizeof(*chan->cd), GFP_KERNEL);
+			if (!chan->cd) {
+				kfree(chan);
+				return -ENOMEM;
+			}
+			chan->cd->bus_id = "memcpy";
+			chan->cd->periph_buses = pl08x->pd->mem_buses;
 			chan->name = kasprintf(GFP_KERNEL, "memcpy%d", i);
 			if (!chan->name) {
+				kfree(chan->cd);
 				kfree(chan);
 				return -ENOMEM;
 			}
@@ -2099,7 +2175,6 @@ static int pl08x_of_probe(struct amba_device *adev,
 {
 	struct pl08x_platform_data *pd;
 	struct pl08x_channel_data *chanp = NULL;
-	u32 cctl_memcpy = 0;
 	u32 val;
 	int ret;
 	int i;
@@ -2139,36 +2214,28 @@ static int pl08x_of_probe(struct amba_device *adev,
 		dev_err(&adev->dev, "illegal burst size for memcpy, set to 1\n");
 		/* Fall through */
 	case 1:
-		cctl_memcpy |= PL080_BSIZE_1 << PL080_CONTROL_SB_SIZE_SHIFT |
-			       PL080_BSIZE_1 << PL080_CONTROL_DB_SIZE_SHIFT;
+		pd->memcpy_burst_size = PL08X_BURST_SZ_1;
 		break;
 	case 4:
-		cctl_memcpy |= PL080_BSIZE_4 << PL080_CONTROL_SB_SIZE_SHIFT |
-			       PL080_BSIZE_4 << PL080_CONTROL_DB_SIZE_SHIFT;
+		pd->memcpy_burst_size = PL08X_BURST_SZ_4;
 		break;
 	case 8:
-		cctl_memcpy |= PL080_BSIZE_8 << PL080_CONTROL_SB_SIZE_SHIFT |
-			       PL080_BSIZE_8 << PL080_CONTROL_DB_SIZE_SHIFT;
+		pd->memcpy_burst_size = PL08X_BURST_SZ_8;
 		break;
 	case 16:
-		cctl_memcpy |= PL080_BSIZE_16 << PL080_CONTROL_SB_SIZE_SHIFT |
-			       PL080_BSIZE_16 << PL080_CONTROL_DB_SIZE_SHIFT;
+		pd->memcpy_burst_size = PL08X_BURST_SZ_16;
 		break;
 	case 32:
-		cctl_memcpy |= PL080_BSIZE_32 << PL080_CONTROL_SB_SIZE_SHIFT |
-			       PL080_BSIZE_32 << PL080_CONTROL_DB_SIZE_SHIFT;
+		pd->memcpy_burst_size = PL08X_BURST_SZ_32;
 		break;
 	case 64:
-		cctl_memcpy |= PL080_BSIZE_64 << PL080_CONTROL_SB_SIZE_SHIFT |
-			       PL080_BSIZE_64 << PL080_CONTROL_DB_SIZE_SHIFT;
+		pd->memcpy_burst_size = PL08X_BURST_SZ_64;
 		break;
 	case 128:
-		cctl_memcpy |= PL080_BSIZE_128 << PL080_CONTROL_SB_SIZE_SHIFT |
-			       PL080_BSIZE_128 << PL080_CONTROL_DB_SIZE_SHIFT;
+		pd->memcpy_burst_size = PL08X_BURST_SZ_128;
 		break;
 	case 256:
-		cctl_memcpy |= PL080_BSIZE_256 << PL080_CONTROL_SB_SIZE_SHIFT |
-			       PL080_BSIZE_256 << PL080_CONTROL_DB_SIZE_SHIFT;
+		pd->memcpy_burst_size = PL08X_BURST_SZ_256;
 		break;
 	}
 
@@ -2182,28 +2249,16 @@ static int pl08x_of_probe(struct amba_device *adev,
 		dev_err(&adev->dev, "illegal bus width for memcpy, set to 8 bits\n");
 		/* Fall through */
 	case 8:
-		cctl_memcpy |= PL080_WIDTH_8BIT << PL080_CONTROL_SWIDTH_SHIFT |
-			       PL080_WIDTH_8BIT << PL080_CONTROL_DWIDTH_SHIFT;
+		pd->memcpy_bus_width = PL08X_BUS_WIDTH_8_BITS;
 		break;
 	case 16:
-		cctl_memcpy |= PL080_WIDTH_16BIT << PL080_CONTROL_SWIDTH_SHIFT |
-			       PL080_WIDTH_16BIT << PL080_CONTROL_DWIDTH_SHIFT;
+		pd->memcpy_bus_width = PL08X_BUS_WIDTH_16_BITS;
 		break;
 	case 32:
-		cctl_memcpy |= PL080_WIDTH_32BIT << PL080_CONTROL_SWIDTH_SHIFT |
-			       PL080_WIDTH_32BIT << PL080_CONTROL_DWIDTH_SHIFT;
+		pd->memcpy_bus_width = PL08X_BUS_WIDTH_32_BITS;
 		break;
 	}
 
-	/* This is currently the only thing making sense */
-	cctl_memcpy |= PL080_CONTROL_PROT_SYS;
-
-	/* Set up memcpy channel */
-	pd->memcpy_channel.bus_id = "memcpy";
-	pd->memcpy_channel.cctl_memcpy = cctl_memcpy;
-	/* Use the buses that can access memory, obviously */
-	pd->memcpy_channel.periph_buses = pd->mem_buses;
-
 	/*
 	 * Allocate channel data for all possible slave channels (one
 	 * for each possible signal), channels will then be allocated
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 5308eae9ce35..79d1bcee738d 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -47,8 +47,6 @@ enum {
  * devices with static assignments
  * @muxval: a number usually used to poke into some mux regiser to
  * mux in the signal to this channel
- * @cctl_memcpy: options for the channel control register for memcpy
- *  *** not used for slave channels ***
  * @addr: source/target address in physical memory for this DMA channel,
  * can be the address of a FIFO register for burst requests for example.
  * This can be left undefined if the PrimeCell API is used for configuring
@@ -63,12 +61,28 @@ struct pl08x_channel_data {
 	int min_signal;
 	int max_signal;
 	u32 muxval;
-	u32 cctl_memcpy;
 	dma_addr_t addr;
 	bool single;
 	u8 periph_buses;
 };
 
+enum pl08x_burst_size {
+	PL08X_BURST_SZ_1,
+	PL08X_BURST_SZ_4,
+	PL08X_BURST_SZ_8,
+	PL08X_BURST_SZ_16,
+	PL08X_BURST_SZ_32,
+	PL08X_BURST_SZ_64,
+	PL08X_BURST_SZ_128,
+	PL08X_BURST_SZ_256,
+};
+
+enum pl08x_bus_width {
+	PL08X_BUS_WIDTH_8_BITS,
+	PL08X_BUS_WIDTH_16_BITS,
+	PL08X_BUS_WIDTH_32_BITS,
+};
+
 /**
  * struct pl08x_platform_data - the platform configuration for the PL08x
  * PrimeCells.
@@ -76,6 +90,11 @@ struct pl08x_channel_data {
  * platform, all inclusive, including multiplexed channels. The available
  * physical channels will be multiplexed around these signals as they are
  * requested, just enumerate all possible channels.
+ * @num_slave_channels: number of elements in the slave channel array
+ * @memcpy_burst_size: the appropriate burst size for memcpy operations
+ * @memcpy_bus_width: memory bus width
+ * @memcpy_prot_buff: whether memcpy DMA is bufferable
+ * @memcpy_prot_cache: whether memcpy DMA is cacheable
  * @get_xfer_signal: request a physical signal to be used for a DMA transfer
  * immediately: if there is some multiplexing or similar blocking the use
  * of the channel the transfer can be denied by returning less than zero,
@@ -90,7 +109,10 @@ struct pl08x_channel_data {
 struct pl08x_platform_data {
 	struct pl08x_channel_data *slave_channels;
 	unsigned int num_slave_channels;
-	struct pl08x_channel_data memcpy_channel;
+	enum pl08x_burst_size memcpy_burst_size;
+	enum pl08x_bus_width memcpy_bus_width;
+	bool memcpy_prot_buff;
+	bool memcpy_prot_cache;
 	int (*get_xfer_signal)(const struct pl08x_channel_data *);
 	void (*put_xfer_signal)(const struct pl08x_channel_data *, int);
 	u8 lli_buses;
-- 
2.9.4
