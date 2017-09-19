From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 19 Sep 2017 19:32:04 +0100
Subject: [PATCH v2] arm64: dts: foundation-v8: Enable PSCI mode
In-Reply-To: <20170918153832.16356-1-daniel.thompson@linaro.org>
References: <20170918153832.16356-1-daniel.thompson@linaro.org>
Message-ID: <20170919183204.12751-1-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently if the Foundation model is running ARM Trusted Firmware then
the kernel, which is configured to use spin tables, cannot start secondary
processors or "power off" the simulation.

After adding a couple of labels to the include file and splitting out the
spin-table configuration into a header, we add a couple of new headers
together with two new DTs (GICv2+PSCI and GICv3+PSCI).

The new GICv3+PSCI DT has been boot tested, the remaining three (two of
which existed prior to this patch) have been "tested" by decompiling the
blobs and comparing them against a reference.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm64/boot/dts/arm/Makefile                   |  4 +++-
 arch/arm64/boot/dts/arm/foundation-v8-gicv2.dtsi   | 19 +++++++++++++++
 .../boot/dts/arm/foundation-v8-gicv3-psci.dts      |  9 +++++++
 arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts    | 25 ++-----------------
 arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtsi   | 28 ++++++++++++++++++++++
 arch/arm64/boot/dts/arm/foundation-v8-psci.dts     |  9 +++++++
 arch/arm64/boot/dts/arm/foundation-v8-psci.dtsi    | 28 ++++++++++++++++++++++
 .../boot/dts/arm/foundation-v8-spin-table.dtsi     | 25 +++++++++++++++++++
 arch/arm64/boot/dts/arm/foundation-v8.dts          | 16 ++-----------
 arch/arm64/boot/dts/arm/foundation-v8.dtsi         | 16 ++++---------
 10 files changed, 129 insertions(+), 50 deletions(-)
 create mode 100644 arch/arm64/boot/dts/arm/foundation-v8-gicv2.dtsi
 create mode 100644 arch/arm64/boot/dts/arm/foundation-v8-gicv3-psci.dts
 create mode 100644 arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtsi
 create mode 100644 arch/arm64/boot/dts/arm/foundation-v8-psci.dts
 create mode 100644 arch/arm64/boot/dts/arm/foundation-v8-psci.dtsi
 create mode 100644 arch/arm64/boot/dts/arm/foundation-v8-spin-table.dtsi

diff --git a/arch/arm64/boot/dts/arm/Makefile b/arch/arm64/boot/dts/arm/Makefile
index 75cc2aa10101..25f82c377f67 100644
--- a/arch/arm64/boot/dts/arm/Makefile
+++ b/arch/arm64/boot/dts/arm/Makefile
@@ -1,4 +1,6 @@
-dtb-$(CONFIG_ARCH_VEXPRESS) += foundation-v8.dtb foundation-v8-gicv3.dtb
+dtb-$(CONFIG_ARCH_VEXPRESS) += \
+	foundation-v8.dtb foundation-v8-psci.dtb \
+	foundation-v8-gicv3.dtb foundation-v8-gicv3-psci.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += juno.dtb juno-r1.dtb juno-r2.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2f-1xv7-ca53x2.dtb
diff --git a/arch/arm64/boot/dts/arm/foundation-v8-gicv2.dtsi b/arch/arm64/boot/dts/arm/foundation-v8-gicv2.dtsi
new file mode 100644
index 000000000000..851abf34fc80
--- /dev/null
+++ b/arch/arm64/boot/dts/arm/foundation-v8-gicv2.dtsi
@@ -0,0 +1,19 @@
+/*
+ * ARM Ltd.
+ *
+ * ARMv8 Foundation model DTS (GICv2 configuration)
+ */
+
+/ {
+	gic: interrupt-controller at 2c001000 {
+		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <2>;
+		interrupt-controller;
+		reg = <0x0 0x2c001000 0 0x1000>,
+		      <0x0 0x2c002000 0 0x2000>,
+		      <0x0 0x2c004000 0 0x2000>,
+		      <0x0 0x2c006000 0 0x2000>;
+		interrupts = <1 9 0xf04>;
+	};
+};
diff --git a/arch/arm64/boot/dts/arm/foundation-v8-gicv3-psci.dts b/arch/arm64/boot/dts/arm/foundation-v8-gicv3-psci.dts
new file mode 100644
index 000000000000..e096e670bec3
--- /dev/null
+++ b/arch/arm64/boot/dts/arm/foundation-v8-gicv3-psci.dts
@@ -0,0 +1,9 @@
+/*
+ * ARM Ltd.
+ *
+ * ARMv8 Foundation model DTS (GICv3+PSCI configuration)
+ */
+
+#include "foundation-v8.dtsi"
+#include "foundation-v8-gicv3.dtsi"
+#include "foundation-v8-psci.dtsi"
diff --git a/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts b/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts
index 35588dfa095c..c5d834d7d0ba 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts
+++ b/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts
@@ -5,26 +5,5 @@
  */

 #include "foundation-v8.dtsi"
