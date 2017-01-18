From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 18 Jan 2017 10:53:31 +0000
Subject: [PATCH 2/2] ARM: DTS: Fix register map for virt-capable GIC
In-Reply-To: <1484736811-24002-1-git-send-email-marc.zyngier@arm.com>
References: <1484736811-24002-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1484736811-24002-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since everybody copied my own mistake from the DT binding example,
let's address all the offenders in one swift go.

Most of them got the CPU interface size wrong (4kB, while it should
be 8kB), except for both keystone platforms which got the control
interface wrong (4kB instead of 8kB).

In the couple of cases were I knew for sure what implementation
was used, I've added the "arm,gic-400" compatible string. I'm 99%
sure that this is what everyong is using, but short of having the
TRM for all the other SoCs, I've let them alone.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/boot/dts/alpine.dtsi        | 2 +-
 arch/arm/boot/dts/axm55xx.dtsi       | 2 +-
 arch/arm/boot/dts/dra7.dtsi          | 2 +-
 arch/arm/boot/dts/ecx-2000.dts       | 2 +-
 arch/arm/boot/dts/exynos3250.dtsi    | 2 +-
 arch/arm/boot/dts/exynos5.dtsi       | 2 +-
 arch/arm/boot/dts/exynos5260.dtsi    | 2 +-
 arch/arm/boot/dts/exynos5440.dtsi    | 2 +-
 arch/arm/boot/dts/imx6ul.dtsi        | 4 ++--
 arch/arm/boot/dts/keystone-k2g.dtsi  | 2 +-
 arch/arm/boot/dts/keystone.dtsi      | 2 +-
 arch/arm/boot/dts/ls1021a.dtsi       | 4 ++--
 arch/arm/boot/dts/mt2701.dtsi        | 2 +-
 arch/arm/boot/dts/mt6580.dtsi        | 2 +-
 arch/arm/boot/dts/mt6589.dtsi        | 2 +-
 arch/arm/boot/dts/mt7623.dtsi        | 2 +-
 arch/arm/boot/dts/mt8127.dtsi        | 2 +-
 arch/arm/boot/dts/mt8135.dtsi        | 2 +-
 arch/arm/boot/dts/omap5.dtsi         | 2 +-
 arch/arm/boot/dts/r8a73a4.dtsi       | 2 +-
 arch/arm/boot/dts/r8a7743.dtsi       | 2 +-
 arch/arm/boot/dts/r8a7745.dtsi       | 2 +-
 arch/arm/boot/dts/r8a7790.dtsi       | 2 +-
 arch/arm/boot/dts/r8a7791.dtsi       | 2 +-
 arch/arm/boot/dts/r8a7792.dtsi       | 2 +-
 arch/arm/boot/dts/r8a7793.dtsi       | 2 +-
 arch/arm/boot/dts/r8a7794.dtsi       | 2 +-
 arch/arm/boot/dts/rk1108.dtsi        | 2 +-
 arch/arm/boot/dts/rk3036.dtsi        | 2 +-
 arch/arm/boot/dts/rk322x.dtsi        | 2 +-
 arch/arm/boot/dts/rk3288.dtsi        | 2 +-
 arch/arm/boot/dts/sun6i-a31.dtsi     | 2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi     | 4 ++--
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 2 +-
 arch/arm/boot/dts/sun8i-a83t.dtsi    | 2 +-
 arch/arm/boot/dts/sun8i-h3.dtsi      | 2 +-
 arch/arm/boot/dts/sun9i-a80.dtsi     | 2 +-
 37 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/arch/arm/boot/dts/alpine.dtsi b/arch/arm/boot/dts/alpine.dtsi
index db8752f..d0eefc3 100644
--- a/arch/arm/boot/dts/alpine.dtsi
+++ b/arch/arm/boot/dts/alpine.dtsi
@@ -93,7 +93,7 @@
 			interrupt-controller;
 			reg = <0x0 0xfb001000 0x0 0x1000>,
 			      <0x0 0xfb002000 0x0 0x2000>,
-			      <0x0 0xfb004000 0x0 0x1000>,
+			      <0x0 0xfb004000 0x0 0x2000>,
 			      <0x0 0xfb006000 0x0 0x2000>;
 			interrupts =
 				<GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
