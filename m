From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 29 Sep 2011 23:19:05 +0800
Subject: [PATCH 4/5] ARM: pxa: use chained irq for GPIO0 and GPIO1
In-Reply-To: <2011092901>
References: <2011092901>
Message-ID: <1317309546-19682-4-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change interrupt of GPIO0 and GPIO1 to chained interrupt. So irq chip of
gpio could be removed from irq.c. So pxa_gpio_to_irq() could be
simplified.

Since IRQ_GPIO() is similar to pxa_gpio_to_irq(), remove IRQ_GPIO().

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/include/mach/gpio.h             |    3 -
 arch/arm/mach-mmp/include/mach/irqs.h             |    3 +-
 arch/arm/mach-mmp/ttc_dkb.c                       |    2 +-
 arch/arm/mach-pxa/am200epd.c                      |    4 +-
 arch/arm/mach-pxa/am300epd.c                      |    4 +-
 arch/arm/mach-pxa/balloon3.c                      |    2 +-
 arch/arm/mach-pxa/cm-x270.c                       |    2 +-
 arch/arm/mach-pxa/cm-x2xx.c                       |    4 +-
 arch/arm/mach-pxa/cm-x300.c                       |    6 +-
 arch/arm/mach-pxa/em-x270.c                       |    6 +-
 arch/arm/mach-pxa/eseries.c                       |    4 +-
 arch/arm/mach-pxa/idp.c                           |    4 +-
 arch/arm/mach-pxa/include/mach/balloon3.h         |    6 +-
 arch/arm/mach-pxa/include/mach/corgi.h            |   24 ++++----
 arch/arm/mach-pxa/include/mach/gpio.h             |   15 -----
 arch/arm/mach-pxa/include/mach/gumstix.h          |   20 ++++----
 arch/arm/mach-pxa/include/mach/idp.h              |   14 +++---
 arch/arm/mach-pxa/include/mach/irqs.h             |    4 +-
 arch/arm/mach-pxa/include/mach/palmld.h           |    8 ++--
 arch/arm/mach-pxa/include/mach/palmt5.h           |    8 ++--
 arch/arm/mach-pxa/include/mach/palmtc.h           |    4 +-
 arch/arm/mach-pxa/include/mach/palmtx.h           |    8 ++--
 arch/arm/mach-pxa/include/mach/pcm027.h           |    8 ++--
 arch/arm/mach-pxa/include/mach/pcm990_baseboard.h |   14 +++---
 arch/arm/mach-pxa/include/mach/poodle.h           |   24 ++++----
 arch/arm/mach-pxa/include/mach/spitz.h            |   34 ++++++------
 arch/arm/mach-pxa/include/mach/tosa.h             |   46 ++++++++--------
 arch/arm/mach-pxa/include/mach/trizeps4.h         |   16 +++---
 arch/arm/mach-pxa/irq.c                           |   61 ---------------------
 arch/arm/mach-pxa/littleton.c                     |    4 +-
 arch/arm/mach-pxa/lpd270.c                        |    4 +-
 arch/arm/mach-pxa/lubbock.c                       |    4 +-
 arch/arm/mach-pxa/mainstone.c                     |    4 +-
 arch/arm/mach-pxa/poodle.c                        |    4 +-
 arch/arm/mach-pxa/sharpsl_pm.c                    |   24 ++++----
 arch/arm/mach-pxa/stargate2.c                     |   22 ++++----
 arch/arm/mach-pxa/vpac270.c                       |    6 +-
 arch/arm/mach-pxa/zylonite_pxa300.c               |    4 +-
 arch/arm/plat-pxa/gpio.c                          |   14 +++++
 39 files changed, 192 insertions(+), 256 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/gpio.h b/arch/arm/mach-mmp/include/mach/gpio.h
index 5ed6977..89d499e 100644
--- a/arch/arm/mach-mmp/include/mach/gpio.h
+++ b/arch/arm/mach-mmp/include/mach/gpio.h
@@ -13,9 +13,6 @@
 #define NR_BUILTIN_GPIO		IRQ_GPIO_NUM
 
 #define gpio_to_bank(gpio)	((gpio) >> 5)
-#define pxa_gpio_to_irq(gpio)	(IRQ_GPIO_START + (gpio))
-#define pxa_irq_to_gpio(irq)	((irq) - IRQ_GPIO_START)
-
 
 #define __gpio_is_inverted(gpio)	(0)
 #define __gpio_is_occupied(gpio)	(0)
diff --git a/arch/arm/mach-mmp/include/mach/irqs.h b/arch/arm/mach-mmp/include/mach/irqs.h
index a09d328..2971a00 100644
--- a/arch/arm/mach-mmp/include/mach/irqs.h
+++ b/arch/arm/mach-mmp/include/mach/irqs.h
@@ -220,7 +220,8 @@
 
 #define IRQ_GPIO_START			128
 #define IRQ_GPIO_NUM			192
-#define IRQ_GPIO(x)			(IRQ_GPIO_START + (x))
+#define pxa_gpio_to_irq(gpio)		(IRQ_GPIO_START + (gpio))
+#define pxa_irq_to_gpio(irq)		((irq) - IRQ_GPIO_START)
 
 #define IRQ_BOARD_START			(IRQ_GPIO_START + IRQ_GPIO_NUM)
 
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index 176515a..a420b07 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -136,7 +136,7 @@ static struct i2c_board_info ttc_dkb_i2c_info[] = {
 	{
 		.type		= "max7312",
 		.addr		= 0x23,
-		.irq		= IRQ_GPIO(80),
+		.irq		= pxa_gpio_to_irq(80),
 		.platform_data	= &max7312_data,
 	},
 };
