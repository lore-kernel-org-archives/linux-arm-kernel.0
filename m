From: pi-cheng.chen@linaro.org (pi-cheng.chen)
Date: Wed,  4 Mar 2015 16:49:16 +0800
Subject: [PATCH v2 4/4] ARM64: dts: mediatek: add cpufreq dts for MT8173 SoC
In-Reply-To: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
References: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
Message-ID: <1425458956-20665-5-git-send-email-pi-cheng.chen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch illustrates how to enable mtk-cpufreq driver for a Mediatek SoC in
device tree using MT8173 as an example. This patch was tested on MT8173 EVB
with several patches which are not yet posted on public mailing list.

Signed-off-by: pi-cheng.chen <pi-cheng.chen@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 10 ++++++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 25 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index b57f095..cc3b954 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -417,3 +417,13 @@
 	status = "okay";
 	clock-frequency = <100000>;
 };
+
+&cpu0 {
+	cpu-supply = <&mt6397_vpca15_reg>;
+	voltage-tolerance = <1>;
+};
+
+&cpu2 {
+	proc-supply = <&da9211_vcpu_reg>;
+	sram-supply = <&mt6397_vsramca7_reg>;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index dd0a445..4ad75a6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -51,6 +51,16 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x000>;
+			clocks = <&infracfg INFRA_CA53SEL>;
+			operating-points = <
+				1508000 1109000
+				1404000	1083000
+				1183000	1028000
+				1105000	1009000
+				1001000	 983000
+				 702000	 908000
+				 507000	 859000
+			>;
 		};
 
 		cpu1: cpu at 1 {
@@ -65,6 +75,16 @@
 			compatible = "arm,cortex-a57";
 			reg = <0x100>;
 			enable-method = "psci";
+			clocks = <&infracfg INFRA_CA57SEL>;
+			operating-points = <
+				1807000	1089000
+				1612000	1049000
+				1404000	1007000
+				1209000	 968000
+				1001000	 927000
+				 702000	 867000
+				 507000	 828000
+			>;
 		};
 
 		cpu3: cpu at 101 {
@@ -75,6 +95,11 @@
 		};
 	};
 
+	cpufreq {
+		compatible = "mediatek,mtk-cpufreq";
+		clocks = <&apmixedsys APMIXED_MAINPLL>;
+	};
+
 	psci {
 		compatible = "arm,psci";
 		method = "smc";
-- 
1.9.1
