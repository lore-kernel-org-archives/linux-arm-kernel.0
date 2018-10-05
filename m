From: robh@kernel.org (Rob Herring)
Date: Fri,  5 Oct 2018 11:58:13 -0500
Subject: [PATCH 01/36] dt-bindings: arm: alpine: Move CPU control related
 binding to cpu-enable-method/al, alpine-smp
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Message-ID: <20181005165848.3474-2-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is best practice to have 1 binding per file, so board level bindings
should be separate for various misc SoC bindings. Move the Alpine CPU
control to al,alpine-smp and we can also remove a cross reference.

Cc: Tsahee Zidenberg <tsahee@annapurnalabs.com>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree at vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/al,alpine.txt     | 72 -------------------
 .../arm/cpu-enable-method/al,alpine-smp       | 34 ++++++++-
 2 files changed, 31 insertions(+), 75 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/al,alpine.txt b/Documentation/devicetree/bindings/arm/al,alpine.txt
index f404a4f9b165..d00debe2e86f 100644
--- a/Documentation/devicetree/bindings/arm/al,alpine.txt
+++ b/Documentation/devicetree/bindings/arm/al,alpine.txt
@@ -14,75 +14,3 @@ compatible: must contain "al,alpine"
 
 	...
 }
-
-* CPU node:
-
-The Alpine platform includes cortex-a15 cores.
-enable-method: must be "al,alpine-smp" to allow smp  [1]
-
-Example:
-
-cpus {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	enable-method = "al,alpine-smp";
-
-	cpu at 0 {
-		compatible = "arm,cortex-a15";
-		device_type = "cpu";
-		reg = <0>;
-	};
-
-	cpu at 1 {
-		compatible = "arm,cortex-a15";
-		device_type = "cpu";
-		reg = <1>;
-	};
-
-	cpu at 2 {
-		compatible = "arm,cortex-a15";
-		device_type = "cpu";
-		reg = <2>;
-	};
-
-	cpu at 3 {
-		compatible = "arm,cortex-a15";
-		device_type = "cpu";
-		reg = <3>;
-	};
-};
-
-
-* Alpine CPU resume registers
-
-The CPU resume register are used to define required resume address after
-reset.
-
-Properties:
-- compatible : Should contain "al,alpine-cpu-resume".
-- reg : Offset and length of the register set for the device
-
-Example:
-
-cpu_resume {
-	compatible = "al,alpine-cpu-resume";
-	reg = <0xfbff5ed0 0x30>;
-};
-
-* Alpine System-Fabric Service Registers
-
-The System-Fabric Service Registers allow various operation on CPU and
-system fabric, like powering CPUs off.
-
-Properties:
-- compatible : Should contain "al,alpine-sysfabric-service" and "syscon".
-- reg : Offset and length of the register set for the device
-
-Example:
-
-nb_service {
-        compatible = "al,alpine-sysfabric-service", "syscon";
-        reg = <0xfb070000 0x10000>;
-};
-
-[1] arm/cpu-enable-method/al,alpine-smp
diff --git a/Documentation/devicetree/bindings/arm/cpu-enable-method/al,alpine-smp b/Documentation/devicetree/bindings/arm/cpu-enable-method/al,alpine-smp
index c2e0cc5e4cfd..35e5afb6d9ad 100644
--- a/Documentation/devicetree/bindings/arm/cpu-enable-method/al,alpine-smp
+++ b/Documentation/devicetree/bindings/arm/cpu-enable-method/al,alpine-smp
@@ -14,7 +14,28 @@ Related properties:	(none)
 
 Note:
 This enable method requires valid nodes compatible with
-"al,alpine-cpu-resume" and "al,alpine-nb-service"[1].
+"al,alpine-cpu-resume" and "al,alpine-nb-service".
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
 
 Example:
 
@@ -48,5 +69,12 @@ cpus {
 	};
 };
 
---
-[1] arm/al,alpine.txt
+cpu_resume {
+	compatible = "al,alpine-cpu-resume";
+	reg = <0xfbff5ed0 0x30>;
+};
+
+nb_service {
+        compatible = "al,alpine-sysfabric-service", "syscon";
+        reg = <0xfb070000 0x10000>;
+};
-- 
2.17.1
