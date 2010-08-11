From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 11 Aug 2010 14:03:58 +0200
Subject: [PATCH 9/9] ARM: S5PV210: add i2c device on Aquila
In-Reply-To: <1281528238-7298-1-git-send-email-m.szyprowski@samsung.com>
References: <1281528238-7298-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1281528238-7298-10-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add i2c bus number 0 on Aquila machine to test i2c device-table approach.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig       |    1 +
 arch/arm/mach-s5pv210/mach-aquila.c |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 4034ea8..8be6195 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -90,6 +90,7 @@ config MACH_AQUILA
 	select S5P_DEV_FIMC1
 	select S5P_DEV_FIMC2
 	select S5PV210_SETUP_FB_24BPP
+	select S5PV210_SETUP_I2C0
 	select S5PV210_SETUP_SDHCI0
 	select S5PV210_SETUP_SDHCI1
 	select S5PV210_SETUP_SDHCI2
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index cb79256..81d2162 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -469,7 +469,10 @@ static void aquila_setup_sdhci(void)
 {
 	gpio_request(AQUILA_EXT_FLASH_EN, "FLASH_EN");
 	gpio_direction_output(AQUILA_EXT_FLASH_EN, 1);
+};
 
+/* I2C0: CAM */
+static struct i2c_board_info i2c0_devs[] __initdata = {
 };
 
 static struct platform_device *aquila_devices[] __initdata = {
@@ -481,6 +484,7 @@ static struct platform_device *aquila_devices[] __initdata = {
 };
 
 static struct s3c_devtable aquila_devtable[] __initdata = {
+	{ .type = SAMSUNG_DEVICE_I2C,		.index = 0 },
 	{ .type = SAMSUNG_DEVICE_FB,		.index = -1, .pdata = &aquila_lcd_pdata},
 	{ .type = SAMSUNG_DEVICE_ONENAND,	.index = -1 },
 	{ .type = SAMSUNG_DEVICE_SDHCI,		.index = 0, .pdata = &aquila_hsmmc0_data},
@@ -501,6 +505,8 @@ static void __init aquila_machine_init(void)
 	aquila_pmic_init();
 	i2c_register_board_info(AP_I2C_GPIO_PMIC_BUS_4, i2c_gpio_pmic_devs,
 			ARRAY_SIZE(i2c_gpio_pmic_devs));
+	i2c_register_board_info(0, i2c0_devs, ARRAY_SIZE(i2c0_devs));
+
 	/* SDHCI */
 	aquila_setup_sdhci();
 
-- 
1.7.1.569.g6f426
