From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 13 Apr 2016 07:55:47 +0800
Subject: [PATCH v4 11/16] arm64: dts: add Hi6220's stub clock node
In-Reply-To: <1460505352-13157-1-git-send-email-guodong.xu@linaro.org>
References: <1460505352-13157-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1460505352-13157-12-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leo Yan <leo.yan@linaro.org>

Enable SRAM node and stub clock node for Hi6220, which uses mailbox
channel 1 for CPU's frequency change.

Furthermore, add the CPU clock phandle in CPU's node and using
operating-points-v2 to register operating points. So can be used by
cpufreq-dt driver.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
Acked-by: Wei Xu <xuwei5@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 56 +++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index d71c51f..3a665ef 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -82,6 +82,11 @@
 			device_type = "cpu";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			clocks = <&stub_clock 0>;
+			operating-points-v2 = <&cpu_opp_table>;
+			cooling-min-level = <4>;
+			cooling-max-level = <0>;
+			#cooling-cells = <2>; /* min followed by max */
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 		};
 
@@ -90,6 +95,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 		};
 
@@ -98,6 +104,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
+			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 		};
 
@@ -106,6 +113,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
+			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 		};
 
@@ -114,6 +122,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 		};
 
@@ -122,6 +131,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x101>;
 			enable-method = "psci";
+			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 		};
 
@@ -130,6 +140,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x102>;
 			enable-method = "psci";
+			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 		};
 
@@ -138,10 +149,42 @@
 			device_type = "cpu";
 			reg = <0x0 0x103>;
 			enable-method = "psci";
+			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 		};
 	};
 
+	cpu_opp_table: cpu_opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <208000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <500000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <432000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <500000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <729000000>;
+			opp-microvolt = <1090000>;
+			clock-latency-ns = <500000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <960000000>;
+			opp-microvolt = <1180000>;
+			clock-latency-ns = <500000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1330000>;
+			clock-latency-ns = <500000>;
+		};
+	};
+
 	gic: interrupt-controller at f6801000 {
 		compatible = "arm,gic-400";
 		reg = <0x0 0xf6801000 0 0x1000>, /* GICD */
@@ -169,6 +212,11 @@
 		#size-cells = <2>;
 		ranges;
 
+		sram: sram at fff80000 {
+			compatible = "hisilicon,hi6220-sramctrl", "syscon";
+			reg = <0x0 0xfff80000 0x0 0x12000>;
+		};
+
 		ao_ctrl: ao_ctrl at f7800000 {
 			compatible = "hisilicon,hi6220-aoctrl", "syscon";
 			reg = <0x0 0xf7800000 0x0 0x2000>;
@@ -194,6 +242,14 @@
 			#clock-cells = <1>;
 		};
 
+		stub_clock: stub_clock {
+			compatible = "hisilicon,hi6220-stub-clk";
+			hisilicon,hi6220-clk-sram = <&sram>;
+			#clock-cells = <1>;
+			mbox-names = "mbox-tx";
+			mboxes = <&mailbox 1 0 11>;
+		};
+
 		uart0: uart at f8015000 {	/* console */
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xf8015000 0x0 0x1000>;
-- 
1.9.1
