From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 31 May 2013 11:18:47 +0200
Subject: [PATCH 12/39] ARM: u300: set up board power from device tree
In-Reply-To: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1369991954-17406-13-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This adds support for setting up the board power from the
device tree on the U300. We use a board-specific node in the
device tree for the S365 board and bind a regulator for the
board power to this node.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/arm/ste-u300.txt | 13 +++++++
 arch/arm/mach-u300/regulator.c                     | 42 ++++++++++++++++++++--
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/ste-u300.txt b/Documentation/devicetree/bindings/arm/ste-u300.txt
index 222dca5..cd9001a 100644
--- a/Documentation/devicetree/bindings/arm/ste-u300.txt
+++ b/Documentation/devicetree/bindings/arm/ste-u300.txt
@@ -7,3 +7,16 @@ or board power regulator supplies.
 Required root node property:
 
 compatible="stericsson,u300";
+
+Boards with the U300 SoC include:
+
+S365 "Small Board U365":
+
+Required node: s365
+
+Example:
+
+s365 {
+	compatible = "stericsson,s365";
+	vana15-supply = <&ab3100_ldo_d_reg>;
+};
diff --git a/arch/arm/mach-u300/regulator.c b/arch/arm/mach-u300/regulator.c
index 9c53f01..8a67dc6 100644
--- a/arch/arm/mach-u300/regulator.c
+++ b/arch/arm/mach-u300/regulator.c
@@ -10,9 +10,14 @@
 #include <linux/device.h>
 #include <linux/signal.h>
 #include <linux/err.h>
+#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/machine.h>
 #include <linux/regulator/consumer.h>
 /* Those are just for writing in syscon */
 #include <linux/io.h>
+#include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <mach/syscon.h>
 
@@ -47,13 +52,17 @@ void u300_pm_poweroff(void)
 /*
  * Hog the regulators needed to power up the board.
  */
-static int __init u300_init_boardpower(void)
+static int __init __u300_init_boardpower(struct platform_device *pdev)
 {
 	int err;
 	u32 val;
 
 	pr_info("U300: setting up board power\n");
-	main_power_15 = regulator_get(NULL, "vana15");
+	if (pdev)
+		main_power_15 = regulator_get(&pdev->dev, "vana15");
+	else
+		main_power_15 = regulator_get(NULL, "vana15");
+
 	if (IS_ERR(main_power_15)) {
 		pr_err("could not get vana15");
 		return PTR_ERR(main_power_15);
@@ -82,7 +91,34 @@ static int __init u300_init_boardpower(void)
 	return 0;
 }
 
+static int __init s365_board_probe(struct platform_device *pdev)
+{
+	return __u300_init_boardpower(pdev);
+}
+
+static const struct of_device_id s365_board_match[] = {
+	{ .compatible = "stericsson,s365" },
+	{},
+};
+
+static struct platform_driver s365_board_driver = {
+	.driver		= {
+		.name   = "s365-board",
+		.owner  = THIS_MODULE,
+		.of_match_table = s365_board_match,
+	},
+};
+
 /*
  * So at module init time we hog the regulator!
  */
-module_init(u300_init_boardpower);
+static int __init u300_init_boardpower(void)
+{
+	if (of_have_populated_dt())
+		return platform_driver_probe(&s365_board_driver,
+					     s365_board_probe);
+	/* Only call this on non-DT boots */
+	return __u300_init_boardpower(NULL);
+}
+
+device_initcall(u300_init_boardpower);
-- 
1.7.11.3
