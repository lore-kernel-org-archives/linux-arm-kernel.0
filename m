From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 10 Sep 2010 09:23:20 +0200
Subject: [PATCH 3/6] ARM: S5PC110: Add si470x radio device to the GONI board
In-Reply-To: <1284103403-10696-1-git-send-email-m.szyprowski@samsung.com>
References: <1284103403-10696-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1284103403-10696-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add required platform definitions for si470x radio device on Samsung
Goni board.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig     |    2 ++
 arch/arm/mach-s5pv210/mach-goni.c |   29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index b46925b..b1f671d 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -83,9 +83,11 @@ config MACH_GONI
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
+	select S3C_DEV_I2C1
 	select S5P_DEV_ONENAND
 	select SAMSUNG_DEV_KEYPAD
 	select S5PV210_SETUP_FB_24BPP
+	select S5PV210_SETUP_I2C1
 	select S5PV210_SETUP_KEYPAD
 	select S5PV210_SETUP_SDHCI
 	help
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index b263f3a..30da422 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -38,6 +38,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/fb.h>
+#include <plat/iic.h>
 #include <plat/keypad.h>
 #include <plat/sdhci.h>
 
@@ -200,6 +201,27 @@ static struct samsung_keypad_platdata keypad_data __initdata = {
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
 
@@ -567,6 +589,13 @@ static void __init goni_map_io(void)
 
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
1.7.2.2
