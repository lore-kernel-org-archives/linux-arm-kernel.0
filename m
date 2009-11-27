From: acassis@gmail.com (Alan Carvalho de Assis)
Date: Fri, 27 Nov 2009 14:09:54 -0200
Subject: [PATCH] mx27: mxt_td60: Add support to SD/MMC
Message-ID: <1259338194-24132-1-git-send-email-acassis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch configures iomux and i2c io expander in order to add
support to SD/MMC cards on i-MXT TD60.

Signed-off-by: Alan Carvalho de Assis <acassis@gmail.com>
---
 arch/arm/mach-mx2/mxt_td60.c           |   39 ++++++++++++++++++++++++++++++-
 arch/arm/plat-mxc/include/mach/iomux.h |    1 +
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx2/mxt_td60.c b/arch/arm/mach-mx2/mxt_td60.c
index dd251f5..03dbbdc 100644
--- a/arch/arm/mach-mx2/mxt_td60.c
+++ b/arch/arm/mach-mx2/mxt_td60.c
@@ -36,6 +36,7 @@
 #include <mach/iomux.h>
 #include <mach/mxc_nand.h>
 #include <mach/i2c.h>
+#include <linux/i2c/pca953x.h>
 #include <mach/imxfb.h>
 #include <mach/mmc.h>
 
@@ -132,6 +133,7 @@ static unsigned int mxt_td60_pins[] __initdata = {
 	PE21_PF_SD1_D3,
 	PE22_PF_SD1_CMD,
 	PE23_PF_SD1_CLK,
+	PF8_AF_ATA_IORDY,
 	/* SDHC2*/
 	PB4_PF_SD2_D0,
 	PB5_PF_SD2_D1,
@@ -150,7 +152,40 @@ static struct imxi2c_platform_data mxt_td60_i2c_data = {
 	.bitrate = 100000,
 };
 
+/* PCA9557 */
+static int mxt_td60_pca9557_setup(struct i2c_client *client,
+				unsigned gpio_base, unsigned ngpio,
+				void *context)
+{
+	static int mxt_td60_gpio_value[] = {
+		-1, -1, -1, -1, -1, -1, -1, 1
+	};
+	int n;
+
+	for (n = 0; n < ARRAY_SIZE(mxt_td60_gpio_value); ++n) {
+		gpio_request(gpio_base + n, "MXT_TD60 GPIO Exp");
+		if (mxt_td60_gpio_value[n] < 0)
+			gpio_direction_input(gpio_base + n);
+		else
+			gpio_direction_output(gpio_base + n,
+						mxt_td60_gpio_value[n]);
+		gpio_export(gpio_base + n, 0);
+	}
+
+	return 0;
+}
+
+static struct pca953x_platform_data mxt_td60_pca9557_pdata = {
+	.gpio_base	= 240, /* place PCA9557 after all MX27 gpio pins */
+	.invert		= 0, /* Do not invert */
+	.setup		= mxt_td60_pca9557_setup,
+};
+
 static struct i2c_board_info mxt_td60_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("pca9557", 0x18),
+		.platform_data = &mxt_td60_pca9557_pdata,
+	},
 };
 
 static struct imxi2c_platform_data mxt_td60_i2c2_data = {
@@ -201,13 +236,13 @@ static struct imx_fb_platform_data mxt_td60_fb_data = {
 static int mxt_td60_sdhc1_init(struct device *dev, irq_handler_t detect_irq,
 				void *data)
 {
-	return request_irq(IRQ_GPIOE(21), detect_irq, IRQF_TRIGGER_RISING,
+	return request_irq(IRQ_GPIOF(8), detect_irq, IRQF_TRIGGER_FALLING,
 				"sdhc1-card-detect", data);
 }
 
 static void mxt_td60_sdhc1_exit(struct device *dev, void *data)
 {
-	free_irq(IRQ_GPIOE(21), data);
+	free_irq(IRQ_GPIOF(8), data);
 }
 
 static struct imxmmc_platform_data sdhc1_pdata = {
diff --git a/arch/arm/plat-mxc/include/mach/iomux.h b/arch/arm/plat-mxc/include/mach/iomux.h
index 6d49f8a..011cfcd 100644
--- a/arch/arm/plat-mxc/include/mach/iomux.h
+++ b/arch/arm/plat-mxc/include/mach/iomux.h
@@ -123,6 +123,7 @@
 #define IRQ_GPIOC(x)  (IRQ_GPIOB(32) + x)
 #define IRQ_GPIOD(x)  (IRQ_GPIOC(32) + x)
 #define IRQ_GPIOE(x)  (IRQ_GPIOD(32) + x)
+#define IRQ_GPIOF(x)  (IRQ_GPIOE(32) + x)
 
 
 extern void mxc_gpio_mode(int gpio_mode);
-- 
1.6.0.4
