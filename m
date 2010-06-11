From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 11 Jun 2010 21:48:47 +0200
Subject: [PATCH 2/9] ARM: S3C64XX: Add SDMA support to DMA core
In-Reply-To: <cover.1276284559.git.mcuelenaere@gmail.com>
References: <cover.1276284559.git.mcuelenaere@gmail.com>
Message-ID: <4C12931F.7020105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The crypto engine uses the DMACH_SECURITY_[RT]X channels, who seem to be
hardcoded to SDMA-only in hardware, so add support for SDMA to the S3C64XX
DMA core.

Only DMACH_SECURITY_[RT]X are using SDMA, other channels are unaffected and
will continue to use standard DMA.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/mach-s3c64xx/dma.c |   51 ++++++++++++++++++++++++++++++++++--------
 1 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dma.c b/arch/arm/mach-s3c64xx/dma.c
index 5567e03..be043db 100644
--- a/arch/arm/mach-s3c64xx/dma.c
+++ b/arch/arm/mach-s3c64xx/dma.c
@@ -45,6 +45,15 @@ struct s3c64xx_dmac {
 /* pool to provide LLI buffers */
 static struct dma_pool *dma_pool;
 
+/* SDMA channel state information */
+static struct s3c2410_dma_chan sdma_chans[S3C_DMA_CHANNELS];
+
+/* Currently hardcodes SECURITY_[RT]X SDMA-only as dictated by HW */
+static inline bool channel_needs_sdma(unsigned int chan)
+{
+	return chan == DMACH_SECURITY_RX || chan == DMACH_SECURITY_TX;
+}
+
 /* Debug configuration and code */
 
 static unsigned char debug_show_buffs = 0;
@@ -92,16 +101,20 @@ static void dbg_showbuffs(struct s3c2410_dma_chan *chan)
 
 static struct s3c2410_dma_chan *s3c64xx_dma_map_channel(unsigned int channel)
 {
+	struct s3c2410_dma_chan *chans = s3c2410_chans;
 	struct s3c2410_dma_chan *chan;
 	unsigned int start, offs;
 
+	if (channel_needs_sdma(channel))
+		chans = sdma_chans;
+
 	start = 0;
 
 	if (channel >= DMACH_PCM1_TX)
 		start = 8;
 
 	for (offs = 0; offs < 8; offs++) {
-		chan = &s3c2410_chans[start + offs];
+		chan = &chans[start + offs];
 		if (!chan->in_use)
 			goto found;
 	}
@@ -634,8 +647,12 @@ static struct sysdev_class dma_sysclass = {
 	.name		= "s3c64xx-dma",
 };
 
+static struct sysdev_class sdma_sysclass = {
+	.name		= "s3c64xx-sdma",
+};
+
 static int s3c64xx_dma_init1(int chno, enum dma_ch chbase,
-			     int irq, unsigned int base)
+			     int irq, unsigned int base, bool sdma)
 {
 	struct s3c2410_dma_chan *chptr = &s3c2410_chans[chno];
 	struct s3c64xx_dmac *dmac;
@@ -651,7 +668,7 @@ static int s3c64xx_dma_init1(int chno, enum dma_ch chbase,
 	}
 
 	dmac->sysdev.id = chno / 8;
-	dmac->sysdev.cls = &dma_sysclass;
+	dmac->sysdev.cls = sdma ? &sdma_sysclass : &dma_sysclass;
 
 	err = sysdev_register(&dmac->sysdev);
 	if (err) {
@@ -666,7 +683,11 @@ static int s3c64xx_dma_init1(int chno, enum dma_ch chbase,
 		goto err_dev;
 	}
 
-	snprintf(clkname, sizeof(clkname), "dma%d", dmac->sysdev.id);
+	if (sdma) {
+		snprintf(clkname, sizeof(clkname), "sdma%d", dmac->sysdev.id);
+		chptr = &sdma_chans[chno];
+	} else
+		snprintf(clkname, sizeof(clkname), "dma%d", dmac->sysdev.id);
 
 	dmac->clk = clk_get(NULL, clkname);
 	if (IS_ERR(dmac->clk)) {
@@ -690,8 +711,8 @@ static int s3c64xx_dma_init1(int chno, enum dma_ch chbase,
 	regptr = regs + PL080_Cx_BASE(0);
 
 	for (ch = 0; ch < 8; ch++, chno++, chptr++) {
-		printk(KERN_INFO "%s: registering DMA %d (%p)\n",
-		       __func__, chno, regptr);
+		printk(KERN_INFO "%s: registering %sDMA %d (%p)\n",
+		       __func__, sdma ? "S" : "", chno, regptr);
 
 		chptr->bit = 1 << ch;
 		chptr->number = chno;
@@ -737,12 +758,22 @@ static int __init s3c64xx_dma_init(void)
 		return -ENOMEM;
 	}
 
-	/* Set all DMA configuration to be DMA, not SDMA */
-	writel(0xffffff, S3C_SYSREG(0x110));
+	ret = sysdev_class_register(&sdma_sysclass);
+	if (ret) {
+		printk(KERN_ERR "%s: failed to create sysclass\n", __func__);
+		return -ENOMEM;
+	}
+
+	/* Set all DMA configuration to be DMA, except SECURITY_[RT]X */
+	writel(0x3fffffff, S3C_SYSREG(0x110));
 
 	/* Register standard DMA controlers */
-	s3c64xx_dma_init1(0, DMACH_UART0, IRQ_DMA0, 0x75000000);
-	s3c64xx_dma_init1(8, DMACH_PCM1_TX, IRQ_DMA1, 0x75100000);
+	s3c64xx_dma_init1(0, DMACH_UART0, IRQ_DMA0, 0x75000000, false);
+	s3c64xx_dma_init1(8, DMACH_PCM1_TX, IRQ_DMA1, 0x75100000, false);
+
+	/* Register SDMA controllers */
+	s3c64xx_dma_init1(0, DMACH_UART0, IRQ_SDMA0, 0x7DB00000, true);
+	s3c64xx_dma_init1(8, DMACH_PCM1_TX, IRQ_SDMA1, 0x7DC00000, true);
 
 	return 0;
 }
-- 
1.7.1
