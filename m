From: anurupvasu@gmail.com (Anurup M)
Date: Wed,  2 Nov 2016 11:42:48 -0400
Subject: [PATCH v1 05/11] dt-bindings: perf: hisi: Add Devicetree bindings for
 Hisilicon SoC PMU
In-Reply-To: <1478101374-18778-1-git-send-email-anurup.m@huawei.com>
References: <1478101374-18778-1-git-send-email-anurup.m@huawei.com>
Message-ID: <1478101374-18778-6-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	1) Device tree bindings for Hisilicon SoC PMU.
	2) Add example for Hisilicon L3 cache, MN and DDRC PMU.

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 .../devicetree/bindings/arm/hisilicon/pmu.txt      | 127 +++++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/pmu.txt

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/pmu.txt b/Documentation/devicetree/bindings/arm/hisilicon/pmu.txt
new file mode 100644
index 0000000..e7b35e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/pmu.txt
@@ -0,0 +1,127 @@
+Hisilicon SoC hip05/06/07 ARMv8 PMU
+===================================
+
+The Hisilicon SoC chips like hip05/06/07 etc. consist of varous independent
+system device PMU's such as L3 cache (L3C), Miscellaneous Nodes(MN) and DDR
+comtroller. These PMU devices are independent and have hardware logic to
+gather statistics and performance information.
+
+HiSilicon SoC chip is encapsulated by multiple CPU and IO die's. The CPU die
+is called as Super CPU cluster (SCCL) which includes 16 cpu-cores. Every SCCL
+is further grouped as CPU clusters (CCL) which includes 4 cpu-cores each.
+e.g. In the case of hip05/06/07, each SCCL has 1 L3 cache and 1 MN PMU device.
+
+The Hisilicon SoC PMU DT node bindigs for uncore PMU devices are as below.
+For PMU devices like L3 cache. MN etc. which are accessed using the djtag,
+the parent node will be the djtag node of the corresponding CPU die(SCCL).
+
+For uncore PMU devices there are some common required properties as detailed
+below.
+
+Required properties:
+	- compatible : This field contain two values. The first value is
+		always "hisilicon" and second value is the Module type as shown
+		in below examples:
+		(a) "hisilicon,hisi-pmu-l3c-v1" for Hisilicon SoC L3C PMU
+			device (Version 1)
+		(b) "hisilicon,hisi-pmu-mn-v1" for Hisilicon SoC MN PMU
+			device (Version 1)
+		(c) "hisilicon,hisi-pmu-ddrc-v1" for Hisilicon SoC DDRC PMU
+			device (Version 1)
+		The hip05/06/07 chips have v1 hardware for L3C, MN and DDRC.
+
+	- scl-id : The Super Cluster ID. This can be the ID of the CPU die
+		   or IO die in the chip.
+
+	- num-events : No of events supported by this PMU device.
+
+	- num-counters : No of hardware counters available for counting.
+
+L3 cache
+--------
+The L3 cache is dedicated for each SCCL and hence there are separate DT nodes
+for L3 cache for each SCCL. For L3 cache PMU the additional required properties
+are
+	- counter-reg : Counter register offset.
+
+	- evtype-reg : Event select register offset.
+
+	- evctrl-reg : Event counting control(LAUCTRL) register offset.
+
+	- event-en : Event enable value.
+
+	- module-id : Module ID to input for djtag. This property is an array of
+		      module_id for each L3 cache banks.
+
+	- num-banks : Number of banks or instances of the device.
+
+	- cfgen-map : Config enable array to select the bank.
+
+Miscellaneous Node
+-------------------
+The MN is dedicated for each SCCL and hence there are separate DT nodes for MN
+for each SCCL. For MN PMU the additional required properties are
+	- counter-reg : Counter register offset.
+
+	- evtype-reg : Event select register offset.
+
+	- evctrl-reg : Event counting control register offset.
+
+	- module-id : Module ID to input for djtag. As MN doesnot have multiple banks
+		      this property is a single value.
+
+	- cfgen-map : Config enable to select the bank. For MN it is a single value
+
+	- event-en : Event enable value.
+
+Example:
+
+	djtag0: djtag at 0 {
+		compatible = "hisilicon,hip05-cpu-djtag-v1";
+		pmul3c0 {
+			compatible = "hisilicon,hisi-pmu-l3c-v1";
+			scl-id = <0x02>;
+			num-events = <0x16>;
+			num-counters = <0x08>;
+			module-id = <0x04 0x04 0x04 0x04>;
+			num-banks = <0x04>;
+			cfgen-map = <0x02 0x04 0x01 0x08>;
+			counter-reg = <0x170>;
+			evctrl-reg = <0x04>;
+			event-en = <0x1000000>;
+			evtype-reg = <0x140>;
+		};
+
+		pmumn0 {
+			compatible = "hisilicon,hisi-pmu-mn-v1";
+			scl-id = <0x02>;
+			num-events = <0x09>;
+			num-counters = <0x04>;
+			module-id = <0x0b>;
+			cfgen-map = <0x01>;
+			counter-reg = <0x30>;
+			evctrl-reg = <0x40>;
+			event-en = <0x01>;
+			evtype-reg = <0x48>;
+		};
+	};
+
+DDR controller
+--------------
+Each SCCL in Hip05/06/07 chips have 2 DDR channels and hence 2 DDR controllers.
+There are separate DT nodes for each DDR channel.
+For DDRC PMU the additional required properties are
+
+	- ch-id : DDRC Channel ID.
+	- reg : Register base address and range for the DDRC channel.
+
+Example:
+	/* DDRC for CPU die scl #2 Channel #1 for hip05 */
+	pmu_sccl0_ddrc1: pmu_ddrc1 at 80358000 {
+		 compatible = "hisilicon,hisi-pmu-ddrc-v1";
+		 scl-id = <0x02>;
+		 ch-id = <0x1>;
+		 num-events = <0x0D>;
+		 num-counters = <0x04>;
+		 reg = <0x80358000 0x10000>; /* TOTEMC DDRC1 */
+	 };
-- 
2.1.4
