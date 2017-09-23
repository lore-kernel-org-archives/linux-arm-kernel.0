From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 23 Sep 2017 16:14:03 +0200
Subject: [PATCH 3/3] ARM: dts: meson: add SoC information nodes
In-Reply-To: <20170923141403.20882-1-martin.blumenstingl@googlemail.com>
References: <20170923141403.20882-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170923141403.20882-4-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SoC type and version information is encoded in different register
blocks.
The SoC type information is part of the "assist" registers.
The misc version information is part of the "bootrom" registers.
On Meson8, Meson8b and Meson8m2 there is additionally information about
the minor version. This information is stored in the "analog top"
registers.

Add the nodes for these register blocks so we can decode the SoC type
and version information.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson.dtsi   | 10 ++++++++++
 arch/arm/boot/dts/meson8.dtsi  |  5 +++++
 arch/arm/boot/dts/meson8b.dtsi |  5 +++++
 3 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index e7edc2d7b75e..ea95c9773eb8 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -80,6 +80,11 @@
 			#size-cells = <1>;
 			ranges = <0x0 0xc1100000 0x200000>;
 
+			assist: assist at 7c00 {
+				compatible = "amlogic,meson-mx-assist", "syscon";
+				reg = <0x7c00 0x200>;
+			};
+
 			hwrng: rng at 8100 {
 				compatible = "amlogic,meson-rng";
 				reg = <0x8100 0x8>;
@@ -261,5 +266,10 @@
 			#size-cells = <1>;
 			ranges = <0 0xd9000000 0x20000>;
 		};
+
+		bootrom: bootrom at d9040000 {
+			compatible = "amlogic,meson-mx-bootrom", "syscon";
+			reg = <0xd9040000 0x10000>;
+		};
 	};
 }; /* end of / */
diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 1db9bbe94337..6c0886633820 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -271,6 +271,11 @@
 		reg = <0x8000 0x4>, <0x4000 0x460>;
 	};
 
+	analog_top: analog-top at 81a8 {
+		compatible = "amlogic,meson8-analog-top", "syscon";
+		reg = <0x81a8 0x14>;
+	};
+
 	pwm_ef: pwm at 86c0 {
 		compatible = "amlogic,meson8-pwm", "amlogic,meson8b-pwm";
 		reg = <0x86c0 0x10>;
diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index a31668cda166..d65017ced82e 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -223,6 +223,11 @@
 		#reset-cells = <1>;
 	};
 
+	analog_top: analog-top at 81a8 {
+		compatible = "amlogic,meson8b-analog-top", "syscon";
+		reg = <0x81a8 0x14>;
+	};
+
 	pwm_ef: pwm at 86c0 {
 		compatible = "amlogic,meson8b-pwm";
 		reg = <0x86c0 0x10>;
-- 
2.14.1
