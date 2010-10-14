From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 14 Oct 2010 10:57:43 +0900
Subject: [PATCH v2 2/2] ARM: S5PV210: Add init code of audio to Goni and Auqila
	board
Message-ID: <4CB66397.3090505@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch add initialization code of audio and I2S platform drivers
to Goni and Aquila board.

Signed-off-by : Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by : Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by : Kyungmin Park <kyungmin.park@samsung.com>
Reviewed-by : Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s5pv210/mach-aquila.c |   24 ++++++++++++++++++++++++
 arch/arm/mach-s5pv210/mach-goni.c   |   11 +++++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 0663ec4..a232937 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -507,8 +507,31 @@ static struct platform_device *aquila_devices[] __initdata = {
 	&s5p_device_fimc0,
 	&s5p_device_fimc1,
 	&s5p_device_fimc2,
+	&s5pv210_device_iis0,
 };
 
+static void __init aquila_sound_init(void)
+{
+	unsigned int gpio;
+
+	/* CODEC_XTAL_EN 
+	 *
+	 * The Aquila board have a oscillator which provide main clock
+	 * to WM8994 codec. The oscillator provide 24MHz clock to WM8994
+	 * clock. Set gpio setting of "CODEC_XTAL_EN" to enable a oscillator.
+	 * */
+	gpio = S5PV210_GPH3(2);		/* XEINT_26 */
+	gpio_request(gpio, "CODEC_XTAL_EN");
+	s3c_gpio_cfgpin(gpio, S3C_GPIO_OUTPUT);
+	s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+
+	/* Ths main clock of WM8994 codec uses the output of CLKOUT pin.
+	 * The CLKOUT[9:8] set to 0x3(XUSBXTI) of 0xE010E000(OTHERS) 
+	 * because it needs 24MHz clock to operate WM8994 codec.
+	 */
+	__raw_writel(__raw_readl(S5P_OTHERS) | (0x3 << 8), S5P_OTHERS);
+}
+
 static void __init aquila_map_io(void)
 {
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
@@ -530,6 +553,7 @@ static void __init aquila_machine_init(void)
 	s3c_fimc_setname(2, "s5p-fimc");
 
 	/* SOUND */
+	aquila_sound_init();
 	i2c_register_board_info(AP_I2C_GPIO_BUS_5, i2c_gpio5_devs,
 			ARRAY_SIZE(i2c_gpio5_devs));
 
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index df5c2d1..63855c5 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -488,8 +488,18 @@ static struct platform_device *goni_devices[] __initdata = {
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc1,
 	&s3c_device_hsmmc2,
+	&s5pv210_device_iis0,
 };
 
+static void __init goni_sound_init(void)
+{
+	/* Ths main clock of WM8994 codec uses the output of CLKOUT pin.
+	 * The CLKOUT[9:8] set to 0x3(XUSBXTI) of 0xE010E000(OTHERS) 
+	 * because it needs 24MHz clock to operate WM8994 codec.
+	 */
+	__raw_writel(__raw_readl(S5P_OTHERS) | (0x3 << 8), S5P_OTHERS);
+}
+
 static void __init goni_map_io(void)
 {
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
@@ -507,6 +517,7 @@ static void __init goni_machine_init(void)
 	goni_setup_sdhci();
 
 	/* SOUND */
+	goni_sound_init();
 	i2c_register_board_info(AP_I2C_GPIO_BUS_5, i2c_gpio5_devs,
 			ARRAY_SIZE(i2c_gpio5_devs));
 
-- 
1.7.0.4
