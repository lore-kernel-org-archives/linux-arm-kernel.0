From: anurupvasu@gmail.com (Anurup M)
Date: Thu,  4 Aug 2016 05:07:08 -0400
Subject: [RFC PATCH v1 04/10] arm64:perf: Add Devicetree bindings for
 Hisilicon SoC PMU
In-Reply-To: <1470301634-79736-1-git-send-email-anurup.m@huawei.com>
References: <1470301634-79736-1-git-send-email-anurup.m@huawei.com>
Message-ID: <1470301634-79736-5-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	1) Device tree bindings for Hisilicon Hip05 PMU.
	2) Add example for Hisilicon L3 cache and MN PMU.

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 .../devicetree/bindings/arm/hisilicon/pmu.txt      | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/pmu.txt

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/pmu.txt b/Documentation/devicetree/bindings/arm/hisilicon/pmu.txt
new file mode 100644
index 0000000..ba540db
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/pmu.txt
@@ -0,0 +1,52 @@
+Hisilicon SoC HIP05 ARMv8 PMU
+
+The Hisilicon Hip05 chip consists of varous independent system device PMU's
+such as L3 cache (L3C) and Miscellaneous Nodes(MN). These PMU devices are
+independent and have hardware logic to gather statistics and performance
+information.
+
+Hip05 chip is encapsulated by multiple CPU and IO die's. The CPU die is called
+as Super CPU cluster (SCCL) which includes 16 cpu-cores. Every CPU SCCL is
+further grouped as CPU clusters (CCL) which includes 4 cpu-cores each.
+Each SCCL has 1 L3 cache and 1 MN units.
+
+The below section describes the bindings for L3C and MN PMU's
+
+Required Properties:
+	- compatible : This field contain two values. The first value is
+		always "hisilicon" and second value is the Module type as shown
+		in below examples:
+		(a) "hisilicon,hip05-l3c" for Hisilicon SoC L3 cache
+		(b) "hisilicon,hip05-mn" for Hisilicon SoC MN
+
+Optional Properties:
+
+	- djtag	: The registers of modules like L3 cache, MN etc. are using
+		the Hisilicon djtag interface.
+		This field contains two values. The first value is the djtag
+		node phandle and second value is the ID of the CPU die or SCCL.
+
+	- interrupt-parent : A phandle indicating which interrupt controller
+		this PMU signals interrupts to.
+
+	- interrupts : Interrupt lines used by this PMU. If the PMU has
+		multiple banks, then all IRQ lines are listed in this
+		property in the order of bank number.
+
+Example:
+	l3c0: l3c {
+		compatible = "hisilicon,hip05-l3c";
+		djtag = <&djtag0 2>; /* DJTAG node for CPU die 2
+				      * (CPU die starts from 1) */
+		interrupt-parent = <&mbigen_pc>;
+		interrupts = <141 4>,<142 4>,
+			 <143 4>,<144 4>; /* IRQ lines for 4 L3 cache banks */
+	};
+
+	mn1: mn {
+		compatible = "hisilicon,hip05-mn";
+		djtag = <&djtag0 2>; /* DJTAG node for CPU die 2
+				      * (CPU die starts from 1) */
+		interrupt-parent = <&mbigen_pc>;
+		interrupts = <146 4>;
+	};
-- 
2.1.4
