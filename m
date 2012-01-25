From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:35:10 +0000
Subject: [PATCH 15/33] MFD: mcp/ucb1x00: separate ucb1x00 driver data from
 the MCP data
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq3wM-0000Yh-Au@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch taken from 5dd7bf59e0 (ARM: sa11x0: Implement autoloading of codec
and codec pdata for mcp bus.) by Jochen Friedrich <jochen@scram.de>.

This adds just the codec data part of the patch.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/collie.c           |    7 ++++++-
 arch/arm/mach-sa1100/include/mach/mcp.h |    2 +-
 arch/arm/mach-sa1100/simpad.c           |    7 ++++++-
 drivers/mfd/mcp-core.c                  |    3 ++-
 drivers/mfd/mcp-sa11x0.c                |    3 +--
 drivers/mfd/ucb1x00-core.c              |    7 ++++---
 include/linux/mfd/mcp.h                 |    3 +--
 include/linux/mfd/ucb1x00.h             |    3 +++
 8 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index efa2bc1..0e73597 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -22,6 +22,7 @@
 #include <linux/tty.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/mfd/ucb1x00.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/timer.h>
@@ -85,10 +86,14 @@ static struct scoop_pcmcia_config collie_pcmcia_config = {
 	.num_devs	= 1,
 };
 
