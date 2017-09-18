From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 18 Sep 2017 16:38:32 +0100
Subject: [PATCH] arm64: dts: foundation-v8: Enable PSCI mode
Message-ID: <20170918153832.16356-1-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently if the Foundation model is running ARM Trusted Firmware then
the kernel, which is configured to use spin tables, cannot start secondary
processors or "power off" the simulation.

Add a couple of labels to the include file, and introduce a new .dts
file that uses these to override the enable-method.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm64/boot/dts/arm/Makefile                   |  3 +-
 .../boot/dts/arm/foundation-v8-gicv3-psci.dts      | 51 ++++++++++++++++++++++
 arch/arm64/boot/dts/arm/foundation-v8.dtsi         |  8 ++--
 3 files changed, 57 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/boot/dts/arm/foundation-v8-gicv3-psci.dts

diff --git a/arch/arm64/boot/dts/arm/Makefile b/arch/arm64/boot/dts/arm/Makefile
index 75cc2aa10101..c9ec88809f3d 100644
--- a/arch/arm64/boot/dts/arm/Makefile
+++ b/arch/arm64/boot/dts/arm/Makefile
@@ -1,4 +1,5 @@
-dtb-$(CONFIG_ARCH_VEXPRESS) += foundation-v8.dtb foundation-v8-gicv3.dtb
+dtb-$(CONFIG_ARCH_VEXPRESS) += \
+	foundation-v8.dtb foundation-v8-gicv3.dtb foundation-v8-gicv3-psci.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += juno.dtb juno-r1.dtb juno-r2.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2f-1xv7-ca53x2.dtb
diff --git a/arch/arm64/boot/dts/arm/foundation-v8-gicv3-psci.dts b/arch/arm64/boot/dts/arm/foundation-v8-gicv3-psci.dts
new file mode 100644
index 000000000000..94a249095104
--- /dev/null
+++ b/arch/arm64/boot/dts/arm/foundation-v8-gicv3-psci.dts
@@ -0,0 +1,51 @@
+/*
+ * ARM Ltd.
+ *
+ * ARMv8 Foundation model DTS (GICv3 configuration)
+ */
+
+#include "foundation-v8.dtsi"
+
+/ {
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	gic: interrupt-controller at 2f000000 {
+		compatible = "arm,gic-v3";
+		#interrupt-cells = <3>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		interrupt-controller;
+		reg =	<0x0 0x2f000000 0x0 0x10000>,
+			<0x0 0x2f100000 0x0 0x200000>,
+			<0x0 0x2c000000 0x0 0x2000>,
+			<0x0 0x2c010000 0x0 0x2000>,
+			<0x0 0x2c02f000 0x0 0x2000>;
+		interrupts = <1 9 4>;
+
+		its: its at 2f020000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			reg = <0x0 0x2f020000 0x0 0x20000>;
+		};
+	};
+};
+
+&cpu0 {
+	enable-method = "psci";
+};
+
+&cpu1 {
+	enable-method = "psci";
+};
+
+&cpu2 {
+	enable-method = "psci";
+};
+
+&cpu3 {
+	enable-method = "psci";
+};
diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dtsi b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
index 8ecdd4331980..8c7f8c4f090a 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8.dtsi
+++ b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
@@ -28,7 +28,7 @@
 		#address-cells = <2>;
 		#size-cells = <0>;

-		cpu at 0 {
+		cpu0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,armv8";
 			reg = <0x0 0x0>;
@@ -36,7 +36,7 @@
 			cpu-release-addr = <0x0 0x8000fff8>;
 			next-level-cache = <&L2_0>;
 		};
-		cpu at 1 {
+		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,armv8";
 			reg = <0x0 0x1>;
@@ -44,7 +44,7 @@
 			cpu-release-addr = <0x0 0x8000fff8>;
 			next-level-cache = <&L2_0>;
 		};
-		cpu at 2 {
+		cpu2: cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,armv8";
 			reg = <0x0 0x2>;
@@ -52,7 +52,7 @@
 			cpu-release-addr = <0x0 0x8000fff8>;
 			next-level-cache = <&L2_0>;
 		};
-		cpu at 3 {
+		cpu3: cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,armv8";
 			reg = <0x0 0x3>;
--
2.9.5
