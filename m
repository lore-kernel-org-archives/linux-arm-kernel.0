From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 16 Oct 2016 23:59:16 +0900
Subject: [PATCH 1/3] arm64: dts: uniphier: switch over to PSCI enable method
In-Reply-To: <1476629958-25368-1-git-send-email-yamada.masahiro@socionext.com>
References: <1476629958-25368-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1476629958-25368-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the first system bring-up, I chose to use spin-table because ARM
Trusted Firmware was not ready for this platform at that moment.

Actually, these SoCs are equipped with EL3 and able to provide PSCI.
Now I finished porting the ATF BL31 for the UniPhier platform, so it
is ready to migrate to PSCI enable method.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 13 ++++++++-----
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 19 ++++++++++---------
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index da3cdd8..73e0acf 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -43,7 +43,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-/memreserve/ 0x80000000 0x00000008;	/* cpu-release-addr */
+/memreserve/ 0x80000000 0x00080000;
 
 / {
 	compatible = "socionext,uniphier-ld11";
@@ -70,19 +70,22 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0 0x000>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0 0x80000000>;
+			enable-method = "psci";
 		};
 
 		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0 0x001>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0 0x80000000>;
+			enable-method = "psci";
 		};
 	};
 
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
 	clocks {
 		refclk: ref {
 			compatible = "fixed-clock";
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index efb47ea..6f48e82 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -43,7 +43,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-/memreserve/ 0x80000000 0x00000008;	/* cpu-release-addr */
+/memreserve/ 0x80000000 0x00080000;
 
 / {
 	compatible = "socionext,uniphier-ld20";
@@ -79,35 +79,36 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0 0x000>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0 0x80000000>;
+			enable-method = "psci";
 		};
 
 		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0 0x001>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0 0x80000000>;
+			enable-method = "psci";
 		};
 
 		cpu2: cpu at 100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0 0x100>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0 0x80000000>;
+			enable-method = "psci";
 		};
 
 		cpu3: cpu at 101 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0 0x101>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0 0x80000000>;
+			enable-method = "psci";
 		};
 	};
 
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
 	clocks {
 		refclk: ref {
 			compatible = "fixed-clock";
-- 
1.9.1