diff --git a/arch/arm/boot/dts/axm55xx.dtsi b/arch/arm/boot/dts/axm55xx.dtsi
index a9d6d59..47799f5 100644
--- a/arch/arm/boot/dts/axm55xx.dtsi
+++ b/arch/arm/boot/dts/axm55xx.dtsi
@@ -62,7 +62,7 @@
 		#address-cells = <0>;
 		interrupt-controller;
 		reg = <0x20 0x01001000 0 0x1000>,
-		      <0x20 0x01002000 0 0x1000>,
+		      <0x20 0x01002000 0 0x2000>,
 		      <0x20 0x01004000 0 0x2000>,
 		      <0x20 0x01006000 0 0x2000>;
 		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 1faf24a..a9ffa49 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -57,7 +57,7 @@
 		interrupt-controller;
 		#interrupt-cells = <3>;
 		reg = <0x0 0x48211000 0x0 0x1000>,
-		      <0x0 0x48212000 0x0 0x1000>,
+		      <0x0 0x48212000 0x0 0x2000>,
 		      <0x0 0x48214000 0x0 0x2000>,
 		      <0x0 0x48216000 0x0 0x2000>;
 		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
diff --git a/arch/arm/boot/dts/ecx-2000.dts b/arch/arm/boot/dts/ecx-2000.dts
index 2ccbb57f..c15e7e0 100644
--- a/arch/arm/boot/dts/ecx-2000.dts
+++ b/arch/arm/boot/dts/ecx-2000.dts
@@ -99,7 +99,7 @@
 			interrupt-controller;
 			interrupts = <1 9 0xf04>;
 			reg = <0xfff11000 0x1000>,
-			      <0xfff12000 0x1000>,
+			      <0xfff12000 0x2000>,
 			      <0xfff14000 0x2000>,
 			      <0xfff16000 0x2000>;
 		};
diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index ba17ee1..9c28ef4 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -234,7 +234,7 @@
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			reg = <0x10481000 0x1000>,
-			      <0x10482000 0x1000>,
+			      <0x10482000 0x2000>,
 			      <0x10484000 0x2000>,
 			      <0x10486000 0x2000>;
 			interrupts = <GIC_PPI 9
diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index 7fd870e..678c08e 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -94,7 +94,7 @@
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			reg =	<0x10481000 0x1000>,
-				<0x10482000 0x1000>,
+				<0x10482000 0x2000>,
 				<0x10484000 0x2000>,
 				<0x10486000 0x2000>;
 			interrupts = <GIC_PPI 9
diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
index 5818718..5e88c96 100644
--- a/arch/arm/boot/dts/exynos5260.dtsi
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -167,7 +167,7 @@
 			#size-cells = <0>;
 			interrupt-controller;
 			reg = <0x10481000 0x1000>,
-				<0x10482000 0x1000>,
+				<0x10482000 0x2000>,
 				<0x10484000 0x2000>,
 				<0x10486000 0x2000>;
 			interrupts = <GIC_PPI 9
diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 2a2e570..77d35bb 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -40,7 +40,7 @@
 		#interrupt-cells = <3>;
 		interrupt-controller;
 		reg =	<0x2E1000 0x1000>,
-			<0x2E2000 0x1000>,
+			<0x2E2000 0x2000>,
 			<0x2E4000 0x2000>,
 			<0x2E6000 0x2000>;
 		interrupts = <GIC_PPI 9
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 39845a7..ac5371a 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -91,11 +91,11 @@
 	};
 
 	intc: interrupt-controller@00a01000 {
-		compatible = "arm,cortex-a7-gic";
+		compatible = "arm,gic-400", "arm,cortex-a7-gic";
 		#interrupt-cells = <3>;
 		interrupt-controller;
 		reg = <0x00a01000 0x1000>,
-		      <0x00a02000 0x1000>,
+		      <0x00a02000 0x2000>,
 		      <0x00a04000 0x2000>,
 		      <0x00a06000 0x2000>;
 	};
diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index 63c7cf0..07bf300 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -45,7 +45,7 @@
 		interrupt-controller;
 		reg = <0x0 0x02561000 0x0 0x1000>,
 		      <0x0 0x02562000 0x0 0x2000>,
