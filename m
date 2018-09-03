From: Anson.Huang@nxp.com (Anson Huang)
Date: Mon,  3 Sep 2018 09:45:41 +0800
Subject: [PATCH V2] ARM: dts: imx7s: enable cpuidle driver
Message-ID: <1535939141-14338-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable cpuidle for i.MX7S/D using generic ARM cpuidle
driver, below 2 idle states enabled:

1. ARM WFI;
2. SoC WAIT mode.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	replace uppercase with lowercase.
 arch/arm/boot/dts/imx7d.dtsi |  1 +
 arch/arm/boot/dts/imx7s.dtsi | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 7cbc2ff..53eb371 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -20,6 +20,7 @@
 			reg = <1>;
 			clock-frequency = <996000000>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			cpu-idle-states = <&cpu_sleep_wait>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 93884ce..d3f6488 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -54,6 +54,19 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		idle-states {
+			entry-method = "psci";
+
+			cpu_sleep_wait: cpu-sleep-wait {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x0010000>;
+				local-timer-stop;
+				entry-latency-us = <100>;
+				exit-latency-us = <50>;
+				min-residency-us = <1000>;
+			};
+		};
+
 		cpu0: cpu at 0 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
@@ -61,6 +74,7 @@
 			clock-frequency = <792000000>;
 			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clks IMX7D_CLK_ARM>;
+			cpu-idle-states = <&cpu_sleep_wait>;
 		};
 	};
 
-- 
2.7.4
