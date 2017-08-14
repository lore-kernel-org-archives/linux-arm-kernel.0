From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 14 Aug 2017 23:58:55 +0200
Subject: [PATCH v6 1/6] dt-bindings: Amlogic: Add Meson8 and Meson8b SMP
 related documentation
In-Reply-To: <20170814215900.1032-1-martin.blumenstingl@googlemail.com>
References: <20170814215900.1032-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170814215900.1032-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

With this patch we add documentation for:

* power-management-unit: the PMU is used to bring up the cores during
  SMP operations
* sram: among other things the sram is used to store the first code
  executed by the core when it is powered up
* cpu-enable-method: the CPU enable method used by Amlogic Meson8 and
  Meson8b SoCs

Signed-off-by: Carlo Caione <carlo@endlessm.com>
[also add Meson8 to the documentation]
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/amlogic/pmu.txt        | 18 ++++++++++++
 .../devicetree/bindings/arm/amlogic/smp-sram.txt   | 32 ++++++++++++++++++++++
 Documentation/devicetree/bindings/arm/cpus.txt     |  2 ++
 3 files changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/pmu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/smp-sram.txt

diff --git a/Documentation/devicetree/bindings/arm/amlogic/pmu.txt b/Documentation/devicetree/bindings/arm/amlogic/pmu.txt
new file mode 100644
index 000000000000..72f8d08198b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/amlogic/pmu.txt
@@ -0,0 +1,18 @@
+Amlogic Meson8 and Meson8b power-management-unit:
+-------------------------------------------------
+
+The pmu is used to turn off and on different power domains of the SoCs
+This includes the power to the CPU cores.
+
+Required node properties:
+- compatible value : depending on the SoC this should be one of:
+			"amlogic,meson8-pmu"
+			"amlogic,meson8b-pmu"
+- reg : physical base address and the size of the registers window
+
+Example:
+
+	pmu at c81000e4 {
+		compatible = "amlogic,meson8b-pmu", "syscon";
+		reg = <0xc81000e0 0x18>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/amlogic/smp-sram.txt b/Documentation/devicetree/bindings/arm/amlogic/smp-sram.txt
new file mode 100644
index 000000000000..3473ddaadfac
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/amlogic/smp-sram.txt
@@ -0,0 +1,32 @@
+Amlogic Meson8 and Meson8b SRAM for smp bringup:
+------------------------------------------------
+
+Amlogic's SMP-capable SoCs use part of the sram for the bringup of the cores.
+Once the core gets powered up it executes the code that is residing at a
+specific location.
+
+Therefore a reserved section sub-node has to be added to the mmio-sram
+declaration.
+
+Required sub-node properties:
+- compatible : depending on the SoC this should be one of:
+		"amlogic,meson8-smp-sram"
+		"amlogic,meson8b-smp-sram"
+
+The rest of the properties should follow the generic mmio-sram discription
+found in ../../misc/sram.txt
+
+Example:
+
+	sram: sram at d9000000 {
+		compatible = "mmio-sram";
+		reg = <0xd9000000 0x20000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xd9000000 0x20000>;
+
+		smp-sram at 1ff80 {
+			compatible = "amlogic,meson8b-smp-sram";
+			reg = <0x1ff80 0x8>;
+		};
+	};
diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index a44253cad269..1ef3e53b9be7 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -197,6 +197,8 @@ described below.
 			    "actions,s500-smp"
 			    "allwinner,sun6i-a31"
 			    "allwinner,sun8i-a23"
+			    "amlogic,meson8-smp"
+			    "amlogic,meson8b-smp"
 			    "arm,realview-smp"
 			    "brcm,bcm11351-cpu-method"
 			    "brcm,bcm23550"
-- 
2.14.1
