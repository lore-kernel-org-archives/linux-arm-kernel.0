From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 14 Apr 2010 07:08:13 +0800
Subject: [PATCH] pxa: make it clear by converting MMC 'delay_detect' to
	millisecond
Message-ID: <i2lf17812d71004131608tef462c28u861748959c308c97@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 4db1d6645934f49806bd1b49ae4c4176e9b7c843
Author: Eric Miao <eric.y.miao@gmail.com>
Date:   Wed Apr 14 07:00:42 2010 +0800

    [ARM] pxa: make it clear by converting MMC 'delay_detect' to millisecond

    delay_detect in HZ is confusing, convert it to be millisecond based. And
    thus remove those unnecessary call to msecs_to_jiffies() at runtime for
    this field. Other constants are converted assuming HZ == 100, which are
    basically true for those platforms.

    The assignment in csb726.c was incorrect, and is fixed in this patch as
    a result.

    Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index be9dc7a..fdda6be 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -433,7 +433,7 @@ static inline void cm_x300_init_nand(void) {}

 #if defined(CONFIG_MMC) || defined(CONFIG_MMC_MODULE)
 static struct pxamci_platform_data cm_x300_mci_platform_data = {
-	.detect_delay		= 20,
+	.detect_delay_ms	= 200,
 	.ocr_mask		= MMC_VDD_32_33|MMC_VDD_33_34,
 	.gpio_card_detect	= GPIO82_MMC_IRQ,
 	.gpio_card_ro		= GPIO85_MMC_WP,
@@ -454,7 +454,7 @@ static void cm_x300_mci2_exit(struct device *dev,
void *data)
 }

 static struct pxamci_platform_data cm_x300_mci2_platform_data = {
-	.detect_delay		= 20,
+	.detect_delay_ms	= 200,
 	.ocr_mask		= MMC_VDD_32_33|MMC_VDD_33_34,
 	.init 			= cm_x300_mci2_init,
 	.exit			= cm_x300_mci2_exit,
diff --git a/arch/arm/mach-pxa/colibri-pxa3xx.c
b/arch/arm/mach-pxa/colibri-pxa3xx.c
index e6c0a22..199afa2 100644
--- a/arch/arm/mach-pxa/colibri-pxa3xx.c
+++ b/arch/arm/mach-pxa/colibri-pxa3xx.c
@@ -96,7 +96,7 @@ static void colibri_pxa3xx_mci_exit(struct device
*dev, void *data)
 }

 static struct pxamci_platform_data colibri_pxa3xx_mci_platform_data = {
-	.detect_delay		= 20,
+	.detect_delay_ms	= 200,
 	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
 	.init			= colibri_pxa3xx_mci_init,
 	.exit			= colibri_pxa3xx_mci_exit,
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index da3156d..2d41f5c 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -437,6 +437,7 @@ static struct platform_device corgiled_device = {
  * to give the card a chance to fully insert/eject.
  */
 static struct pxamci_platform_data corgi_mci_platform_data = {
+	.detect_delay_ms	= 250,
 	.ocr_mask		= MMC_VDD_32_33|MMC_VDD_33_34,
 	.gpio_card_detect	= -1,
 	.gpio_card_ro		= CORGI_GPIO_nSD_WP,
@@ -679,7 +680,6 @@ static void __init corgi_init(void)
 	corgi_init_spi();

  	pxa_set_udc_info(&udc_info);
-	corgi_mci_platform_data.detect_delay = msecs_to_jiffies(250);
 	pxa_set_mci_info(&corgi_mci_platform_data);
 	pxa_set_ficp_info(&corgi_ficp_platform_data);
 	pxa_set_i2c_info(NULL);
diff --git a/arch/arm/mach-pxa/csb726.c b/arch/arm/mach-pxa/csb726.c
index 88575b8..91fd4fe 100644
--- a/arch/arm/mach-pxa/csb726.c
+++ b/arch/arm/mach-pxa/csb726.c
@@ -125,18 +125,9 @@ static unsigned long csb726_pin_config[] = {
 	GPIO118_I2C_SDA,
 };

-static struct pxamci_platform_data csb726_mci_data;
-
-static int csb726_mci_init(struct device *dev,
-		irq_handler_t detect, void *data)
-{
-	csb726_mci_data.detect_delay = msecs_to_jiffies(500);
-	return 0;
-}
-
 static struct pxamci_platform_data csb726_mci = {
+	.detect_delay_ms	= 500,
 	.ocr_mask		= MMC_VDD_32_33|MMC_VDD_33_34,
-	.init			= csb726_mci_init,
 	/* FIXME setpower */
 	.gpio_card_detect	= CSB726_GPIO_MMC_DETECT,
 	.gpio_card_ro		= CSB726_GPIO_MMC_RO,
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index aab04f3..0517c17 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -626,6 +626,7 @@ static int em_x270_mci_get_ro(struct device *dev)
 }

 static struct pxamci_platform_data em_x270_mci_platform_data = {
+	.detect_delay_ms	= 250,
 	.ocr_mask		= MMC_VDD_20_21|MMC_VDD_21_22|MMC_VDD_22_23|
 				  MMC_VDD_24_25|MMC_VDD_25_26|MMC_VDD_26_27|
 				  MMC_VDD_27_28|MMC_VDD_28_29|MMC_VDD_29_30|
@@ -643,7 +644,6 @@ static void __init em_x270_init_mmc(void)
 	if (machine_is_em_x270())
 		em_x270_mci_platform_data.get_ro = em_x270_mci_get_ro;

-	em_x270_mci_platform_data.detect_delay	= msecs_to_jiffies(250);
 	pxa_set_mci_info(&em_x270_mci_platform_data);
 }
 #else
diff --git a/arch/arm/mach-pxa/include/mach/mmc.h
b/arch/arm/mach-pxa/include/mach/mmc.h
index 02a69dc..9eb515b 100644
--- a/arch/arm/mach-pxa/include/mach/mmc.h
+++ b/arch/arm/mach-pxa/include/mach/mmc.h
@@ -9,7 +9,7 @@ struct mmc_host;

 struct pxamci_platform_data {
 	unsigned int ocr_mask;			/* available voltages */
-	unsigned long detect_delay;		/* delay in jiffies before detecting
cards after interrupt */
+	unsigned long detect_delay_ms;		/* delay in millisecond before
detecting cards after interrupt */
 	int (*init)(struct device *, irq_handler_t , void *);
 	int (*get_ro)(struct device *);
 	void (*setpower)(struct device *, unsigned int);
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index fa527b2..b3bffe7 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -272,7 +272,7 @@ static inline void littleton_init_keypad(void) {}

 #if defined(CONFIG_MMC_PXA) || defined(CONFIG_MMC_PXA_MODULE)
 static struct pxamci_platform_data littleton_mci_platform_data = {
-	.detect_delay		= 20,
+	.detect_delay_ms	= 200,
 	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
 	.gpio_card_detect	= GPIO_MMC1_CARD_DETECT,
 	.gpio_card_ro		= -1,
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index 63d65a2..330c328 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -478,7 +478,7 @@ static void lubbock_mci_exit(struct device *dev, void *data)

 static struct pxamci_platform_data lubbock_mci_platform_data = {
 	.ocr_mask		= MMC_VDD_32_33|MMC_VDD_33_34,
-	.detect_delay		= 1,
+	.detect_delay_ms	= 10,
 	.init 			= lubbock_mci_init,
 	.get_ro			= lubbock_mci_get_ro,
 	.exit 			= lubbock_mci_exit,
diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index 843fcca..1538ccc 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -425,6 +425,7 @@ struct gpio_vbus_mach_info gpio_vbus_data = {
  * to give the card a chance to fully insert/eject.
  */
 static struct pxamci_platform_data mioa701_mci_info = {
+	.detect_delay_ms	= 250,
 	.ocr_mask 		= MMC_VDD_32_33 | MMC_VDD_33_34,
 	.gpio_card_detect	= GPIO15_SDIO_INSERT,
 	.gpio_card_ro		= GPIO78_SDIO_RO,
@@ -790,7 +791,6 @@ static void __init mioa701_machine_init(void)
 	mio_gpio_request(ARRAY_AND_SIZE(global_gpios));
 	bootstrap_init();
 	set_pxa_fb_info(&mioa701_pxafb_info);
-	mioa701_mci_info.detect_delay = msecs_to_jiffies(250);
 	pxa_set_mci_info(&mioa701_mci_info);
 	pxa_set_keypad_info(&mioa701_keypad_info);
 	wm97xx_bat_set_pdata(&mioa701_battery_data);
diff --git a/arch/arm/mach-pxa/mxm8x10.c b/arch/arm/mach-pxa/mxm8x10.c
index 8c9c6f0..462167a 100644
--- a/arch/arm/mach-pxa/mxm8x10.c
+++ b/arch/arm/mach-pxa/mxm8x10.c
@@ -325,7 +325,7 @@ static mfp_cfg_t mfp_cfg[] __initdata = {
 #if defined(CONFIG_MMC)
 static struct pxamci_platform_data mxm_8x10_mci_platform_data = {
 	.ocr_mask = MMC_VDD_32_33 | MMC_VDD_33_34,
-	.detect_delay = 1,
+	.detect_delay_ms = 10,
 	.gpio_card_detect = MXM_8X10_SD_nCD,
 	.gpio_card_ro = MXM_8X10_SD_WP,
 	.gpio_power = -1
diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
index f70c75b..1963819 100644
--- a/arch/arm/mach-pxa/palmld.c
+++ b/arch/arm/mach-pxa/palmld.c
@@ -168,7 +168,7 @@ static struct pxamci_platform_data
palmld_mci_platform_data = {
 	.gpio_card_detect	= GPIO_NR_PALMLD_SD_DETECT_N,
 	.gpio_card_ro		= GPIO_NR_PALMLD_SD_READONLY,
 	.gpio_power		= GPIO_NR_PALMLD_SD_POWER,
-	.detect_delay		= 20,
+	.detect_delay_ms	= 200,
 };

 /******************************************************************************
diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
index d902a81..5305a39 100644
--- a/arch/arm/mach-pxa/palmt5.c
+++ b/arch/arm/mach-pxa/palmt5.c
@@ -110,7 +110,7 @@ static struct pxamci_platform_data
palmt5_mci_platform_data = {
 	.gpio_card_detect	= GPIO_NR_PALMT5_SD_DETECT_N,
 	.gpio_card_ro		= GPIO_NR_PALMT5_SD_READONLY,
 	.gpio_power		= GPIO_NR_PALMT5_SD_POWER,
-	.detect_delay		= 20,
+	.detect_delay_ms	= 200,
 };

 /******************************************************************************
diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
index 717d7a6..033b567 100644
--- a/arch/arm/mach-pxa/palmtc.c
+++ b/arch/arm/mach-pxa/palmtc.c
@@ -121,7 +121,7 @@ static struct pxamci_platform_data
palmtc_mci_platform_data = {
 	.gpio_power		= GPIO_NR_PALMTC_SD_POWER,
 	.gpio_card_ro		= GPIO_NR_PALMTC_SD_READONLY,
 	.gpio_card_detect	= GPIO_NR_PALMTC_SD_DETECT_N,
-	.detect_delay		= 20,
+	.detect_delay_ms	= 200,
 };

 /******************************************************************************
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index 007b58c..ecc1a40 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -170,7 +170,7 @@ static struct pxamci_platform_data
palmtx_mci_platform_data = {
 	.gpio_card_detect	= GPIO_NR_PALMTX_SD_DETECT_N,
 	.gpio_card_ro		= GPIO_NR_PALMTX_SD_READONLY,
 	.gpio_power		= GPIO_NR_PALMTX_SD_POWER,
-	.detect_delay		= 20,
+	.detect_delay_ms	= 200,
 };

 /******************************************************************************
diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c
b/arch/arm/mach-pxa/pcm990-baseboard.c
index 9d0ecea..f56ae10 100644
--- a/arch/arm/mach-pxa/pcm990-baseboard.c
+++ b/arch/arm/mach-pxa/pcm990-baseboard.c
@@ -326,7 +326,7 @@ static void pcm990_mci_exit(struct device *dev, void *data)
 #define MSECS_PER_JIFFY (1000/HZ)

 static struct pxamci_platform_data pcm990_mci_platform_data = {
-	.detect_delay		= 250 / MSECS_PER_JIFFY,
+	.detect_delay_ms	= 250,
 	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
 	.init 			= pcm990_mci_init,
 	.setpower 		= pcm990_mci_setpower,
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index d58a524..d0fbe3b 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -277,6 +277,7 @@ static void poodle_mci_exit(struct device *dev, void *data)
 }

 static struct pxamci_platform_data poodle_mci_platform_data = {
+	.detect_delay_ms	= 250,
 	.ocr_mask		= MMC_VDD_32_33|MMC_VDD_33_34,
 	.init 			= poodle_mci_init,
 	.setpower 		= poodle_mci_setpower,
@@ -450,7 +451,6 @@ static void __init poodle_init(void)
 	set_pxa_fb_parent(&poodle_locomo_device.dev);
 	set_pxa_fb_info(&poodle_fb_info);
 	pxa_set_udc_info(&udc_info);
-	poodle_mci_platform_data.detect_delay = msecs_to_jiffies(250);
 	pxa_set_mci_info(&poodle_mci_platform_data);
 	pxa_set_ficp_info(&poodle_ficp_platform_data);
 	pxa_set_i2c_info(NULL);
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 3184bdc..e0f85a0 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -716,7 +716,7 @@ static void raumfeld_mci_exit(struct device *dev,
void *data)
 static struct pxamci_platform_data raumfeld_mci_platform_data = {
 	.init			= raumfeld_mci_init,
 	.exit			= raumfeld_mci_exit,
-	.detect_delay		= 20,
+	.detect_delay_ms	= 200,
 	.gpio_card_detect	= -1,
 	.gpio_card_ro		= -1,
 	.gpio_power		= -1,
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 19b5109..9e03e8b 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -537,6 +537,7 @@ static void spitz_mci_setpower(struct device *dev,
unsigned int vdd)
 }

 static struct pxamci_platform_data spitz_mci_platform_data = {
+	.detect_delay_ms	= 250,
 	.ocr_mask		= MMC_VDD_32_33|MMC_VDD_33_34,
 	.setpower 		= spitz_mci_setpower,
 	.gpio_card_detect	= SPITZ_GPIO_nSD_DETECT,
@@ -757,7 +758,6 @@ static void __init common_init(void)
 	spitz_init_spi();

 	platform_add_devices(devices, ARRAY_SIZE(devices));
-	spitz_mci_platform_data.detect_delay = msecs_to_jiffies(250);
 	pxa_set_mci_info(&spitz_mci_platform_data);
 	pxa_set_ohci_info(&spitz_ohci_platform_data);
 	pxa_set_ficp_info(&spitz_ficp_platform_data);
diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index 2041eb1..af40d2a 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -464,8 +464,6 @@ static struct platform_device smc91x_device = {



-static struct pxamci_platform_data stargate2_mci_platform_data;
-
 /*
  * The card detect interrupt isn't debounced so we delay it by 250ms
  * to give the card a chance to fully insert / eject.
@@ -489,8 +487,6 @@ static int stargate2_mci_init(struct device *dev,
 		goto free_power_en;
 	}
 	gpio_direction_input(SG2_GPIO_nSD_DETECT);
-	/* Delay to allow for full insertion */
-	stargate2_mci_platform_data.detect_delay = msecs_to_jiffies(250);

 	err = request_irq(IRQ_GPIO(SG2_GPIO_nSD_DETECT),
 			  stargate2_detect_int,
@@ -529,6 +525,7 @@ static void stargate2_mci_exit(struct device *dev,
void *data)
 }

 static struct pxamci_platform_data stargate2_mci_platform_data = {
+	.detect_delay_ms = 250,
 	.ocr_mask = MMC_VDD_32_33 | MMC_VDD_33_34,
 	.init = stargate2_mci_init,
 	.setpower = stargate2_mci_setpower,
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index ad55279..7512b82 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -275,6 +275,7 @@ static void tosa_mci_exit(struct device *dev, void *data)
 }

 static struct pxamci_platform_data tosa_mci_platform_data = {
+	.detect_delay_ms	= 250,
 	.ocr_mask       	= MMC_VDD_32_33|MMC_VDD_33_34,
 	.init           	= tosa_mci_init,
 	.exit           	= tosa_mci_exit,
@@ -926,7 +927,6 @@ static void __init tosa_init(void)
 	dummy = gpiochip_reserve(TOSA_SCOOP_JC_GPIO_BASE, 12);
 	dummy = gpiochip_reserve(TOSA_TC6393XB_GPIO_BASE, 16);

-	tosa_mci_platform_data.detect_delay = msecs_to_jiffies(250);
 	pxa_set_mci_info(&tosa_mci_platform_data);
 	pxa_set_udc_info(&udc_info);
 	pxa_set_ficp_info(&tosa_ficp_platform_data);
diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
index 797f254..6968911 100644
--- a/arch/arm/mach-pxa/trizeps4.c
+++ b/arch/arm/mach-pxa/trizeps4.c
@@ -349,7 +349,7 @@ static void trizeps4_mci_exit(struct device *dev,
void *data)

 static struct pxamci_platform_data trizeps4_mci_platform_data = {
 	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
-	.detect_delay	= 1,
+	.detect_delay_ms= 10,
 	.init 		= trizeps4_mci_init,
 	.exit		= trizeps4_mci_exit,
 	.get_ro		= NULL,	/* write-protection not supported */
diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
index 0a9647b..d858b97 100644
--- a/arch/arm/mach-pxa/vpac270.c
+++ b/arch/arm/mach-pxa/vpac270.c
@@ -191,7 +191,7 @@ static struct pxamci_platform_data
vpac270_mci_platform_data = {
 	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
 	.gpio_card_detect	= GPIO53_VPAC270_SD_DETECT_N,
 	.gpio_card_ro		= GPIO52_VPAC270_SD_READONLY,
-	.detect_delay		= 20,
+	.detect_delay_ms	= 200,
 };

 static void __init vpac270_mmc_init(void)
diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index c837318..f5d1ae3 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -291,7 +291,7 @@ static struct pxamci_platform_data z2_mci_platform_data = {
 	.gpio_card_detect	= GPIO96_ZIPITZ2_SD_DETECT,
 	.gpio_power		= -1,
 	.gpio_card_ro		= -1,
-	.detect_delay		= 20,
+	.detect_delay_ms	= 200,
 };

 static void __init z2_mmc_init(void)
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index 39896d8..3680f6a 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -644,7 +644,7 @@ static struct pxafb_mach_info zeus_fb_info = {

 static struct pxamci_platform_data zeus_mci_platform_data = {
 	.ocr_mask		= MMC_VDD_32_33|MMC_VDD_33_34,
-	.detect_delay		= HZ/4,
+	.detect_delay_ms	= 250,
 	.gpio_card_detect       = ZEUS_MMC_CD_GPIO,
 	.gpio_card_ro           = ZEUS_MMC_WP_GPIO,
 	.gpio_card_ro_invert	= 1,
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index 2b4043c..c479cbe 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -218,7 +218,7 @@ static inline void zylonite_init_lcd(void) {}

 #if defined(CONFIG_MMC)
 static struct pxamci_platform_data zylonite_mci_platform_data = {
-	.detect_delay	= 20,
+	.detect_delay_ms= 200,
 	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
 	.gpio_card_detect = EXT_GPIO(0),
 	.gpio_card_ro	= EXT_GPIO(2),
@@ -226,7 +226,7 @@ static struct pxamci_platform_data
zylonite_mci_platform_data = {
 };

 static struct pxamci_platform_data zylonite_mci2_platform_data = {
-	.detect_delay	= 20,
+	.detect_delay_ms= 200,
 	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
 	.gpio_card_detect = EXT_GPIO(1),
 	.gpio_card_ro	= EXT_GPIO(3),
@@ -234,7 +234,7 @@ static struct pxamci_platform_data
zylonite_mci2_platform_data = {
 };

 static struct pxamci_platform_data zylonite_mci3_platform_data = {
-	.detect_delay	= 20,
+	.detect_delay_ms= 200,
 	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
 	.gpio_card_detect = EXT_GPIO(30),
 	.gpio_card_ro	= EXT_GPIO(31),
diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 0d783f3..cafd388 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -543,7 +543,7 @@ static irqreturn_t pxamci_detect_irq(int irq, void *devid)
 {
 	struct pxamci_host *host = mmc_priv(devid);

-	mmc_detect_change(devid, host->pdata->detect_delay);
+	mmc_detect_change(devid, msecs_to_jiffies(host->pdata->detect_delay_ms));
 	return IRQ_HANDLED;
 }
