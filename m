From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  3 Aug 2015 09:26:41 +0200
Subject: [PATCH 1/2] ARM: ux500: add an SMP enablement type and move cpu nodes
Message-ID: <1438586801-30115-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "cpus" node cannot be inside the "soc" node, while this
works for the CoreSight blocks, the early boot code will look
for "cpus" directly under the root node, so this is a hard
convention. So move the CPU nodes.

Augment the "reg" property to match what is actually in the
hardware: 0x300 and 0x301 respectively.

Then add an SMP enablement type to be used by the SMP init
code, "ste,dbx500-smp".

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi ARM SoC people: please apply this as a fix for v4.2
as it is prerequisite for 2/2 which is a more proper fix
for the secondary CPU boot regression addressed by the
fixed remappings patch.
---
 Documentation/devicetree/bindings/arm/cpus.txt |  1 +
 arch/arm/boot/dts/ste-dbx5x0.dtsi              | 53 +++++++++++++-------------
 2 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index d6b794cef0b8..91e6e5c478d0 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -199,6 +199,7 @@ nodes to be present and contain the properties described below.
 			    "qcom,kpss-acc-v1"
 			    "qcom,kpss-acc-v2"
 			    "rockchip,rk3066-smp"
+			    "ste,dbx500-smp"
 
 	- cpu-release-addr
 		Usage: required for systems that have an "enable-method"
diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index a75f3289e653..b8f81fb418ce 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -15,6 +15,33 @@
 #include "skeleton.dtsi"
 
 / {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "ste,dbx500-smp";
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&CPU0>;
+				};
+				core1 {
+					cpu = <&CPU1>;
+				};
+			};
+		};
+		CPU0: cpu at 300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x300>;
+		};
+		CPU1: cpu at 301 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x301>;
+		};
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -22,32 +49,6 @@
 		interrupt-parent = <&intc>;
 		ranges;
 
-		cpus {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			cpu-map {
-				cluster0 {
-					core0 {
-						cpu = <&CPU0>;
-					};
-					core1 {
-						cpu = <&CPU1>;
-					};
-				};
-			};
-			CPU0: cpu at 0 {
-				device_type = "cpu";
-				compatible = "arm,cortex-a9";
-				reg = <0>;
-			};
-			CPU1: cpu at 1 {
-				device_type = "cpu";
-				compatible = "arm,cortex-a9";
-				reg = <1>;
-			};
-		};
-
 		ptm at 801ae000 {
 			compatible = "arm,coresight-etm3x", "arm,primecell";
 			reg = <0x801ae000 0x1000>;
-- 
2.4.3
