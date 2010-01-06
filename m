From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:32:08 -0800
Subject: [PATCH 26/35] davinci: add CDCE949 support on DM6467 EVM
In-Reply-To: <1262802737-6601-26-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-5-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-6-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-7-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-8-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-9-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-10-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-11-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-12-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-13-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-14-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-15-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-16-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-17-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-18-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-19-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-20-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-21-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-22-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-23-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-24-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-25-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-26-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-27-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nageswari Srinivasan <nageswari@ti.com>

This patch adds the CDCE949 reference oscillator to
the davinci clock list.

On the DM6467T EVM, the CDCE949 is responsible for
generating the pixel clock for display. On the DM6467
EVM, this pixel clock was being obtained from an
internal source. This is not possible on the DM6467T
EVM because of the presence of a 33MHz oscillator.

The TSIF module also requires the CDCE949 to generate
the data clocks.

The actual clock definitions will be added by patches
adding support for DM6467T VPIF and TSIF. This patch
mearly lays the foundation for that work.

Signed-off-by: Nageswari Srinivasan <nageswari@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/Makefile           |    2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c |   31 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index d0fed3a..6aac880 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -26,7 +26,7 @@ obj-$(CONFIG_MACH_SFFSDR)		+= board-sffsdr.o
 obj-$(CONFIG_MACH_NEUROS_OSD2)		+= board-neuros-osd2.o
 obj-$(CONFIG_MACH_DAVINCI_DM355_EVM)	+= board-dm355-evm.o
 obj-$(CONFIG_MACH_DM355_LEOPARD)	+= board-dm355-leopard.o
-obj-$(CONFIG_MACH_DAVINCI_DM6467_EVM)	+= board-dm646x-evm.o
+obj-$(CONFIG_MACH_DAVINCI_DM6467_EVM)	+= board-dm646x-evm.o cdce949.o
 obj-$(CONFIG_MACH_DAVINCI_DM365_EVM)	+= board-dm365-evm.o
 obj-$(CONFIG_MACH_DAVINCI_DA830_EVM)	+= board-da830-evm.o
 obj-$(CONFIG_MACH_DAVINCI_DA850_EVM)	+= board-da850-evm.o
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 6ff3411..6c7c604 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -40,6 +40,8 @@
 #include <mach/serial.h>
 #include <mach/i2c.h>
 #include <mach/nand.h>
+#include <mach/clock.h>
+#include <mach/cdce949.h>
 
 #include "clock.h"
 
@@ -389,6 +391,9 @@ static struct i2c_board_info __initdata i2c_info[] =  {
 	{
 		I2C_BOARD_INFO("cpld_video", 0x3b),
 	},
+	{
+		I2C_BOARD_INFO("cdce949", 0x6c),
+	},
 };
 
 static struct davinci_i2c_platform_data i2c_pdata = {
@@ -681,9 +686,35 @@ static void __init evm_init_i2c(void)
 	evm_init_video();
 }
 
+#define CDCE949_XIN_RATE	27000000
+
+/* CDCE949 support - "lpsc" field is overridden to work as clock number */
+static struct clk cdce_clk_in = {
+	.name	= "cdce_xin",
+	.rate	= ATOMIC_INIT(CDCE949_XIN_RATE),
+};
+
+static struct davinci_clk cdce_clks[] = {
+	CLK(NULL, "xin", &cdce_clk_in),
+	CLK(NULL, NULL, NULL),
+};
+
+static void __init cdce_clk_init(void)
+{
+	struct davinci_clk *c;
+	struct clk *clk;
+
+	for (c = cdce_clks; c->lk.clk; c++) {
+		clk = c->lk.clk;
+		clkdev_add(&c->lk);
+		clk_register(clk);
+	}
+}
+
 static void __init davinci_map_io(void)
 {
 	dm646x_init();
+	cdce_clk_init();
 }
 
 static struct davinci_uart_config uart_config __initdata = {
-- 
1.6.6.rc2.1.g42108