-
-/ {
-	gic: interrupt-controller at 2f000000 {
-		compatible = "arm,gic-v3";
-		#interrupt-cells = <3>;
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-		interrupt-controller;
-		reg =	<0x0 0x2f000000 0x0 0x10000>,
-			<0x0 0x2f100000 0x0 0x200000>,
-			<0x0 0x2c000000 0x0 0x2000>,
-			<0x0 0x2c010000 0x0 0x2000>,
-			<0x0 0x2c02f000 0x0 0x2000>;
-		interrupts = <1 9 4>;
-
-		its: its at 2f020000 {
-			compatible = "arm,gic-v3-its";
-			msi-controller;
-			reg = <0x0 0x2f020000 0x0 0x20000>;
-		};
-	};
-};
+#include "foundation-v8-gicv3.dtsi"
+#include "foundation-v8-spin-table.dtsi"
diff --git a/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtsi b/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtsi
new file mode 100644
index 000000000000..91fc5c60d88b
--- /dev/null
+++ b/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtsi
@@ -0,0 +1,28 @@
+/*
+ * ARM Ltd.
+ *
+ * ARMv8 Foundation model DTS (GICv3 configuration)
+ */
+
+/ {
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
diff --git a/arch/arm64/boot/dts/arm/foundation-v8-psci.dts b/arch/arm64/boot/dts/arm/foundation-v8-psci.dts
new file mode 100644
index 000000000000..723f23c7cd31
--- /dev/null
+++ b/arch/arm64/boot/dts/arm/foundation-v8-psci.dts
@@ -0,0 +1,9 @@
+/*
+ * ARM Ltd.
+ *
+ * ARMv8 Foundation model DTS (GICv2+PSCI configuration)
+ */
+
+#include "foundation-v8.dtsi"
+#include "foundation-v8-gicv2.dtsi"
+#include "foundation-v8-psci.dtsi"
diff --git a/arch/arm64/boot/dts/arm/foundation-v8-psci.dtsi b/arch/arm64/boot/dts/arm/foundation-v8-psci.dtsi
new file mode 100644
index 000000000000..16cdf395728b
--- /dev/null
+++ b/arch/arm64/boot/dts/arm/foundation-v8-psci.dtsi
@@ -0,0 +1,28 @@
+/*
+ * ARM Ltd.
+ *
+ * ARMv8 Foundation model DTS (PSCI configuration)
+ */
+
+/ {
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
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
diff --git a/arch/arm64/boot/dts/arm/foundation-v8-spin-table.dtsi b/arch/arm64/boot/dts/arm/foundation-v8-spin-table.dtsi
new file mode 100644
index 000000000000..4d4186ba0e8c
--- /dev/null
+++ b/arch/arm64/boot/dts/arm/foundation-v8-spin-table.dtsi
@@ -0,0 +1,25 @@
+/*
+ * ARM Ltd.
+ *
+ * ARMv8 Foundation model DTS (spin table configuration)
+ */
+
+&cpu0 {
+	enable-method = "spin-table";
+	cpu-release-addr = <0x0 0x8000fff8>;
+};
+
+&cpu1 {
+	enable-method = "spin-table";
+	cpu-release-addr = <0x0 0x8000fff8>;
+};
+
+&cpu2 {
+	enable-method = "spin-table";
+	cpu-release-addr = <0x0 0x8000fff8>;
+};
+
+&cpu3 {
+	enable-method = "spin-table";
+	cpu-release-addr = <0x0 0x8000fff8>;
+};
diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dts b/arch/arm64/boot/dts/arm/foundation-v8.dts
index 71168077312d..8ff7c86fc929 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8.dts
+++ b/arch/arm64/boot/dts/arm/foundation-v8.dts
@@ -5,17 +5,5 @@
  */

 #include "foundation-v8.dtsi"
-
-/ {
-	gic: interrupt-controller at 2c001000 {
-		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
-		#interrupt-cells = <3>;
-		#address-cells = <2>;
-		interrupt-controller;
-		reg = <0x0 0x2c001000 0 0x1000>,
-		      <0x0 0x2c002000 0 0x2000>,
-		      <0x0 0x2c004000 0 0x2000>,
-		      <0x0 0x2c006000 0 0x2000>;
-		interrupts = <1 9 0xf04>;
-	};
-};
+#include "foundation-v8-gicv2.dtsi"
+#include "foundation-v8-spin-table.dtsi"
diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dtsi b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
index 8ecdd4331980..60f6ab920743 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8.dtsi
+++ b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
@@ -28,36 +28,28 @@
 		#address-cells = <2>;
 		#size-cells = <0>;

-		cpu at 0 {
+		cpu0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,armv8";
 			reg = <0x0 0x0>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0x0 0x8000fff8>;
 			next-level-cache = <&L2_0>;
 		};
-		cpu at 1 {
+		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,armv8";
 			reg = <0x0 0x1>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0x0 0x8000fff8>;
 			next-level-cache = <&L2_0>;
 		};
-		cpu at 2 {
+		cpu2: cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,armv8";
 			reg = <0x0 0x2>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0x0 0x8000fff8>;
 			next-level-cache = <&L2_0>;
 		};
-		cpu at 3 {
+		cpu3: cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,armv8";
 			reg = <0x0 0x3>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0x0 0x8000fff8>;
 			next-level-cache = <&L2_0>;
 		};

--
2.9.5
