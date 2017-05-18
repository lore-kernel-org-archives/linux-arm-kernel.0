From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 18 May 2017 13:59:26 +0100
Subject: [PATCH v9 0/9] coresight: enable debug module
In-Reply-To: <1494298202-6739-1-git-send-email-leo.yan@linaro.org>
References: <1494298202-6739-1-git-send-email-leo.yan@linaro.org>
Message-ID: <20170518125926.GA28458@e107814-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 09, 2017 at 10:49:53AM +0800, Leo Yan wrote:
> ARMv8 architecture reference manual (ARM DDI 0487A.k) Chapter H7 "The
> Sample-based Profiling Extension" has description for sampling
> registers, we can utilize these registers to check program counter
> value with combined CPU exception level, secure state, etc. So this is
> helpful for CPU lockup bugs, e.g. if one CPU has run into infinite loop
> with IRQ disabled; the 'hang' CPU cannot switch context and handle any
> interrupt, so it cannot handle SMP call for stack dump, etc.
> 
> This patch series is to enable coresight debug module with sample-based
> registers and register call back notifier for PCSR register dumping
> when panic happens, so we can see below dumping info for panic; and
> this patch series has considered the conditions for access permission
> for debug registers self, so this can avoid access debug registers when
> CPU power domain is off; the driver also try to figure out the CPU is
> in secure or non-secure state.
> 
> Patch 0001 is to document the dt binding; patch 0002 adds one detailed
> document to describe the Coresight debug module implementation, the
> clock and power domain impaction on the driver, some examples for usage.
> 
> Patch 0003 is to document boot parameters used in kernel command line.
> 
> Patch 0004 is to add file entries for MAINTAINERS.
> 
> Patch 0005 is used to fix the func of_get_coresight_platform_data()
> doesn't properly drop the reference to the CPU node pointer; and
> patch 0006 is refactor to add new function of_coresight_get_cpu().
> 
> Patch 0007 is the driver for CPU debug module.
> 
> Patch 0008 in this series are to enable debug unit on 96boards Hikey,
> Patch 0009 is to enable debug on 96boards DB410c. Have verified on both
> two boards.

Leo,

Please could you include the following patch in your series, which adds
the DT nodes for CPU debug on Juno boards ?

----8>----
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Date: Tue, 28 Mar 2017 13:40:24 +0100
Subject: [PATCH] arm64: dts: juno: Add Coresight CPU debug nodes

Add Coresight CPU debug nodes for Juno r0, r1 & r2. The CPU
debug areas are mapped at the same address for all revisions,
like the ETM, even though the CPUs have changed from r1 to r2.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.porier@linaro.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 54 ++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/arm/juno-r1.dts    | 24 +++++++++++++++
 arch/arm64/boot/dts/arm/juno-r2.dts    | 24 +++++++++++++++
 arch/arm64/boot/dts/arm/juno.dts       | 24 +++++++++++++++
 4 files changed, 126 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index df539e8..0613aed 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -216,6 +216,15 @@
 		};
 	};
 
+	cpu_debug0: cpu_debug at 22010000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0x22010000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+	};
+
 	funnel at 220c0000 { /* cluster0 funnel */
 		compatible = "arm,coresight-funnel", "arm,primecell";
 		reg = <0 0x220c0000 0 0x1000>;
@@ -266,6 +275,15 @@
 		};
 	};
 
+	cpu_debug1: cpu_debug at 22110000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0x22110000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+	};
+
 	etm2: etm at 23040000 {
 		compatible = "arm,coresight-etm4x", "arm,primecell";
 		reg = <0 0x23040000 0 0x1000>;
@@ -280,6 +298,15 @@
 		};
 	};
 
+	cpu_debug2: cpu_debug at 23010000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0x23010000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+	};
+
 	funnel at 230c0000 { /* cluster1 funnel */
 		compatible = "arm,coresight-funnel", "arm,primecell";
 		reg = <0 0x230c0000 0 0x1000>;
@@ -344,6 +371,15 @@
 		};
 	};
 
+	cpu_debug3: cpu_debug at 23110000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0x23110000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+	};
+
 	etm4: etm at 23240000 {
 		compatible = "arm,coresight-etm4x", "arm,primecell";
 		reg = <0 0x23240000 0 0x1000>;
@@ -358,6 +394,15 @@
 		};
 	};
 
+	cpu_debug4: cpu_debug at 23210000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0x23210000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+	};
+
 	etm5: etm at 23340000 {
 		compatible = "arm,coresight-etm4x", "arm,primecell";
 		reg = <0 0x23340000 0 0x1000>;
@@ -372,6 +417,15 @@
 		};
 	};
 
+	cpu_debug5: cpu_debug at 23310000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0x23310000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+	};
+
 	replicator at 20120000 {
 		compatible = "qcom,coresight-replicator1x", "arm,primecell";
 		reg = <0 0x20120000 0 0x1000>;
diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
index 0033c59..d6a4cda 100644
--- a/arch/arm64/boot/dts/arm/juno-r1.dts
+++ b/arch/arm64/boot/dts/arm/juno-r1.dts
@@ -239,3 +239,27 @@
 &stm_out_port {
 	remote-endpoint = <&csys1_funnel_in_port0>;
 };
+
+&cpu_debug0 {
+	cpu = <&A57_0>;
+};
+
+&cpu_debug1 {
+	cpu = <&A57_1>;
+};
+
+&cpu_debug2 {
+	cpu = <&A53_0>;
+};
+
+&cpu_debug3 {
+	cpu = <&A53_1>;
+};
+
+&cpu_debug4 {
+	cpu = <&A53_2>;
+};
+
+&cpu_debug5 {
+	cpu = <&A53_3>;
+};
diff --git a/arch/arm64/boot/dts/arm/juno-r2.dts b/arch/arm64/boot/dts/arm/juno-r2.dts
index 218d0e4..38a8ad6 100644
--- a/arch/arm64/boot/dts/arm/juno-r2.dts
+++ b/arch/arm64/boot/dts/arm/juno-r2.dts
@@ -239,3 +239,27 @@
 &stm_out_port {
 	remote-endpoint = <&csys1_funnel_in_port0>;
 };
+
+&cpu_debug0 {
+	cpu = <&A72_0>;
+};
+
+&cpu_debug1 {
+	cpu = <&A72_1>;
+};
+
+&cpu_debug2 {
+	cpu = <&A53_0>;
+};
+
+&cpu_debug3 {
+	cpu = <&A53_1>;
+};
+
+&cpu_debug4 {
+	cpu = <&A53_2>;
+};
+
+&cpu_debug5 {
+	cpu = <&A53_3>;
+};
diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index bb2820e..9f37dbb 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -226,3 +226,27 @@
 		};
 	};
 };
+
+&cpu_debug0 {
+	cpu = <&A57_0>;
+};
+
+&cpu_debug1 {
+	cpu = <&A57_1>;
+};
+
+&cpu_debug2 {
+	cpu = <&A53_0>;
+};
+
+&cpu_debug3 {
+	cpu = <&A53_1>;
+};
+
+&cpu_debug4 {
+	cpu = <&A53_2>;
+};
+
+&cpu_debug5 {
+	cpu = <&A53_3>;
+};
-- 
2.7.4
