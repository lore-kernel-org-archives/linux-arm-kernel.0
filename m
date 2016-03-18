From: juri.lelli@arm.com (Juri Lelli)
Date: Fri, 18 Mar 2016 14:24:08 +0000
Subject: [PATCH v4 2/8] Documentation: arm: define DT cpu capacity bindings
In-Reply-To: <1458311054-13524-1-git-send-email-juri.lelli@arm.com>
References: <1458311054-13524-1-git-send-email-juri.lelli@arm.com>
Message-ID: <1458311054-13524-3-git-send-email-juri.lelli@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM systems may be configured to have cpus with different power/performance
characteristics within the same chip. In this case, additional information
has to be made available to the kernel (the scheduler in particular) for it
to be aware of such differences and take decisions accordingly.

Therefore, this patch aims at standardizing cpu capacities device tree
bindings for ARM platforms. Bindings define cpu capacity parameter, to
allow operating systems to retrieve such information from the device tree
and initialize related kernel structures, paving the way for common code in
the kernel to deal with heterogeneity.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: devicetree at vger.kernel.org
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---

Changes from v1:
 - removed section regarding capacity-scale
 - added information regarding normalization
---
 .../devicetree/bindings/arm/cpu-capacity.txt       | 222 +++++++++++++++++++++
 Documentation/devicetree/bindings/arm/cpus.txt     |   9 +
 2 files changed, 231 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cpu-capacity.txt

diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
new file mode 100644
index 0000000..fdfc453
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
@@ -0,0 +1,222 @@
+==========================================
+ARM CPUs capacity bindings
+==========================================
+
+==========================================
+1 - Introduction
+==========================================
+
+ARM systems may be configured to have cpus with different power/performance
+characteristics within the same chip. In this case, additional information
+has to be made available to the kernel (the scheduler in particular) for
+it to be aware of such differences and take decisions accordingly.
+
+==========================================
+2 - CPU capacity definition
+==========================================
+
+CPU capacity is a number that provides the scheduler information about CPUs
+heterogeneity. Such heterogeneity can come from micro-architectural differences
+(e.g., ARM big.LITTLE systems) or maximum frequency at which CPUs can run
+(e.g., SMP systems with multiple frequency domains). Heterogeneity in this
+context is about differing performance characteristics; this binding tries to
+capture a first-order approximation of the relative performance of CPUs.
+
+One simple way to estimate CPU capacities is to iteratively run a well-known
+CPU user space benchmark (e.g, sysbench) on each CPU at maximum frequency and
+then normalize values w.r.t.  the best performing CPU.  One can also do a
+statistically significant study of a wide collection of benchmarks, but pros
+of such an approach are not really evident at the time of writing.
+
+==========================================
+3 - capacity
+==========================================
+
+capacity is an optional cpu node [1] property: u32 value representing CPU
+capacity. Values are normalized w.r.t. the biggest capacity found while
+parsing the DT.
+
+If capacity property is all-or-nothing: if it is specified for a cpu node, it
+has to be specified for every other cpu nodes, or the system will fall back to
+the default capacity value for every CPU.
+
+===========================================
+4 - Examples
+===========================================
+
+Example 1 (ARM 64-bit, 6-cpu system, two clusters):
+capacities are scaled w.r.t. 1024 (cpu at 0 and cpu at 1)
+
+cpus {
+	#address-cells = <2>;
+	#size-cells = <0>;
+
+	cpu-map {
+		cluster0 {
+			core0 {
+				cpu = <&A57_0>;
+			};
+			core1 {
+				cpu = <&A57_1>;
+			};
+		};
+
+		cluster1 {
+			core0 {
+				cpu = <&A53_0>;
+			};
+			core1 {
+				cpu = <&A53_1>;
+			};
+			core2 {
+				cpu = <&A53_2>;
+			};
+			core3 {
+				cpu = <&A53_3>;
+			};
+		};
+	};
+
+	idle-states {
+		entry-method = "arm,psci";
+
+		CPU_SLEEP_0: cpu-sleep-0 {
+			compatible = "arm,idle-state";
+			arm,psci-suspend-param = <0x0010000>;
+			local-timer-stop;
+			entry-latency-us = <100>;
+			exit-latency-us = <250>;
+			min-residency-us = <150>;
+		};
+
+		CLUSTER_SLEEP_0: cluster-sleep-0 {
+			compatible = "arm,idle-state";
+			arm,psci-suspend-param = <0x1010000>;
+			local-timer-stop;
+			entry-latency-us = <800>;
+			exit-latency-us = <700>;
+			min-residency-us = <2500>;
+		};
+	};
+
+	A57_0: cpu at 0 {
+		compatible = "arm,cortex-a57","arm,armv8";
+		reg = <0x0 0x0>;
+		device_type = "cpu";
+		enable-method = "psci";
+		next-level-cache = <&A57_L2>;
+		clocks = <&scpi_dvfs 0>;
+		cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		capacity = <1024>;
+	};
+
+	A57_1: cpu at 1 {
+		compatible = "arm,cortex-a57","arm,armv8";
+		reg = <0x0 0x1>;
+		device_type = "cpu";
+		enable-method = "psci";
+		next-level-cache = <&A57_L2>;
+		clocks = <&scpi_dvfs 0>;
+		cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		capacity = <1024>;
+	};
+
+	A53_0: cpu at 100 {
+		compatible = "arm,cortex-a53","arm,armv8";
+		reg = <0x0 0x100>;
+		device_type = "cpu";
+		enable-method = "psci";
+		next-level-cache = <&A53_L2>;
+		clocks = <&scpi_dvfs 1>;
+		cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		capacity = <447>;
+	};
+
+	A53_1: cpu at 101 {
+		compatible = "arm,cortex-a53","arm,armv8";
+		reg = <0x0 0x101>;
+		device_type = "cpu";
+		enable-method = "psci";
+		next-level-cache = <&A53_L2>;
+		clocks = <&scpi_dvfs 1>;
+		cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		capacity = <447>;
+	};
+
+	A53_2: cpu at 102 {
+		compatible = "arm,cortex-a53","arm,armv8";
+		reg = <0x0 0x102>;
+		device_type = "cpu";
+		enable-method = "psci";
+		next-level-cache = <&A53_L2>;
+		clocks = <&scpi_dvfs 1>;
+		cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		capacity = <447>;
+	};
+
+	A53_3: cpu at 103 {
+		compatible = "arm,cortex-a53","arm,armv8";
+		reg = <0x0 0x103>;
+		device_type = "cpu";
+		enable-method = "psci";
+		next-level-cache = <&A53_L2>;
+		clocks = <&scpi_dvfs 1>;
+		cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		capacity = <447>;
+	};
+
+	A57_L2: l2-cache0 {
+		compatible = "cache";
+	};
+
+	A53_L2: l2-cache1 {
+		compatible = "cache";
+	};
+};
+
+Example 2 (ARM 32-bit, 4-cpu system, two clusters,
+	   cpus 0,1 at 1GHz, cpus 2,3 at 500MHz):
+capacities are scaled w.r.t. 2 (cpu at 0 and cpu at 1), this means that first
+cluster is twice fast than second cluster (i.e., cpu at 0 and cpu at 1 might be
+running at twice the clock-frequency of cpu at 2 and cpu at 3)
+
+cpus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	cpu0: cpu at 0 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <0>;
+		capacity = <2>;
+	};
+
+	cpu1: cpu at 1 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <1>;
+		capacity = <2>;
+	};
+
+	cpu2: cpu at 2 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <0x100>;
+		capacity = <1>;
+	};
+
+	cpu3: cpu at 3 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <0x101>;
+		capacity = <1>;
+	};
+};
+
+===========================================
+5 - References
+===========================================
+
+[1] ARM Linux Kernel documentation - CPUs bindings
+    Documentation/devicetree/bindings/arm/cpus.txt
diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index ae9be07..efd6151 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -237,6 +237,13 @@ nodes to be present and contain the properties described below.
 			# List of phandles to idle state nodes supported
 			  by this cpu [3].
 
+	- capacity
+		Usage: Optional
+		Value type: <u32>
+		Definition:
+			# u32 value representing CPU capacity [3], relative to
+			  highest capacity in the system.
+
 	- rockchip,pmu
 		Usage: optional for systems that have an "enable-method"
 		       property value of "rockchip,rk3066-smp"
@@ -460,3 +467,5 @@ cpus {
 [2] arm/msm/qcom,kpss-acc.txt
 [3] ARM Linux kernel documentation - idle states bindings
     Documentation/devicetree/bindings/arm/idle-states.txt
+[3] ARM Linux kernel documentation - cpu capacity bindings
+    Documentation/devicetree/bindings/arm/cpu-capacity.txt
-- 
2.7.0
