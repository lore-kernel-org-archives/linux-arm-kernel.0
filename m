From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Thu, 12 Mar 2015 13:53:09 +0200
Subject: [PATCH v6 4/6] ARM: dts: Alpine platform binding documentation
Message-ID: <55017e25.+YC0O9kly8Rbiti6%tsahee@annapurnalabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces documentation for alpine devicetree bindings.

Signed-off-by: Barak Wasserstrom <barak@annapurnalabs.com>
Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 .../devicetree/bindings/arm/al,alpine.txt          | 88 ++++++++++++++++++++++
 .../bindings/arm/cpu-enable-method/al,alpine-smp   | 52 +++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  2 +
 3 files changed, 142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/al,alpine.txt
 create mode 100644 Documentation/devicetree/bindings/arm/cpu-enable-method/al,alpine-smp

diff --git a/Documentation/devicetree/bindings/arm/al,alpine.txt b/Documentation/devicetree/bindings/arm/al,alpine.txt
new file mode 100644
index 0000000..f404a4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/al,alpine.txt
@@ -0,0 +1,88 @@
+Annapurna Labs Alpine Platform Device Tree Bindings
+---------------------------------------------------------------
+
+Boards in the Alpine family shall have the following properties:
+
+* Required root node properties:
+compatible: must contain "al,alpine"
+
+* Example:
+
+/ {
+	model = "Annapurna Labs Alpine Dev Board";
+	compatible = "al,alpine";
+
+	...
+}
+
+* CPU node:
+
+The Alpine platform includes cortex-a15 cores.
+enable-method: must be "al,alpine-smp" to allow smp  [1]
+
+Example:
+
+cpus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	enable-method = "al,alpine-smp";
+
+	cpu at 0 {
+		compatible = "arm,cortex-a15";
+		device_type = "cpu";
+		reg = <0>;
+	};
+
+	cpu at 1 {
+		compatible = "arm,cortex-a15";
+		device_type = "cpu";
+		reg = <1>;
+	};
+
+	cpu at 2 {
+		compatible = "arm,cortex-a15";
+		device_type = "cpu";
+		reg = <2>;
+	};
+
+	cpu at 3 {
+		compatible = "arm,cortex-a15";
+		device_type = "cpu";
+		reg = <3>;
+	};
+};
+
+
+* Alpine CPU resume registers
+
+The CPU resume register are used to define required resume address after
+reset.
+
+Properties:
+- compatible : Should contain "al,alpine-cpu-resume".
+- reg : Offset and length of the register set for the device
+
+Example:
+
+cpu_resume {
+	compatible = "al,alpine-cpu-resume";
+	reg = <0xfbff5ed0 0x30>;
+};
+
+* Alpine System-Fabric Service Registers
+
+The System-Fabric Service Registers allow various operation on CPU and
+system fabric, like powering CPUs off.
+
+Properties:
+- compatible : Should contain "al,alpine-sysfabric-service" and "syscon".
+- reg : Offset and length of the register set for the device
+
+Example:
+
+nb_service {
+        compatible = "al,alpine-sysfabric-service", "syscon";
+        reg = <0xfb070000 0x10000>;
+};
+
+[1] arm/cpu-enable-method/al,alpine-smp
diff --git a/Documentation/devicetree/bindings/arm/cpu-enable-method/al,alpine-smp b/Documentation/devicetree/bindings/arm/cpu-enable-method/al,alpine-smp
new file mode 100644
index 0000000..c2e0cc5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cpu-enable-method/al,alpine-smp
@@ -0,0 +1,52 @@
+========================================================
+Secondary CPU enable-method "al,alpine-smp" binding
+========================================================
+
+This document describes the "al,alpine-smp" method for
+enabling secondary CPUs. To apply to all CPUs, a single
+"al,alpine-smp" enable method should be defined in the
+"cpus" node.
+
+Enable method name:	"al,alpine-smp"
+Compatible machines:	"al,alpine"
+Compatible CPUs:	"arm,cortex-a15"
+Related properties:	(none)
+
+Note:
+This enable method requires valid nodes compatible with
+"al,alpine-cpu-resume" and "al,alpine-nb-service"[1].
+
+Example:
+
+cpus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	enable-method = "al,alpine-smp";
+
+	cpu at 0 {
+		compatible = "arm,cortex-a15";
+		device_type = "cpu";
+		reg = <0>;
+	};
+
+	cpu at 1 {
+		compatible = "arm,cortex-a15";
+		device_type = "cpu";
+		reg = <1>;
+	};
+
+	cpu at 2 {
+		compatible = "arm,cortex-a15";
+		device_type = "cpu";
+		reg = <2>;
+	};
+
+	cpu at 3 {
+		compatible = "arm,cortex-a15";
+		device_type = "cpu";
+		reg = <3>;
+	};
+};
+
+--
+[1] arm/al,alpine.txt
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index aeb5bb5..cb94a098 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -11,6 +11,8 @@ adapteva	Adapteva, Inc.
 adh	AD Holdings Plc.
 adi	Analog Devices, Inc.
 aeroflexgaisler	Aeroflex Gaisler AB
+ak	Asahi Kasei Corp.
+al	Annapurna Labs
 allwinner	Allwinner Technology Co., Ltd.
 alphascale	AlphaScale Integrated Circuits Systems, Inc.
 altr	Altera Corp.
-- 
1.9.1
