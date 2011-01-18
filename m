From: michael.williamson@criticallink.com (Michael Williamson)
Date: Tue, 18 Jan 2011 12:21:44 -0500
Subject: [PATCH v1 3/5] davinci: da850: move da850_evm specific mcasp pins to
	board file.
In-Reply-To: <1295371306-24035-1-git-send-email-michael.williamson@criticallink.com>
References: <1295371306-24035-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <1295371306-24035-4-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The da850_mcasp_pins pinmux array is specific to the da850_evm, and is
not generic.  Move the array to the board file, make it static initdata,
and rename it accordingly.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
---
 arch/arm/mach-davinci/board-da850-evm.c    |    9 ++++++++-
 arch/arm/mach-davinci/da850.c              |    7 -------
 arch/arm/mach-davinci/include/mach/da8xx.h |    1 -
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index b01fb2a..c4c0b75 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -664,6 +664,13 @@ static struct snd_platform_data da850_evm_snd_data = {
 	.rxnumevt	= 1,
 };
 
+static const short da850_evm_mcasp_pins[] __initconst = {
+	DA850_AHCLKX, DA850_ACLKX, DA850_AFSX,
+	DA850_AHCLKR, DA850_ACLKR, DA850_AFSR, DA850_AMUTE,
+	DA850_AXR_11, DA850_AXR_12,
+	-1
+};
+
 static int da850_evm_mmc_get_ro(int index)
 {
 	return gpio_get_value(DA850_MMCSD_WP_PIN);
@@ -1106,7 +1113,7 @@ static __init void da850_evm_init(void)
 	__raw_writel(0, IO_ADDRESS(DA8XX_UART1_BASE) + 0x30);
 	__raw_writel(0, IO_ADDRESS(DA8XX_UART0_BASE) + 0x30);
 
-	ret = davinci_cfg_reg_list(da850_mcasp_pins);
+	ret = davinci_cfg_reg_list(da850_evm_mcasp_pins);
 	if (ret)
 		pr_warning("da850_evm_init: mcasp mux setup failed: %d\n",
 				ret);
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index ca4f595..5b98232 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -577,13 +577,6 @@ const short da850_i2c1_pins[] __initdata = {
 	-1
 };
 
-const short da850_mcasp_pins[] __initdata = {
-	DA850_AHCLKX, DA850_ACLKX, DA850_AFSX,
-	DA850_AHCLKR, DA850_ACLKR, DA850_AFSR, DA850_AMUTE,
-	DA850_AXR_11, DA850_AXR_12,
-	-1
-};
-
 const short da850_lcdcntl_pins[] __initdata = {
 	DA850_LCD_D_0, DA850_LCD_D_1, DA850_LCD_D_2, DA850_LCD_D_3,
 	DA850_LCD_D_4, DA850_LCD_D_5, DA850_LCD_D_6, DA850_LCD_D_7,
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 4297f1e..89668b4 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -128,7 +128,6 @@ extern const short da850_uart1_pins[];
 extern const short da850_uart2_pins[];
 extern const short da850_i2c0_pins[];
 extern const short da850_i2c1_pins[];
-extern const short da850_mcasp_pins[];
 extern const short da850_lcdcntl_pins[];
 extern const short da850_mmcsd0_pins[];
 
-- 
1.7.0.4