-		      <0x0 0x02564000 0x0 0x1000>,
+		      <0x0 0x02564000 0x0 0x2000>,
 		      <0x0 0x02566000 0x0 0x2000>;
 		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
 				IRQ_TYPE_LEVEL_HIGH)>;
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 02708ba..aaff6816 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -35,7 +35,7 @@
 		interrupt-controller;
 		reg = <0x0 0x02561000 0x0 0x1000>,
 		      <0x0 0x02562000 0x0 0x2000>,
-		      <0x0 0x02564000 0x0 0x1000>,
+		      <0x0 0x02564000 0x0 0x2000>,
 		      <0x0 0x02566000 0x0 0x2000>;
 		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
 				IRQ_TYPE_LEVEL_HIGH)>;
diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 282d854..45ea57f 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -110,11 +110,11 @@
 		ranges;
 
 		gic: interrupt-controller at 1400000 {
-			compatible = "arm,cortex-a7-gic";
+			compatible = "arm,gic-400", "arm,cortex-a7-gic";
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			reg = <0x0 0x1401000 0x0 0x1000>,
-			      <0x0 0x1402000 0x0 0x1000>,
+			      <0x0 0x1402000 0x0 0x2000>,
 			      <0x0 0x1404000 0x0 0x2000>,
 			      <0x0 0x1406000 0x0 0x2000>;
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index 7eab6f4..454d099 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -170,7 +170,7 @@
 		#interrupt-cells = <3>;
 		interrupt-parent = <&gic>;
 		reg = <0 0x10211000 0 0x1000>,
-		      <0 0x10212000 0 0x1000>,
+		      <0 0x10212000 0 0x2000>,
 		      <0 0x10214000 0 0x2000>,
 		      <0 0x10216000 0 0x2000>;
 	};
diff --git a/arch/arm/boot/dts/mt6580.dtsi b/arch/arm/boot/dts/mt6580.dtsi
index 06fdf6c..a349dba 100644
--- a/arch/arm/boot/dts/mt6580.dtsi
+++ b/arch/arm/boot/dts/mt6580.dtsi
@@ -91,7 +91,7 @@
 		#interrupt-cells = <3>;
 		interrupt-parent = <&gic>;
 		reg = <0x10211000 0x1000>,
-		      <0x10212000 0x1000>,
+		      <0x10212000 0x2000>,
 		      <0x10214000 0x2000>,
 		      <0x10216000 0x2000>;
 	};
diff --git a/arch/arm/boot/dts/mt6589.dtsi b/arch/arm/boot/dts/mt6589.dtsi
index 88b3cb1..0d6f60a 100644
--- a/arch/arm/boot/dts/mt6589.dtsi
+++ b/arch/arm/boot/dts/mt6589.dtsi
@@ -102,7 +102,7 @@
 			#interrupt-cells = <3>;
 			interrupt-parent = <&gic>;
 			reg = <0x10211000 0x1000>,
-			      <0x10212000 0x1000>,
+			      <0x10212000 0x2000>,
 			      <0x10214000 0x2000>,
 			      <0x10216000 0x2000>;
 		};
diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index fd2b614..19a54a3 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -104,7 +104,7 @@
 		#interrupt-cells = <3>;
 		interrupt-parent = <&gic>;
 		reg = <0 0x10211000 0 0x1000>,
-		      <0 0x10212000 0 0x1000>,
+		      <0 0x10212000 0 0x2000>,
 		      <0 0x10214000 0 0x2000>,
 		      <0 0x10216000 0 0x2000>;
 	};
diff --git a/arch/arm/boot/dts/mt8127.dtsi b/arch/arm/boot/dts/mt8127.dtsi
index 52086c8..916c095 100644
--- a/arch/arm/boot/dts/mt8127.dtsi
+++ b/arch/arm/boot/dts/mt8127.dtsi
@@ -129,7 +129,7 @@
 			#interrupt-cells = <3>;
 			interrupt-parent = <&gic>;
 			reg = <0 0x10211000 0 0x1000>,