+static struct ucb1x00_plat_data collie_ucb1x00_data = {
+	.gpio_base	= COLLIE_TC35143_GPIO_BASE,
+};
+
 static struct mcp_plat_data collie_mcp_data = {
 	.mccr0		= MCCR0_ADM | MCCR0_ExtClk,
 	.sclk_rate	= 9216000,
-	.gpio_base	= COLLIE_TC35143_GPIO_BASE,
+	.codec_pdata	= &collie_ucb1x00_data,
 };
 
 /*
diff --git a/arch/arm/mach-sa1100/include/mach/mcp.h b/arch/arm/mach-sa1100/include/mach/mcp.h
index ed1a331..4b2860ae 100644
--- a/arch/arm/mach-sa1100/include/mach/mcp.h
+++ b/arch/arm/mach-sa1100/include/mach/mcp.h
@@ -16,7 +16,7 @@ struct mcp_plat_data {
 	u32 mccr0;
 	u32 mccr1;
 	unsigned int sclk_rate;
-	int gpio_base;
+	void *codec_pdata;
 };
 
 #endif
diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index 3aa36ec..74da17a 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -10,6 +10,7 @@
 #include <linux/string.h> 
 #include <linux/pm.h>
 #include <linux/platform_device.h>
+#include <linux/mfd/ucb1x00.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/io.h>
@@ -187,10 +188,14 @@ static struct resource simpad_flash_resources [] = {
 	}
 };
 
+static struct ucb1x00_plat_data simpad_ucb1x00_data = {
+	.gpio_base	= SIMPAD_UCB1X00_GPIO_BASE,
+};
+
 static struct mcp_plat_data simpad_mcp_data = {
 	.mccr0		= MCCR0_ADM,
 	.sclk_rate	= 11981000,
-	.gpio_base	= SIMPAD_UCB1X00_GPIO_BASE,
+	.codec_pdata	= &&simpad_ucb1x00_data,
 };
 
 
diff --git a/drivers/mfd/mcp-core.c b/drivers/mfd/mcp-core.c
index 280a4f8..c409d63 100644
--- a/drivers/mfd/mcp-core.c
+++ b/drivers/mfd/mcp-core.c
@@ -217,8 +217,9 @@ struct mcp *mcp_host_alloc(struct device *parent, size_t size)
 }
 EXPORT_SYMBOL(mcp_host_alloc);
 
-int mcp_host_add(struct mcp *mcp)
+int mcp_host_add(struct mcp *mcp, void *pdata)
 {
+	mcp->attached_device.platform_data = pdata;
 	dev_set_name(&mcp->attached_device, "mcp0");
 	return device_add(&mcp->attached_device);
 }
diff --git a/drivers/mfd/mcp-sa11x0.c b/drivers/mfd/mcp-sa11x0.c
index 420710b..960ebc7 100644
--- a/drivers/mfd/mcp-sa11x0.c
+++ b/drivers/mfd/mcp-sa11x0.c
@@ -194,7 +194,6 @@ static int mcp_sa11x0_probe(struct platform_device *dev)
 	mcp->owner		= THIS_MODULE;
 	mcp->ops		= &mcp_sa11x0;
 	mcp->sclk_rate		= data->sclk_rate;
-	mcp->gpio_base		= data->gpio_base;
 
 	m = priv(mcp);
 	m->mccr0 = data->mccr0 | 0x7f7f;
@@ -229,7 +228,7 @@ static int mcp_sa11x0_probe(struct platform_device *dev)
 	mcp->rw_timeout = (64 * 3 * 1000000 + mcp->sclk_rate - 1) /
 			  mcp->sclk_rate;
 
-	ret = mcp_host_add(mcp);
+	ret = mcp_host_add(mcp, data->codec_pdata);
 	if (ret == 0)
 		return 0;
 
diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
index f2fb420..6825169 100644
--- a/drivers/mfd/ucb1x00-core.c
+++ b/drivers/mfd/ucb1x00-core.c
@@ -534,6 +534,7 @@ static int ucb1x00_probe(struct mcp *mcp)
 {
 	struct ucb1x00 *ucb;
 	struct ucb1x00_driver *drv;
+	struct ucb1x00_plat_data *pdata;
 	unsigned int id;
 	int ret = -ENODEV;
 	int temp;
@@ -551,7 +552,7 @@ static int ucb1x00_probe(struct mcp *mcp)
 	if (!ucb)
 		goto err_disable;
 
-
+	pdata = mcp->attached_device.platform_data;
 	ucb->dev.class = &ucb1x00_class;
 	ucb->dev.parent = &mcp->attached_device;
 	dev_set_name(&ucb->dev, "ucb1x00");
@@ -570,9 +571,9 @@ static int ucb1x00_probe(struct mcp *mcp)
 	}
 
 	ucb->gpio.base = -1;
-	if (mcp->gpio_base != 0) {
+	if (pdata && pdata->gpio_base) {
 		ucb->gpio.label = dev_name(&ucb->dev);
-		ucb->gpio.base = mcp->gpio_base;
+		ucb->gpio.base = pdata->gpio_base;
 		ucb->gpio.ngpio = 10;
 		ucb->gpio.set = ucb1x00_gpio_set;
 		ucb->gpio.get = ucb1x00_gpio_get;
diff --git a/include/linux/mfd/mcp.h b/include/linux/mfd/mcp.h
index dfe7e51..bfcdf6d 100644
--- a/include/linux/mfd/mcp.h
+++ b/include/linux/mfd/mcp.h
@@ -20,7 +20,6 @@ struct mcp {
 	unsigned int	sclk_rate;
 	unsigned int	rw_timeout;
 	struct device	attached_device;
-	int		gpio_base;
 };
 
 struct mcp_ops {
@@ -41,7 +40,7 @@ void mcp_disable(struct mcp *);
 #define mcp_get_sclk_rate(mcp)	((mcp)->sclk_rate)
 
 struct mcp *mcp_host_alloc(struct device *, size_t);
-int mcp_host_add(struct mcp *);
+int mcp_host_add(struct mcp *, void *);
 void mcp_host_del(struct mcp *);
 void mcp_host_free(struct mcp *);
 
diff --git a/include/linux/mfd/ucb1x00.h b/include/linux/mfd/ucb1x00.h
index 4321f04..731b23a 100644
--- a/include/linux/mfd/ucb1x00.h
+++ b/include/linux/mfd/ucb1x00.h
@@ -104,6 +104,9 @@
 #define UCB_MODE_DYN_VFLAG_ENA	(1 << 12)
 #define UCB_MODE_AUD_OFF_CAN	(1 << 13)
 
+struct ucb1x00_plat_data {
+	int			gpio_base;
+};
 
 struct ucb1x00_irq {
 	void *devid;
-- 
1.7.4.4
