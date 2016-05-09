From: petr@barix.com (Petr Kulhavy)
Date: Mon,  9 May 2016 15:59:48 +0200
Subject: [PATCH] ARM: davinci: remove unused davinci-i2s pdata
Message-ID: <1462802388-25088-1-git-send-email-petr@barix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The davinci-i2s driver ("davinci-mcbsp") does not use platform
data any longer. Remove the dummy pdata provided by the board
drivers dm355, dm365, dm644x and neuros-osd2.

Signed-off-by: Petr Kulhavy <petr@barix.com>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/board-dm355-evm.c   | 4 +---
 arch/arm/mach-davinci/board-dm365-evm.c   | 6 +-----
 arch/arm/mach-davinci/board-dm644x-evm.c  | 4 +---
 arch/arm/mach-davinci/board-neuros-osd2.c | 4 +---
 arch/arm/mach-davinci/davinci.h           | 6 +++---
 arch/arm/mach-davinci/dm355.c             | 3 +--
 arch/arm/mach-davinci/dm365.c             | 3 +--
 arch/arm/mach-davinci/dm644x.c            | 3 +--
 8 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 1844076f6403..18296a99c4d2 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -115,8 +115,6 @@ static struct davinci_i2c_platform_data i2c_pdata = {
 	.scl_pin        = 14,
 };
 
-static struct snd_platform_data dm355_evm_snd_data;
-
 static int dm355evm_mmc_gpios = -EINVAL;
 
 static void dm355evm_mmcsd_gpios(unsigned gpio)
@@ -411,7 +409,7 @@ static __init void dm355_evm_init(void)
 			ARRAY_SIZE(dm355_evm_spi_info));
 
 	/* DM335 EVM uses ASP1; line-out is a stereo mini-jack */
-	dm355_init_asp1(ASP1_TX_EVT_EN | ASP1_RX_EVT_EN, &dm355_evm_snd_data);
+	dm355_init_asp1(ASP1_TX_EVT_EN | ASP1_RX_EVT_EN);
 }
 
 MACHINE_START(DAVINCI_DM355_EVM, "DaVinci DM355 EVM")
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index f073518f621a..e832949bc767 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -176,10 +176,6 @@ static struct at24_platform_data eeprom_info = {
 	.context	= (void *)0x7f00,
 };
 
