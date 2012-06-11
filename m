From: lost.distance@yahoo.com (Paul Parsons)
Date: Mon, 11 Jun 2012 15:31:14 +0100
Subject: [PATCH v4] ARM: pxa: hx4700: Fix basic suspend/resume
Message-ID: <mailman.19.1339425083.1417.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Basic suspend/resume is fixed by ensuring that the PGSR registers are
set correctly before sleep mode is entered. In particular four of the
active low resets need to be driven high while in sleep mode, otherwise
the unit resets itself instead of suspending. Another problem was that
the PCFR_GPROD bit is set by the HTC bootloader; this caused GPIO reset
(i.e. the reset button) to fail immediately after returning from sleep
mode.

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
Cc: Philipp Zabel <philipp.zabel@gmail.com>
---

V4:
Rebased from linux-3.3-rc6 to linux-3.5-rc2.

 arch/arm/mach-pxa/hx4700.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index d09da6a..d3de84b 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -127,7 +127,11 @@ static unsigned long hx4700_pin_config[] __initdata = {
 	GPIO19_SSP2_SCLK,
 	GPIO86_SSP2_RXD,
 	GPIO87_SSP2_TXD,
-	GPIO88_GPIO,
+	GPIO88_GPIO | MFP_LPM_DRIVE_HIGH,	/* TSC2046_CS */
+
+	/* BQ24022 Regulator */
+	GPIO72_GPIO | MFP_LPM_KEEP_OUTPUT,	/* BQ24022_nCHARGE_EN */
+	GPIO96_GPIO | MFP_LPM_KEEP_OUTPUT,	/* BQ24022_ISET2 */
 
 	/* HX4700 specific input GPIOs */
 	GPIO12_GPIO | WAKEUP_ON_EDGE_RISE,	/* ASIC3_IRQ */
@@ -135,6 +139,10 @@ static unsigned long hx4700_pin_config[] __initdata = {
 	GPIO14_GPIO,	/* nWLAN_IRQ */
 
 	/* HX4700 specific output GPIOs */
+	GPIO61_GPIO | MFP_LPM_DRIVE_HIGH,	/* W3220_nRESET */
+	GPIO71_GPIO | MFP_LPM_DRIVE_HIGH,	/* ASIC3_nRESET */
+	GPIO81_GPIO | MFP_LPM_DRIVE_HIGH,	/* CPU_GP_nRESET */
+	GPIO116_GPIO | MFP_LPM_DRIVE_HIGH,	/* CPU_HW_nRESET */
 	GPIO102_GPIO | MFP_LPM_DRIVE_LOW,	/* SYNAPTICS_POWER_ON */
 
 	GPIO10_GPIO,	/* GSM_IRQ */
@@ -872,14 +880,19 @@ static struct gpio global_gpios[] = {
 	{ GPIO110_HX4700_LCD_LVDD_3V3_ON, GPIOF_OUT_INIT_HIGH, "LCD_LVDD" },
 	{ GPIO111_HX4700_LCD_AVDD_3V3_ON, GPIOF_OUT_INIT_HIGH, "LCD_AVDD" },
 	{ GPIO32_HX4700_RS232_ON,         GPIOF_OUT_INIT_HIGH, "RS232_ON" },
+	{ GPIO61_HX4700_W3220_nRESET,     GPIOF_OUT_INIT_HIGH, "W3220_nRESET" },
 	{ GPIO71_HX4700_ASIC3_nRESET,     GPIOF_OUT_INIT_HIGH, "ASIC3_nRESET" },
+	{ GPIO81_HX4700_CPU_GP_nRESET,    GPIOF_OUT_INIT_HIGH, "CPU_GP_nRESET" },
 	{ GPIO82_HX4700_EUART_RESET,      GPIOF_OUT_INIT_HIGH, "EUART_RESET" },
+	{ GPIO116_HX4700_CPU_HW_nRESET,   GPIOF_OUT_INIT_HIGH, "CPU_HW_nRESET" },
 };
 
 static void __init hx4700_init(void)
 {
 	int ret;
 
+	PCFR = PCFR_GPR_EN | PCFR_OPDE;
+
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(hx4700_pin_config));
 	gpio_set_wake(GPIO12_HX4700_ASIC3_IRQ, 1);
 	ret = gpio_request_array(ARRAY_AND_SIZE(global_gpios));
-- 
1.7.3.4
