From: zhangshaokun@hisilicon.com (Shaokun Zhang)
Date: Mon, 22 May 2017 20:48:21 +0800
Subject: [PATCH v8 3/9] dt-bindings: perf: hisi: Add Devicetree bindings for
 Hisilicon SoC PMU
Message-ID: <1495457301-234856-1-git-send-email-zhangshaokun@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anurup M <anurup.m@huawei.com>

1) Device tree bindings for Hisilicon SoC PMU.
2) Add example for Hisilicon L3 cache and MN PMU.
3) Add child nodes of L3C and MN in djtag bindings example.

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/hisilicon/djtag.txt    | 29 +++++++
 .../devicetree/bindings/arm/hisilicon/pmu.txt      | 93 ++++++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/pmu.txt

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/djtag.txt b/Documentation/devicetree/bindings/arm/hisilicon/djtag.txt
index fde5bab..27e67cc 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/djtag.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/djtag.txt
@@ -27,6 +27,35 @@ Example 1: Djtag for CPU die in HiP07
 		hisilicon,scl-id = <0x03>;
 
 		/* All connecting components will appear as child nodes */
+
+		pmul3c0 {
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x01>;
+			hisilicon,instance-id = <0x01>;
+		};
+
+		pmul3c1 {
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x02>;
+			hisilicon,instance-id = <0x01>;
+		};
+
+		pmul3c2 {
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x03>;
+			hisilicon,instance-id = <0x01>;
+		};
+
+		pmul3c3 {
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x04>;
+			hisilicon,instance-id = <0x01>;
+		};
+
+		pmumn0 {
+			compatible = "hisilicon,hip07-pmu-mn-v2";
+			hisilicon,module-id = <0x21>;
+		};
 	};
 
 Hisilicon HiP05/06/07 djtag for IO die
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/pmu.txt b/Documentation/devicetree/bindings/arm/hisilicon/pmu.txt
new file mode 100644
index 0000000..488e740
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/pmu.txt
@@ -0,0 +1,93 @@
+Hisilicon SoC HiP05/06/07 ARMv8 PMU
+===================================
+
+The Hisilicon SoC chips like HiP05/06/07 etc. consist of various independent
+system device PMUs such as L3 cache (L3C) and Miscellaneous Nodes(MN). These
+PMU devices are independent and have hardware logic to gather statistics and
+performance information.
+
+HiSilicon SoC chip is encapsulated by multiple CPU and IO dies. The CPU die
+is called as Super CPU cluster (SCCL) which includes 16 cpu-cores. Every SCCL
+in HiP05/06/07 chips are further grouped as CPU clusters (CCL) which includes
+4 cpu-cores each.
+e.g. In the case of HiP05/06/07, each SCCL has 1 L3 cache and 1 MN PMU device.
+The L3 cache is further grouped as 4 L3 cache banks in a SCCL.
+
+The Hisilicon SoC PMU DT node bindings for uncore PMU devices are as below.
+For PMU devices like L3 cache. MN etc. which are accessed using the djtag,
+the parent node will be the djtag node of the corresponding CPU die (SCCL).
+
+L3 cache
+---------
+The L3 cache is dedicated for each SCCL. Each SCCL in HiP05/06/07 chips have 4
+L3 cache banks. Each L3 cache bank have separate DT nodes.
+
+Required properties:
+
+	- compatible : This value should be as follows
+		(a) "hisilicon,hip05-pmu-l3c-v1" for v1 hw in HiP05 chipset
+		(b) "hisilicon,hip06-pmu-l3c-v1" for v1 hw in HiP06 chipset
+		(c) "hisilicon,hip07-pmu-l3c-v2" for v2 hw in HiP07 chipset
+
+	- hisilicon,module-id : This property is the module identifier for djtag.
+		In v1 hw, this value is 0x04 for all L3 cache instances. But
+		in v2 hw, this value is unique for each L3 cache instance.
+
+	- hisilicon,instance-id : This property will identify the L3 cache instance
+		or bank in djtag. In v1 hw, this value is unique for each L3 cache
+		instance. But in v2 hw, it is 0x01 for all L3 cache instances.
+
+	*The counter overflow IRQ is not supported in v1, v2 hardware (HiP05/06/07).
+
+Miscellaneous Node
+------------------
+The MN is dedicated for each SCCL and hence there are separate DT nodes for MN
+for each SCCL.
+
+Required properties:
+
+	- compatible : This value should be as follows
+		(a) "hisilicon,hip05-pmu-mn-v1" for v1 hw in HiP05 chipset
+		(b) "hisilicon,hip06-pmu-mn-v1" for v1 hw in HiP06 chipset
+		(c) "hisilicon,hip07-pmu-mn-v2" for v2 hw in HiP07 chipset
+
+	- hisilicon,module-id : Module ID to input for djtag.
+
+	*The counter overflow IRQ is not supported in v1, v2 hardware (HiP05/06/07).
+
+Example:
+
+	djtag0: djtag at 60010000 {
+		compatible = "hisilicon,hip07-cpu-djtag-v2";
+		reg = <0x0 0x60010000 0x0 0x10000>;
+		hisilicon,scl-id = <0x03>;
+
+		pmul3c0 {
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x01>;
+			hisilicon,instance-id = <0x01>;
+		};
+
+		pmul3c1 {
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x02>;
+			hisilicon,instance-id = <0x01>;
+		};
+
+		pmul3c2 {
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x03>;
+			hisilicon,instance-id = <0x01>;
+		};
+
+		pmul3c3 {
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x04>;
+			hisilicon,instance-id = <0x01>;
+		};
+
+		pmumn0 {
+			compatible = "hisilicon,hip07-pmu-mn-v2";
+			hisilicon,module-id = <0x21>;
+		};
+	};
-- 
1.9.1
