From: jason@lakedaemon.net (Jason Cooper)
Date: Wed,  7 Mar 2012 03:44:53 +0000
Subject: [PATCH 12/14] ARM: kirkwood: use devicetree for orion-ehci
In-Reply-To: <cover.1331090356.git.jason@lakedaemon.net>
References: <cover.1331090356.git.jason@lakedaemon.net>
Message-ID: <45ba995e67914c0e04a8735fcc06b64b8dd687ec.1331090356.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Original devicetree node from Michael Walle, changed to use
'mrvl,orion-ehci' for compatible property.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/boot/dts/kirkwood-dreamplug.dts |    7 +++++++
 arch/arm/mach-kirkwood/board-dt.c        |    1 -
 arch/arm/mach-kirkwood/common.c          |    6 ++++++
 3 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
index ebb2c87..f332380 100644
--- a/arch/arm/boot/dts/kirkwood-dreamplug.dts
+++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
@@ -22,4 +22,11 @@
 		interrupts = <33>;
 		clock-frequency = <200000000>;
 	};
+
+	ehci at f1050000 {
+		compatible = "mrvl,orion-ehci";
+		reg = <0xf1050000 0x1000>;
+		interrupts = <19>;
+		phy-version = "orion";
+	};
 };
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 638f261..1034ac7 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -147,7 +147,6 @@ static void __init dreamplug_init(void)
 				ARRAY_SIZE(dreamplug_spi_slave_info));
 	kirkwood_spi_init();
 
-	kirkwood_ehci_init();
 	kirkwood_ge00_init(&dreamplug_ge00_data);
 	kirkwood_ge01_init(&dreamplug_ge01_data);
 	kirkwood_sata_init(&dreamplug_sata_data);
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 154f1cf..d0e8575 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -498,6 +498,12 @@ static int __init kirkwood_clock_gate(void)
 		kirkwood_clk_ctrl |= CGC_CRYPTO;
 		of_node_put(np);
 	}
+
+	np = of_find_compatible_node(NULL, NULL, "mrvl,orion-ehci");
+	if (np && of_device_is_available(np)) {
+		kirkwood_clk_ctrl |= CGC_USB0;
+		of_node_put(np);
+	}
 #endif
 
 	/* For SATA: first shutdown the phy */
-- 
1.7.3.4
