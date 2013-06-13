From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 13 Jun 2013 22:20:28 +0200
Subject: [PATCH 2/2] regulators: ab3100: bootstrap board power
Message-ID: <1371154828-28117-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This moves the code from the platform that is bootstrapping
the power on the U300 platform out from the machine directory
and the special-purpose board node and module and into the
regulator node and driver itself.

Cc: Mark Brown <broonie@kernel.org>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/arm/ste-u300.txt |  18 ---
 arch/arm/boot/dts/ste-u300.dts                     |   9 +-
 arch/arm/mach-u300/Makefile                        |   1 -
 arch/arm/mach-u300/regulator.c                     | 133 ---------------------
 drivers/regulator/ab3100.c                         |  73 +++++++++++
 5 files changed, 76 insertions(+), 158 deletions(-)
 delete mode 100644 arch/arm/mach-u300/regulator.c

diff --git a/Documentation/devicetree/bindings/arm/ste-u300.txt b/Documentation/devicetree/bindings/arm/ste-u300.txt
index 69b5ab0..5ae045f 100644
--- a/Documentation/devicetree/bindings/arm/ste-u300.txt
+++ b/Documentation/devicetree/bindings/arm/ste-u300.txt
@@ -13,18 +13,6 @@ This contains the system controller.
 - compatible: must be "stericsson,u300-syscon".
 - reg: the base address and size of the system controller.
 