-			      <0 0x10212000 0 0x1000>,
+			      <0 0x10212000 0 0x2000>,
 			      <0 0x10214000 0 0x2000>,
 			      <0 0x10216000 0 0x2000>;
 		};
diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
index 1d7f92b..a97b4ee 100644
--- a/arch/arm/boot/dts/mt8135.dtsi
+++ b/arch/arm/boot/dts/mt8135.dtsi
@@ -221,7 +221,7 @@
 			#interrupt-cells = <3>;
 			interrupt-parent = <&gic>;
 			reg = <0 0x10211000 0 0x1000>,
-			      <0 0x10212000 0 0x1000>,
+			      <0 0x10212000 0 0x2000>,
 			      <0 0x10214000 0 0x2000>,
 			      <0 0x10216000 0 0x2000>;
 		};
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 7cd92ba..71b4809 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -92,7 +92,7 @@
 		interrupt-controller;
 		#interrupt-cells = <3>;
 		reg = <0 0x48211000 0 0x1000>,
-		      <0 0x48212000 0 0x1000>,
+		      <0 0x48212000 0 0x2000>,
 		      <0 0x48214000 0 0x2000>,
 		      <0 0x48216000 0 0x2000>;
 		interrupt-parent = <&gic>;
diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 53183ff..14a66ca 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -465,7 +465,7 @@
 		#address-cells = <0>;
 		interrupt-controller;
 		reg = <0 0xf1001000 0 0x1000>,
-			<0 0xf1002000 0 0x1000>,
+			<0 0xf1002000 0 0x2000>,
 			<0 0xf1004000 0 0x2000>,
 			<0 0xf1006000 0 0x2000>;
 		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 216cb1f..172a944 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -55,7 +55,7 @@
 			#address-cells = <0>;
 			interrupt-controller;
 			reg = <0 0xf1001000 0 0x1000>,
-			      <0 0xf1002000 0 0x1000>,
+			      <0 0xf1002000 0 0x2000>,
 			      <0 0xf1004000 0 0x2000>,
 			      <0 0xf1006000 0 0x2000>;
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) |
diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 0b2e2f3..7390ec0 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -55,7 +55,7 @@
 			#address-cells = <0>;
 			interrupt-controller;
 			reg = <0 0xf1001000 0 0x1000>,
-			      <0 0xf1002000 0 0x1000>,
+			      <0 0xf1002000 0 0x2000>,
 			      <0 0xf1004000 0 0x2000>,
 			      <0 0xf1006000 0 0x2000>;
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) |
diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 0c8900d..ac38764 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -183,7 +183,7 @@
 		#address-cells = <0>;
 		interrupt-controller;
 		reg = <0 0xf1001000 0 0x1000>,
-			<0 0xf1002000 0 0x1000>,
+			<0 0xf1002000 0 0x2000>,
 			<0 0xf1004000 0 0x2000>,
 			<0 0xf1006000 0 0x2000>;
 		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 8721466..28039db 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -114,7 +114,7 @@
 		#address-cells = <0>;
 		interrupt-controller;
 		reg = <0 0xf1001000 0 0x1000>,
-			<0 0xf1002000 0 0x1000>,
+			<0 0xf1002000 0 0x2000>,
 			<0 0xf1004000 0 0x2000>,
 			<0 0xf1006000 0 0x2000>;
 		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index 6ced3c1..1ed5c88 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -88,7 +88,7 @@
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			reg = <0 0xf1001000 0 0x1000>,
-			      <0 0xf1002000 0 0x1000>,
+			      <0 0xf1002000 0 0x2000>,
 			      <0 0xf1004000 0 0x2000>,
 			      <0 0xf1006000 0 0x2000>;
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) |
diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 2fb527c..934c097 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -105,7 +105,7 @@
 		#address-cells = <0>;
 		interrupt-controller;
 		reg = <0 0xf1001000 0 0x1000>,
-			<0 0xf1002000 0 0x1000>,
+			<0 0xf1002000 0 0x2000>,
 			<0 0xf1004000 0 0x2000>,
 			<0 0xf1006000 0 0x2000>;
 		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index fb576db..09f7823 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -71,7 +71,7 @@
 		#address-cells = <0>;
 		interrupt-controller;
 		reg = <0 0xf1001000 0 0x1000>,