-static struct snd_platform_data dm365_evm_snd_data __maybe_unused = {
-	.asp_chan_q = EVENTQ_3,
-};
-
 static struct i2c_board_info i2c_info[] = {
 	{
 		I2C_BOARD_INFO("24c256", 0x50),
@@ -763,7 +759,7 @@ static __init void dm365_evm_init(void)
 	evm_init_cpld();
 
 #ifdef CONFIG_SND_DM365_AIC3X_CODEC
-	dm365_init_asp(&dm365_evm_snd_data);
+	dm365_init_asp();
 #elif defined(CONFIG_SND_DM365_VOICE_CODEC)
 	dm365_init_vc(&dm365_evm_snd_data);
 #endif
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 68cc09907828..96a9528e373e 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -264,8 +264,6 @@ static struct platform_device rtc_dev = {
 	.id             = -1,
 };
 
-static struct snd_platform_data dm644x_evm_snd_data;
-
 /*----------------------------------------------------------------------*/
 #ifdef CONFIG_I2C
 /*
@@ -799,7 +797,7 @@ static __init void davinci_evm_init(void)
 	dm644x_init_video(&dm644xevm_capture_cfg, &dm644xevm_display_cfg);
 
 	davinci_serial_init(dm644x_serial_device);
-	dm644x_init_asp(&dm644x_evm_snd_data);
+	dm644x_init_asp();
 
 	/* irlml6401 switches over 1A, in under 8 msec */
 	davinci_setup_usb(1000, 8);
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index 8fcdcf87c47c..ad10017203c1 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -127,8 +127,6 @@ static struct platform_device davinci_fb_device = {
 	.num_resources = 0,
 };
 
-static struct snd_platform_data dm644x_ntosd2_snd_data;
-
 static struct gpio_led ntosd2_leds[] = {
 	{ .name = "led1_green", .gpio = GPIO(10), },
 	{ .name = "led1_red",   .gpio = GPIO(11), },
@@ -200,7 +198,7 @@ static __init void davinci_ntosd2_init(void)
 				ARRAY_SIZE(davinci_ntosd2_devices));
 
 	davinci_serial_init(dm644x_serial_device);
-	dm644x_init_asp(&dm644x_ntosd2_snd_data);
+	dm644x_init_asp();
 
 	soc_info->emac_pdata->phy_id = NEUROS_OSD2_PHY_ID;
 
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index 4ffc37accce0..d1f8e29f1e30 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -85,13 +85,13 @@ int davinci_init_wdt(void);
 void dm355_init(void);
 void dm355_init_spi0(unsigned chipselect_mask,
 		const struct spi_board_info *info, unsigned len);
-void dm355_init_asp1(u32 evt_enable, struct snd_platform_data *pdata);
+void dm355_init_asp1(u32 evt_enable);
 int dm355_init_video(struct vpfe_config *, struct vpbe_config *);
 int dm355_gpio_register(void);
 
 /* DM365 function declarations */
 void dm365_init(void);
-void dm365_init_asp(struct snd_platform_data *pdata);
+void dm365_init_asp(void);
 void dm365_init_vc(struct snd_platform_data *pdata);
 void dm365_init_ks(struct davinci_ks_platform_data *pdata);
 void dm365_init_rtc(void);
@@ -102,7 +102,7 @@ int dm365_gpio_register(void);
 
 /* DM644x function declarations */
 void dm644x_init(void);
-void dm644x_init_asp(struct snd_platform_data *pdata);
+void dm644x_init_asp(void);
 int dm644x_init_video(struct vpfe_config *, struct vpbe_config *);
 int dm644x_gpio_register(void);
 
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 5a19cca7ed6a..d33322ddedab 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -1035,7 +1035,7 @@ static struct davinci_soc_info davinci_soc_info_dm355 = {
 	.sram_len		= SZ_32K,
 };
 
-void __init dm355_init_asp1(u32 evt_enable, struct snd_platform_data *pdata)
+void __init dm355_init_asp1(u32 evt_enable)
 {
 	/* we don't use ASP1 IRQs, or we'd need to mux them ... */
 	if (evt_enable & ASP1_TX_EVT_EN)
@@ -1044,7 +1044,6 @@ void __init dm355_init_asp1(u32 evt_enable, struct snd_platform_data *pdata)
 	if (evt_enable & ASP1_RX_EVT_EN)
 		davinci_cfg_reg(DM355_EVT9_ASP1_RX);
 
-	dm355_asp1_device.dev.platform_data = pdata;
 	platform_device_register(&dm355_asp1_device);
 }
 
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 8aa004b02fe9..95fbfd962c79 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -1138,7 +1138,7 @@ static struct davinci_soc_info davinci_soc_info_dm365 = {
 	.sram_len		= SZ_32K,
 };
 
-void __init dm365_init_asp(struct snd_platform_data *pdata)
+void __init dm365_init_asp(void)
 {
 	davinci_cfg_reg(DM365_MCBSP0_BDX);
 	davinci_cfg_reg(DM365_MCBSP0_X);
@@ -1148,7 +1148,6 @@ void __init dm365_init_asp(struct snd_platform_data *pdata)
 	davinci_cfg_reg(DM365_MCBSP0_BFSR);
 	davinci_cfg_reg(DM365_EVT2_ASP_TX);
 	davinci_cfg_reg(DM365_EVT3_ASP_RX);
-	dm365_asp_device.dev.platform_data = pdata;
 	platform_device_register(&dm365_asp_device);
 }
 
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 0afa279ec460..b437c3730f65 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -921,10 +921,9 @@ static struct davinci_soc_info davinci_soc_info_dm644x = {
 	.sram_len		= SZ_16K,
 };
 
-void __init dm644x_init_asp(struct snd_platform_data *pdata)
+void __init dm644x_init_asp(void)
 {
 	davinci_cfg_reg(DM644X_MCBSP);
-	dm644x_asp_device.dev.platform_data = pdata;
 	platform_device_register(&dm644x_asp_device);
 }
 
-- 
1.9.1
