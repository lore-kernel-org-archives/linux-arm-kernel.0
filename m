From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Nov 2009 14:13:38 +0000
Subject: [PATCH] Allow platforms to control which PXA uarts are registered
Message-ID: <20091105141337.GB21681@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For some platforms, it is inappropriate to register all PXA UARTs.
In some cases, the UARTs may not be used, and in others we may want
to avoid registering the UARTs to allow other drivers (eg, FICP) to
make use of the UART.

In addition, a while back there was a request to be able to pass
platform data to the UART driver.

This patch enables all of this by providing functions platforms can
call to register each individual UART.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---

Note: this patch needs verification that those platforms missing
a call to pxa_set_hwuart_info() really don't use the HWUART - I
think I got it right based upon which are PXA255 based platforms.

 arch/arm/mach-pxa/balloon3.c       |    4 ++++
 arch/arm/mach-pxa/cm-x2xx.c        |    4 ++++
 arch/arm/mach-pxa/cm-x300.c        |    4 ++++
 arch/arm/mach-pxa/colibri-pxa270.c |    3 +++
 arch/arm/mach-pxa/colibri-pxa300.c |    4 ++++
 arch/arm/mach-pxa/colibri-pxa320.c |    4 ++++
 arch/arm/mach-pxa/corgi.c          |    4 ++++
 arch/arm/mach-pxa/csb726.c         |    3 +++
 arch/arm/mach-pxa/devices.c        |   26 +++++++++++++++++++++++++-
 arch/arm/mach-pxa/e330.c           |    3 +++
 arch/arm/mach-pxa/e350.c           |    3 +++
 arch/arm/mach-pxa/e400.c           |    3 +++
 arch/arm/mach-pxa/e740.c           |    3 +++
 arch/arm/mach-pxa/e750.c           |    3 +++
 arch/arm/mach-pxa/e800.c           |    3 +++
 arch/arm/mach-pxa/em-x270.c        |    4 ++++
 arch/arm/mach-pxa/ezx.c            |    3 +++
 arch/arm/mach-pxa/generic.h        |    5 +++++
 arch/arm/mach-pxa/gumstix.c        |    5 +++++
 arch/arm/mach-pxa/h5000.c          |    3 +++
 arch/arm/mach-pxa/himalaya.c       |    3 +++
 arch/arm/mach-pxa/hx4700.c         |    4 ++++
 arch/arm/mach-pxa/idp.c            |    3 +++
 arch/arm/mach-pxa/imote2.c         |    6 +++++-
 arch/arm/mach-pxa/littleton.c      |    4 ++++
 arch/arm/mach-pxa/lpd270.c         |    4 ++++
 arch/arm/mach-pxa/lubbock.c        |    4 ++++
 arch/arm/mach-pxa/magician.c       |    4 ++++
 arch/arm/mach-pxa/mainstone.c      |    4 ++++
 arch/arm/mach-pxa/mioa701.c        |    3 +++
 arch/arm/mach-pxa/mp900.c          |    3 +++
 arch/arm/mach-pxa/palmld.c         |    4 ++++
 arch/arm/mach-pxa/palmt5.c         |    4 ++++
 arch/arm/mach-pxa/palmtc.c         |    5 +++++
 arch/arm/mach-pxa/palmte2.c        |    4 ++++
 arch/arm/mach-pxa/palmtx.c         |    4 ++++
 arch/arm/mach-pxa/palmz72.c        |    4 ++++
 arch/arm/mach-pxa/pcm027.c         |    4 ++++
 arch/arm/mach-pxa/poodle.c         |    4 ++++
 arch/arm/mach-pxa/pxa25x.c         |    7 +------
 arch/arm/mach-pxa/pxa27x.c         |    3 ---
 arch/arm/mach-pxa/pxa3xx.c         |    3 ---
 arch/arm/mach-pxa/saar.c           |    4 ++++
 arch/arm/mach-pxa/spitz.c          |    4 ++++
 arch/arm/mach-pxa/stargate2.c      |    4 ++++
 arch/arm/mach-pxa/tavorevb.c       |    4 ++++
 arch/arm/mach-pxa/tosa.c           |    5 +++++
 arch/arm/mach-pxa/treo680.c        |    5 +++++
 arch/arm/mach-pxa/trizeps4.c       |    4 ++++
 arch/arm/mach-pxa/viper.c          |    4 ++++
 arch/arm/mach-pxa/xcep.c           |    5 +++++
 arch/arm/mach-pxa/zylonite.c       |    4 ++++
 52 files changed, 211 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index f23138b..b8cd07c 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -306,6 +306,10 @@ static void __init balloon3_init(void)
 	 */
 	ARB_CNTRL = ARB_CORE_PARK | 0x234;
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	pxa_set_i2c_info(NULL);
 	if (balloon3_has(BALLOON3_FEATURE_AUDIO))
 		pxa_set_ac97_info(NULL);
