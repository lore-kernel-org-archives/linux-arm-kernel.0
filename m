From: jochen@scram.de (Jochen Friedrich)
Date: Sun, 27 Nov 2011 22:00:55 +0100
Subject: [PATCH 2/2] ARM: sa1100: Refactor mcp-sa11x0 to use platform
 resources.
In-Reply-To: <1322427655-914-1-git-send-email-jochen@scram.de>
References: <1322427655-914-1-git-send-email-jochen@scram.de>
Message-ID: <1322427655-914-2-git-send-email-jochen@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of memory resources rather than hardcoded IO adresses.
This is a first step towards DT support.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/arm/mach-sa1100/assabet.c |   11 +++
 arch/arm/mach-sa1100/cerf.c    |   10 +++
 arch/arm/mach-sa1100/collie.c  |   10 +++
 arch/arm/mach-sa1100/generic.c |    7 ++-
 arch/arm/mach-sa1100/lart.c    |    9 ++
 arch/arm/mach-sa1100/shannon.c |   10 +++
 arch/arm/mach-sa1100/simpad.c  |   10 +++
 drivers/mfd/mcp-sa11x0.c       |  162 +++++++++++++++++++++++++++-------------
 8 files changed, 176 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 14b31f1..96a162c 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -253,6 +253,17 @@ static void __init assabet_init(void)
 	sa11x0_register_mtd(&assabet_flash_data, assabet_flash_resources,
 			    ARRAY_SIZE(assabet_flash_resources));
 	sa11x0_register_irda(&assabet_irda_data);
+
+	/*
+	 * Setup the PPC unit correctly.
+	 */
+	PPDR &= ~PPC_RXD4;
+	PPDR |= PPC_TXD4 | PPC_SCLK | PPC_SFRM;
+	PSDR |= PPC_RXD4;
+	PSDR &= ~(PPC_TXD4 | PPC_SCLK | PPC_SFRM);
+	PPSR &= ~(PPC_TXD4 | PPC_SCLK | PPC_SFRM);
+
+	ASSABET_BCR_set(ASSABET_BCR_CODEC_RST);
 	sa11x0_register_mcp(&assabet_mcp_data);
 }
 
diff --git a/arch/arm/mach-sa1100/cerf.c b/arch/arm/mach-sa1100/cerf.c
index 73d4f1d..3e025df2a 100644
--- a/arch/arm/mach-sa1100/cerf.c
+++ b/arch/arm/mach-sa1100/cerf.c
@@ -134,6 +134,16 @@ static void __init cerf_init(void)
 {
 	platform_add_devices(cerf_devices, ARRAY_SIZE(cerf_devices));
 	sa11x0_register_mtd(&cerf_flash_data, &cerf_flash_resource, 1);
+
+	/*
+	 * Setup the PPC unit correctly.
+	 */
+	PPDR &= ~PPC_RXD4;
+	PPDR |= PPC_TXD4 | PPC_SCLK | PPC_SFRM;
+	PSDR |= PPC_RXD4;
+	PSDR &= ~(PPC_TXD4 | PPC_SCLK | PPC_SFRM);
+	PPSR &= ~(PPC_TXD4 | PPC_SCLK | PPC_SFRM);
+
 	sa11x0_register_mcp(&cerf_mcp_data);
 }
 
diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index 65165f1..326e44b 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -359,6 +359,16 @@ static void __init collie_init(void)
 
 	sa11x0_register_mtd(&collie_flash_data, collie_flash_resources,
 			    ARRAY_SIZE(collie_flash_resources));
+
+	/*
+	 * Setup the PPC unit correctly.
+	 */
+	PPDR &= ~PPC_RXD4;
+	PPDR |= PPC_TXD4 | PPC_SCLK | PPC_SFRM;
+	PSDR |= PPC_RXD4;
+	PSDR &= ~(PPC_TXD4 | PPC_SCLK | PPC_SFRM);
+	PPSR &= ~(PPC_TXD4 | PPC_SCLK | PPC_SFRM);
+
 	sa11x0_register_mcp(&collie_mcp_data);
 
 	sharpsl_save_param();
diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 465bcfc..83717b2 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -226,10 +226,15 @@ static struct platform_device sa11x0uart3_device = {
 static struct resource sa11x0mcp_resources[] = {
 	[0] = {
 		.start	= __PREG(Ser4MCCR0),
-		.end	= __PREG(Ser4MCCR0) + 0xffff,
+		.end	= __PREG(Ser4MCCR0) + 0x1C - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
+		.start	= __PREG(Ser4MCCR1),
+		.end	= __PREG(Ser4MCCR1) + 0x4 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[2] = {
 		.start	= IRQ_Ser4MCP,
 		.end	= IRQ_Ser4MCP,
 		.flags	= IORESOURCE_IRQ,
diff --git a/arch/arm/mach-sa1100/lart.c b/arch/arm/mach-sa1100/lart.c
index 6235f39..c4c3018 100644
--- a/arch/arm/mach-sa1100/lart.c
+++ b/arch/arm/mach-sa1100/lart.c
@@ -29,6 +29,15 @@ static struct mcp_plat_data lart_mcp_data = {
 
 static void __init lart_init(void)
 {
+	/*
+	 * Setup the PPC unit correctly.
+	 */
+	PPDR &= ~PPC_RXD4;
+	PPDR |= PPC_TXD4 | PPC_SCLK | PPC_SFRM;
+	PSDR |= PPC_RXD4;
+	PSDR &= ~(PPC_TXD4 | PPC_SCLK | PPC_SFRM);
+	PPSR &= ~(PPC_TXD4 | PPC_SCLK | PPC_SFRM);
+
 	sa11x0_register_mcp(&lart_mcp_data);
 }
 
diff --git a/arch/arm/mach-sa1100/shannon.c b/arch/arm/mach-sa1100/shannon.c
index b227368..9f36335 100644
--- a/arch/arm/mach-sa1100/shannon.c
+++ b/arch/arm/mach-sa1100/shannon.c
@@ -61,6 +61,16 @@ static struct mcp_plat_data shannon_mcp_data = {
 static void __init shannon_init(void)
 {
 	sa11x0_register_mtd(&shannon_flash_data, &shannon_flash_resource, 1);
+
+	/*
+	 * Setup the PPC unit correctly.
+	 */
+	PPDR &= ~PPC_RXD4;
+	PPDR |= PPC_TXD4 | PPC_SCLK | PPC_SFRM;
+	PSDR |= PPC_RXD4;
+	PSDR &= ~(PPC_TXD4 | PPC_SCLK | PPC_SFRM);
+	PPSR &= ~(PPC_TXD4 | PPC_SCLK | PPC_SFRM);
+
 	sa11x0_register_mcp(&shannon_mcp_data);
 }
 
diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index c05b2e9..c9f2f41 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -387,6 +387,16 @@ static int __init simpad_init(void)
 
 	sa11x0_register_mtd(&simpad_flash_data, simpad_flash_resources,
 			      ARRAY_SIZE(simpad_flash_resources));
+
+	/*
+	 * Setup the PPC unit correctly.
+	 */
+	PPDR &= ~PPC_RXD4;
+	PPDR |= PPC_TXD4 | PPC_SCLK | PPC_SFRM;
+	PSDR |= PPC_RXD4;
+	PSDR &= ~(PPC_TXD4 | PPC_SCLK | PPC_SFRM);
+	PPSR &= ~(PPC_TXD4 | PPC_SCLK | PPC_SFRM);
+
 	sa11x0_register_mcp(&simpad_mcp_data);
 
 	ret = platform_add_devices(devices, ARRAY_SIZE(devices));
diff --git a/drivers/mfd/mcp-sa11x0.c b/drivers/mfd/mcp-sa11x0.c
index 9cd38f1..965b2f7 100644
--- a/drivers/mfd/mcp-sa11x0.c
+++ b/drivers/mfd/mcp-sa11x0.c
@@ -19,6 +19,7 @@
 #include <linux/spinlock.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/mcp.h>
+#include <linux/io.h>
 
 #include <mach/dma.h>
 #include <mach/hardware.h>
@@ -26,12 +27,19 @@
 #include <asm/system.h>
 #include <mach/mcp.h>
 
-#include <mach/assabet.h>
-
+/* Register offsets */
+#define MCCR0	0x00
+#define MCDR0	0x08
+#define MCDR1	0x0C
+#define MCDR2	0x10
+#define MCSR	0x18
+#define MCCR1	0x00
 
 struct mcp_sa11x0 {
-	u32	mccr0;
-	u32	mccr1;
+	u32		mccr0;
+	u32		mccr1;
+	unsigned char	*mccr0_base;
+	unsigned char	*mccr1_base;
 };
 
 #define priv(mcp)	((struct mcp_sa11x0 *)mcp_priv(mcp))
@@ -39,25 +47,25 @@ struct mcp_sa11x0 {
 static void
 mcp_sa11x0_set_telecom_divisor(struct mcp *mcp, unsigned int divisor)
 {
-	unsigned int mccr0;
+	struct mcp_sa11x0 *priv = priv(mcp);
 
 	divisor /= 32;
 
-	mccr0 = Ser4MCCR0 & ~0x00007f00;
-	mccr0 |= divisor << 8;
-	Ser4MCCR0 = mccr0;
+	priv->mccr0 &= ~0x00007f00;
+	priv->mccr0 |= divisor << 8;
+	__raw_writel(priv->mccr0, priv->mccr0_base + MCCR0);
 }
 
 static void
 mcp_sa11x0_set_audio_divisor(struct mcp *mcp, unsigned int divisor)
 {
-	unsigned int mccr0;
+	struct mcp_sa11x0 *priv = priv(mcp);
 
 	divisor /= 32;
 
-	mccr0 = Ser4MCCR0 & ~0x0000007f;
-	mccr0 |= divisor;
-	Ser4MCCR0 = mccr0;
+	priv->mccr0 &= ~0x0000007f;
+	priv->mccr0 |= divisor;
+	__raw_writel(priv->mccr0, priv->mccr0_base + MCCR0);
 }
 
 /*
@@ -71,12 +79,16 @@ mcp_sa11x0_write(struct mcp *mcp, unsigned int reg, unsigned int val)
 {
 	int ret = -ETIME;
 	int i;
+	u32 mcpreg;
+	struct mcp_sa11x0 *priv = priv(mcp);
 
-	Ser4MCDR2 = reg << 17 | MCDR2_Wr | (val & 0xffff);
+	mcpreg = reg << 17 | MCDR2_Wr | (val & 0xffff);
+	__raw_writel(mcpreg, priv->mccr0_base + MCDR2);
 
 	for (i = 0; i < 2; i++) {
 		udelay(mcp->rw_timeout);
-		if (Ser4MCSR & MCSR_CWC) {
+		mcpreg = __raw_readl(priv->mccr0_base + MCSR);
+		if (mcpreg & MCSR_CWC) {
 			ret = 0;
 			break;
 		}
@@ -97,13 +109,18 @@ mcp_sa11x0_read(struct mcp *mcp, unsigned int reg)
 {
 	int ret = -ETIME;
 	int i;
+	u32 mcpreg;
+	struct mcp_sa11x0 *priv = priv(mcp);
 
-	Ser4MCDR2 = reg << 17 | MCDR2_Rd;
+	mcpreg = reg << 17 | MCDR2_Rd;
+	__raw_writel(mcpreg, priv->mccr0_base + MCDR2);
 
 	for (i = 0; i < 2; i++) {
 		udelay(mcp->rw_timeout);
-		if (Ser4MCSR & MCSR_CRC) {
-			ret = Ser4MCDR2 & 0xffff;
+		mcpreg = __raw_readl(priv->mccr0_base + MCSR);
+		if (mcpreg & MCSR_CRC) {
+			ret = __raw_readl(priv->mccr0_base + MCDR2)
+				& 0xffff;
 			break;
 		}
 	}
@@ -116,13 +133,19 @@ mcp_sa11x0_read(struct mcp *mcp, unsigned int reg)
 
 static void mcp_sa11x0_enable(struct mcp *mcp)
 {
-	Ser4MCSR = -1;
-	Ser4MCCR0 |= MCCR0_MCE;
+	struct mcp_sa11x0 *priv = priv(mcp);
+
+	__raw_writel(-1, priv->mccr0_base + MCSR);
+	priv->mccr0 |= MCCR0_MCE;
+	__raw_writel(priv->mccr0, priv->mccr0_base + MCCR0);
 }
 
 static void mcp_sa11x0_disable(struct mcp *mcp)
 {
-	Ser4MCCR0 &= ~MCCR0_MCE;
+	struct mcp_sa11x0 *priv = priv(mcp);
+
+	priv->mccr0 &= ~MCCR0_MCE;
+	__raw_writel(priv->mccr0, priv->mccr0_base + MCCR0);
 }
 
 /*
@@ -142,6 +165,9 @@ static int mcp_sa11x0_probe(struct platform_device *pdev)
 	struct mcp_plat_data *data = pdev->dev.platform_data;
 	struct mcp *mcp;
 	int ret;
+	struct mcp_sa11x0 *priv;
+	struct resource *res_mem0, *res_mem1;
+	u32 size0, size1;
 
 	if (!data)
 		return -ENODEV;
@@ -149,46 +175,59 @@ static int mcp_sa11x0_probe(struct platform_device *pdev)
 	if (!data->codec)
 		return -ENODEV;
 
-	if (!request_mem_region(0x80060000, 0x60, "sa11x0-mcp"))
+	res_mem0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res_mem0)
+		return -ENODEV;
+	size0 = res_mem0->end - res_mem0->start + 1;
+
+	res_mem1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res_mem1)
+		return -ENODEV;
+	size1 = res_mem1->end - res_mem1->start + 1;
+
+	if (!request_mem_region(res_mem0->start, size0, "sa11x0-mcp"))
 		return -EBUSY;
 
+	if (!request_mem_region(res_mem1->start, size1, "sa11x0-mcp")) {
+		ret = -EBUSY;
+		goto release;
+	}
+
 	mcp = mcp_host_alloc(&pdev->dev, sizeof(struct mcp_sa11x0));
 	if (!mcp) {
 		ret = -ENOMEM;
-		goto release;
+		goto release2;
 	}
 
+	priv = priv(mcp);
+
 	mcp->owner		= THIS_MODULE;
 	mcp->ops		= &mcp_sa11x0;
 	mcp->sclk_rate		= data->sclk_rate;
-	mcp->dma_audio_rd	= DMA_Ser4MCP0Rd;
-	mcp->dma_audio_wr	= DMA_Ser4MCP0Wr;
-	mcp->dma_telco_rd	= DMA_Ser4MCP1Rd;
-	mcp->dma_telco_wr	= DMA_Ser4MCP1Wr;
+	mcp->dma_audio_rd	= DDAR_DevAdd(res_mem0->start + MCDR0)
+				+ DDAR_DevRd + DDAR_Brst4 + DDAR_8BitDev;
+	mcp->dma_audio_wr	= DDAR_DevAdd(res_mem0->start + MCDR0)
+				+ DDAR_DevWr + DDAR_Brst4 + DDAR_8BitDev;
+	mcp->dma_telco_rd	= DDAR_DevAdd(res_mem0->start + MCDR1)
+				+ DDAR_DevRd + DDAR_Brst4 + DDAR_8BitDev;
+	mcp->dma_telco_wr	= DDAR_DevAdd(res_mem0->start + MCDR1)
+				+ DDAR_DevWr + DDAR_Brst4 + DDAR_8BitDev;
 	mcp->codec		= data->codec;
 
 	platform_set_drvdata(pdev, mcp);
 
-	if (machine_is_assabet()) {
-		ASSABET_BCR_set(ASSABET_BCR_CODEC_RST);
-	}
-
-	/*
-	 * Setup the PPC unit correctly.
-	 */
-	PPDR &= ~PPC_RXD4;
-	PPDR |= PPC_TXD4 | PPC_SCLK | PPC_SFRM;
-	PSDR |= PPC_RXD4;
-	PSDR &= ~(PPC_TXD4 | PPC_SCLK | PPC_SFRM);
-	PPSR &= ~(PPC_TXD4 | PPC_SCLK | PPC_SFRM);
-
 	/*
 	 * Initialise device.  Note that we initially
 	 * set the sampling rate to minimum.
 	 */
-	Ser4MCSR = -1;
-	Ser4MCCR1 = data->mccr1;
-	Ser4MCCR0 = data->mccr0 | 0x7f7f;
+	priv->mccr0_base = ioremap(res_mem0->start, size0);
+	priv->mccr1_base = ioremap(res_mem1->start, size1);
+
+	__raw_writel(-1, priv->mccr0_base + MCSR);
+	priv->mccr1 = data->mccr1;
+	priv->mccr0 = data->mccr0 | 0x7f7f;
+	__raw_writel(priv->mccr0, priv->mccr0_base + MCCR0);
+	__raw_writel(priv->mccr1, priv->mccr1_base + MCCR1);
 
 	/*
 	 * Calculate the read/write timeout (us) from the bit clock
@@ -202,32 +241,49 @@ static int mcp_sa11x0_probe(struct platform_device *pdev)
 	if (ret == 0)
 		goto out;
 
+ release2:
+	release_mem_region(res_mem1->start, size1);
  release:
-	release_mem_region(0x80060000, 0x60);
+	release_mem_region(res_mem0->start, size0);
 	platform_set_drvdata(pdev, NULL);
 
  out:
 	return ret;
 }
 
-static int mcp_sa11x0_remove(struct platform_device *dev)
+static int mcp_sa11x0_remove(struct platform_device *pdev)
 {
-	struct mcp *mcp = platform_get_drvdata(dev);
+	struct mcp *mcp = platform_get_drvdata(pdev);
+	struct mcp_sa11x0 *priv = priv(mcp);
+	struct resource *res_mem;
+	u32 size;
 
-	platform_set_drvdata(dev, NULL);
+	platform_set_drvdata(pdev, NULL);
 	mcp_host_unregister(mcp);
-	release_mem_region(0x80060000, 0x60);
 
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res_mem) {
+		size = res_mem->end - res_mem->start + 1;
+		release_mem_region(res_mem->start, size);
+	}
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (res_mem) {
+		size = res_mem->end - res_mem->start + 1;
+		release_mem_region(res_mem->start, size);
+	}
+	iounmap(priv->mccr0_base);
+	iounmap(priv->mccr1_base);
 	return 0;
 }
 
 static int mcp_sa11x0_suspend(struct platform_device *dev, pm_message_t state)
 {
 	struct mcp *mcp = platform_get_drvdata(dev);
+	struct mcp_sa11x0 *priv = priv(mcp);
+	u32 mccr0;
 
-	priv(mcp)->mccr0 = Ser4MCCR0;
-	priv(mcp)->mccr1 = Ser4MCCR1;
-	Ser4MCCR0 &= ~MCCR0_MCE;
+	mccr0 = priv->mccr0 & ~MCCR0_MCE;
+	__raw_writel(mccr0, priv->mccr0_base + MCCR0);
 
 	return 0;
 }
@@ -235,9 +291,10 @@ static int mcp_sa11x0_suspend(struct platform_device *dev, pm_message_t state)
 static int mcp_sa11x0_resume(struct platform_device *dev)
 {
 	struct mcp *mcp = platform_get_drvdata(dev);
+	struct mcp_sa11x0 *priv = priv(mcp);
 
-	Ser4MCCR1 = priv(mcp)->mccr1;
-	Ser4MCCR0 = priv(mcp)->mccr0;
+	__raw_writel(priv->mccr0, priv->mccr0_base + MCCR0);
+	__raw_writel(priv->mccr1, priv->mccr1_base + MCCR1);
 
 	return 0;
 }
@@ -254,6 +311,7 @@ static struct platform_driver mcp_sa11x0_driver = {
 	.resume		= mcp_sa11x0_resume,
 	.driver		= {
 		.name	= "sa11x0-mcp",
+		.owner  = THIS_MODULE,
 	},
 };
 
-- 
1.7.7.3
