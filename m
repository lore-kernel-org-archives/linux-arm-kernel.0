From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 24 Nov 2014 14:03:38 +0530
Subject: [PATCH v6]  i2c: s3c2410: Handle i2c sys_cfg register in i2c driver
Message-ID: <1416818018-6684-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's handle i2c interrupt re-configuration in i2c driver. This will
help us in removing some soc specific checks from machine files and
will help in removing static iomapping of SYS register in exynos.c

Also handle saving and restoring of SYS_I2C_CFG register during
suspend and resume of i2c driver.

CC: Wolfram Sang <wsa@the-dreams.de>
CC: linux-i2c at vger.kernel.org
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
This patch is created from following patch series V5(1/2).

https://patchwork.kernel.org/patch/5354131/

DT and machine (mach-exynos) changes will be posted separately. 


 drivers/i2c/busses/i2c-s3c2410.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 6524477..09a6bac 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -35,6 +35,8 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #include <asm/irq.h>
 
@@ -87,6 +89,9 @@
 /* Max time to wait for bus to become idle after a xfer (in us) */
 #define S3C2410_IDLE_TIMEOUT	5000
 
+/* Exynos5 Sysreg offset */
+#define EXYNOS5_SYS_I2C_CFG	0x0234
+
 /* i2c controller state */
 enum s3c24xx_i2c_state {
 	STATE_IDLE,
@@ -123,6 +128,8 @@ struct s3c24xx_i2c {
 #if defined(CONFIG_ARM_S3C24XX_CPUFREQ)
 	struct notifier_block	freq_transition;
 #endif
+	struct regmap		*sysreg;
+	unsigned int		sys_i2c_cfg;
 };
 
 static struct platform_device_id s3c24xx_driver_ids[] = {
@@ -1071,6 +1078,7 @@ static void
 s3c24xx_i2c_parse_dt(struct device_node *np, struct s3c24xx_i2c *i2c)
 {
 	struct s3c2410_platform_i2c *pdata = i2c->pdata;
+	int id;
 
 	if (!np)
 		return;
@@ -1080,6 +1088,21 @@ s3c24xx_i2c_parse_dt(struct device_node *np, struct s3c24xx_i2c *i2c)
 	of_property_read_u32(np, "samsung,i2c-slave-addr", &pdata->slave_addr);
 	of_property_read_u32(np, "samsung,i2c-max-bus-freq",
 				(u32 *)&pdata->frequency);
+	/*
+	 * Exynos5's legacy i2c controller and new high speed i2c
+	 * controller have muxed interrupt sources. By default the
+	 * interrupts for 4-channel HS-I2C controller are enabled.
+	 * If nodes for first four channels of legacy i2c controller
+	 * are available then re-configure the interrupts via the
+	 * system register.
+	 */
+	id = of_alias_get_id(np, "i2c");
+	i2c->sysreg = syscon_regmap_lookup_by_phandle(np,
+			"samsung,sysreg-phandle");
+	if (IS_ERR(i2c->sysreg))
+		return;
+
+	regmap_update_bits(i2c->sysreg, EXYNOS5_SYS_I2C_CFG, BIT(id), 0);
 }
 #else
 static void
@@ -1260,6 +1283,9 @@ static int s3c24xx_i2c_suspend_noirq(struct device *dev)
 
 	i2c->suspended = 1;
 
+	if (!IS_ERR(i2c->sysreg))
+		regmap_read(i2c->sysreg, EXYNOS5_SYS_I2C_CFG, &i2c->sys_i2c_cfg);
+
 	return 0;
 }
 
@@ -1268,6 +1294,9 @@ static int s3c24xx_i2c_resume_noirq(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct s3c24xx_i2c *i2c = platform_get_drvdata(pdev);
 
+	if (!IS_ERR(i2c->sysreg))
+		regmap_write(i2c->sysreg, EXYNOS5_SYS_I2C_CFG, i2c->sys_i2c_cfg);
+
 	clk_prepare_enable(i2c->clk);
 	s3c24xx_i2c_init(i2c);
 	clk_disable_unprepare(i2c->clk);
-- 
1.7.9.5