diff --git a/arch/arm/mach-pxa/am200epd.c b/arch/arm/mach-pxa/am200epd.c
index 4cb069f..e69da52 100644
--- a/arch/arm/mach-pxa/am200epd.c
+++ b/arch/arm/mach-pxa/am200epd.c
@@ -138,7 +138,7 @@ static void am200_cleanup(struct metronomefb_par *par)
 {
 	int i;
 
-	free_irq(IRQ_GPIO(RDY_GPIO_PIN), par);
+	free_irq(pxa_gpio_to_irq(RDY_GPIO_PIN), par);
 
 	for (i = 0; i < ARRAY_SIZE(gpios); i++)
 		gpio_free(gpios[i]);
@@ -292,7 +292,7 @@ static int am200_setup_irq(struct fb_info *info)
 {
 	int ret;
 
-	ret = request_irq(IRQ_GPIO(RDY_GPIO_PIN), am200_handle_irq,
+	ret = request_irq(pxa_gpio_to_irq(RDY_GPIO_PIN), am200_handle_irq,
 				IRQF_DISABLED|IRQF_TRIGGER_FALLING,
 				"AM200", info->par);
 	if (ret)
diff --git a/arch/arm/mach-pxa/am300epd.c b/arch/arm/mach-pxa/am300epd.c
index fa8bad2..aba8193 100644
--- a/arch/arm/mach-pxa/am300epd.c
+++ b/arch/arm/mach-pxa/am300epd.c
@@ -176,7 +176,7 @@ static void am300_cleanup(struct broadsheetfb_par *par)
 {
 	int i;
 
-	free_irq(IRQ_GPIO(RDY_GPIO_PIN), par);
+	free_irq(pxa_gpio_to_irq(RDY_GPIO_PIN), par);
 
 	for (i = 0; i < ARRAY_SIZE(gpios); i++)
 		gpio_free(gpios[i]);
@@ -240,7 +240,7 @@ static int am300_setup_irq(struct fb_info *info)
 	int ret;
 	struct broadsheetfb_par *par = info->par;
 
-	ret = request_irq(IRQ_GPIO(RDY_GPIO_PIN), am300_handle_irq,
+	ret = request_irq(pxa_gpio_to_irq(RDY_GPIO_PIN), am300_handle_irq,
 				IRQF_DISABLED|IRQF_TRIGGER_RISING,
 				"AM300", par);
 	if (ret)
diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index 7765d67..f992ace 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -179,7 +179,7 @@ static unsigned long balloon3_ac97_pin_config[] __initdata = {
 };
 
 static struct ucb1400_pdata vpac270_ucb1400_pdata = {
-	.irq		= IRQ_GPIO(BALLOON3_GPIO_CODEC_IRQ),
+	.irq		= pxa_gpio_to_irq(BALLOON3_GPIO_CODEC_IRQ),
 };
 
 
diff --git a/arch/arm/mach-pxa/cm-x270.c b/arch/arm/mach-pxa/cm-x270.c
index 885e91a..7065df5 100644
--- a/arch/arm/mach-pxa/cm-x270.c
+++ b/arch/arm/mach-pxa/cm-x270.c
@@ -33,7 +33,7 @@
 /* GPIO IRQ usage */
 #define GPIO83_MMC_IRQ		(83)
 
-#define CMX270_MMC_IRQ		IRQ_GPIO(GPIO83_MMC_IRQ)
+#define CMX270_MMC_IRQ		pxa_gpio_to_irq(GPIO83_MMC_IRQ)
 
 /* MMC power enable */
 #define GPIO105_MMC_POWER	(105)
diff --git a/arch/arm/mach-pxa/cm-x2xx.c b/arch/arm/mach-pxa/cm-x2xx.c
index 349896c..ed2689a 100644
--- a/arch/arm/mach-pxa/cm-x2xx.c
+++ b/arch/arm/mach-pxa/cm-x2xx.c
@@ -58,8 +58,8 @@ extern void cmx270_init(void);
 #define CMX255_GPIO_IT8152_IRQ	(0)
 #define CMX270_GPIO_IT8152_IRQ	(22)
 
-#define CMX255_ETHIRQ		IRQ_GPIO(GPIO22_ETHIRQ)
-#define CMX270_ETHIRQ		IRQ_GPIO(GPIO10_ETHIRQ)
+#define CMX255_ETHIRQ		pxa_gpio_to_irq(GPIO22_ETHIRQ)
+#define CMX270_ETHIRQ		pxa_gpio_to_irq(GPIO10_ETHIRQ)
 
 #if defined(CONFIG_DM9000) || defined(CONFIG_DM9000_MODULE)
 static struct resource cmx255_dm9000_resource[] = {
diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 0f00e01..934c29a 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -64,7 +64,7 @@
 #define GPIO82_MMC_IRQ		(82)
 #define GPIO85_MMC_WP		(85)
 
-#define	CM_X300_MMC_IRQ		IRQ_GPIO(GPIO82_MMC_IRQ)
+#define	CM_X300_MMC_IRQ		pxa_gpio_to_irq(GPIO82_MMC_IRQ)
 
 #define GPIO95_RTC_CS		(95)
 #define GPIO96_RTC_WR		(96)
@@ -229,8 +229,8 @@ static struct resource dm9000_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[2] = {
-		.start	= IRQ_GPIO(mfp_to_gpio(MFP_PIN_GPIO99)),
-		.end	= IRQ_GPIO(mfp_to_gpio(MFP_PIN_GPIO99)),
+		.start	= pxa_gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO99)),
+		.end	= pxa_gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO99)),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	}
 };
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index a802c2c..3c08f2f 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -70,7 +70,7 @@
 /* common  GPIOs */
 #define GPIO11_NAND_CS		(11)
 #define GPIO41_ETHIRQ		(41)
-#define EM_X270_ETHIRQ		IRQ_GPIO(GPIO41_ETHIRQ)
+#define EM_X270_ETHIRQ		pxa_gpio_to_irq(GPIO41_ETHIRQ)
 #define GPIO115_WLAN_PWEN	(115)
 #define GPIO19_WLAN_STRAP	(19)
 #define GPIO9_USB_VBUS_EN	(9)
@@ -805,7 +805,7 @@ static struct spi_board_info em_x270_spi_devices[] __initdata = {
 		.modalias		= "libertas_spi",
 		.max_speed_hz		= 13000000,
 		.bus_num		= 2,
-		.irq			= IRQ_GPIO(116),
+		.irq			= pxa_gpio_to_irq(116),
 		.chip_select		= 0,
 		.controller_data	= &em_x270_libertas_chip,
 		.platform_data		= &em_x270_libertas_pdata,
@@ -1203,7 +1203,7 @@ static struct da903x_platform_data em_x270_da9030_info = {
 
 static struct i2c_board_info em_x270_i2c_pmic_info = {
 	I2C_BOARD_INFO("da9030", 0x49),
-	.irq = IRQ_GPIO(0),
+	.irq = pxa_gpio_to_irq(0),
 	.platform_data = &em_x270_da9030_info,
 };
 
diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index e823c54..fc26443 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -120,8 +120,8 @@ struct resource eseries_tmio_resources[] = {
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start  = IRQ_GPIO(GPIO_ESERIES_TMIO_IRQ),
-		.end    = IRQ_GPIO(GPIO_ESERIES_TMIO_IRQ),
+		.start  = pxa_gpio_to_irq(GPIO_ESERIES_TMIO_IRQ),
+		.end    = pxa_gpio_to_irq(GPIO_ESERIES_TMIO_IRQ),
 		.flags  = IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/mach-pxa/idp.c b/arch/arm/mach-pxa/idp.c
index ddf20e5..f2e210f 100644
--- a/arch/arm/mach-pxa/idp.c
+++ b/arch/arm/mach-pxa/idp.c
@@ -75,8 +75,8 @@ static struct resource smc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= IRQ_GPIO(4),
-		.end	= IRQ_GPIO(4),
+		.start	= pxa_gpio_to_irq(4),
+		.end	= pxa_gpio_to_irq(4),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	}
 };
diff --git a/arch/arm/mach-pxa/include/mach/balloon3.h b/arch/arm/mach-pxa/include/mach/balloon3.h
index 7074e76..6844342 100644
--- a/arch/arm/mach-pxa/include/mach/balloon3.h
+++ b/arch/arm/mach-pxa/include/mach/balloon3.h
@@ -172,9 +172,9 @@ enum balloon3_features {
 /* Balloon3 Interrupts */
 #define BALLOON3_IRQ(x)		(IRQ_BOARD_START + (x))
 
-#define BALLOON3_AUX_NIRQ	IRQ_GPIO(BALLOON3_GPIO_AUX_NIRQ)
-#define BALLOON3_CODEC_IRQ	IRQ_GPIO(BALLOON3_GPIO_CODEC_IRQ)
-#define BALLOON3_S0_CD_IRQ	IRQ_GPIO(BALLOON3_GPIO_S0_CD)
+#define BALLOON3_AUX_NIRQ	pxa_gpio_to_irq(BALLOON3_GPIO_AUX_NIRQ)
+#define BALLOON3_CODEC_IRQ	pxa_gpio_to_irq(BALLOON3_GPIO_CODEC_IRQ)
+#define BALLOON3_S0_CD_IRQ	pxa_gpio_to_irq(BALLOON3_GPIO_S0_CD)
 
 #define BALLOON3_NR_IRQS	(IRQ_BOARD_START + 16)
 
diff --git a/arch/arm/mach-pxa/include/mach/corgi.h b/arch/arm/mach-pxa/include/mach/corgi.h
index 5dfd119..baf4aff 100644
--- a/arch/arm/mach-pxa/include/mach/corgi.h
+++ b/arch/arm/mach-pxa/include/mach/corgi.h
@@ -66,18 +66,18 @@
 /*
  * Corgi Interrupts
  */
-#define CORGI_IRQ_GPIO_KEY_INT		IRQ_GPIO(0)
-#define CORGI_IRQ_GPIO_AC_IN		IRQ_GPIO(1)
-#define CORGI_IRQ_GPIO_WAKEUP		IRQ_GPIO(3)
-#define CORGI_IRQ_GPIO_AK_INT		IRQ_GPIO(4)
-#define CORGI_IRQ_GPIO_TP_INT		IRQ_GPIO(5)
-#define CORGI_IRQ_GPIO_nSD_DETECT	IRQ_GPIO(9)
-#define CORGI_IRQ_GPIO_nSD_INT		IRQ_GPIO(10)
-#define CORGI_IRQ_GPIO_MAIN_BAT_LOW	IRQ_GPIO(11)
-#define CORGI_IRQ_GPIO_CF_CD		IRQ_GPIO(14)
-#define CORGI_IRQ_GPIO_CHRG_FULL	IRQ_GPIO(16)	/* Battery fully charged */
-#define CORGI_IRQ_GPIO_CF_IRQ		IRQ_GPIO(17)
-#define CORGI_IRQ_GPIO_KEY_SENSE(a)	IRQ_GPIO(58+(a))	/* Keyboard Sense lines */
+#define CORGI_IRQ_GPIO_KEY_INT		pxa_gpio_to_irq(0)
+#define CORGI_IRQ_GPIO_AC_IN		pxa_gpio_to_irq(1)
+#define CORGI_IRQ_GPIO_WAKEUP		pxa_gpio_to_irq(3)
+#define CORGI_IRQ_GPIO_AK_INT		pxa_gpio_to_irq(4)
+#define CORGI_IRQ_GPIO_TP_INT		pxa_gpio_to_irq(5)
+#define CORGI_IRQ_GPIO_nSD_DETECT	pxa_gpio_to_irq(9)
+#define CORGI_IRQ_GPIO_nSD_INT		pxa_gpio_to_irq(10)
+#define CORGI_IRQ_GPIO_MAIN_BAT_LOW	pxa_gpio_to_irq(11)
+#define CORGI_IRQ_GPIO_CF_CD		pxa_gpio_to_irq(14)
+#define CORGI_IRQ_GPIO_CHRG_FULL	pxa_gpio_to_irq(16)	/* Battery fully charged */
+#define CORGI_IRQ_GPIO_CF_IRQ		pxa_gpio_to_irq(17)
+#define CORGI_IRQ_GPIO_KEY_SENSE(a)	pxa_gpio_to_irq(58+(a))	/* Keyboard Sense lines */
 
 
 /*
diff --git a/arch/arm/mach-pxa/include/mach/gpio.h b/arch/arm/mach-pxa/include/mach/gpio.h
index 45ac8e6..d58efb5 100644
--- a/arch/arm/mach-pxa/include/mach/gpio.h
+++ b/arch/arm/mach-pxa/include/mach/gpio.h
@@ -58,21 +58,6 @@
 #define NR_BUILTIN_GPIO		PXA_GPIO_IRQ_NUM
 
 #define gpio_to_bank(gpio)	((gpio) >> 5)
-#define pxa_gpio_to_irq(gpio)	IRQ_GPIO(gpio)
-
-static inline int pxa_irq_to_gpio(unsigned int irq)
-{
-	int gpio;
-
-	if (irq == IRQ_GPIO0 || irq == IRQ_GPIO1)
-		return irq - IRQ_GPIO0;
-
-	gpio = irq - PXA_GPIO_IRQ_BASE;
-	if (gpio >= 2 && gpio < NR_BUILTIN_GPIO)
-		return gpio;
-
-	return -1;
-}
 
 #ifdef CONFIG_CPU_PXA26x
 /* GPIO86/87/88/89 on PXA26x have their direction bits in GPDR2 inverted,
diff --git a/arch/arm/mach-pxa/include/mach/gumstix.h b/arch/arm/mach-pxa/include/mach/gumstix.h
index 9b89868..c52d751 100644
--- a/arch/arm/mach-pxa/include/mach/gumstix.h
+++ b/arch/arm/mach-pxa/include/mach/gumstix.h
@@ -24,7 +24,7 @@ has detected a cable insertion; driven low otherwise. */
 #define GPIO_GUMSTIX_USB_GPIOx		41
 
 /* usb state change */
-#define GUMSTIX_USB_INTR_IRQ		IRQ_GPIO(GPIO_GUMSTIX_USB_GPIOn)
+#define GUMSTIX_USB_INTR_IRQ		pxa_gpio_to_irq(GPIO_GUMSTIX_USB_GPIOn)
 
 #define GPIO_GUMSTIX_USB_GPIOn_MD	(GPIO_GUMSTIX_USB_GPIOn | GPIO_IN)
 #define GPIO_GUMSTIX_USB_GPIOx_CON_MD	(GPIO_GUMSTIX_USB_GPIOx | GPIO_OUT)
@@ -35,7 +35,7 @@ has detected a cable insertion; driven low otherwise. */
  */
 #define GUMSTIX_GPIO_nSD_WP		22 /* SD Write Protect */
 #define GUMSTIX_GPIO_nSD_DETECT		11 /* MMC/SD Card Detect */
-#define GUMSTIX_IRQ_GPIO_nSD_DETECT	IRQ_GPIO(GUMSTIX_GPIO_nSD_DETECT)
+#define GUMSTIX_IRQ_GPIO_nSD_DETECT	pxa_gpio_to_irq(GUMSTIX_GPIO_nSD_DETECT)
 
 /*
  * SMC Ethernet definitions
@@ -49,10 +49,10 @@ has detected a cable insertion; driven low otherwise. */
 
 #define GPIO_GUMSTIX_ETH0		36
 #define GPIO_GUMSTIX_ETH0_MD		(GPIO_GUMSTIX_ETH0 | GPIO_IN)
-#define GUMSTIX_ETH0_IRQ		IRQ_GPIO(GPIO_GUMSTIX_ETH0)
+#define GUMSTIX_ETH0_IRQ		pxa_gpio_to_irq(GPIO_GUMSTIX_ETH0)
 #define GPIO_GUMSTIX_ETH1		27
 #define GPIO_GUMSTIX_ETH1_MD		(GPIO_GUMSTIX_ETH1 | GPIO_IN)
-#define GUMSTIX_ETH1_IRQ		IRQ_GPIO(GPIO_GUMSTIX_ETH1)
+#define GUMSTIX_ETH1_IRQ		pxa_gpio_to_irq(GPIO_GUMSTIX_ETH1)
 
 
 /* CF reset line */
@@ -63,18 +63,18 @@ has detected a cable insertion; driven low otherwise. */
 #define GPIO4_nSTSCHG			GPIO4_nBVD1
 #define GPIO11_nCD			11
 #define GPIO26_PRDY_nBSY		26
-#define GUMSTIX_S0_nSTSCHG_IRQ		IRQ_GPIO(GPIO4_nSTSCHG)
-#define GUMSTIX_S0_nCD_IRQ		IRQ_GPIO(GPIO11_nCD)
-#define GUMSTIX_S0_PRDY_nBSY_IRQ	IRQ_GPIO(GPIO26_PRDY_nBSY)
+#define GUMSTIX_S0_nSTSCHG_IRQ		pxa_gpio_to_irq(GPIO4_nSTSCHG)
+#define GUMSTIX_S0_nCD_IRQ		pxa_gpio_to_irq(GPIO11_nCD)
+#define GUMSTIX_S0_PRDY_nBSY_IRQ	pxa_gpio_to_irq(GPIO26_PRDY_nBSY)
 
 /* CF slot 1 */
 #define GPIO18_nBVD1			18
 #define GPIO18_nSTSCHG			GPIO18_nBVD1
 #define GPIO36_nCD			36
 #define GPIO27_PRDY_nBSY		27
-#define GUMSTIX_S1_nSTSCHG_IRQ		IRQ_GPIO(GPIO18_nSTSCHG)
-#define GUMSTIX_S1_nCD_IRQ		IRQ_GPIO(GPIO36_nCD)
-#define GUMSTIX_S1_PRDY_nBSY_IRQ	IRQ_GPIO(GPIO27_PRDY_nBSY)
+#define GUMSTIX_S1_nSTSCHG_IRQ		pxa_gpio_to_irq(GPIO18_nSTSCHG)
+#define GUMSTIX_S1_nCD_IRQ		pxa_gpio_to_irq(GPIO36_nCD)
+#define GUMSTIX_S1_PRDY_nBSY_IRQ	pxa_gpio_to_irq(GPIO27_PRDY_nBSY)
 
 /* CF GPIO line modes */
 #define GPIO4_nSTSCHG_MD		(GPIO4_nSTSCHG | GPIO_IN)
diff --git a/arch/arm/mach-pxa/include/mach/idp.h b/arch/arm/mach-pxa/include/mach/idp.h
index 5eff96f..ce3655c 100644
--- a/arch/arm/mach-pxa/include/mach/idp.h
+++ b/arch/arm/mach-pxa/include/mach/idp.h
@@ -135,24 +135,24 @@
 
 /* A listing of interrupts used by external hardware devices */
 
-#define TOUCH_PANEL_IRQ			IRQ_GPIO(5)
-#define IDE_IRQ				IRQ_GPIO(21)
+#define TOUCH_PANEL_IRQ			pxa_gpio_to_irq(5)
+#define IDE_IRQ				pxa_gpio_to_irq(21)
 
 #define TOUCH_PANEL_IRQ_EDGE		IRQ_TYPE_EDGE_FALLING
 
-#define ETHERNET_IRQ			IRQ_GPIO(4)
+#define ETHERNET_IRQ			pxa_gpio_to_irq(4)
 #define ETHERNET_IRQ_EDGE		IRQ_TYPE_EDGE_RISING
 
 #define IDE_IRQ_EDGE			IRQ_TYPE_EDGE_RISING
 
-#define PCMCIA_S0_CD_VALID		IRQ_GPIO(7)
+#define PCMCIA_S0_CD_VALID		pxa_gpio_to_irq(7)
 #define PCMCIA_S0_CD_VALID_EDGE		IRQ_TYPE_EDGE_BOTH
 
-#define PCMCIA_S1_CD_VALID		IRQ_GPIO(8)
+#define PCMCIA_S1_CD_VALID		pxa_gpio_to_irq(8)
 #define PCMCIA_S1_CD_VALID_EDGE		IRQ_TYPE_EDGE_BOTH
 
-#define PCMCIA_S0_RDYINT		IRQ_GPIO(19)
-#define PCMCIA_S1_RDYINT		IRQ_GPIO(22)
+#define PCMCIA_S0_RDYINT		pxa_gpio_to_irq(19)
+#define PCMCIA_S1_RDYINT		pxa_gpio_to_irq(22)
 
 
 /*
diff --git a/arch/arm/mach-pxa/include/mach/irqs.h b/arch/arm/mach-pxa/include/mach/irqs.h
index 7cc5a78..9e0f1b7d 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -90,8 +90,8 @@
 #define PXA_GPIO_IRQ_BASE	PXA_IRQ(96)
 #define PXA_GPIO_IRQ_NUM	(192)
 
-#define GPIO_2_x_TO_IRQ(x)	(PXA_GPIO_IRQ_BASE + (x))
-#define IRQ_GPIO(x)	(((x) < 2) ? (IRQ_GPIO0 + (x)) : GPIO_2_x_TO_IRQ(x))
+#define pxa_gpio_to_irq(gpio)	(PXA_GPIO_IRQ_BASE + (gpio))
+#define pxa_irq_to_gpio(irq)	((irq) - PXA_GPIO_IRQ_BASE)
 
 /*
  * The following interrupts are for board specific purposes. Since
diff --git a/arch/arm/mach-pxa/include/mach/palmld.h b/arch/arm/mach-pxa/include/mach/palmld.h
index ae536e8..8ed3103 100644
--- a/arch/arm/mach-pxa/include/mach/palmld.h
+++ b/arch/arm/mach-pxa/include/mach/palmld.h
@@ -68,10 +68,10 @@
 /* 20, 53 and 86 are usb related too */
 
 /* INTERRUPTS */
-#define IRQ_GPIO_PALMLD_GPIO_RESET	IRQ_GPIO(GPIO_NR_PALMLD_GPIO_RESET)
-#define IRQ_GPIO_PALMLD_SD_DETECT_N	IRQ_GPIO(GPIO_NR_PALMLD_SD_DETECT_N)
-#define IRQ_GPIO_PALMLD_WM9712_IRQ	IRQ_GPIO(GPIO_NR_PALMLD_WM9712_IRQ)
-#define IRQ_GPIO_PALMLD_IDE_IRQ		IRQ_GPIO(GPIO_NR_PALMLD_IDE_IRQ)
+#define IRQ_GPIO_PALMLD_GPIO_RESET	pxa_gpio_to_irq(GPIO_NR_PALMLD_GPIO_RESET)
+#define IRQ_GPIO_PALMLD_SD_DETECT_N	pxa_gpio_to_irq(GPIO_NR_PALMLD_SD_DETECT_N)
+#define IRQ_GPIO_PALMLD_WM9712_IRQ	pxa_gpio_to_irq(GPIO_NR_PALMLD_WM9712_IRQ)
+#define IRQ_GPIO_PALMLD_IDE_IRQ		pxa_gpio_to_irq(GPIO_NR_PALMLD_IDE_IRQ)
 
 
 /** HERE ARE INIT VALUES **/
diff --git a/arch/arm/mach-pxa/include/mach/palmt5.h b/arch/arm/mach-pxa/include/mach/palmt5.h
index 6baf746..649776c 100644
--- a/arch/arm/mach-pxa/include/mach/palmt5.h
+++ b/arch/arm/mach-pxa/include/mach/palmt5.h
@@ -48,10 +48,10 @@
 #define GPIO_NR_PALMT5_BT_RESET			83
 
 /* INTERRUPTS */
-#define IRQ_GPIO_PALMT5_SD_DETECT_N	IRQ_GPIO(GPIO_NR_PALMT5_SD_DETECT_N)
-#define IRQ_GPIO_PALMT5_WM9712_IRQ	IRQ_GPIO(GPIO_NR_PALMT5_WM9712_IRQ)
-#define IRQ_GPIO_PALMT5_USB_DETECT	IRQ_GPIO(GPIO_NR_PALMT5_USB_DETECT)
-#define IRQ_GPIO_PALMT5_GPIO_RESET	IRQ_GPIO(GPIO_NR_PALMT5_GPIO_RESET)
+#define IRQ_GPIO_PALMT5_SD_DETECT_N	pxa_gpio_to_irq(GPIO_NR_PALMT5_SD_DETECT_N)
+#define IRQ_GPIO_PALMT5_WM9712_IRQ	pxa_gpio_to_irq(GPIO_NR_PALMT5_WM9712_IRQ)
+#define IRQ_GPIO_PALMT5_USB_DETECT	pxa_gpio_to_irq(GPIO_NR_PALMT5_USB_DETECT)
+#define IRQ_GPIO_PALMT5_GPIO_RESET	pxa_gpio_to_irq(GPIO_NR_PALMT5_GPIO_RESET)
 
 /** HERE ARE INIT VALUES **/
 
diff --git a/arch/arm/mach-pxa/include/mach/palmtc.h b/arch/arm/mach-pxa/include/mach/palmtc.h
index 3f9dd3f..6db872b 100644
--- a/arch/arm/mach-pxa/include/mach/palmtc.h
+++ b/arch/arm/mach-pxa/include/mach/palmtc.h
@@ -52,8 +52,8 @@
 #define GPIO_NR_PALMTC_IR_DISABLE	45
 
 /* IRQs */
-#define IRQ_GPIO_PALMTC_SD_DETECT_N	IRQ_GPIO(GPIO_NR_PALMTC_SD_DETECT_N)
-#define IRQ_GPIO_PALMTC_WLAN_READY	IRQ_GPIO(GPIO_NR_PALMTC_WLAN_READY)
+#define IRQ_GPIO_PALMTC_SD_DETECT_N	pxa_gpio_to_irq(GPIO_NR_PALMTC_SD_DETECT_N)
+#define IRQ_GPIO_PALMTC_WLAN_READY	pxa_gpio_to_irq(GPIO_NR_PALMTC_WLAN_READY)
 
 /* UCB1400 GPIOs */
 #define GPIO_NR_PALMTC_POWER_DETECT	(0x80 | 0x00)
diff --git a/arch/arm/mach-pxa/include/mach/palmtx.h b/arch/arm/mach-pxa/include/mach/palmtx.h
index 10abc4f..e8643ec 100644
--- a/arch/arm/mach-pxa/include/mach/palmtx.h
+++ b/arch/arm/mach-pxa/include/mach/palmtx.h
@@ -62,10 +62,10 @@
 #define GPIO_NR_PALMTX_NAND_BUFFER_DIR		79
 
 /* INTERRUPTS */
-#define IRQ_GPIO_PALMTX_SD_DETECT_N	IRQ_GPIO(GPIO_NR_PALMTX_SD_DETECT_N)
-#define IRQ_GPIO_PALMTX_WM9712_IRQ	IRQ_GPIO(GPIO_NR_PALMTX_WM9712_IRQ)
-#define IRQ_GPIO_PALMTX_USB_DETECT	IRQ_GPIO(GPIO_NR_PALMTX_USB_DETECT)
-#define IRQ_GPIO_PALMTX_GPIO_RESET	IRQ_GPIO(GPIO_NR_PALMTX_GPIO_RESET)
+#define IRQ_GPIO_PALMTX_SD_DETECT_N	pxa_gpio_to_irq(GPIO_NR_PALMTX_SD_DETECT_N)
+#define IRQ_GPIO_PALMTX_WM9712_IRQ	pxa_gpio_to_irq(GPIO_NR_PALMTX_WM9712_IRQ)
+#define IRQ_GPIO_PALMTX_USB_DETECT	pxa_gpio_to_irq(GPIO_NR_PALMTX_USB_DETECT)
+#define IRQ_GPIO_PALMTX_GPIO_RESET	pxa_gpio_to_irq(GPIO_NR_PALMTX_GPIO_RESET)
 
 /** HERE ARE INIT VALUES **/
 
diff --git a/arch/arm/mach-pxa/include/mach/pcm027.h b/arch/arm/mach-pxa/include/mach/pcm027.h
index 4bac588..b9d8903 100644
--- a/arch/arm/mach-pxa/include/mach/pcm027.h
+++ b/arch/arm/mach-pxa/include/mach/pcm027.h
@@ -34,7 +34,7 @@
 
 /* I2C RTC */
 #define PCM027_RTC_IRQ_GPIO	0
-#define PCM027_RTC_IRQ		IRQ_GPIO(PCM027_RTC_IRQ_GPIO)
+#define PCM027_RTC_IRQ		pxa_gpio_to_irq(PCM027_RTC_IRQ_GPIO)
 #define PCM027_RTC_IRQ_EDGE	IRQ_TYPE_EDGE_FALLING
 #define ADR_PCM027_RTC		0x51	/* I2C address */
 
@@ -43,21 +43,21 @@
 
 /* Ethernet chip (SMSC91C111) */
 #define PCM027_ETH_IRQ_GPIO	52
-#define PCM027_ETH_IRQ		IRQ_GPIO(PCM027_ETH_IRQ_GPIO)
+#define PCM027_ETH_IRQ		pxa_gpio_to_irq(PCM027_ETH_IRQ_GPIO)
 #define PCM027_ETH_IRQ_EDGE	IRQ_TYPE_EDGE_RISING
 #define PCM027_ETH_PHYS		PXA_CS5_PHYS
 #define PCM027_ETH_SIZE		(1*1024*1024)
 
 /* CAN controller SJA1000 (unsupported yet) */
 #define PCM027_CAN_IRQ_GPIO	114
-#define PCM027_CAN_IRQ		IRQ_GPIO(PCM027_CAN_IRQ_GPIO)
+#define PCM027_CAN_IRQ		pxa_gpio_to_irq(PCM027_CAN_IRQ_GPIO)
 #define PCM027_CAN_IRQ_EDGE	IRQ_TYPE_EDGE_FALLING
 #define PCM027_CAN_PHYS		0x22000000
 #define PCM027_CAN_SIZE		0x100
 
 /* SPI GPIO expander (unsupported yet) */
 #define PCM027_EGPIO_IRQ_GPIO	27
-#define PCM027_EGPIO_IRQ	IRQ_GPIO(PCM027_EGPIO_IRQ_GPIO)
+#define PCM027_EGPIO_IRQ	pxa_gpio_to_irq(PCM027_EGPIO_IRQ_GPIO)
 #define PCM027_EGPIO_IRQ_EDGE	IRQ_TYPE_EDGE_FALLING
 #define PCM027_EGPIO_CS		24
 /*
diff --git a/arch/arm/mach-pxa/include/mach/pcm990_baseboard.h b/arch/arm/mach-pxa/include/mach/pcm990_baseboard.h
index 8a4383b..3b3c94e 100644
--- a/arch/arm/mach-pxa/include/mach/pcm990_baseboard.h
+++ b/arch/arm/mach-pxa/include/mach/pcm990_baseboard.h
@@ -28,14 +28,14 @@
 
 /* CPLD's interrupt controller is connected to PCM-027 GPIO 9 */
 #define PCM990_CTRL_INT_IRQ_GPIO	9
-#define PCM990_CTRL_INT_IRQ		IRQ_GPIO(PCM990_CTRL_INT_IRQ_GPIO)
+#define PCM990_CTRL_INT_IRQ		pxa_gpio_to_irq(PCM990_CTRL_INT_IRQ_GPIO)
 #define PCM990_CTRL_INT_IRQ_EDGE	IRQ_TYPE_EDGE_RISING
 #define PCM990_CTRL_PHYS		PXA_CS1_PHYS	/* 16-Bit */
 #define PCM990_CTRL_BASE		0xea000000
 #define PCM990_CTRL_SIZE		(1*1024*1024)
 
 #define PCM990_CTRL_PWR_IRQ_GPIO	14
-#define PCM990_CTRL_PWR_IRQ		IRQ_GPIO(PCM990_CTRL_PWR_IRQ_GPIO)
+#define PCM990_CTRL_PWR_IRQ		pxa_gpio_to_irq(PCM990_CTRL_PWR_IRQ_GPIO)
 #define PCM990_CTRL_PWR_IRQ_EDGE	IRQ_TYPE_EDGE_RISING
 
 /* visible CPLD (U7) registers */
@@ -132,7 +132,7 @@
  * IDE
  */
 #define PCM990_IDE_IRQ_GPIO	13
-#define PCM990_IDE_IRQ		IRQ_GPIO(PCM990_IDE_IRQ_GPIO)
+#define PCM990_IDE_IRQ		pxa_gpio_to_irq(PCM990_IDE_IRQ_GPIO)
 #define PCM990_IDE_IRQ_EDGE	IRQ_TYPE_EDGE_RISING
 #define PCM990_IDE_PLD_PHYS	0x20000000	/* 16 bit wide */
 #define PCM990_IDE_PLD_BASE	0xee000000
@@ -188,11 +188,11 @@
  * Compact Flash
  */
 #define PCM990_CF_IRQ_GPIO	11
-#define PCM990_CF_IRQ		IRQ_GPIO(PCM990_CF_IRQ_GPIO)
+#define PCM990_CF_IRQ		pxa_gpio_to_irq(PCM990_CF_IRQ_GPIO)
 #define PCM990_CF_IRQ_EDGE	IRQ_TYPE_EDGE_RISING
 
 #define PCM990_CF_CD_GPIO	12
-#define PCM990_CF_CD		IRQ_GPIO(PCM990_CF_CD_GPIO)
+#define PCM990_CF_CD		pxa_gpio_to_irq(PCM990_CF_CD_GPIO)
 #define PCM990_CF_CD_EDGE	IRQ_TYPE_EDGE_RISING
 
 #define PCM990_CF_PLD_PHYS	0x30000000	/* 16 bit wide */
@@ -258,14 +258,14 @@
  * Wolfson AC97 Touch
  */
 #define PCM990_AC97_IRQ_GPIO	10
-#define PCM990_AC97_IRQ		IRQ_GPIO(PCM990_AC97_IRQ_GPIO)
+#define PCM990_AC97_IRQ		pxa_gpio_to_irq(PCM990_AC97_IRQ_GPIO)
 #define PCM990_AC97_IRQ_EDGE	IRQ_TYPE_EDGE_RISING
 
 /*
  * MMC phyCORE
  */
 #define PCM990_MMC0_IRQ_GPIO	9
-#define PCM990_MMC0_IRQ		IRQ_GPIO(PCM990_MMC0_IRQ_GPIO)
+#define PCM990_MMC0_IRQ		pxa_gpio_to_irq(PCM990_MMC0_IRQ_GPIO)
 #define PCM990_MMC0_IRQ_EDGE	IRQ_TYPE_EDGE_FALLING
 
 /*
diff --git a/arch/arm/mach-pxa/include/mach/poodle.h b/arch/arm/mach-pxa/include/mach/poodle.h
index 83d1cfd..58717fd 100644
--- a/arch/arm/mach-pxa/include/mach/poodle.h
+++ b/arch/arm/mach-pxa/include/mach/poodle.h
@@ -47,18 +47,18 @@
 #define POODLE_GPIO_DISCHARGE_ON        (42) /* Enable battery discharge */
 
 /* PXA GPIOs */
-#define POODLE_IRQ_GPIO_ON_KEY		IRQ_GPIO(0)
-#define POODLE_IRQ_GPIO_AC_IN		IRQ_GPIO(1)
-#define POODLE_IRQ_GPIO_HP_IN		IRQ_GPIO(4)
-#define POODLE_IRQ_GPIO_CO		IRQ_GPIO(16)
-#define POODLE_IRQ_GPIO_TP_INT		IRQ_GPIO(5)
-#define POODLE_IRQ_GPIO_WAKEUP		IRQ_GPIO(11)
-#define POODLE_IRQ_GPIO_GA_INT		IRQ_GPIO(10)
-#define POODLE_IRQ_GPIO_CF_IRQ		IRQ_GPIO(17)
-#define POODLE_IRQ_GPIO_CF_CD		IRQ_GPIO(14)
-#define POODLE_IRQ_GPIO_nSD_INT		IRQ_GPIO(8)
-#define POODLE_IRQ_GPIO_nSD_DETECT	IRQ_GPIO(9)
-#define POODLE_IRQ_GPIO_MAIN_BAT_LOW	IRQ_GPIO(13)
+#define POODLE_IRQ_GPIO_ON_KEY		pxa_gpio_to_irq(0)
+#define POODLE_IRQ_GPIO_AC_IN		pxa_gpio_to_irq(1)
+#define POODLE_IRQ_GPIO_HP_IN		pxa_gpio_to_irq(4)
+#define POODLE_IRQ_GPIO_CO		pxa_gpio_to_irq(16)
+#define POODLE_IRQ_GPIO_TP_INT		pxa_gpio_to_irq(5)
+#define POODLE_IRQ_GPIO_WAKEUP		pxa_gpio_to_irq(11)
+#define POODLE_IRQ_GPIO_GA_INT		pxa_gpio_to_irq(10)
+#define POODLE_IRQ_GPIO_CF_IRQ		pxa_gpio_to_irq(17)
+#define POODLE_IRQ_GPIO_CF_CD		pxa_gpio_to_irq(14)
+#define POODLE_IRQ_GPIO_nSD_INT		pxa_gpio_to_irq(8)
+#define POODLE_IRQ_GPIO_nSD_DETECT	pxa_gpio_to_irq(9)
+#define POODLE_IRQ_GPIO_MAIN_BAT_LOW	pxa_gpio_to_irq(13)
 
 /* SCOOP GPIOs */
 #define POODLE_SCOOP_CHARGE_ON	SCOOP_GPCR_PA11
diff --git a/arch/arm/mach-pxa/include/mach/spitz.h b/arch/arm/mach-pxa/include/mach/spitz.h
index 685749a..9023719 100644
--- a/arch/arm/mach-pxa/include/mach/spitz.h
+++ b/arch/arm/mach-pxa/include/mach/spitz.h
@@ -164,23 +164,23 @@
 
 /* Spitz IRQ Definitions */
 
-#define SPITZ_IRQ_GPIO_KEY_INT        IRQ_GPIO(SPITZ_GPIO_KEY_INT)
-#define SPITZ_IRQ_GPIO_AC_IN          IRQ_GPIO(SPITZ_GPIO_AC_IN)
-#define SPITZ_IRQ_GPIO_AK_INT         IRQ_GPIO(SPITZ_GPIO_AK_INT)
-#define SPITZ_IRQ_GPIO_HP_IN          IRQ_GPIO(SPITZ_GPIO_HP_IN)
-#define SPITZ_IRQ_GPIO_TP_INT         IRQ_GPIO(SPITZ_GPIO_TP_INT)
-#define SPITZ_IRQ_GPIO_SYNC           IRQ_GPIO(SPITZ_GPIO_SYNC)
-#define SPITZ_IRQ_GPIO_ON_KEY         IRQ_GPIO(SPITZ_GPIO_ON_KEY)
-#define SPITZ_IRQ_GPIO_SWA            IRQ_GPIO(SPITZ_GPIO_SWA)
-#define SPITZ_IRQ_GPIO_SWB            IRQ_GPIO(SPITZ_GPIO_SWB)
-#define SPITZ_IRQ_GPIO_BAT_COVER      IRQ_GPIO(SPITZ_GPIO_BAT_COVER)
-#define SPITZ_IRQ_GPIO_FATAL_BAT      IRQ_GPIO(SPITZ_GPIO_FATAL_BAT)
-#define SPITZ_IRQ_GPIO_CO             IRQ_GPIO(SPITZ_GPIO_CO)
-#define SPITZ_IRQ_GPIO_CF_IRQ         IRQ_GPIO(SPITZ_GPIO_CF_IRQ)
-#define SPITZ_IRQ_GPIO_CF_CD          IRQ_GPIO(SPITZ_GPIO_CF_CD)
-#define SPITZ_IRQ_GPIO_CF2_IRQ        IRQ_GPIO(SPITZ_GPIO_CF2_IRQ)
-#define SPITZ_IRQ_GPIO_nSD_INT        IRQ_GPIO(SPITZ_GPIO_nSD_INT)
-#define SPITZ_IRQ_GPIO_nSD_DETECT     IRQ_GPIO(SPITZ_GPIO_nSD_DETECT)
+#define SPITZ_IRQ_GPIO_KEY_INT        pxa_gpio_to_irq(SPITZ_GPIO_KEY_INT)
+#define SPITZ_IRQ_GPIO_AC_IN          pxa_gpio_to_irq(SPITZ_GPIO_AC_IN)
+#define SPITZ_IRQ_GPIO_AK_INT         pxa_gpio_to_irq(SPITZ_GPIO_AK_INT)
+#define SPITZ_IRQ_GPIO_HP_IN          pxa_gpio_to_irq(SPITZ_GPIO_HP_IN)
+#define SPITZ_IRQ_GPIO_TP_INT         pxa_gpio_to_irq(SPITZ_GPIO_TP_INT)
+#define SPITZ_IRQ_GPIO_SYNC           pxa_gpio_to_irq(SPITZ_GPIO_SYNC)
+#define SPITZ_IRQ_GPIO_ON_KEY         pxa_gpio_to_irq(SPITZ_GPIO_ON_KEY)
+#define SPITZ_IRQ_GPIO_SWA            pxa_gpio_to_irq(SPITZ_GPIO_SWA)
+#define SPITZ_IRQ_GPIO_SWB            pxa_gpio_to_irq(SPITZ_GPIO_SWB)
+#define SPITZ_IRQ_GPIO_BAT_COVER      pxa_gpio_to_irq(SPITZ_GPIO_BAT_COVER)
+#define SPITZ_IRQ_GPIO_FATAL_BAT      pxa_gpio_to_irq(SPITZ_GPIO_FATAL_BAT)
+#define SPITZ_IRQ_GPIO_CO             pxa_gpio_to_irq(SPITZ_GPIO_CO)
+#define SPITZ_IRQ_GPIO_CF_IRQ         pxa_gpio_to_irq(SPITZ_GPIO_CF_IRQ)
+#define SPITZ_IRQ_GPIO_CF_CD          pxa_gpio_to_irq(SPITZ_GPIO_CF_CD)
+#define SPITZ_IRQ_GPIO_CF2_IRQ        pxa_gpio_to_irq(SPITZ_GPIO_CF2_IRQ)
+#define SPITZ_IRQ_GPIO_nSD_INT        pxa_gpio_to_irq(SPITZ_GPIO_nSD_INT)
+#define SPITZ_IRQ_GPIO_nSD_DETECT     pxa_gpio_to_irq(SPITZ_GPIO_nSD_DETECT)
 
 /*
  * Shared data structures
diff --git a/arch/arm/mach-pxa/include/mach/tosa.h b/arch/arm/mach-pxa/include/mach/tosa.h
index 1272c4b..046460e 100644
--- a/arch/arm/mach-pxa/include/mach/tosa.h
+++ b/arch/arm/mach-pxa/include/mach/tosa.h
@@ -141,30 +141,30 @@
 /*
  * Interrupts
  */
-#define TOSA_IRQ_GPIO_WAKEUP        	IRQ_GPIO(TOSA_GPIO_WAKEUP)
-#define TOSA_IRQ_GPIO_AC_IN         	IRQ_GPIO(TOSA_GPIO_AC_IN)
-#define TOSA_IRQ_GPIO_RECORD_BTN    	IRQ_GPIO(TOSA_GPIO_RECORD_BTN)
-#define TOSA_IRQ_GPIO_SYNC          	IRQ_GPIO(TOSA_GPIO_SYNC)
-#define TOSA_IRQ_GPIO_USB_IN        	IRQ_GPIO(TOSA_GPIO_USB_IN)
-#define TOSA_IRQ_GPIO_JACKET_DETECT 	IRQ_GPIO(TOSA_GPIO_JACKET_DETECT)
-#define TOSA_IRQ_GPIO_nSD_INT       	IRQ_GPIO(TOSA_GPIO_nSD_INT)
-#define TOSA_IRQ_GPIO_nSD_DETECT    	IRQ_GPIO(TOSA_GPIO_nSD_DETECT)
-#define TOSA_IRQ_GPIO_BAT1_CRG      	IRQ_GPIO(TOSA_GPIO_BAT1_CRG)
-#define TOSA_IRQ_GPIO_CF_CD         	IRQ_GPIO(TOSA_GPIO_CF_CD)
-#define TOSA_IRQ_GPIO_BAT0_CRG      	IRQ_GPIO(TOSA_GPIO_BAT0_CRG)
-#define TOSA_IRQ_GPIO_TC6393XB_INT    	IRQ_GPIO(TOSA_GPIO_TC6393XB_INT)
-#define TOSA_IRQ_GPIO_BAT0_LOW      	IRQ_GPIO(TOSA_GPIO_BAT0_LOW)
-#define TOSA_IRQ_GPIO_EAR_IN        	IRQ_GPIO(TOSA_GPIO_EAR_IN)
-#define TOSA_IRQ_GPIO_CF_IRQ        	IRQ_GPIO(TOSA_GPIO_CF_IRQ)
-#define TOSA_IRQ_GPIO_ON_KEY        	IRQ_GPIO(TOSA_GPIO_ON_KEY)
-#define TOSA_IRQ_GPIO_VGA_LINE      	IRQ_GPIO(TOSA_GPIO_VGA_LINE)
-#define TOSA_IRQ_GPIO_TP_INT        	IRQ_GPIO(TOSA_GPIO_TP_INT)
-#define TOSA_IRQ_GPIO_JC_CF_IRQ     	IRQ_GPIO(TOSA_GPIO_JC_CF_IRQ)
-#define TOSA_IRQ_GPIO_BAT_LOCKED    	IRQ_GPIO(TOSA_GPIO_BAT_LOCKED)
-#define TOSA_IRQ_GPIO_BAT1_LOW      	IRQ_GPIO(TOSA_GPIO_BAT1_LOW)
-#define TOSA_IRQ_GPIO_KEY_SENSE(a)  	IRQ_GPIO(69+(a))
-
-#define TOSA_IRQ_GPIO_MAIN_BAT_LOW 	IRQ_GPIO(TOSA_GPIO_MAIN_BAT_LOW)
+#define TOSA_IRQ_GPIO_WAKEUP        	pxa_gpio_to_irq(TOSA_GPIO_WAKEUP)
+#define TOSA_IRQ_GPIO_AC_IN         	pxa_gpio_to_irq(TOSA_GPIO_AC_IN)
+#define TOSA_IRQ_GPIO_RECORD_BTN    	pxa_gpio_to_irq(TOSA_GPIO_RECORD_BTN)
+#define TOSA_IRQ_GPIO_SYNC          	pxa_gpio_to_irq(TOSA_GPIO_SYNC)
+#define TOSA_IRQ_GPIO_USB_IN        	pxa_gpio_to_irq(TOSA_GPIO_USB_IN)
+#define TOSA_IRQ_GPIO_JACKET_DETECT 	pxa_gpio_to_irq(TOSA_GPIO_JACKET_DETECT)
+#define TOSA_IRQ_GPIO_nSD_INT       	pxa_gpio_to_irq(TOSA_GPIO_nSD_INT)
+#define TOSA_IRQ_GPIO_nSD_DETECT    	pxa_gpio_to_irq(TOSA_GPIO_nSD_DETECT)
+#define TOSA_IRQ_GPIO_BAT1_CRG      	pxa_gpio_to_irq(TOSA_GPIO_BAT1_CRG)
+#define TOSA_IRQ_GPIO_CF_CD         	pxa_gpio_to_irq(TOSA_GPIO_CF_CD)
+#define TOSA_IRQ_GPIO_BAT0_CRG      	pxa_gpio_to_irq(TOSA_GPIO_BAT0_CRG)
+#define TOSA_IRQ_GPIO_TC6393XB_INT    	pxa_gpio_to_irq(TOSA_GPIO_TC6393XB_INT)
+#define TOSA_IRQ_GPIO_BAT0_LOW      	pxa_gpio_to_irq(TOSA_GPIO_BAT0_LOW)
+#define TOSA_IRQ_GPIO_EAR_IN        	pxa_gpio_to_irq(TOSA_GPIO_EAR_IN)
+#define TOSA_IRQ_GPIO_CF_IRQ        	pxa_gpio_to_irq(TOSA_GPIO_CF_IRQ)
+#define TOSA_IRQ_GPIO_ON_KEY        	pxa_gpio_to_irq(TOSA_GPIO_ON_KEY)
+#define TOSA_IRQ_GPIO_VGA_LINE      	pxa_gpio_to_irq(TOSA_GPIO_VGA_LINE)
+#define TOSA_IRQ_GPIO_TP_INT        	pxa_gpio_to_irq(TOSA_GPIO_TP_INT)
+#define TOSA_IRQ_GPIO_JC_CF_IRQ     	pxa_gpio_to_irq(TOSA_GPIO_JC_CF_IRQ)
+#define TOSA_IRQ_GPIO_BAT_LOCKED    	pxa_gpio_to_irq(TOSA_GPIO_BAT_LOCKED)
+#define TOSA_IRQ_GPIO_BAT1_LOW      	pxa_gpio_to_irq(TOSA_GPIO_BAT1_LOW)
+#define TOSA_IRQ_GPIO_KEY_SENSE(a)  	pxa_gpio_to_irq(69+(a))
+
+#define TOSA_IRQ_GPIO_MAIN_BAT_LOW 	pxa_gpio_to_irq(TOSA_GPIO_MAIN_BAT_LOW)
 
 #define TOSA_KEY_SYNC		KEY_102ND /* ??? */
 
diff --git a/arch/arm/mach-pxa/include/mach/trizeps4.h b/arch/arm/mach-pxa/include/mach/trizeps4.h
index 903e1a2..19f8559 100644
--- a/arch/arm/mach-pxa/include/mach/trizeps4.h
+++ b/arch/arm/mach-pxa/include/mach/trizeps4.h
@@ -43,30 +43,30 @@
 
 /* Ethernet Controller Davicom DM9000 */
 #define GPIO_DM9000		101
-#define TRIZEPS4_ETH_IRQ	IRQ_GPIO(GPIO_DM9000)
+#define TRIZEPS4_ETH_IRQ	pxa_gpio_to_irq(GPIO_DM9000)
 
 /* UCB1400 audio / TS-controller */
 #define GPIO_UCB1400		1
-#define TRIZEPS4_UCB1400_IRQ	IRQ_GPIO(GPIO_UCB1400)
+#define TRIZEPS4_UCB1400_IRQ	pxa_gpio_to_irq(GPIO_UCB1400)
 
 /* PCMCIA socket Compact Flash */
 #define GPIO_PCD		11		/* PCMCIA Card Detect */
-#define TRIZEPS4_CD_IRQ		IRQ_GPIO(GPIO_PCD)
+#define TRIZEPS4_CD_IRQ		pxa_gpio_to_irq(GPIO_PCD)
 #define GPIO_PRDY		13		/* READY / nINT */
-#define TRIZEPS4_READY_NINT	IRQ_GPIO(GPIO_PRDY)
+#define TRIZEPS4_READY_NINT	pxa_gpio_to_irq(GPIO_PRDY)
 
 /* MMC socket */
 #define GPIO_MMC_DET		12
-#define TRIZEPS4_MMC_IRQ	IRQ_GPIO(GPIO_MMC_DET)
+#define TRIZEPS4_MMC_IRQ	pxa_gpio_to_irq(GPIO_MMC_DET)
 
 /* DOC NAND chip */
 #define GPIO_DOC_LOCK           94
 #define GPIO_DOC_IRQ            93
-#define TRIZEPS4_DOC_IRQ        IRQ_GPIO(GPIO_DOC_IRQ)
+#define TRIZEPS4_DOC_IRQ        pxa_gpio_to_irq(GPIO_DOC_IRQ)
 
 /* SPI interface */
 #define GPIO_SPI                53
-#define TRIZEPS4_SPI_IRQ        IRQ_GPIO(GPIO_SPI)
+#define TRIZEPS4_SPI_IRQ        pxa_gpio_to_irq(GPIO_SPI)
 
 /* LEDS using tx2 / rx2 */
 #define GPIO_SYS_BUSY_LED	46
@@ -74,7 +74,7 @@
 
 /* Off-module PIC on ConXS board */
 #define GPIO_PIC		0
-#define TRIZEPS4_PIC_IRQ	IRQ_GPIO(GPIO_PIC)
+#define TRIZEPS4_PIC_IRQ	pxa_gpio_to_irq(GPIO_PIC)
 
 #ifdef CONFIG_MACH_TRIZEPS_CONXS
 /* for CONXS base board define these registers */
diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index a8e1aa1..26ad6cd 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -11,7 +11,6 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
  */
-#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
@@ -90,45 +89,6 @@ static struct irq_chip pxa_internal_irq_chip = {
 	.irq_unmask	= pxa_unmask_irq,
 };
 
-/*
- * GPIO IRQs for GPIO 0 and 1
- */
-static int pxa_set_low_gpio_type(struct irq_data *d, unsigned int type)
-{
-	int gpio = d->irq - IRQ_GPIO0;
-
-	if (__gpio_is_occupied(gpio)) {
-		pr_err("%s failed: GPIO is configured\n", __func__);
-		return -EINVAL;
-	}
-
-	if (type & IRQ_TYPE_EDGE_RISING)
-		GRER(gpio) |= GPIO_bit(gpio);
-	else
-		GRER(gpio) &= ~GPIO_bit(gpio);
-
-	if (type & IRQ_TYPE_EDGE_FALLING)
-		GFER(gpio) |= GPIO_bit(gpio);
-	else
-		GFER(gpio) &= ~GPIO_bit(gpio);
-
-	return 0;
-}
-
-static void pxa_ack_low_gpio(struct irq_data *d)
-{
-	int gpio = d->irq - IRQ_GPIO0;
-	GEDR(gpio) = 1 << gpio;
-}
-
-static struct irq_chip pxa_low_gpio_chip = {
-	.name		= "GPIO-l",
-	.irq_ack	= pxa_ack_low_gpio,
-	.irq_mask	= pxa_mask_irq,
-	.irq_unmask	= pxa_unmask_irq,
-	.irq_set_type	= pxa_set_low_gpio_type,
-};
-
 asmlinkage void __exception_irq_entry icip_handle_irq(struct pt_regs *regs)
 {
 	uint32_t icip, icmr, mask;
@@ -159,26 +119,6 @@ asmlinkage void __exception_irq_entry ichp_handle_irq(struct pt_regs *regs)
 	} while (1);
 }
 
-static void __init pxa_init_low_gpio_irq(int (*fn)(struct irq_data *,
-					 unsigned int))
-{
-	int irq;
-
-	/* clear edge detection on GPIO 0 and 1 */
-	GFER(0) &= ~0x3;
-	GRER(0) &= ~0x3;
-	GEDR(0) = 0x3;
-
-	for (irq = IRQ_GPIO0; irq <= IRQ_GPIO1; irq++) {
-		irq_set_chip_and_handler(irq, &pxa_low_gpio_chip,
-					 handle_edge_irq);
-		irq_set_chip_data(irq, irq_base(0));
-		set_irq_flags(irq, IRQF_VALID);
-	}
-
-	pxa_low_gpio_chip.irq_set_wake = fn;
-}
-
 void __init pxa_init_irq(int irq_nr, int (*fn)(struct irq_data *, unsigned int))
 {
 	int irq, i, n;
@@ -209,7 +149,6 @@ void __init pxa_init_irq(int irq_nr, int (*fn)(struct irq_data *, unsigned int))
 	__raw_writel(1, irq_base(0) + ICCR);
 
 	pxa_internal_irq_chip.irq_set_wake = fn;
-	pxa_init_low_gpio_irq(fn);
 }
 
 #ifdef CONFIG_PM
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index 0296e1d..4cf259b 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -124,8 +124,8 @@ static struct resource smc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= IRQ_GPIO(mfp_to_gpio(MFP_PIN_GPIO90)),
-		.end	= IRQ_GPIO(mfp_to_gpio(MFP_PIN_GPIO90)),
+		.start	= pxa_gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO90)),
+		.end	= pxa_gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO90)),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWEDGE,
 	}
 };
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index 64540d9..b5e0968 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -152,8 +152,8 @@ static void __init lpd270_init_irq(void)
 					 handle_level_irq);
 		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
 	}
