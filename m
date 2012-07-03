From: andrew@lunn.ch (Andrew Lunn)
Date: Tue,  3 Jul 2012 16:22:38 +0200
Subject: [PATCH v2 05/12] ARM: kirkwood: use devicetree for orion-spi
In-Reply-To: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
Message-ID: <1341325365-21393-6-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Walle <michael@walle.cc>

Populate the devices with auxdata to set the device names which are used by
clkdev to lookup the clocks.

Signed-off-by: Michael Walle <micheal@walle.cc>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood.dtsi   |    9 +++++++++
 arch/arm/mach-kirkwood/board-dt.c |    8 +++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 66544d7..c9f36e7 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -60,6 +60,15 @@
 			interrupts = <53>;
 		};
 
+		spi at 10600 {
+			compatible = "marvell,orion-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			reg = <0x10600 0x28>;
+			status = "disabled";
+		};
+
 		nand at 3000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 27ac3d8..8f8da5d 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -26,6 +26,11 @@ static struct of_device_id kirkwood_dt_match_table[] __initdata = {
 	{ }
 };
 
+struct of_dev_auxdata kirkwood_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("marvell,orion-spi", 0xf1010600, "orion_spi.0", NULL),
+	{},
+};
+
 static void __init kirkwood_dt_init(void)
 {
 	pr_info("Kirkwood: %s, TCLK=%d.\n", kirkwood_id(), kirkwood_tclk);
@@ -69,7 +74,8 @@ static void __init kirkwood_dt_init(void)
 	if (of_machine_is_compatible("raidsonic,ib-nas62x0"))
 		ib62x0_init();
 
-	of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL);
+	of_platform_populate(NULL, kirkwood_dt_match_table,
+			     kirkwood_auxdata_lookup, NULL);
 }
 
 static const char *kirkwood_dt_board_compat[] = {
-- 
1.7.10
