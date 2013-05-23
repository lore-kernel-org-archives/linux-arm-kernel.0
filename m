From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 23 May 2013 19:31:23 +0200
Subject: [PATCH 1/6] ARM: u300: add syscon node
In-Reply-To: <1369330288-14856-1-git-send-email-linus.walleij@stericsson.com>
References: <1369330288-14856-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1369330288-14856-2-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This adds a device tree node for the U300 system controller
and remaps this dynamically instead of using hard-coded
virtual addresses. The board power set-up code is altered
to fetch a reference to the syscon using ampersand <&syscon>
notation. This way of passing a pointer to the syscon will
also be used by the clocks.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/arm/ste-u300.txt | 30 +++++++++++++++++++---
 arch/arm/boot/dts/ste-u300.dts                     |  6 +++++
 arch/arm/mach-u300/core.c                          | 22 +++++++++++++---
 arch/arm/mach-u300/regulator.c                     | 21 ++++++++++++---
 4 files changed, 69 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/ste-u300.txt b/Documentation/devicetree/bindings/arm/ste-u300.txt
index cd9001a..69b5ab0 100644
--- a/Documentation/devicetree/bindings/arm/ste-u300.txt
+++ b/Documentation/devicetree/bindings/arm/ste-u300.txt
@@ -8,15 +8,39 @@ Required root node property:
 
 compatible="stericsson,u300";
 
+Required node: syscon
+This contains the system controller.
+- compatible: must be "stericsson,u300-syscon".
+- reg: the base address and size of the system controller.
+
 Boards with the U300 SoC include:
 
 S365 "Small Board U365":
 
 Required node: s365
+This contains the board-specific information.
+- compatible: must be "stericsson,s365".
+- vana15-supply: the regulator supplying the 1.5V to drive the
+  board.
+- syscon: a pointer to the syscon node so we can acccess the
+  syscon registers to set the board as self-powered.
 
 Example:
 
