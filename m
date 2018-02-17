From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Sun, 18 Feb 2018 03:54:41 +0800
Subject: [PATCH v3 06/15] arm64: dts: mt7622: add cpufreq related device nodes
In-Reply-To: <cover.1518895232.git.sean.wang@mediatek.com>
References: <cover.1518895232.git.sean.wang@mediatek.com>
Message-ID: <2cf761c2a20a8ff8a9208ddf3872f10f6f3198f5.1518895232.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add clocks, regulators and opp information into cpu nodes.
In addition, the power supply for cpu nodes is deployed on
mt7622-rfb1 board.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 12 +++++++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi     | 52 ++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index 42bd3a4..b387865 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -20,6 +20,18 @@
 		bootargs = "console=ttyS0,115200n1";
 	};
 
+	cpus {
+		cpu at 0 {
+			proc-supply = <&mt6380_vcpu_reg>;
+			sram-supply = <&mt6380_vm_reg>;
+		};
+
+		cpu at 1 {
+			proc-supply = <&mt6380_vcpu_reg>;
+			sram-supply = <&mt6380_vm_reg>;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys-polled";
 		poll-interval = <100>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index c387c4c..7256879 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -18,6 +18,50 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	cpu_opp_table: opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp-300000000 {
+			opp-hz = /bits/ 64 <30000000>;
+			opp-microvolt = <950000>;
+		};
+
+		opp-437500000 {
+			opp-hz = /bits/ 64 <437500000>;
+			opp-microvolt = <1000000>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1050000>;
+		};
+
+		opp-812500000 {
+			opp-hz = /bits/ 64 <812500000>;
+			opp-microvolt = <1100000>;
+		};
+
+		opp-1025000000 {
+			opp-hz = /bits/ 64 <1025000000>;
+			opp-microvolt = <1150000>;
+		};
+
+		opp-1137500000 {
+			opp-hz = /bits/ 64 <1137500000>;
+			opp-microvolt = <1200000>;
+		};
+
+		opp-1262500000 {
+			opp-hz = /bits/ 64 <1262500000>;
+			opp-microvolt = <1250000>;
+		};
+
+		opp-1350000000 {
+			opp-hz = /bits/ 64 <1350000000>;
+			opp-microvolt = <1310000>;
+		};
+	};
+
 	cpus {
 		#address-cells = <2>;
 		#size-cells = <0>;
@@ -26,6 +70,10 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0 0x0>;
+			clocks = <&infracfg CLK_INFRA_MUX1_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAIN_CORE_EN>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cpu_opp_table>;
 			enable-method = "psci";
 			clock-frequency = <1300000000>;
 		};
@@ -34,6 +82,10 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0 0x1>;
+			clocks = <&infracfg CLK_INFRA_MUX1_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAIN_CORE_EN>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cpu_opp_table>;
 			enable-method = "psci";
 			clock-frequency = <1300000000>;
 		};
-- 
2.7.4