-	irq_set_chained_handler(IRQ_GPIO(0), lpd270_irq_handler);
-	irq_set_irq_type(IRQ_GPIO(0), IRQ_TYPE_EDGE_FALLING);
+	irq_set_chained_handler(pxa_gpio_to_irq(0), lpd270_irq_handler);
+	irq_set_irq_type(pxa_gpio_to_irq(0), IRQ_TYPE_EDGE_FALLING);
 }
 
 
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index c48ce6d..b33c633 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -170,8 +170,8 @@ static void __init lubbock_init_irq(void)
 		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
 	}
 
-	irq_set_chained_handler(IRQ_GPIO(0), lubbock_irq_handler);
-	irq_set_irq_type(IRQ_GPIO(0), IRQ_TYPE_EDGE_FALLING);
+	irq_set_chained_handler(pxa_gpio_to_irq(0), lubbock_irq_handler);
+	irq_set_irq_type(pxa_gpio_to_irq(0), IRQ_TYPE_EDGE_FALLING);
 }
 
 #ifdef CONFIG_PM
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index 0567d39..cd3917a 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -178,8 +178,8 @@ static void __init mainstone_init_irq(void)
 	MST_INTMSKENA = 0;
 	MST_INTSETCLR = 0;
 
-	irq_set_chained_handler(IRQ_GPIO(0), mainstone_irq_handler);
-	irq_set_irq_type(IRQ_GPIO(0), IRQ_TYPE_EDGE_FALLING);
+	irq_set_chained_handler(pxa_gpio_to_irq(0), mainstone_irq_handler);
+	irq_set_irq_type(pxa_gpio_to_irq(0), IRQ_TYPE_EDGE_FALLING);
 }
 
 #ifdef CONFIG_PM
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 469dcd6..a577826 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -166,8 +166,8 @@ static struct resource locomo_resources[] = {
 		.flags		= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start		= IRQ_GPIO(10),
-		.end		= IRQ_GPIO(10),
+		.start		= pxa_gpio_to_irq(10),
+		.end		= pxa_gpio_to_irq(10),
 		.flags		= IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
index 785880f..7fa6f84 100644
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -907,24 +907,24 @@ static int __devinit sharpsl_pm_probe(struct platform_device *pdev)
 	gpio_direction_input(sharpsl_pm.machinfo->gpio_batlock);
 
 	/* Register interrupt handlers */
-	if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_acin), sharpsl_ac_isr, IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING, "AC Input Detect", sharpsl_ac_isr)) {
-		dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", IRQ_GPIO(sharpsl_pm.machinfo->gpio_acin));
+	if (request_irq(pxa_gpio_to_irq(sharpsl_pm.machinfo->gpio_acin), sharpsl_ac_isr, IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING, "AC Input Detect", sharpsl_ac_isr)) {
+		dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", pxa_gpio_to_irq(sharpsl_pm.machinfo->gpio_acin));
 	}
 
-	if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batlock), sharpsl_fatal_isr, IRQF_DISABLED | IRQF_TRIGGER_FALLING, "Battery Cover", sharpsl_fatal_isr)) {
-		dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", IRQ_GPIO(sharpsl_pm.machinfo->gpio_batlock));
+	if (request_irq(pxa_gpio_to_irq(sharpsl_pm.machinfo->gpio_batlock), sharpsl_fatal_isr, IRQF_DISABLED | IRQF_TRIGGER_FALLING, "Battery Cover", sharpsl_fatal_isr)) {
+		dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", pxa_gpio_to_irq(sharpsl_pm.machinfo->gpio_batlock));
 	}
 
 	if (sharpsl_pm.machinfo->gpio_fatal) {
-		if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_fatal), sharpsl_fatal_isr, IRQF_DISABLED | IRQF_TRIGGER_FALLING, "Fatal Battery", sharpsl_fatal_isr)) {
-			dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", IRQ_GPIO(sharpsl_pm.machinfo->gpio_fatal));
+		if (request_irq(pxa_gpio_to_irq(sharpsl_pm.machinfo->gpio_fatal), sharpsl_fatal_isr, IRQF_DISABLED | IRQF_TRIGGER_FALLING, "Fatal Battery", sharpsl_fatal_isr)) {
+			dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", pxa_gpio_to_irq(sharpsl_pm.machinfo->gpio_fatal));
 		}
 	}
 
 	if (sharpsl_pm.machinfo->batfull_irq) {
 		/* Register interrupt handler. */
-		if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batfull), sharpsl_chrg_full_isr, IRQF_DISABLED | IRQF_TRIGGER_RISING, "CO", sharpsl_chrg_full_isr)) {
-			dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", IRQ_GPIO(sharpsl_pm.machinfo->gpio_batfull));
+		if (request_irq(pxa_gpio_to_irq(sharpsl_pm.machinfo->gpio_batfull), sharpsl_chrg_full_isr, IRQF_DISABLED | IRQF_TRIGGER_RISING, "CO", sharpsl_chrg_full_isr)) {
+			dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", pxa_gpio_to_irq(sharpsl_pm.machinfo->gpio_batfull));
 		}
 	}
 