diff --git a/arch/arm/mach-pxa/cm-x2xx.c b/arch/arm/mach-pxa/cm-x2xx.c
index b50ef39..bff6e78 100644
--- a/arch/arm/mach-pxa/cm-x2xx.c
+++ b/arch/arm/mach-pxa/cm-x2xx.c
@@ -453,6 +453,10 @@ static inline void cmx2xx_init_ac97(void) {}
 
 static void __init cmx2xx_init(void)
 {
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	cmx2xx_pm_init();
 
 	if (cpu_is_pxa25x())
diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 102916f..68496fa 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -438,6 +438,10 @@ static void __init cm_x300_init(void)
 	/* board-processor specific GPIO initialization */
 	pxa3xx_mfp_config(ARRAY_AND_SIZE(cm_x300_mfp_cfg));
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	cm_x300_init_dm9000();
 	cm_x300_init_lcd();
 	cm_x300_init_ohci();
diff --git a/arch/arm/mach-pxa/colibri-pxa270.c b/arch/arm/mach-pxa/colibri-pxa270.c
index 01bcfaa..061c453 100644
--- a/arch/arm/mach-pxa/colibri-pxa270.c
+++ b/arch/arm/mach-pxa/colibri-pxa270.c
@@ -130,6 +130,9 @@ static struct platform_device *colibri_pxa270_devices[] __initdata = {
 static void __init colibri_pxa270_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(colibri_pxa270_pin_config));
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
 	platform_add_devices(ARRAY_AND_SIZE(colibri_pxa270_devices));
 }
 
diff --git a/arch/arm/mach-pxa/colibri-pxa300.c b/arch/arm/mach-pxa/colibri-pxa300.c
index 37c239c..45c23fd 100644
--- a/arch/arm/mach-pxa/colibri-pxa300.c
+++ b/arch/arm/mach-pxa/colibri-pxa300.c
@@ -170,6 +170,10 @@ static inline void colibri_pxa310_init_ac97(void) {}
 
 void __init colibri_pxa300_init(void)
 {
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	colibri_pxa300_init_eth();
 	colibri_pxa300_init_ohci();
 	colibri_pxa3xx_init_nand();
diff --git a/arch/arm/mach-pxa/colibri-pxa320.c b/arch/arm/mach-pxa/colibri-pxa320.c
index 4945728..520d7b3 100644
--- a/arch/arm/mach-pxa/colibri-pxa320.c
+++ b/arch/arm/mach-pxa/colibri-pxa320.c
@@ -197,6 +197,10 @@ static void __init colibri_pxa320_init_uart(void)
 
 void __init colibri_pxa320_init(void)
 {
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	colibri_pxa320_init_eth();
 	colibri_pxa320_init_ohci();
 	colibri_pxa3xx_init_nand();
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index b536b5a..74446cf 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -671,6 +671,10 @@ static void __init corgi_init(void)
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(corgi_pin_config));
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	corgi_init_spi();
 
  	pxa_set_udc_info(&udc_info);
diff --git a/arch/arm/mach-pxa/csb726.c b/arch/arm/mach-pxa/csb726.c
index 965480e..88575b8 100644
--- a/arch/arm/mach-pxa/csb726.c
+++ b/arch/arm/mach-pxa/csb726.c
@@ -268,6 +268,9 @@ static void __init csb726_init(void)
 /*	MSC2 = 0x06697ff4; *//* none/SM501 */
 	MSC2 = (MSC2 & ~0xffff) | 0x7ff4; /* SM501 */
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
 	pxa_set_i2c_info(NULL);
 	pxa27x_set_i2c_power_info(NULL);
 	pxa_set_mci_info(&csb726_mci);
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 46fabe1..86c53a4 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -15,6 +15,7 @@
 #include <mach/camera.h>
 #include <mach/audio.h>
 #include <mach/pxa3xx_nand.h>
+#include <mach/hardware.h>
 
 #include "devices.h"
 #include "generic.h"
@@ -167,13 +168,18 @@ static struct resource pxa_resource_ffuart[] = {
 	}
 };
 