-			<0 0xf1002000 0 0x1000>,
+			<0 0xf1002000 0 0x2000>,
 			<0 0xf1004000 0 0x2000>,
 			<0 0xf1006000 0 0x2000>;
 		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
diff --git a/arch/arm/boot/dts/rk1108.dtsi b/arch/arm/boot/dts/rk1108.dtsi
index d770023..d6194bf 100644
--- a/arch/arm/boot/dts/rk1108.dtsi
+++ b/arch/arm/boot/dts/rk1108.dtsi
@@ -215,7 +215,7 @@
 		#address-cells = <0>;
 
 		reg = <0x32011000 0x1000>,
-		      <0x32012000 0x1000>,
+		      <0x32012000 0x2000>,
 		      <0x32014000 0x2000>,
 		      <0x32016000 0x2000>;
 		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 4ed49a2..ff9b90b 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -189,7 +189,7 @@
 		#address-cells = <0>;
 
 		reg = <0x10139000 0x1000>,
-		      <0x1013a000 0x1000>,
+		      <0x1013a000 0x2000>,
 		      <0x1013c000 0x2000>,
 		      <0x1013e000 0x2000>;
 		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 9d3aee5..9dff822 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -443,7 +443,7 @@
 		#address-cells = <0>;
 
 		reg = <0x32011000 0x1000>,
-		      <0x32012000 0x1000>,
+		      <0x32012000 0x2000>,
 		      <0x32014000 0x2000>,
 		      <0x32016000 0x2000>;
 		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 4fad133..af46cba 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1110,7 +1110,7 @@
 		#address-cells = <0>;
 
 		reg = <0xffc01000 0x1000>,
-		      <0xffc02000 0x1000>,
+		      <0xffc02000 0x2000>,
 		      <0xffc04000 0x2000>,
 		      <0xffc06000 0x2000>;
 		interrupts = <GIC_PPI 9 0xf04>;
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 2b26175..6ed505a 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -861,7 +861,7 @@
 		gic: interrupt-controller at 01c81000 {
 			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c81000 0x1000>,
-			      <0x01c82000 0x1000>,
+			      <0x01c82000 0x2000>,
 			      <0x01c84000 0x2000>,
 			      <0x01c86000 0x2000>;
 			interrupt-controller;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index f7db067..3c24832 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1686,9 +1686,9 @@
 		};
 
 		gic: interrupt-controller at 01c81000 {
-			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
+			compatible = "arm,gic-400", "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c81000 0x1000>,
-			      <0x01c82000 0x1000>,
+			      <0x01c82000 0x2000>,
 			      <0x01c84000 0x2000>,
 			      <0x01c86000 0x2000>;
 			interrupt-controller;
diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index e4991a7..49dfe86 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -489,7 +489,7 @@
 		gic: interrupt-controller at 01c81000 {
 			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c81000 0x1000>,
-			      <0x01c82000 0x1000>,
+			      <0x01c82000 0x2000>,
 			      <0x01c84000 0x2000>,
 			      <0x01c86000 0x2000>;
 			interrupt-controller;
diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index d3473f8..04c3fdd 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -217,7 +217,7 @@
 		gic: interrupt-controller at 01c81000 {
 			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c81000 0x1000>,
-			      <0x01c82000 0x1000>,
+			      <0x01c82000 0x2000>,
 			      <0x01c84000 0x2000>,
 			      <0x01c86000 0x2000>;
 			interrupt-controller;
diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 6c14a6f..292abd0 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -580,7 +580,7 @@
 		gic: interrupt-controller at 01c81000 {
 			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c81000 0x1000>,
-			      <0x01c82000 0x1000>,
+			      <0x01c82000 0x2000>,
 			      <0x01c84000 0x2000>,
 			      <0x01c86000 0x2000>;
 			interrupt-controller;
diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 979ad1a..b7b5831 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -613,7 +613,7 @@
 		gic: interrupt-controller at 01c41000 {
 			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c41000 0x1000>,
-			      <0x01c42000 0x1000>,
+			      <0x01c42000 0x2000>,
 			      <0x01c44000 0x2000>,
 			      <0x01c46000 0x2000>;
 			interrupt-controller;
-- 
2.1.4
