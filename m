From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu,  3 Mar 2011 14:58:33 +0000
Subject: [PATCH 5/7] ARM: S3C64XX: Reduce output of s3c64xx_dma_init1()
In-Reply-To: <20110303145710.GA32234@opensource.wolfsonmicro.com>
References: <20110303145710.GA32234@opensource.wolfsonmicro.com>
Message-ID: <1299164315-22246-5-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben-linux@fluff.org>

Reduce the logging output of s3c64xx_dma_init1() as it is not useful
for normal bootup (and we get an overall indication of the registration
of the PL180 DMA block).

This removes the following output from the log:

s3c64xx_dma_init1: registering DMA 0 (e0808100)
s3c64xx_dma_init1: registering DMA 1 (e0808120)
s3c64xx_dma_init1: registering DMA 2 (e0808140)
s3c64xx_dma_init1: registering DMA 3 (e0808160)
s3c64xx_dma_init1: registering DMA 4 (e0808180)
s3c64xx_dma_init1: registering DMA 5 (e08081a0)
s3c64xx_dma_init1: registering DMA 6 (e08081c0)
s3c64xx_dma_init1: registering DMA 7 (e08081e0)

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/dma.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dma.c b/arch/arm/mach-s3c64xx/dma.c
index 135db1b..c35585c 100644
--- a/arch/arm/mach-s3c64xx/dma.c
+++ b/arch/arm/mach-s3c64xx/dma.c
@@ -690,12 +690,12 @@ static int s3c64xx_dma_init1(int chno, enum dma_ch chbase,
 
 	regptr = regs + PL080_Cx_BASE(0);
 
-	for (ch = 0; ch < 8; ch++, chno++, chptr++) {
-		printk(KERN_INFO "%s: registering DMA %d (%p)\n",
-		       __func__, chno, regptr);
+	for (ch = 0; ch < 8; ch++, chptr++) {
+		pr_debug("%s: registering DMA %d (%p)\n",
+			 __func__, chno + ch, regptr);
 
 		chptr->bit = 1 << ch;
-		chptr->number = chno;
+		chptr->number = chno + ch;
 		chptr->dmac = dmac;
 		chptr->regs = regptr;
 		regptr += PL080_Cx_STRIDE;
@@ -704,7 +704,8 @@ static int s3c64xx_dma_init1(int chno, enum dma_ch chbase,
 	/* for the moment, permanently enable the controller */
 	writel(PL080_CONFIG_ENABLE, regs + PL080_CONFIG);
 
-	printk(KERN_INFO "PL080: IRQ %d, at %p\n", irq, regs);
+	printk(KERN_INFO "PL080: IRQ %d, at %p, channels %d..%d\n",
+	       irq, regs, chno, chno+8);
 
 	return 0;
 
-- 
1.7.2.3
