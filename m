From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 16 Feb 2016 11:15:04 +0900
Subject: [PATCH 2/9] ARM: dts: uniphier: rework UniPhier System Bus nodes
In-Reply-To: <1455588911-9827-1-git-send-email-yamada.masahiro@socionext.com>
References: <1455588911-9827-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1455588911-9827-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tidy up the System Bus nodes in order to make the driver
(drivers/bus/uniphier-system-bus.c) really available.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-common32.dtsi             | 19 ++++++++++---------
 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi             | 19 ++++++++++---------
 arch/arm/boot/dts/uniphier-support-card.dtsi         |  2 +-
 arch/arm/mach-uniphier/platsmp.c                     | 11 +++++------
 arch/arm64/boot/dts/socionext/uniphier-ph1-ld10.dtsi | 18 ++++++++++++------
 5 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-common32.dtsi b/arch/arm/boot/dts/uniphier-common32.dtsi
index ea9301a..ae48d28 100644
--- a/arch/arm/boot/dts/uniphier-common32.dtsi
+++ b/arch/arm/boot/dts/uniphier-common32.dtsi
@@ -52,12 +52,6 @@
 		ranges;
 		interrupt-parent = <&intc>;
 
-		extbus: extbus {
-			compatible = "simple-bus";
-			#address-cells = <2>;
-			#size-cells = <1>;
-		};
-
 		serial0: serial at 54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
@@ -98,9 +92,16 @@
 			clocks = <&uart_clk>;
 		};
 
-		system-bus-controller at 58c00000 {
-			compatible = "socionext,uniphier-system-bus-controller";
-			reg = <0x58c00000 0x400>, <0x59800000 0x2000>;
+		system_bus: system-bus at 58c00000 {
+			compatible = "socionext,uniphier-system-bus";
+			reg = <0x58c00000 0x400>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+		};
+
+		smpctrl at 59800000 {
+			compatible = "socionext,uniphier-smpctrl";
+			reg = <0x59801000 0x400>;
 		};
 
 		timer at 60000200 {
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi b/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
index 691a17d..ef94d2e 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
@@ -94,12 +94,6 @@
 		ranges;
 		interrupt-parent = <&intc>;
 
-		extbus: extbus {
-			compatible = "simple-bus";
-			#address-cells = <2>;
-			#size-cells = <1>;
-		};
-
 		timer at 20000200 {
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0x20000200 0x20>;
@@ -216,9 +210,16 @@
 			clock-frequency = <400000>;
 		};
 
-		system-bus-controller at 58c00000 {
-			compatible = "socionext,uniphier-system-bus-controller";
-			reg = <0x58c00000 0x400>, <0x59800000 0x2000>;
+		system_bus: system-bus at 58c00000 {
+			compatible = "socionext,uniphier-system-bus";
+			reg = <0x58c00000 0x400>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+		};
+
+		smpctrl at 59800000 {
+			compatible = "socionext,uniphier-smpctrl";
+			reg = <0x59801000 0x400>;
 		};
 
 		usb0: usb at 5a800100 {
diff --git a/arch/arm/boot/dts/uniphier-support-card.dtsi b/arch/arm/boot/dts/uniphier-support-card.dtsi
index fa807e8..0d2826a 100644
--- a/arch/arm/boot/dts/uniphier-support-card.dtsi
+++ b/arch/arm/boot/dts/uniphier-support-card.dtsi
@@ -42,7 +42,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-&extbus {
+&system_bus {
 	ranges = <1 0x00000000 0x42000000 0x02000000>;
 
 	support_card: support_card {
diff --git a/arch/arm/mach-uniphier/platsmp.c b/arch/arm/mach-uniphier/platsmp.c
index e1cfc1d..b53a8d9 100644
--- a/arch/arm/mach-uniphier/platsmp.c
+++ b/arch/arm/mach-uniphier/platsmp.c
@@ -30,7 +30,7 @@
  * The secondary CPUs check this register from the boot ROM for the jump
  * destination.  After that, it can be reused as a scratch register.
  */
-#define UNIPHIER_SBC_ROM_BOOT_RSV2	0x1208
+#define UNIPHIER_SMPCTRL_ROM_BOOT_RSV2	0x208
 
 static void __iomem *uniphier_smp_rom_boot_rsv2;
 static unsigned int uniphier_smp_max_cpus;
@@ -98,15 +98,14 @@ static int __init uniphier_smp_prepare_trampoline(unsigned int max_cpus)
 	phys_addr_t rom_rsv2_phys;
 	int ret;
 
-	np = of_find_compatible_node(NULL, NULL,
-				"socionext,uniphier-system-bus-controller");
-	ret = of_address_to_resource(np, 1, &res);
+	np = of_find_compatible_node(NULL, NULL, "socionext,uniphier-smpctrl");
+	ret = of_address_to_resource(np, 0, &res);
 	if (ret) {
-		pr_err("failed to get resource of system-bus-controller\n");
+		pr_err("failed to get resource of uniphier-smpctrl\n");
 		return ret;
 	}
 
-	rom_rsv2_phys = res.start + UNIPHIER_SBC_ROM_BOOT_RSV2;
+	rom_rsv2_phys = res.start + UNIPHIER_SMPCTRL_ROM_BOOT_RSV2;
 
 	ret = uniphier_smp_copy_trampoline(rom_rsv2_phys);
 	if (ret)
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ph1-ld10.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ph1-ld10.dtsi
index 0296af9..84637eb 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ph1-ld10.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ph1-ld10.dtsi
@@ -133,12 +133,6 @@
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
 
-		extbus: extbus {
-			compatible = "simple-bus";
-			#address-cells = <2>;
-			#size-cells = <1>;
-		};
-
 		serial0: serial at 54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
@@ -261,6 +255,18 @@
 			clock-frequency = <400000>;
 		};
 
+		system_bus: system-bus at 58c00000 {
+			compatible = "socionext,uniphier-system-bus";
+			reg = <0x58c00000 0x400>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+		};
+
+		smpctrl at 59800000 {
+			compatible = "socionext,uniphier-smpctrl";
+			reg = <0x59801000 0x400>;
+		};
+
 		pinctrl: pinctrl at 5f801000 {
 			compatible = "socionext,ph1-ld10-pinctrl", "syscon";
 			reg = <0x5f801000 0xe00>;
-- 
1.9.1
