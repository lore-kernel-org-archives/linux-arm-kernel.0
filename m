From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Thu, 19 Aug 2010 17:50:44 +0900
Subject: [PATCH 2/4] ARM: S5PC110: Add si470x radio device to the GONI board
In-Reply-To: <1282207846-4578-1-git-send-email-jy0922.shim@samsung.com>
References: <1282207846-4578-1-git-send-email-jy0922.shim@samsung.com>
Message-ID: <1282207846-4578-2-git-send-email-jy0922.shim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to support si470x radio device to the GONI board.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig     |    2 ++
 arch/arm/mach-s5pv210/mach-goni.c |   30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 3843210..303c8a6 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -88,9 +88,11 @@ config MACH_GONI
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
+	select S3C_DEV_I2C1
 	select S5PC110_DEV_ONENAND
 	select SAMSUNG_DEV_KEYPAD
 	select S5PV210_SETUP_FB_24BPP
+	select S5PV210_SETUP_I2C1
 	select S5PV210_SETUP_KEYPAD
 	select S5PV210_SETUP_SDHCI
 	help
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 2dabd7f..c4f10c8 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -30,6 +30,7 @@
 #include <mach/regs-fb.h>
 
 #include <plat/gpio-cfg.h>
+#include <plat/iic.h>
 #include <plat/regs-serial.h>
 #include <plat/s5pv210.h>
 #include <plat/devs.h>
@@ -134,6 +135,27 @@ static struct samsung_keypad_platdata keypad_data __initdata = {
 	.cols		= 3,
 };
 
+/* Radio */
+static struct i2c_board_info i2c1_devs[] __initdata = {
+	{
+		I2C_BOARD_INFO("si470x", 0x10),
+	},
+};
+
+static void __init goni_radio_init(void)
+{
+	int gpio;
+
+	gpio = S5PV210_GPJ2(4);			/* XMSMDATA_4 */
+	gpio_request(gpio, "FM_INT");
+	s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(0xf));
+	i2c1_devs[0].irq = gpio_to_irq(gpio);
+
+	gpio = S5PV210_GPJ2(5);			/* XMSMDATA_5 */
+	gpio_request(gpio, "FM_RST");
+	gpio_direction_output(gpio, 1);
+}
+
 /* MAX8998 regulators */
 #if defined(CONFIG_REGULATOR_MAX8998) || defined(CONFIG_REGULATOR_MAX8998_MODULE)
 
@@ -488,6 +510,7 @@ static struct platform_device *goni_devices[] __initdata = {
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc1,
 	&s3c_device_hsmmc2,
+	&s3c_device_i2c1,
 	&samsung_device_keypad,
 };
 
@@ -500,6 +523,13 @@ static void __init goni_map_io(void)
 
 static void __init goni_machine_init(void)
 {
+	/* Radio: call before I2C 1 registeration */
+	goni_radio_init();
+
+	/* I2C1 */
+	s3c_i2c1_set_platdata(NULL);
+	i2c_register_board_info(1, i2c1_devs, ARRAY_SIZE(i2c1_devs));
+
 	/* PMIC */
 	goni_pmic_init();
 	i2c_register_board_info(AP_I2C_GPIO_PMIC_BUS_4, i2c_gpio_pmic_devs,
-- 
1.7.0.4