-struct platform_device pxa_device_ffuart= {
+struct platform_device pxa_device_ffuart = {
 	.name		= "pxa2xx-uart",
 	.id		= 0,
 	.resource	= pxa_resource_ffuart,
 	.num_resources	= ARRAY_SIZE(pxa_resource_ffuart),
 };
 
+void __init pxa_set_ffuart_info(void *info)
+{
+	pxa_register_device(&pxa_device_ffuart, info);
+}
+
 static struct resource pxa_resource_btuart[] = {
 	{
 		.start	= 0x40200000,
@@ -193,6 +199,11 @@ struct platform_device pxa_device_btuart = {
 	.num_resources	= ARRAY_SIZE(pxa_resource_btuart),
 };
 
+void __init pxa_set_btuart_info(void *info)
+{
+	pxa_register_device(&pxa_device_btuart, info);
+}
+
 static struct resource pxa_resource_stuart[] = {
 	{
 		.start	= 0x40700000,
@@ -212,6 +223,11 @@ struct platform_device pxa_device_stuart = {
 	.num_resources	= ARRAY_SIZE(pxa_resource_stuart),
 };
 
+void __init pxa_set_stuart_info(void *info)
+{
+	pxa_register_device(&pxa_device_stuart, info);
+}
+
 static struct resource pxa_resource_hwuart[] = {
 	{
 		.start	= 0x41600000,
@@ -231,6 +247,14 @@ struct platform_device pxa_device_hwuart = {
 	.num_resources	= ARRAY_SIZE(pxa_resource_hwuart),
 };
 
+void __init pxa_set_hwuart_info(void *info)
+{
+	if (cpu_is_pxa255())
+		pxa_register_device(&pxa_device_hwuart, info);
+	else
+		pr_info("UART: Ignoring attempt to register HWUART on non-PXA255 hardware");
+}
+
 static struct resource pxai2c_resources[] = {
 	{
 		.start	= 0x40301680,
diff --git a/arch/arm/mach-pxa/e330.c b/arch/arm/mach-pxa/e330.c
index 74d3f89..8fde338 100644
--- a/arch/arm/mach-pxa/e330.c
+++ b/arch/arm/mach-pxa/e330.c
@@ -55,6 +55,9 @@ static struct platform_device *devices[] __initdata = {
 
 static void __init e330_init(void)
 {
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
 	eseries_register_clks();
 	eseries_get_tmio_gpios();
 	platform_add_devices(devices, ARRAY_SIZE(devices));
diff --git a/arch/arm/mach-pxa/e350.c b/arch/arm/mach-pxa/e350.c
index 0800362..f50f055 100644
--- a/arch/arm/mach-pxa/e350.c
+++ b/arch/arm/mach-pxa/e350.c
@@ -56,6 +56,9 @@ static struct platform_device *devices[] __initdata = {
 
 static void __init e350_init(void)
 {
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
 	eseries_register_clks();
 	eseries_get_tmio_gpios();
 	platform_add_devices(devices, ARRAY_SIZE(devices));
diff --git a/arch/arm/mach-pxa/e400.c b/arch/arm/mach-pxa/e400.c
index ed9c0c3..55b950f 100644
--- a/arch/arm/mach-pxa/e400.c
+++ b/arch/arm/mach-pxa/e400.c
@@ -130,6 +130,9 @@ static struct platform_device *devices[] __initdata = {
 static void __init e400_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(e400_pin_config));
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
 	/* Fixme - e400 may have a switched clock */
 	eseries_register_clks();
 	eseries_get_tmio_gpios();
diff --git a/arch/arm/mach-pxa/e740.c b/arch/arm/mach-pxa/e740.c
index 49acdfa..94b23a9 100644
--- a/arch/arm/mach-pxa/e740.c
+++ b/arch/arm/mach-pxa/e740.c
@@ -192,6 +192,9 @@ static struct platform_device *devices[] __initdata = {
 static void __init e740_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(e740_pin_config));
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
 	eseries_register_clks();
 	clk_add_alias("CLK_CK48M", e740_t7l66xb_device.name,
 			"UDCCLK", &pxa25x_device_udc.dev),
diff --git a/arch/arm/mach-pxa/e750.c b/arch/arm/mach-pxa/e750.c
index 4052ece..5eccbce 100644
--- a/arch/arm/mach-pxa/e750.c
+++ b/arch/arm/mach-pxa/e750.c
@@ -194,6 +194,9 @@ static struct platform_device *devices[] __initdata = {
 static void __init e750_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(e750_pin_config));
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
 	clk_add_alias("CLK_CK3P6MI", e750_tc6393xb_device.name,
 			"GPIO11_CLK", NULL),
 	eseries_get_tmio_gpios();
diff --git a/arch/arm/mach-pxa/e800.c b/arch/arm/mach-pxa/e800.c
index 9866c7b..aad129b 100644
--- a/arch/arm/mach-pxa/e800.c
+++ b/arch/arm/mach-pxa/e800.c
@@ -195,6 +195,9 @@ static struct platform_device *devices[] __initdata = {
 
 static void __init e800_init(void)
 {
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
 	clk_add_alias("CLK_CK3P6MI", e800_tc6393xb_device.name,
 			"GPIO11_CLK", NULL),
 	eseries_get_tmio_gpios();
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index aec7f42..e0b0fda 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -1286,6 +1286,10 @@ static void __init em_x270_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(common_pin_config));
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 #ifdef CONFIG_PM
 	pxa27x_set_pwrmode(PWRMODE_DEEPSLEEP);
 #endif
diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index 588b265..0dca63e 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -971,6 +971,9 @@ static void __init e2_init(void)
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(gen2_pin_config));
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(e2_pin_config));
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
 	pxa_set_i2c_info(NULL);
 	i2c_register_board_info(0, ARRAY_AND_SIZE(e2_i2c_board_info));
 
diff --git a/arch/arm/mach-pxa/generic.h b/arch/arm/mach-pxa/generic.h
index 485fede..890fb90 100644
--- a/arch/arm/mach-pxa/generic.h
+++ b/arch/arm/mach-pxa/generic.h
@@ -67,3 +67,8 @@ extern struct sysdev_class pxa_irq_sysclass;
 extern struct sysdev_class pxa_gpio_sysclass;
 extern struct sysdev_class pxa2xx_mfp_sysclass;
 extern struct sysdev_class pxa3xx_mfp_sysclass;
+
+void __init pxa_set_ffuart_info(void *info);
+void __init pxa_set_btuart_info(void *info);
+void __init pxa_set_stuart_info(void *info);
+void __init pxa_set_hwuart_info(void *info);
diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
index 1708c01..96c3451 100644
--- a/arch/arm/mach-pxa/gumstix.c
+++ b/arch/arm/mach-pxa/gumstix.c
@@ -211,6 +211,11 @@ static void __init gumstix_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(gumstix_pin_config));
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+	pxa_set_hwuart_info(NULL);
+
 	gumstix_bluetooth_init();
 	gumstix_udc_init();
 	gumstix_mmc_init();
diff --git a/arch/arm/mach-pxa/h5000.c b/arch/arm/mach-pxa/h5000.c
index f3d220c..c1cab08 100644
--- a/arch/arm/mach-pxa/h5000.c
+++ b/arch/arm/mach-pxa/h5000.c
@@ -193,6 +193,9 @@ static void __init h5000_init(void)
 	fix_msc();
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(h5000_pin_config));
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
 	pxa_set_udc_info(&h5000_udc_mach_info);
 	platform_add_devices(ARRAY_AND_SIZE(devices));
 }
diff --git a/arch/arm/mach-pxa/himalaya.c b/arch/arm/mach-pxa/himalaya.c
index cea99fe..f9a2e4b 100644
--- a/arch/arm/mach-pxa/himalaya.c
+++ b/arch/arm/mach-pxa/himalaya.c
@@ -150,6 +150,9 @@ static void __init himalaya_lcd_init(void)
 
 static void __init himalaya_init(void)
 {
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
 	himalaya_lcd_init();
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index abff9e1..458fd78 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -849,6 +849,10 @@ static void __init hx4700_init(void)
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(hx4700_pin_config));
 	hx4700_gpio_request(ARRAY_AND_SIZE(global_gpios));
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	pxa_set_ficp_info(&ficp_info);
diff --git a/arch/arm/mach-pxa/idp.c b/arch/arm/mach-pxa/idp.c
index b6486ef..5c9e11d 100644
--- a/arch/arm/mach-pxa/idp.c
+++ b/arch/arm/mach-pxa/idp.c
@@ -179,6 +179,9 @@ static void __init idp_init(void)
 	printk("idp_init()\n");
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(idp_pin_config));
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
 
 	platform_device_register(&smc91x_device);
 	//platform_device_register(&mst_audio_device);
diff --git a/arch/arm/mach-pxa/imote2.c b/arch/arm/mach-pxa/imote2.c
index 2a4945d..5b0862d 100644
--- a/arch/arm/mach-pxa/imote2.c
+++ b/arch/arm/mach-pxa/imote2.c
@@ -554,8 +554,12 @@ static struct i2c_pxa_platform_data i2c_pdata = {
 
 static void __init imote2_init(void)
 {
-
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(imote2_pin_config));
+
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	/* SPI chip select directions - all other directions should
 	 * be handled by drivers.*/
 	gpio_direction_output(37, 0);
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index 1384895..bc761fc 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -413,6 +413,10 @@ static void __init littleton_init(void)
 	/* initialize MFP configurations */
 	pxa3xx_mfp_config(ARRAY_AND_SIZE(littleton_mfp_cfg));
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	/*
 	 * Note: we depend bootloader set the correct
 	 * value to MSC register for SMC91x.
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index d64395f..1373c22 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -455,6 +455,10 @@ static void __init lpd270_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(lpd270_pin_config));
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	lpd270_flash_data[0].width = (BOOT_DEF & 1) ? 2 : 4;
 	lpd270_flash_data[1].width = 4;
 
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index c6a94d3..98ee7e5 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -518,6 +518,10 @@ static void __init lubbock_init(void)
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(lubbock_pin_config));
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	clk_add_alias("SA1111_CLK", NULL, "GPIO11_CLK", NULL);
 	pxa_set_udc_info(&udc_info);
 	set_pxa_fb_info(&sharp_lm8v31);
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 5360c07..8a38d60 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -742,6 +742,10 @@ static void __init magician_init(void)
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(magician_pin_config));
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	platform_add_devices(ARRAY_AND_SIZE(devices));
 
 	err = gpio_request(GPIO83_MAGICIAN_nIR_EN, "nIR_EN");
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index a4eeae3..851ee0f 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -576,6 +576,10 @@ static void __init mainstone_init(void)
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(mainstone_pin_config));
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	mst_flash_data[0].width = (BOOT_DEF & 1) ? 2 : 4;
 	mst_flash_data[1].width = 4;
 
diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index 3cab452..2466a44 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -798,6 +798,9 @@ static void __init mioa701_machine_init(void)
 	UP2OCR = UP2OCR_HXOE;
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(mioa701_pin_config));
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
 	mio_gpio_request(ARRAY_AND_SIZE(global_gpios));
 	bootstrap_init();
 	set_pxa_fb_info(&mioa701_pxafb_info);
diff --git a/arch/arm/mach-pxa/mp900.c b/arch/arm/mach-pxa/mp900.c
index a65713c..6d45039 100644
--- a/arch/arm/mach-pxa/mp900.c
+++ b/arch/arm/mach-pxa/mp900.c
@@ -84,6 +84,9 @@ static struct platform_device *devices[] __initdata = {
 static void __init mp900c_init(void)
 {
 	printk(KERN_INFO "MobilePro 900/C machine init\n");
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
 
diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
index 1ad029d..5914021 100644
--- a/arch/arm/mach-pxa/palmld.c
+++ b/arch/arm/mach-pxa/palmld.c
@@ -530,6 +530,10 @@ static void __init palmld_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmld_pin_config));
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	palmld_pm_init();
 	set_pxa_fb_info(&palmld_lcd_screen);
 	pxa_set_mci_info(&palmld_mci_platform_data);
diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
index 2dd7ce2..7f89ca2 100644
--- a/arch/arm/mach-pxa/palmt5.c
+++ b/arch/arm/mach-pxa/palmt5.c
@@ -419,6 +419,10 @@ static void __init palmt5_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmt5_pin_config));
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	palmt5_pm_init();
 	set_pxa_fb_info(&palmt5_lcd_screen);
 	pxa_set_mci_info(&palmt5_mci_platform_data);
diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
index 0b92291..3084175 100644
--- a/arch/arm/mach-pxa/palmtc.c
+++ b/arch/arm/mach-pxa/palmtc.c
@@ -416,6 +416,11 @@ static void __init palmtc_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmtc_pin_config));
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+	pxa_set_hwuart_info(NULL);
+
 	set_pxa_fb_info(&palmtc_lcd_screen);
 	pxa_set_mci_info(&palmtc_mci_platform_data);
 	pxa_set_udc_info(&palmtc_udc_info);
diff --git a/arch/arm/mach-pxa/palmte2.c b/arch/arm/mach-pxa/palmte2.c
index 277c406..265d62b 100644
--- a/arch/arm/mach-pxa/palmte2.c
+++ b/arch/arm/mach-pxa/palmte2.c
@@ -373,6 +373,10 @@ static void __init palmte2_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmte2_pin_config));
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	set_pxa_fb_info(&palmte2_lcd_screen);
 	pxa_set_mci_info(&palmte2_mci_platform_data);
 	palmte2_udc_init();
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index 76a2b37..7bf18c2 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -570,6 +570,10 @@ static void __init palmtx_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmtx_pin_config));
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	palmtx_pm_init();
 	set_pxa_fb_info(&palmtx_lcd_screen);
 	pxa_set_mci_info(&palmtx_mci_platform_data);
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index c2bf493..d787ac7 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -491,6 +491,10 @@ static void __init palmz72_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmz72_pin_config));
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	set_pxa_fb_info(&palmz72_lcd_screen);
 	pxa_set_mci_info(&palmz72_mci_platform_data);
 	palmz72_udc_init();
diff --git a/arch/arm/mach-pxa/pcm027.c b/arch/arm/mach-pxa/pcm027.c
index 6abfa29..2190af0 100644
--- a/arch/arm/mach-pxa/pcm027.c
+++ b/arch/arm/mach-pxa/pcm027.c
@@ -227,6 +227,10 @@ static void __init pcm027_init(void)
 
 	pxa2xx_mfp_config(pcm027_pin_config, ARRAY_SIZE(pcm027_pin_config));
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	/* at last call the baseboard to initialize itself */
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index a186994..e5eeb3a 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -449,6 +449,10 @@ static void __init poodle_init(void)
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(poodle_pin_config));
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	platform_scoop_config = &poodle_pcmcia_config;
 
 	ret = platform_add_devices(devices, ARRAY_SIZE(devices));
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 77c2693..2c1b0b7 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -322,9 +322,6 @@ void __init pxa26x_init_irq(void)
 
 static struct platform_device *pxa25x_devices[] __initdata = {
 	&pxa25x_device_udc,
-	&pxa_device_ffuart,
-	&pxa_device_btuart,
-	&pxa_device_stuart,
 	&pxa_device_i2s,
 	&sa1100_device_rtc,
 	&pxa25x_device_ssp,
@@ -372,10 +369,8 @@ static int __init pxa25x_init(void)
 	}
 
 	/* Only add HWUART for PXA255/26x; PXA210/250 do not have it. */
-	if (cpu_is_pxa255()) {
+	if (cpu_is_pxa255())
 		clks_register(&pxa25x_hwuart_clkreg, 1);
-		ret = platform_device_register(&pxa_device_hwuart);
-	}
 
 	return ret;
 }
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index ec68cc1..6a0b731 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -364,9 +364,6 @@ void __init pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *info)
 
 static struct platform_device *devices[] __initdata = {
 	&pxa27x_device_udc,
-	&pxa_device_ffuart,
-	&pxa_device_btuart,
-	&pxa_device_stuart,
 	&pxa_device_i2s,
 	&sa1100_device_rtc,
 	&pxa_device_rtc,
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 09b7b1a..f81b900 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -553,9 +553,6 @@ void __init pxa3xx_set_i2c_power_info(struct i2c_pxa_platform_data *info)
 
 static struct platform_device *devices[] __initdata = {
 	&pxa27x_device_udc,
-	&pxa_device_ffuart,
-	&pxa_device_btuart,
-	&pxa_device_stuart,
 	&pxa_device_i2s,
 	&sa1100_device_rtc,
 	&pxa_device_rtc,
diff --git a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c
index 8241a63..0546d0a 100644
--- a/arch/arm/mach-pxa/saar.c
+++ b/arch/arm/mach-pxa/saar.c
@@ -485,6 +485,10 @@ static void __init saar_init(void)
 	/* initialize MFP configurations */
 	pxa3xx_mfp_config(ARRAY_AND_SIZE(saar_mfp_cfg));
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	platform_device_register(&smc91x_device);
 
 	saar_init_i2c();
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 3da45d0..bbd7a85 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -768,6 +768,10 @@ static void __init common_init(void)
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(spitz_pin_config));
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	spitz_init_spi();
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index 3b205b6..a98a434 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -760,6 +760,10 @@ static void __init stargate2_init(void)
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(stargate2_pin_config));
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	/* spi chip selects */
 	gpio_direction_output(37, 0);
 	gpio_direction_output(24, 0);
diff --git a/arch/arm/mach-pxa/tavorevb.c b/arch/arm/mach-pxa/tavorevb.c
index b75353a..f02dcb5 100644
--- a/arch/arm/mach-pxa/tavorevb.c
+++ b/arch/arm/mach-pxa/tavorevb.c
@@ -477,6 +477,10 @@ static void __init tavorevb_init(void)
 	/* initialize MFP configurations */
 	pxa3xx_mfp_config(ARRAY_AND_SIZE(tavorevb_mfp_cfg));
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	platform_device_register(&smc91x_device);
 
 	tavorevb_init_lcd();
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index e81a526..c854c16 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -825,6 +825,11 @@ static void __init tosa_init(void)
 	int dummy;
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(tosa_pin_config));
+
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	gpio_set_wake(MFP_PIN_GPIO1, 1);
 	/* We can't pass to gpio-keys since it will drop the Reset altfunc */
 
diff --git a/arch/arm/mach-pxa/treo680.c b/arch/arm/mach-pxa/treo680.c
index fe08507..fa9ba66 100644
--- a/arch/arm/mach-pxa/treo680.c
+++ b/arch/arm/mach-pxa/treo680.c
@@ -495,6 +495,11 @@ static void __init treo680_init(void)
 {
 	treo680_pm_init();
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(treo680_pin_config));
+
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	pxa_set_keypad_info(&treo680_keypad_platform_data);
 	treo680_lcd_power_init();
 	set_pxa_fb_info(&treo680_lcd_screen);
diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
index 3981e03..0aa858e 100644
--- a/arch/arm/mach-pxa/trizeps4.c
+++ b/arch/arm/mach-pxa/trizeps4.c
@@ -524,6 +524,10 @@ static void __init trizeps4_init(void)
 					ARRAY_SIZE(trizeps4_devices));
 	}
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	if (0)	/* dont know how to determine LCD */
 		set_pxa_fb_info(&sharp_lcd);
 	else
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index d33c232..6c36bd9 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -908,6 +908,10 @@ static void __init viper_init(void)
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(viper_pin_config));
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	/* Wake-up serial console */
 	viper_init_serial_gpio();
 
diff --git a/arch/arm/mach-pxa/xcep.c b/arch/arm/mach-pxa/xcep.c
index 3fd79cb..d3b4e3f 100644
--- a/arch/arm/mach-pxa/xcep.c
+++ b/arch/arm/mach-pxa/xcep.c
@@ -165,6 +165,11 @@ static void __init xcep_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(xcep_pin_config));
 
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+	pxa_set_hwuart_info(NULL);
+
 	/* See Intel XScale Developer's Guide for details */
 	/* Set RDF and RDN to appropriate values (chip select 3 (smc91x)) */
 	MSC1 = (MSC1 & 0xffff) | 0xD5540000;
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index 09784d3..1762882 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -444,6 +444,10 @@ static inline void zylonite_init_ohci(void) {}
 
 static void __init zylonite_init(void)
 {
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+
 	/* board-processor specific initialization */
 	zylonite_pxa300_init();
 	zylonite_pxa320_init();