@@ -953,14 +953,14 @@ static int sharpsl_pm_remove(struct platform_device *pdev)
 
 	led_trigger_unregister_simple(sharpsl_charge_led_trigger);
 
-	free_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_acin), sharpsl_ac_isr);
-	free_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batlock), sharpsl_fatal_isr);
+	free_irq(pxa_gpio_to_irq(sharpsl_pm.machinfo->gpio_acin), sharpsl_ac_isr);
+	free_irq(pxa_gpio_to_irq(sharpsl_pm.machinfo->gpio_batlock), sharpsl_fatal_isr);
 
 	if (sharpsl_pm.machinfo->gpio_fatal)
-		free_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_fatal), sharpsl_fatal_isr);
+		free_irq(pxa_gpio_to_irq(sharpsl_pm.machinfo->gpio_fatal), sharpsl_fatal_isr);
 
 	if (sharpsl_pm.machinfo->batfull_irq)
-		free_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batfull), sharpsl_chrg_full_isr);
+		free_irq(pxa_gpio_to_irq(sharpsl_pm.machinfo->gpio_batfull), sharpsl_chrg_full_isr);
 
 	gpio_free(sharpsl_pm.machinfo->gpio_batlock);
 	gpio_free(sharpsl_pm.machinfo->gpio_batfull);
diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index 8752dc0..6f23f7a 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -376,7 +376,7 @@ static struct spi_board_info spi_board_info[] __initdata = {
 		.bus_num = 1,
 		.chip_select = 0,
 		.controller_data = &staccel_chip_info,
-		.irq = IRQ_GPIO(96),
+		.irq = pxa_gpio_to_irq(96),
 	}, {
 		.modalias = "cc2420",
 		.max_speed_hz = 6500000,
@@ -560,18 +560,18 @@ static struct i2c_board_info __initdata imote2_i2c_board_info[] = {
 		/* Through a nand gate - Also beware, on V2 sensor board the
 		 * pull up resistors are missing.
 		 */
-		.irq = IRQ_GPIO(99),
+		.irq = pxa_gpio_to_irq(99),
 	}, { /* ITS400 Sensor board only */
 		.type = "tsl2561",
 		.addr = 0x49,
 		/* Through a nand gate - Also beware, on V2 sensor board the
 		 * pull up resistors are missing.
 		 */
-		.irq = IRQ_GPIO(99),
+		.irq = pxa_gpio_to_irq(99),
 	}, { /* ITS400 Sensor board only */
 		.type = "tmp175",
 		.addr = 0x4A,
-		.irq = IRQ_GPIO(96),
+		.irq = pxa_gpio_to_irq(96),
 	}, { /* IMB400 Multimedia board */
 		.type = "wm8940",
 		.addr = 0x1A,
@@ -661,8 +661,8 @@ static struct resource smc91x_resources[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start = IRQ_GPIO(40),
-		.end = IRQ_GPIO(40),
+		.start = pxa_gpio_to_irq(40),
+		.end = pxa_gpio_to_irq(40),
 		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	}
 };
@@ -707,7 +707,7 @@ static int stargate2_mci_init(struct device *dev,
 	}
 	gpio_direction_input(SG2_GPIO_nSD_DETECT);
 
-	err = request_irq(IRQ_GPIO(SG2_GPIO_nSD_DETECT),
+	err = request_irq(pxa_gpio_to_irq(SG2_GPIO_nSD_DETECT),
 			  stargate2_detect_int,
 			  IRQ_TYPE_EDGE_BOTH,
 			  "MMC card detect",
@@ -738,7 +738,7 @@ static void stargate2_mci_setpower(struct device *dev, unsigned int vdd)
 
 static void stargate2_mci_exit(struct device *dev, void *data)
 {
-	free_irq(IRQ_GPIO(SG2_GPIO_nSD_DETECT), data);
+	free_irq(pxa_gpio_to_irq(SG2_GPIO_nSD_DETECT), data);
 	gpio_free(SG2_SD_POWER_ENABLE);
 	gpio_free(SG2_GPIO_nSD_DETECT);
 }
@@ -938,18 +938,18 @@ static struct i2c_board_info __initdata stargate2_i2c_board_info[] = {
 		/* Through a nand gate - Also beware, on V2 sensor board the
 		 * pull up resistors are missing.
 		 */
-		.irq = IRQ_GPIO(99),
+		.irq = pxa_gpio_to_irq(99),
 	}, { /* ITS400 Sensor board only */
 		.type = "tsl2561",
 		.addr = 0x49,
 		/* Through a nand gate - Also beware, on V2 sensor board the
 		 * pull up resistors are missing.
 		 */
-		.irq = IRQ_GPIO(99),
+		.irq = pxa_gpio_to_irq(99),
 	}, { /* ITS400 Sensor board only */
 		.type = "tmp175",
 		.addr = 0x4A,
-		.irq = IRQ_GPIO(96),
+		.irq = pxa_gpio_to_irq(96),
 	},
 };
 
diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
index 261f258..f648608 100644
--- a/arch/arm/mach-pxa/vpac270.c
+++ b/arch/arm/mach-pxa/vpac270.c
@@ -395,8 +395,8 @@ static struct resource vpac270_dm9000_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[2] = {
-		.start	= IRQ_GPIO(GPIO114_VPAC270_ETH_IRQ),
-		.end	= IRQ_GPIO(GPIO114_VPAC270_ETH_IRQ),
+		.start	= pxa_gpio_to_irq(GPIO114_VPAC270_ETH_IRQ),
+		.end	= pxa_gpio_to_irq(GPIO114_VPAC270_ETH_IRQ),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	},
 };
@@ -433,7 +433,7 @@ static pxa2xx_audio_ops_t vpac270_ac97_pdata = {
 };
 
 static struct ucb1400_pdata vpac270_ucb1400_pdata = {
-	.irq		= IRQ_GPIO(GPIO113_VPAC270_TS_IRQ),
+	.irq		= pxa_gpio_to_irq(GPIO113_VPAC270_TS_IRQ),
 };
 
 static struct platform_device vpac270_ucb1400_device = {
diff --git a/arch/arm/mach-pxa/zylonite_pxa300.c b/arch/arm/mach-pxa/zylonite_pxa300.c
index 93c64d8..dcdf0d2 100644
--- a/arch/arm/mach-pxa/zylonite_pxa300.c
+++ b/arch/arm/mach-pxa/zylonite_pxa300.c
@@ -231,12 +231,12 @@ static struct i2c_board_info zylonite_i2c_board_info[] = {
 		.type		= "pca9539",
 		.addr		= 0x74,
 		.platform_data	= &gpio_exp[0],
-		.irq		= IRQ_GPIO(18),
+		.irq		= pxa_gpio_to_irq(18),
 	}, {
 		.type		= "pca9539",
 		.addr		= 0x75,
 		.platform_data	= &gpio_exp[1],
-		.irq		= IRQ_GPIO(19),
+		.irq		= pxa_gpio_to_irq(19),
 	},
 };
 
diff --git a/arch/arm/plat-pxa/gpio.c b/arch/arm/plat-pxa/gpio.c
index 5ab42f8..d667d8d 100644
--- a/arch/arm/plat-pxa/gpio.c
+++ b/arch/arm/plat-pxa/gpio.c
@@ -282,6 +282,20 @@ void __init pxa_init_gpio(int mux_irq, int start, int end,
 		__raw_writel(~0,c->regbase + GEDR_OFFSET);
 	}
 
+#ifdef CONFIG_ARCH_PXA
+	irq = gpio_to_irq(0);
+	irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
+				 handle_edge_irq);
+	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+	irq_set_chained_handler(IRQ_GPIO0, pxa_gpio_demux_handler);
+
+	irq = gpio_to_irq(1);
+	irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
+				 handle_edge_irq);
+	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+	irq_set_chained_handler(IRQ_GPIO1, pxa_gpio_demux_handler);
+#endif
+
 	for (irq  = pxa_gpio_to_irq(start); irq <= pxa_gpio_to_irq(end);
 		irq++) {
 		irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
-- 
1.7.2.5
