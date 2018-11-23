From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 23 Nov 2018 20:53:07 +0100
Subject: [PATCH 2/6] ARM: dts: meson: group the Cortex-A5 / Cortex-A9
 peripherals
In-Reply-To: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
References: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
Message-ID: <20181123195311.4578-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The public Meson8b (S805) datasheet describes a memory region called "A9
Periph base" which starts at 0xC4300000 and ends at 0xC430FFFF. Add a
simple-bus node and move all peripherals that are part of this memory
region.
This makes the .dts a bit easier to read. No functional changes.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson.dtsi   | 24 ++++++++++++++++--------
 arch/arm/boot/dts/meson8.dtsi  | 12 +++++++-----
 arch/arm/boot/dts/meson8b.dtsi | 12 +++++++-----
 3 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 0839da07a75c..e4645f612712 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -59,14 +59,6 @@
 		cache-level = <2>;
 	};
 
-	gic: interrupt-controller at c4301000 {
-		compatible = "arm,cortex-a9-gic";
-		reg = <0xc4301000 0x1000>,
-		      <0xc4300100 0x0100>;
-		interrupt-controller;
-		#interrupt-cells = <3>;
-	};
-
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -207,6 +199,22 @@
 			};
 		};
 
+		periph: bus at c4300000 {
+			compatible = "simple-bus";
+			reg = <0xc4300000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0xc4300000 0x10000>;
+
+			gic: interrupt-controller at 1000 {
+				compatible = "arm,cortex-a9-gic";
+				reg = <0x1000 0x1000>,
+				      <0x100 0x100>;
+				interrupt-controller;
+				#interrupt-cells = <3>;
+			};
+		};
+
 		aobus: aobus at c8100000 {
 			compatible = "simple-bus";
 			reg = <0xc8100000 0x100000>;
diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 3be5fbd07997..28b9f6779993 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -129,11 +129,6 @@
 			no-map;
 		};
 	};
-
-	scu at c4300000 {
-		compatible = "arm,cortex-a9-scu";
-		reg = <0xc4300000 0x100>;
-	};
 }; /* end of / */
 
 &aobus {
@@ -362,6 +357,13 @@
 	arm,shared-override;
 };
 
+&periph {
+	scu at 0 {
+		compatible = "arm,cortex-a9-scu";
+		reg = <0x0 0x100>;
+	};
+};
+
 &pwm_ab {
 	compatible = "amlogic,meson8-pwm", "amlogic,meson8b-pwm";
 };
diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 587a855f872b..6b097ab8637f 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -112,11 +112,6 @@
 			no-map;
 		};
 	};
-
-	scu at c4300000 {
-		compatible = "arm,cortex-a5-scu";
-		reg = <0xc4300000 0x100>;
-	};
 }; /* end of / */
 
 &aobus {
@@ -349,6 +344,13 @@
 	arm,shared-override;
 };
 
+&periph {
+	scu at 0 {
+		compatible = "arm,cortex-a5-scu";
+		reg = <0x0 0x100>;
+	};
+};
+
 &pwm_ab {
 	compatible = "amlogic,meson8b-pwm";
 };
-- 
2.19.2
