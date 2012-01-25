From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:34:09 +0000
Subject: [PATCH 12/33] MFD: mcp-sa11x0: convert mcp-sa11x0 to use platform
 resources
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq3vN-0000YQ-CE@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch taken from af9081ae64 (ARM: sa1100: Refactor mcp-sa11x0 to use
platform resources.) by Jochen Friedrich <jochen@scram.de>, and fixes
applied.

We can safely do this now that we have sanitized host removal; the
original patch had use-after-free bugs in the removal code.  Not only
that, but there was no checking of the ioremap() return.

The final change over Jochen's patch is that we wrap the base pointer
selection inside the various register indexes, which reduces the
possibility of the wrong register index being used.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/generic.c |    5 ++
 drivers/mfd/mcp-sa11x0.c       |  141 ++++++++++++++++++++++++++++------------
 2 files changed, 104 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 1416094..9379c53 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -221,6 +221,11 @@ static struct resource sa11x0mcp_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
+		.start	= __PREG(Ser4MCCR1),
+		.end	= __PREG(Ser4MCCR1) + 4 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[2] = {
 		.start	= IRQ_Ser4MCP,
 		.end	= IRQ_Ser4MCP,
 		.flags	= IORESOURCE_IRQ,
diff --git a/drivers/mfd/mcp-sa11x0.c b/drivers/mfd/mcp-sa11x0.c
index 703e76a..4d06db7 100644
--- a/drivers/mfd/mcp-sa11x0.c
+++ b/drivers/mfd/mcp-sa11x0.c
@@ -13,6 +13,7 @@
  */
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
@@ -30,34 +31,44 @@
 #define DRIVER_NAME "sa11x0-mcp"
 
 struct mcp_sa11x0 {
-	u32	mccr0;
-	u32	mccr1;
+	void __iomem	*base0;
+	void __iomem	*base1;
+	u32		mccr0;
+	u32		mccr1;
 };
 
+/* Register offsets */
+#define MCCR0(m)	((m)->base0 + 0x00)
+#define MCDR0(m)	((m)->base0 + 0x08)
+#define MCDR1(m)	((m)->base0 + 0x0c)
+#define MCDR2(m)	((m)->base0 + 0x10)
+#define MCSR(m)		((m)->base0 + 0x18)
+#define MCCR1(m)	((m)->base1 + 0x00)
+
 #define priv(mcp)	((struct mcp_sa11x0 *)mcp_priv(mcp))
 
 static void
 mcp_sa11x0_set_telecom_divisor(struct mcp *mcp, unsigned int divisor)
 {
-	unsigned int mccr0;
+	struct mcp_sa11x0 *m = priv(mcp);
 
 	divisor /= 32;
 
-	mccr0 = Ser4MCCR0 & ~0x00007f00;
-	mccr0 |= divisor << 8;
-	Ser4MCCR0 = mccr0;
+	m->mccr0 &= ~0x00007f00;
+	m->mccr0 |= divisor << 8;
+	writel_relaxed(m->mccr0, MCCR0(m));
 }
 
 static void
 mcp_sa11x0_set_audio_divisor(struct mcp *mcp, unsigned int divisor)
 {
-	unsigned int mccr0;
+	struct mcp_sa11x0 *m = priv(mcp);
 
 	divisor /= 32;
 
-	mccr0 = Ser4MCCR0 & ~0x0000007f;
-	mccr0 |= divisor;
-	Ser4MCCR0 = mccr0;
+	m->mccr0 &= ~0x0000007f;
+	m->mccr0 |= divisor;
+	writel_relaxed(m->mccr0, MCCR0(m));
 }
 
 /*
@@ -69,14 +80,15 @@ mcp_sa11x0_set_audio_divisor(struct mcp *mcp, unsigned int divisor)
 static void
 mcp_sa11x0_write(struct mcp *mcp, unsigned int reg, unsigned int val)
 {
+	struct mcp_sa11x0 *m = priv(mcp);
 	int ret = -ETIME;
 	int i;
 
-	Ser4MCDR2 = reg << 17 | MCDR2_Wr | (val & 0xffff);
+	writel_relaxed(reg << 17 | MCDR2_Wr | (val & 0xffff), MCDR2(m));
 
 	for (i = 0; i < 2; i++) {
 		udelay(mcp->rw_timeout);
-		if (Ser4MCSR & MCSR_CWC) {
+		if (readl_relaxed(MCSR(m)) & MCSR_CWC) {
 			ret = 0;
 			break;
 		}
@@ -95,15 +107,16 @@ mcp_sa11x0_write(struct mcp *mcp, unsigned int reg, unsigned int val)
 static unsigned int
 mcp_sa11x0_read(struct mcp *mcp, unsigned int reg)
 {
+	struct mcp_sa11x0 *m = priv(mcp);
 	int ret = -ETIME;
 	int i;
 
-	Ser4MCDR2 = reg << 17 | MCDR2_Rd;
+	writel_relaxed(reg << 17 | MCDR2_Rd, MCDR2(m));
 
 	for (i = 0; i < 2; i++) {
 		udelay(mcp->rw_timeout);
-		if (Ser4MCSR & MCSR_CRC) {
-			ret = Ser4MCDR2 & 0xffff;
+		if (readl_relaxed(MCSR(m)) & MCSR_CRC) {
+			ret = readl_relaxed(MCDR2(m)) & 0xffff;
 			break;
 		}
 	}
@@ -116,13 +129,19 @@ mcp_sa11x0_read(struct mcp *mcp, unsigned int reg)
 
 static void mcp_sa11x0_enable(struct mcp *mcp)
 {
-	Ser4MCSR = -1;
-	Ser4MCCR0 |= MCCR0_MCE;
+	struct mcp_sa11x0 *m = priv(mcp);
+
+	writel(-1, MCSR(m));
+	m->mccr0 |= MCCR0_MCE;
+	writel_relaxed(m->mccr0, MCCR0(m));
 }
 
 static void mcp_sa11x0_disable(struct mcp *mcp)
 {
-	Ser4MCCR0 &= ~MCCR0_MCE;
+	struct mcp_sa11x0 *m = priv(mcp);
+
+	m->mccr0 &= ~MCCR0_MCE;
+	writel_relaxed(m->mccr0, MCCR0(m));
 }
 
 /*
@@ -137,22 +156,38 @@ static struct mcp_ops mcp_sa11x0 = {
 	.disable		= mcp_sa11x0_disable,
 };
 
-static int mcp_sa11x0_probe(struct platform_device *pdev)
+static int mcp_sa11x0_probe(struct platform_device *dev)
 {
-	struct mcp_plat_data *data = pdev->dev.platform_data;
+	struct mcp_plat_data *data = dev->dev.platform_data;
+	struct resource *mem0, *mem1;
+	struct mcp_sa11x0 *m;
 	struct mcp *mcp;
 	int ret;
 
 	if (!data)
 		return -ENODEV;
 
-	if (!request_mem_region(0x80060000, 0x60, "sa11x0-mcp"))
-		return -EBUSY;
+	mem0 = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	mem1 = platform_get_resource(dev, IORESOURCE_MEM, 1);
+	if (!mem0 || !mem1)
+		return -ENXIO;
+
+	if (!request_mem_region(mem0->start, resource_size(mem0),
+				DRIVER_NAME)) {
+		ret = -EBUSY;
+		goto err_mem0;
+	}
 
-	mcp = mcp_host_alloc(&pdev->dev, sizeof(struct mcp_sa11x0));
+	if (!request_mem_region(mem1->start, resource_size(mem1),
+				DRIVER_NAME)) {
+		ret = -EBUSY;
+		goto err_mem1;
+	}
+
+	mcp = mcp_host_alloc(&dev->dev, sizeof(struct mcp_sa11x0));
 	if (!mcp) {
 		ret = -ENOMEM;
-		goto release;
+		goto err_alloc;
 	}
 
 	mcp->owner		= THIS_MODULE;
@@ -160,7 +195,18 @@ static int mcp_sa11x0_probe(struct platform_device *pdev)
 	mcp->sclk_rate		= data->sclk_rate;
 	mcp->gpio_base		= data->gpio_base;
 
-	platform_set_drvdata(pdev, mcp);
+	m = priv(mcp);
+	m->mccr0 = data->mccr0 | 0x7f7f;
+	m->mccr1 = data->mccr1;
+
+	m->base0 = ioremap(mem0->start, resource_size(mem0));
+	m->base1 = ioremap(mem1->start, resource_size(mem1));
+	if (!m->base0 || !m->base1) {
+		ret = -ENOMEM;
+		goto err_ioremap;
+	}
+
+	platform_set_drvdata(dev, mcp);
 
 	if (machine_is_assabet()) {
 		ASSABET_BCR_set(ASSABET_BCR_CODEC_RST);
@@ -170,9 +216,9 @@ static int mcp_sa11x0_probe(struct platform_device *pdev)
 	 * Initialise device.  Note that we initially
 	 * set the sampling rate to minimum.
 	 */
-	Ser4MCSR = -1;
-	Ser4MCCR1 = data->mccr1;
-	Ser4MCCR0 = data->mccr0 | 0x7f7f;
+	writel_relaxed(-1, MCSR(m));
+	writel_relaxed(m->mccr1, MCCR1(m));
+	writel_relaxed(m->mccr0, MCCR0(m));
 
 	/*
 	 * Calculate the read/write timeout (us) from the bit clock
@@ -184,46 +230,57 @@ static int mcp_sa11x0_probe(struct platform_device *pdev)
 
 	ret = mcp_host_add(mcp);
 	if (ret == 0)
-		goto out;
+		return 0;
 
-	mcp_host_free(mcp);
- release:
-	release_mem_region(0x80060000, 0x60);
-	platform_set_drvdata(pdev, NULL);
+	platform_set_drvdata(dev, NULL);
 
- out:
+ err_ioremap:
+	iounmap(m->base1);
+	iounmap(m->base0);
+	mcp_host_free(mcp);
+ err_alloc:
+	release_mem_region(mem1->start, resource_size(mem1));
+ err_mem1:
+	release_mem_region(mem0->start, resource_size(mem0));
+ err_mem0:
 	return ret;
 }
 
 static int mcp_sa11x0_remove(struct platform_device *dev)
 {
 	struct mcp *mcp = platform_get_drvdata(dev);
+	struct mcp_sa11x0 *m = priv(mcp);
+	struct resource *mem0, *mem1;
+
+	mem0 = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	mem1 = platform_get_resource(dev, IORESOURCE_MEM, 1);
 
 	platform_set_drvdata(dev, NULL);
 	mcp_host_del(mcp);
+	iounmap(m->base1);
+	iounmap(m->base0);
 	mcp_host_free(mcp);
-	release_mem_region(0x80060000, 0x60);
+	release_mem_region(mem1->start, resource_size(mem1));
+	release_mem_region(mem0->start, resource_size(mem0));
 
 	return 0;
 }
 
 static int mcp_sa11x0_suspend(struct platform_device *dev, pm_message_t state)
 {
-	struct mcp *mcp = platform_get_drvdata(dev);
+	struct mcp_sa11x0 *m = priv(platform_get_drvdata(dev));
 
-	priv(mcp)->mccr0 = Ser4MCCR0;
-	priv(mcp)->mccr1 = Ser4MCCR1;
-	Ser4MCCR0 &= ~MCCR0_MCE;
+	writel(m->mccr0 & ~MCCR0_MCE, MCCR0(m));
 
 	return 0;
 }
 
 static int mcp_sa11x0_resume(struct platform_device *dev)
 {
-	struct mcp *mcp = platform_get_drvdata(dev);
+	struct mcp_sa11x0 *m = priv(platform_get_drvdata(dev));
 
-	Ser4MCCR1 = priv(mcp)->mccr1;
-	Ser4MCCR0 = priv(mcp)->mccr0;
+	writel_relaxed(m->mccr1, MCCR1(m));
+	writel_relaxed(m->mccr0, MCCR0(m));
 
 	return 0;
 }
-- 
1.7.4.4
