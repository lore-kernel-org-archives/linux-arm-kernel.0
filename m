From: lost.distance@yahoo.com (Paul Parsons)
Date: Fri, 9 Mar 2012 16:36:13 +0000 (GMT)
Subject: [PATCH v2] pxa/hx4700: Fix basic suspend/resume
Message-ID: <1331310973.21920.YahooMailClassic@web29018.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Basic suspend/resume is fixed by ensuring that the PGSR registers are set
correctly before sleep mode is entered. In particular four of the active low
resets need to be driven high while in sleep mode, otherwise the unit resets
itself instead of suspending. Another problem was that the PCFR_GPROD bit is set
by the HTC bootloader; this caused GPIO reset (i.e. the reset button) to fail
immediately after returning from sleep mode.

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
---

V2:
Removed comment about mmc driver not resuming properly: 10 months later it does.
Stopped using the verboten MFP_CFG_OUT().
Changed GPIO88, GPIO72, GPIO96 from KEEP_OUTPUT to DRIVE_HIGH.
Added GPIO61, GPIO81, GPIO116 to global_gpios[].
Assign to PCFR instead of masking it, per manual: "Write 0b0 to reserved bits".
Rebased to linux-3.2-rc6.

diff -uprN clean-3.3-rc6/arch/arm/mach-pxa/hx4700.c linux-3.3-rc6/arch/arm/mach-pxa/hx4700.c
--- clean-3.3-rc6/arch/arm/mach-pxa/hx4700.c	2012-03-04 01:08:09.000000000 +0000
+++ linux-3.3-rc6/arch/arm/mach-pxa/hx4700.c	2012-03-09 16:06:31.121359005 +0000
@@ -121,7 +121,11 @@ static unsigned long hx4700_pin_config[]
 	GPIO19_SSP2_SCLK,
 	GPIO86_SSP2_RXD,
 	GPIO87_SSP2_TXD,
-	GPIO88_GPIO,
+	GPIO88_GPIO | MFP_LPM_DRIVE_HIGH,	/* TSC2046_CS */
+
+	/* BQ24022 Regulator */
+	GPIO72_GPIO | MFP_LPM_DRIVE_HIGH,	/* BQ24022_nCHARGE_EN */
+	GPIO96_GPIO | MFP_LPM_DRIVE_HIGH,	/* BQ24022_ISET2 */
 
 	/* HX4700 specific input GPIOs */
 	GPIO12_GPIO,	/* ASIC3_IRQ */
@@ -134,6 +138,11 @@ static unsigned long hx4700_pin_config[]
 	GPIO108_GPIO,	/* GSM_READY */
 	GPIO58_GPIO,	/* TSC2046_nPENIRQ */
 	GPIO66_GPIO,	/* nSDIO_IRQ */
+
+	GPIO61_GPIO | MFP_LPM_DRIVE_HIGH,	/* W3220_nRESET */
+	GPIO71_GPIO | MFP_LPM_DRIVE_HIGH,	/* ASIC3_nRESET */
+	GPIO81_GPIO | MFP_LPM_DRIVE_HIGH,	/* CPU_GP_nRESET */
+	GPIO116_GPIO | MFP_LPM_DRIVE_HIGH,	/* CPU_HW_nRESET */
 };
 
 /*
@@ -828,15 +837,20 @@ static struct gpio global_gpios[] = {
 	{ GPIO110_HX4700_LCD_LVDD_3V3_ON, GPIOF_OUT_INIT_HIGH, "LCD_LVDD" },
 	{ GPIO111_HX4700_LCD_AVDD_3V3_ON, GPIOF_OUT_INIT_HIGH, "LCD_AVDD" },
 	{ GPIO32_HX4700_RS232_ON,         GPIOF_OUT_INIT_HIGH, "RS232_ON" },
+	{ GPIO61_HX4700_W3220_nRESET,     GPIOF_OUT_INIT_HIGH, "W3220_nRESET" },
 	{ GPIO71_HX4700_ASIC3_nRESET,     GPIOF_OUT_INIT_HIGH, "ASIC3_nRESET" },
+	{ GPIO81_HX4700_CPU_GP_nRESET,    GPIOF_OUT_INIT_HIGH, "CPU_GP_nRESET" },
 	{ GPIO82_HX4700_EUART_RESET,      GPIOF_OUT_INIT_HIGH, "EUART_RESET" },
 	{ GPIO105_HX4700_nIR_ON,          GPIOF_OUT_INIT_HIGH, "nIR_EN" },
+	{ GPIO116_HX4700_CPU_HW_nRESET,   GPIOF_OUT_INIT_HIGH, "CPU_HW_nRESET" },
 };
 
 static void __init hx4700_init(void)
 {
 	int ret;
 
+	PCFR = PCFR_GPR_EN | PCFR_OPDE;
+
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(hx4700_pin_config));
 	ret = gpio_request_array(ARRAY_AND_SIZE(global_gpios));
 	if (ret)