-s365 {
-	compatible = "stericsson,s365";
-	vana15-supply = <&ab3100_ldo_d_reg>;
+/ {
+	model = "ST-Ericsson U300";
+	compatible = "stericsson,u300";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	s365 {
+		compatible = "stericsson,s365";
+		vana15-supply = <&ab3100_ldo_d_reg>;
+		syscon = <&syscon>;
+	};
+
+	syscon: syscon at c0011000 {
+		compatible = "stericsson,u300-syscon";
+		reg = <0xc0011000 0x1000>;
+	};
 };
diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index 35a2d58..0530095 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -27,6 +27,12 @@
 	s365 {
 		compatible = "stericsson,s365";
 		vana15-supply = <&ab3100_ldo_d_reg>;
+		syscon = <&syscon>;
+	};
+
+	syscon: syscon at c0011000 {
+		compatible = "stericsson,u300-syscon";
+		reg = <0xc0011000 0x1000>;
 	};
 
 	timer: timer at c0014000 {
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 9caf5ea..bde6540 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -18,6 +18,7 @@
 #include <linux/platform_data/pinctrl-coh901.h>
 #include <linux/platform_data/dma-coh901318.h>
 #include <linux/irqchip.h>
+#include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/clocksource.h>
 #include <linux/clk.h>
@@ -52,6 +53,8 @@
 #define U300_SYSCON_BCR_EXTRA_BOOT_OPTION_MASK			(0x01FC)
 #define U300_SYSCON_BCR_APP_BOOT_SERV_MASK			(0x0003)
 
+static void __iomem *syscon_base;
+
 /*
  * Static I/O mappings that are needed for booting the U300 platforms. The
  * only things we need are the areas where we find the timer, syscon and
@@ -205,7 +208,7 @@ static void __init u300_init_check_chip(void)
 	const char unknown[] = "UNKNOWN";
 
 	/* Read out and print chip ID */
-	val = readw(U300_SYSCON_VBASE + U300_SYSCON_CIDR);
+	val = readw(syscon_base + U300_SYSCON_CIDR);
 	/* This is in funky bigendian order... */
 	val = (val & 0xFFU) << 8 | (val >> 8);
 	chip = db_chips;
@@ -294,10 +297,21 @@ static struct of_dev_auxdata u300_auxdata_lookup[] __initdata = {
 
 static void __init u300_init_irq_dt(void)
 {
+	struct device_node *syscon;
 	struct clk *clk;
 
+	syscon = of_find_node_by_path("/syscon at c0011000");
+	if (!syscon) {
+		pr_crit("could not find syscon node\n");
+		return;
+	}
+	syscon_base = of_iomap(syscon, 0);
+	if (!syscon_base) {
+		pr_crit("could not remap syscon\n");
+		return;
+	}
 	/* initialize clocking early, we want to clock the INTCON */
-	u300_clk_init(U300_SYSCON_VBASE);
+	u300_clk_init(syscon_base);
 
 	/* Bootstrap EMIF and SEMI clocks */
 	clk = clk_get_sys("pl172", NULL);
@@ -330,9 +344,9 @@ static void __init u300_init_machine_dt(void)
 			u300_auxdata_lookup, NULL);
 
 	/* Enable SEMI self refresh */
-	val = readw(U300_SYSCON_VBASE + U300_SYSCON_SMCR) |
+	val = readw(syscon_base + U300_SYSCON_SMCR) |
 		U300_SYSCON_SMCR_SEMI_SREFREQ_ENABLE;
-	writew(val, U300_SYSCON_VBASE + U300_SYSCON_SMCR);
+	writew(val, syscon_base + U300_SYSCON_SMCR);
 }
 
 static const char * u300_board_compat[] = {
diff --git a/arch/arm/mach-u300/regulator.c b/arch/arm/mach-u300/regulator.c
index 1cbe88c..273fceb 100644
--- a/arch/arm/mach-u300/regulator.c
+++ b/arch/arm/mach-u300/regulator.c
@@ -16,8 +16,8 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/consumer.h>
 /* Those are just for writing in syscon */
+#include <linux/of_address.h>
 #include <linux/io.h>
-#include "u300-regs.h"
 
 /* Power Management Control 16bit (R/W) */
 #define U300_SYSCON_PMCR					(0x50)
@@ -57,10 +57,25 @@ void u300_pm_poweroff(void)
  */
 static int __init __u300_init_boardpower(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *syscon_np;
+	static void __iomem *syscon_base;
 	int err;
 	u32 val;
 
 	pr_info("U300: setting up board power\n");
+
+	syscon_np = of_parse_phandle(np, "syscon", 0);
+	if (!syscon_np) {
+		pr_crit("U300: no syscon node\n");
+		return -ENODEV;
+	}
+	syscon_base = of_iomap(syscon_np, 0);
+	if (!syscon_base) {
+		pr_crit("U300: could not remap syscon\n");
+		return -ENODEV;
+	}
+
 	main_power_15 = regulator_get(&pdev->dev, "vana15");
 
 	if (IS_ERR(main_power_15)) {
@@ -81,9 +96,9 @@ static int __init __u300_init_boardpower(struct platform_device *pdev)
 	 * the rest of the U300 power management is implemented.
 	 */
 	pr_info("U300: disable system controller pull-up\n");
-	val = readw(U300_SYSCON_VBASE + U300_SYSCON_PMCR);
+	val = readw(syscon_base + U300_SYSCON_PMCR);
 	val &= ~U300_SYSCON_PMCR_DCON_ENABLE;
-	writew(val, U300_SYSCON_VBASE + U300_SYSCON_PMCR);
+	writew(val, syscon_base + U300_SYSCON_PMCR);
 
 	/* Register globally exported PM poweroff hook */
 	pm_power_off = u300_pm_poweroff;
-- 
1.7.11.3
