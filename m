From: lost.distance@yahoo.com (Paul Parsons)
Date: Wed, 11 May 2011 19:49:20 +0000
Subject: [PATCH] pxa/hx4700: Fix basic suspend/resume
Message-ID: <E1QKFPN-0003xV-Sf@outmx07.plus.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Basic suspend/resume is fixed by ensuring that the PGSR registers are set correctly before sleep mode is entered. In particular four of the active low resets need to be driven high while in sleep mode, otherwise the unit resets itself instead of suspending. Another problem was that the PCFR_GPROD bit is apparently set by the HTC bootloader; this caused GPIO reset (i.e. the reset button) to fail immediately after returning from sleep mode.

Driver-specific bugs still remain. In particular the mmc driver does not resume properly after returning from sleep mode, thus preventing sleep mode from being entered a second time.

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
---
--- clean-2.6.39-rc7/arch/arm/mach-pxa/hx4700.c	2011-05-11 00:54:10.787247169 +0100
+++ linux-2.6.39-rc7/arch/arm/mach-pxa/hx4700.c	2011-05-11 20:21:54.026109594 +0100
@@ -120,7 +120,11 @@ static unsigned long hx4700_pin_config[]
 	GPIO19_SSP2_SCLK,
 	GPIO86_SSP2_RXD,
 	GPIO87_SSP2_TXD,
-	GPIO88_GPIO,
+	MFP_CFG_OUT(GPIO88, AF0, KEEP_OUTPUT),	/* TSC2046_CS */
+
+	/* BQ24022 Regulator */
+	MFP_CFG_OUT(GPIO72, AF0, KEEP_OUTPUT),	/* BQ24022_nCHARGE_EN */
+	MFP_CFG_OUT(GPIO96, AF0, KEEP_OUTPUT),	/* BQ24022_ISET2 */
 
 	/* HX4700 specific input GPIOs */
 	GPIO12_GPIO,	/* ASIC3_IRQ */
@@ -133,6 +137,11 @@ static unsigned long hx4700_pin_config[]
 	GPIO108_GPIO,	/* GSM_READY */
 	GPIO58_GPIO,	/* TSC2046_nPENIRQ */
 	GPIO66_GPIO,	/* nSDIO_IRQ */
+
+	MFP_CFG_OUT(GPIO61, AF0, DRIVE_HIGH),	/* W3220_nRESET */
+	MFP_CFG_OUT(GPIO71, AF0, DRIVE_HIGH),	/* ASIC3_nRESET */
+	MFP_CFG_OUT(GPIO81, AF0, DRIVE_HIGH),	/* CPU_GP_nRESET */
+	MFP_CFG_OUT(GPIO116, AF0, DRIVE_HIGH),	/* CPU_HW_nRESET */
 };
 
 #define HX4700_GPIO_IN(num, _desc) \
@@ -847,6 +872,8 @@ static struct gpio_ress global_gpios[] =
 
 static void __init hx4700_init(void)
 {
+	PCFR &= ~PCFR_GPROD;	/* Else GPIO reset fails after sleep mode */
+
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(hx4700_pin_config));
 	hx4700_gpio_request(ARRAY_AND_SIZE(global_gpios));
 
