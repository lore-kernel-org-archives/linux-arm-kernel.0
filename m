From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 13 Jun 2013 22:19:45 +0200
Subject: [PATCH 1/2] ARM: u300: switch to using syscon regmap for board
Message-ID: <1371154785-28082-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This switches the code using a local remapping of the
system controller to enable the U300 board to be
self-powered over to making the U300-specific syscon
compatible with the MFD generic syscon driver, selecting
the generic syscon driver, and augmenting the board
power code to pick the regmap and manipulate the syscon
from the regmap side of things.

Cc: Dong Aisheng <dong.aisheng@linaro.org>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-u300.dts |  2 +-
 arch/arm/mach-u300/Kconfig     |  1 +
 arch/arm/mach-u300/regulator.c | 19 ++++++++-----------
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index 05a0821..8a1032c 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -31,7 +31,7 @@
 	};
 
 	syscon: syscon at c0011000 {
-		compatible = "stericsson,u300-syscon";
+		compatible = "stericsson,u300-syscon", "syscon";
 		reg = <0xc0011000 0x1000>;
 		clk32: app_32_clk at 32k {
 			#clock-cells = <0>;
diff --git a/arch/arm/mach-u300/Kconfig b/arch/arm/mach-u300/Kconfig
index e2f350f..09f4dda 100644
--- a/arch/arm/mach-u300/Kconfig
+++ b/arch/arm/mach-u300/Kconfig
@@ -20,6 +20,7 @@ config ARCH_U300
 	select PINCTRL_COH901
 	select PINCTRL_U300
 	select SPARSE_IRQ
+	select MFD_SYSCON
 	select USE_OF
 	help
 	  Support for ST-Ericsson U300 series mobile platforms.
diff --git a/arch/arm/mach-u300/regulator.c b/arch/arm/mach-u300/regulator.c
index 273fceb..bf40cd4 100644
--- a/arch/arm/mach-u300/regulator.c
+++ b/arch/arm/mach-u300/regulator.c
@@ -15,9 +15,8 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/consumer.h>
-/* Those are just for writing in syscon */
-#include <linux/of_address.h>
-#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 /* Power Management Control 16bit (R/W) */
 #define U300_SYSCON_PMCR					(0x50)
@@ -59,9 +58,8 @@ static int __init __u300_init_boardpower(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *syscon_np;
-	static void __iomem *syscon_base;
+	struct regmap *regmap;
 	int err;
-	u32 val;
 
 	pr_info("U300: setting up board power\n");
 
@@ -70,9 +68,9 @@ static int __init __u300_init_boardpower(struct platform_device *pdev)
 		pr_crit("U300: no syscon node\n");
 		return -ENODEV;
 	}
-	syscon_base = of_iomap(syscon_np, 0);
-	if (!syscon_base) {
-		pr_crit("U300: could not remap syscon\n");
+	regmap = syscon_node_to_regmap(syscon_np);
+	if (!regmap) {
+		pr_crit("U300: could not locate syscon regmap\n");
 		return -ENODEV;
 	}
 
@@ -96,9 +94,8 @@ static int __init __u300_init_boardpower(struct platform_device *pdev)
 	 * the rest of the U300 power management is implemented.
 	 */
 	pr_info("U300: disable system controller pull-up\n");
-	val = readw(syscon_base + U300_SYSCON_PMCR);
-	val &= ~U300_SYSCON_PMCR_DCON_ENABLE;
-	writew(val, syscon_base + U300_SYSCON_PMCR);
+	regmap_update_bits(regmap, U300_SYSCON_PMCR,
+			   U300_SYSCON_PMCR_DCON_ENABLE, 0);
 
 	/* Register globally exported PM poweroff hook */
 	pm_power_off = u300_pm_poweroff;
-- 
1.7.11.3
