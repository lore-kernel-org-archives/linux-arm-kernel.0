From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:22 -0700
Subject: [PATCH 18/46] davinci: Add LCD Graphics support for DA830/OMAP-L137
	EVM
In-Reply-To: <1255720190-7452-19-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-10-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-11-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-12-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-13-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-14-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-15-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-16-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-17-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-18-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-19-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-20-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Chen <schen@mvista.com>

Add graphics support for the Sharp LCD035Q3DG01 graphical
LCD that's on the User Interface (UI) daughter card of the
DA830/OMAP-L137 EVM.

The LCD shares EMIFA lines with the NAND and NOR devices that
are also on the UI card so those lines are shared via a couple
of muxes.  The muxes are controlled by the 'MUX_MODE' line on
the UI card.  The 'MUX_MODE' line is controlled by pin P6 of
a pcf8574 i2c expander that's at i2c address 0x3f on UI card.
The i2c expander is controlled using the gpio infrastructure
from the board code using the 'setup()' and 'teardown()'
routines.

Signed-off-by: Steve Chen <schen@mvista.com>
Signed-off-by: Mark A. Greer <mgreer@mvista.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/Kconfig           |   21 ++++++++++++++
 arch/arm/mach-davinci/board-da830-evm.c |   44 ++++++++++++++++++++++++++++++-
 arch/arm/mach-davinci/da830.c           |    2 +-
 3 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 40866c6..7b6dddf 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -101,6 +101,27 @@ config MACH_DAVINCI_DA830_EVM
 	help
 	  Say Y here to select the TI DA830/OMAP-L137 Evaluation Module.
 
+config DA830_UI
+	bool "DA830/OMAP-L137 UI (User Interface) board support"
+	depends on MACH_DAVINCI_DA830_EVM
+	help
+	  Say Y here if you have the DA830/OMAP-L137 UI
+	  (User Interface) board installed and you want to
+	  enable the peripherals located on User Interface
+	  board.
+
+choice
+	prompt "Select DA830/OMAP-L137 UI board peripheral"
+	depends on DA830_UI
+
+config DA830_UI_LCD
+	bool "LCD"
+	help
+	  Say Y here to use the LCD as a framebuffer or simple character
+	  display.
+
+endchoice
+
 config MACH_DAVINCI_DA850_EVM
 	bool "TI DA850/OMAP-L138 Reference Platform"
 	default ARCH_DAVINCI_DA850
diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 69a791a..dfc4897 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -13,7 +13,9 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/console.h>
+#include <linux/gpio.h>
 #include <linux/i2c.h>
+#include <linux/i2c/pcf857x.h>
 #include <linux/i2c/at24.h>
 
 #include <asm/mach-types.h>
@@ -38,6 +40,31 @@ static struct at24_platform_data da830_evm_i2c_eeprom_info = {
 	.context	= (void *)0x7f00,
 };
 
+static int da830_evm_ui_expander_setup(struct i2c_client *client, int gpio,
+		unsigned ngpio, void *context)
+{
+	gpio_request(gpio + 6, "MUX_MODE");
+#ifdef CONFIG_DA830_UI_LCD
+	gpio_direction_output(gpio + 6, 0);
+#else /* Must be NAND or NOR */
+	gpio_direction_output(gpio + 6, 1);
+#endif
+	return 0;
+}
+
+static int da830_evm_ui_expander_teardown(struct i2c_client *client, int gpio,
+		unsigned ngpio, void *context)
+{
+	gpio_free(gpio + 6);
+	return 0;
+}
+
+static struct pcf857x_platform_data da830_evm_ui_expander_info = {
+	.gpio_base	= DAVINCI_N_GPIO,
+	.setup		= da830_evm_ui_expander_setup,
+	.teardown	= da830_evm_ui_expander_teardown,
+};
+
 static struct i2c_board_info __initdata da830_evm_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("24c256", 0x50),
@@ -45,7 +72,11 @@ static struct i2c_board_info __initdata da830_evm_i2c_devices[] = {
 	},
 	{
 		I2C_BOARD_INFO("tlv320aic3x", 0x18),
-	}
+	},
+	{
+		I2C_BOARD_INFO("pcf8574", 0x3f),
+		.platform_data	= &da830_evm_ui_expander_info,
+	},
 };
 
 static struct davinci_i2c_platform_data da830_evm_i2c_0_pdata = {
@@ -175,6 +206,17 @@ static __init void da830_evm_init(void)
 	if (ret)
 		pr_warning("da830_evm_init: mmc/sd registration failed: %d\n",
 				ret);
+
+#ifdef CONFIG_DA830_UI_LCD
+	ret = da8xx_pinmux_setup(da830_lcdcntl_pins);
+	if (ret)
+		pr_warning("da830_evm_init: lcdcntl mux setup failed: %d\n",
+				ret);
+
+	ret = da8xx_register_lcdc(&sharp_lcd035q3dg01_pdata);
+	if (ret)
+		pr_warning("da830_evm_init: lcd setup failed: %d\n", ret);
+#endif
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index f52174a..f0b2f96 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -411,7 +411,7 @@ static struct davinci_clk da830_clks[] = {
 	CLK(NULL,		"pwm2",		&pwm2_clk),
 	CLK("eqep.0",		NULL,		&eqep0_clk),
 	CLK("eqep.1",		NULL,		&eqep1_clk),
-	CLK("da830_lcdc",	NULL,		&lcdc_clk),
+	CLK("da8xx_lcdc.0",	NULL,		&lcdc_clk),
 	CLK("davinci-mcasp.0",	NULL,		&mcasp0_clk),
 	CLK("davinci-mcasp.1",	NULL,		&mcasp1_clk),
 	CLK("davinci-mcasp.2",	NULL,		&mcasp2_clk),
-- 
1.6.4.3
