From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:28:32 +0900
Subject: [GIT PULL 08/19] ARM: shmobile: ape6evm-reference: switch PFC to DT
In-Reply-To: <cover.1375838900.git.horms+renesas@verge.net.au>
References: <cover.1375838900.git.horms+renesas@verge.net.au>
Message-ID: <59b2bc34aaa5d4c85c5c868ea6da42c1d06ff27c.1375838900.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

PFC pinctrl configuration can now be performed via DT. Update
ape6evm-reference to use this.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts  | 10 ++++++++++
 arch/arm/mach-shmobile/board-ape6evm-reference.c |  9 ---------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
index 6f4506e..bbd09d8 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
@@ -53,3 +53,13 @@
 	>;
 	voltage-tolerance = <1>; /* 1% */
 };
+
+&pfc {
+	pinctrl-0 = <&scifa0_pins>;
+	pinctrl-names = "default";
+
+	scifa0_pins: scifa0 {
+		renesas,groups = "scifa0_data";
+		renesas,function = "scifa0";
+	};
+};
diff --git a/arch/arm/mach-shmobile/board-ape6evm-reference.c b/arch/arm/mach-shmobile/board-ape6evm-reference.c
index 46b41de..52cc5fa 100644
--- a/arch/arm/mach-shmobile/board-ape6evm-reference.c
+++ b/arch/arm/mach-shmobile/board-ape6evm-reference.c
@@ -29,12 +29,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-static const struct pinctrl_map ape6evm_pinctrl_map[] = {
-	/* SCIFA0 console */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a73a4",
-				  "scifa0_data", "scifa0"),
-};
-
 static void __init ape6evm_add_standard_devices(void)
 {
 
@@ -52,9 +46,6 @@ static void __init ape6evm_add_standard_devices(void)
 	clk_put(parent);
 	clk_put(mp);
 
-	pinctrl_register_mappings(ape6evm_pinctrl_map,
-				  ARRAY_SIZE(ape6evm_pinctrl_map));
-	r8a73a4_pinmux_init();
 	r8a73a4_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
-- 
1.8.3.2
