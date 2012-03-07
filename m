From: jason@lakedaemon.net (Jason Cooper)
Date: Wed,  7 Mar 2012 03:44:46 +0000
Subject: [PATCH 05/14] ARM: kirkwood: add interrupt controller to devicetree.
In-Reply-To: <cover.1331090356.git.jason@lakedaemon.net>
References: <cover.1331090356.git.jason@lakedaemon.net>
Message-ID: <c27a2b2c176940d153f2659e1a64f9349fbdb9c1.1331090356.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on work by Michael Walle (commit a952154).

Used just the intc portion of the patch, fixed the register address, and
used of_find_compatible_node() instead.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/boot/dts/kirkwood.dtsi   |    9 ++++++++-
 arch/arm/mach-kirkwood/board-dt.c |    7 +++++++
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 702b955..7896a1d 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -2,5 +2,12 @@
 
 / {
 	compatible = "mrvl,kirkwood";
-};
+	interrupt-parent = <&intc>;
 
+	intc: interrupt-controller at fed20200 {
+		compatible = "mrvl,orion-intc";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0xfed20200 0x20>;
+	};
+};
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index f514b42..f9f446b 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/irqdomain.h>
 #include <linux/mtd/partitions.h>
 #include <linux/ata_platform.h>
 #include <linux/mv643xx_eth.h>
@@ -159,6 +160,8 @@ static void __init dreamplug_init(void)
 
 static void __init kirkwood_dt_init(void)
 {
+	struct device_node *node;
+
 	pr_info("Kirkwood: %s, TCLK=%d.\n", kirkwood_id(), kirkwood_tclk);
 
 	/*
@@ -175,6 +178,10 @@ static void __init kirkwood_dt_init(void)
 	kirkwood_l2_init();
 #endif
 
+	node = of_find_compatible_node(NULL, NULL, "mrvl,orion-intc");
+	if (node)
+		irq_domain_add_simple(node, 0);
+
 	/* internal devices that every board has */
 	kirkwood_rtc_init();
 	kirkwood_wdt_init();
-- 
1.7.3.4