-Boards with the U300 SoC include:
-
-S365 "Small Board U365":
-
-Required node: s365
-This contains the board-specific information.
-- compatible: must be "stericsson,s365".
-- vana15-supply: the regulator supplying the 1.5V to drive the
-  board.
-- syscon: a pointer to the syscon node so we can acccess the
-  syscon registers to set the board as self-powered.
-
 Example:
 
 / {
@@ -33,12 +21,6 @@ Example:
 	#address-cells = <1>;
 	#size-cells = <1>;
 
-	s365 {
-		compatible = "stericsson,s365";
-		vana15-supply = <&ab3100_ldo_d_reg>;
-		syscon = <&syscon>;
-	};
-
 	syscon: syscon at c0011000 {
 		compatible = "stericsson,u300-syscon";
 		reg = <0xc0011000 0x1000>;
diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index 8a1032c..fecc72a 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -24,12 +24,6 @@
 		reg = <0x48000000 0x03c00000>;
 	};
 
-	s365 {
-		compatible = "stericsson,s365";
-		vana15-supply = <&ab3100_ldo_d_reg>;
-		syscon = <&syscon>;
-	};
-
 	syscon: syscon at c0011000 {
 		compatible = "stericsson,u300-syscon", "syscon";
 		reg = <0xc0011000 0x1000>;
@@ -314,6 +308,9 @@
 			interrupts = <0>; /* EXT0 IRQ */
 			ab3100-regulators {
 				compatible = "stericsson,ab3100-regulators";
+				/* This is for powering the board */
+				vana15-supply = <&ab3100_ldo_d_reg>;
+				syscon = <&syscon>;
 				ab3100_ldo_a_reg: ab3100_ldo_a {
 					regulator-compatible = "ab3100_ldo_a";
 					startup-delay-us = <200>;
diff --git a/arch/arm/mach-u300/Makefile b/arch/arm/mach-u300/Makefile
index 0f362b6..fcaa301 100644
--- a/arch/arm/mach-u300/Makefile
+++ b/arch/arm/mach-u300/Makefile
@@ -8,4 +8,3 @@ obj-n		:=
 obj-		:=
 
 obj-$(CONFIG_MACH_U300_SPIDUMMY)  += dummyspichip.o
-obj-$(CONFIG_REGULATOR_AB3100)    += regulator.o
diff --git a/arch/arm/mach-u300/regulator.c b/arch/arm/mach-u300/regulator.c
deleted file mode 100644
index bf40cd4..0000000
--- a/arch/arm/mach-u300/regulator.c
+++ /dev/null
@@ -1,133 +0,0 @@
-/*
- * arch/arm/mach-u300/regulator.c
- *
- * Copyright (C) 2009 ST-Ericsson AB
- * License terms: GNU General Public License (GPL) version 2
- * Handle board-bound regulators and board power not related
- * to any devices.
- * Author: Linus Walleij <linus.walleij@stericsson.com>
- */
-#include <linux/device.h>
-#include <linux/signal.h>
-#include <linux/err.h>
-#include <linux/of.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/regulator/machine.h>
-#include <linux/regulator/consumer.h>
-#include <linux/mfd/syscon.h>
-#include <linux/regmap.h>
-
-/* Power Management Control 16bit (R/W) */
-#define U300_SYSCON_PMCR					(0x50)
-#define U300_SYSCON_PMCR_DCON_ENABLE				(0x0002)
-#define U300_SYSCON_PMCR_PWR_MGNT_ENABLE			(0x0001)
-
-/*
- * Regulators that power the board and chip and which are
- * not copuled to specific drivers are hogged in these
- * instances.
- */
-static struct regulator *main_power_15;
-
-/*
- * This function is used from pm.h to shut down the system by
- * resetting all regulators in turn and then disable regulator
- * LDO D (main power).
- */
-void u300_pm_poweroff(void)
-{
-	sigset_t old, all;
-
-	sigfillset(&all);
-	if (!sigprocmask(SIG_BLOCK, &all, &old)) {
-		/* Disable LDO D to shut down the system */
-		if (main_power_15)
-			regulator_disable(main_power_15);
-		else
-			pr_err("regulator not available to shut down system\n");
-		(void) sigprocmask(SIG_SETMASK, &old, NULL);
-	}
-	return;
-}
-
-/*
- * Hog the regulators needed to power up the board.
- */
-static int __init __u300_init_boardpower(struct platform_device *pdev)
-{
-	struct device_node *np = pdev->dev.of_node;
-	struct device_node *syscon_np;
-	struct regmap *regmap;
-	int err;
-
-	pr_info("U300: setting up board power\n");
-
-	syscon_np = of_parse_phandle(np, "syscon", 0);
-	if (!syscon_np) {
-		pr_crit("U300: no syscon node\n");
-		return -ENODEV;
-	}
-	regmap = syscon_node_to_regmap(syscon_np);
-	if (!regmap) {
-		pr_crit("U300: could not locate syscon regmap\n");
-		return -ENODEV;
-	}
-
-	main_power_15 = regulator_get(&pdev->dev, "vana15");
-
-	if (IS_ERR(main_power_15)) {
-		pr_err("could not get vana15");
-		return PTR_ERR(main_power_15);
-	}
-	err = regulator_enable(main_power_15);
-	if (err) {
-		pr_err("could not enable vana15\n");
-		return err;
-	}
-
-	/*
-	 * On U300 a special system controller register pulls up the DC
-	 * until the vana15 (LDO D) regulator comes up. At this point, all
-	 * regulators are set and we do not need power control via
-	 * DC ON anymore. This function will likely be moved whenever
-	 * the rest of the U300 power management is implemented.
-	 */
-	pr_info("U300: disable system controller pull-up\n");
-	regmap_update_bits(regmap, U300_SYSCON_PMCR,
-			   U300_SYSCON_PMCR_DCON_ENABLE, 0);
-
-	/* Register globally exported PM poweroff hook */
-	pm_power_off = u300_pm_poweroff;
-
-	return 0;
-}
-
-static int __init s365_board_probe(struct platform_device *pdev)
-{
-	return __u300_init_boardpower(pdev);
-}
-
-static const struct of_device_id s365_board_match[] = {
-	{ .compatible = "stericsson,s365" },
-	{},
-};
-
-static struct platform_driver s365_board_driver = {
-	.driver		= {
-		.name   = "s365-board",
-		.owner  = THIS_MODULE,
-		.of_match_table = s365_board_match,
-	},
-};
-
-/*
- * So at module init time we hog the regulator!
- */
-static int __init u300_init_boardpower(void)
-{
-	return platform_driver_probe(&s365_board_driver,
-				     s365_board_probe);
-}
-
-device_initcall(u300_init_boardpower);
diff --git a/drivers/regulator/ab3100.c b/drivers/regulator/ab3100.c
index 3be9e46..7004f6e 100644
--- a/drivers/regulator/ab3100.c
+++ b/drivers/regulator/ab3100.c
@@ -19,6 +19,11 @@
 #include <linux/mfd/abx500.h>
 #include <linux/of.h>
 #include <linux/regulator/of_regulator.h>
+/* These are for powering the board */
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/pm.h>
 
 /* LDO registers and some handy masking definitions for AB3100 */
 #define AB3100_LDO_A		0x40
@@ -622,9 +627,40 @@ static int ab3100_regulators_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* Power Management Control 16bit (R/W) */
+#define U300_SYSCON_PMCR				(0x50)
+#define U300_SYSCON_PMCR_DCON_ENABLE			(0x0002)
+#define U300_SYSCON_PMCR_PWR_MGNT_ENABLE		(0x0001)
+
+static struct regulator *main_power_15;
+
+/*
+ * This function is used from pm.h to shut down the system by
+ * resetting all regulators in turn and then disable regulator
+ * LDO D (main power).
+ */
+void ab3100_pm_poweroff(void)
+{
+	sigset_t old, all;
+
+	sigfillset(&all);
+	if (!sigprocmask(SIG_BLOCK, &all, &old)) {
+		/* Disable LDO D to shut down the system */
+		if (main_power_15)
+			regulator_disable(main_power_15);
+		else
+			pr_err("regulator not available to shut down system\n");
+		(void) sigprocmask(SIG_SETMASK, &old, NULL);
+	}
+	return;
+}
+
+
 static int
 ab3100_regulator_of_probe(struct platform_device *pdev, struct device_node *np)
 {
+	struct device_node *syscon_np;
+	struct regmap *regmap;
 	int err, i;
 
 	/*
@@ -654,6 +690,43 @@ ab3100_regulator_of_probe(struct platform_device *pdev, struct device_node *np)
 		}
 	}
 
+	dev_notice(&pdev->dev, "setting up board power\n");
+
+	main_power_15 = regulator_get(&pdev->dev, "vana15");
+	if (IS_ERR(main_power_15)) {
+		dev_err(&pdev->dev, "could not get vana15");
+		return PTR_ERR(main_power_15);
+	}
+	err = regulator_enable(main_power_15);
+	if (err) {
+		dev_err(&pdev->dev, "could not enable vana15\n");
+		return err;
+	}
+
+	/*
+	 * On U300 a special system controller register pulls up the DC
+	 * until the vana15 (LDO D) regulator comes up. At this point, all
+	 * regulators are set and we do not need power control via
+	 * DC ON anymore. This function will likely be moved whenever
+	 * the rest of the U300 power management is implemented.
+	 */
+	syscon_np = of_parse_phandle(np, "syscon", 0);
+	if (!syscon_np) {
+		dev_crit(&pdev->dev, "no syscon node\n");
+		return -ENODEV;
+	}
+	regmap = syscon_node_to_regmap(syscon_np);
+	if (!regmap) {
+		dev_crit(&pdev->dev, "could not locate syscon regmap\n");
+		return -ENODEV;
+	}
+	dev_info(&pdev->dev, "disable system controller pull-up\n");
+	regmap_update_bits(regmap, U300_SYSCON_PMCR,
+			   U300_SYSCON_PMCR_DCON_ENABLE, 0);
+
+	/* Register globally exported PM poweroff hook */
+	pm_power_off = ab3100_pm_poweroff;
+
 	return 0;
 }
 
-- 
1.7.11.3
