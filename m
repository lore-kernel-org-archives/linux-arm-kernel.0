From: mike@compulab.co.il (Mike Rapoport)
Date: Wed, 14 Oct 2009 09:20:24 +0200
Subject: [PATCH 07/10] [ARM] pxa/cm-x300: add da9030 support
In-Reply-To: <cover.1255504387.git.mike@compulab.co.il>
References: <cover.1255504387.git.mike@compulab.co.il>
Message-ID: <8f10bd510edc03f3553f36cc77c5abd52dace8f5.1255504387.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Igor Grinberg <grinberg@compulab.co.il>

Register DA9030 PMIC. Use only backlight sub-device for now.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-pxa/cm-x300.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 544758c..9ae2a68 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -27,6 +27,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c/pca953x.h>
 
+#include <linux/mfd/da903x.h>
+
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_gpio.h>
 #include <linux/spi/tdo24m.h>
@@ -552,6 +554,35 @@ static void __init cm_x300_init_rtc(void)
 static inline void cm_x300_init_rtc(void) {}
 #endif
 
+/* DA9030 */
+struct da903x_subdev_info cm_x300_da9030_subdevs[] = {
+	{
+		.name = "da903x-backlight",
+		.id = DA9030_ID_WLED,
+	}
+};
+
+static struct da903x_platform_data cm_x300_da9030_info = {
+	.num_subdevs = ARRAY_SIZE(cm_x300_da9030_subdevs),
+	.subdevs = cm_x300_da9030_subdevs,
+};
+
+static struct i2c_board_info cm_x300_pmic_info = {
+	I2C_BOARD_INFO("da9030", 0x49),
+	.irq = IRQ_GPIO(0),
+	.platform_data = &cm_x300_da9030_info,
+};
+
+static struct i2c_pxa_platform_data cm_x300_pwr_i2c_info = {
+	.use_pio = 1,
+};
+
+static void __init cm_x300_init_da9030(void)
+{
+	pxa3xx_set_i2c_power_info(&cm_x300_pwr_i2c_info);
+	i2c_register_board_info(1, &cm_x300_pmic_info, 1);
+}
+
 static void __init cm_x300_init_wi2wi(void)
 {
 	int bt_reset, wlan_en;
@@ -605,6 +636,7 @@ static void __init cm_x300_init_mfp(void)
 static void __init cm_x300_init(void)
 {
 	cm_x300_init_mfp();
+	cm_x300_init_da9030();
 	cm_x300_init_dm9000();
 	cm_x300_init_lcd();
 	cm_x300_init_ohci();
-- 
1.6.0.6
