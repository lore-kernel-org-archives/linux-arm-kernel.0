From: wxt@rock-chips.com (Caesar Wang)
Date: Wed,  6 Jul 2016 16:20:54 +0800
Subject: [PATCH] arm64: dts: rockchip: Add idle-states to device tree for
 rk3399
Message-ID: <1467793254-10808-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the rk3399 ATF had been supported on ARM github [0], so we can add
idle-states for rk3399.
This patch adds idle-states bindings data collected through tests
experiments (latency and energy consumption) on rk3399 evb2 board.

You can see detail idle-states definitions on document [1].

* arm,psci-suspend-param: power_state parameter to pass to the PSCI
  suspend call.
* entry-latency: Worst case latency required to enter the idle state. The
  exit-latency may be guaranteed only after entry-latency has passed.
* min-residency: Minimum period, including preparation and entry, for a
  given idle state to be worthwhile energywise
* min-residency: Minimum period, including preparation and entry, for a
  given idle state to be worthwhile energywise.

[0]:
https://github.com/ARM-software/arm-trusted-firmware
[1]:
Documentation/devicetree/bindings/arm/psci.txt
Documentation/devicetree/bindings/arm/idle-states.txt

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index a6dd623..12ce265 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -101,6 +101,18 @@
 			};
 		};
 
+		idle-states {
+			entry-method = "psci";
+			cpu_sleep: cpu-sleep-0 {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x0010000>;
+				entry-latency-us = <350>;
+				exit-latency-us = <600>;
+				min-residency-us = <1150>;
+			};
+		};
+
 		cpu_l0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
@@ -108,6 +120,7 @@
 			enable-method = "psci";
 			#cooling-cells = <2>; /* min followed by max */
 			clocks = <&cru ARMCLKL>;
+			cpu-idle-states = <&cpu_sleep>;
 		};
 
 		cpu_l1: cpu at 1 {
@@ -116,6 +129,7 @@
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			clocks = <&cru ARMCLKL>;
+			cpu-idle-states = <&cpu_sleep>;
 		};
 
 		cpu_l2: cpu at 2 {
@@ -124,6 +138,7 @@
 			reg = <0x0 0x2>;
 			enable-method = "psci";
 			clocks = <&cru ARMCLKL>;
+			cpu-idle-states = <&cpu_sleep>;
 		};
 
 		cpu_l3: cpu at 3 {
@@ -132,6 +147,7 @@
 			reg = <0x0 0x3>;
 			enable-method = "psci";
 			clocks = <&cru ARMCLKL>;
+			cpu-idle-states = <&cpu_sleep>;
 		};
 
 		cpu_b0: cpu at 100 {
@@ -141,6 +157,7 @@
 			enable-method = "psci";
 			#cooling-cells = <2>; /* min followed by max */
 			clocks = <&cru ARMCLKB>;
+			cpu-idle-states = <&cpu_sleep>;
 		};
 
 		cpu_b1: cpu at 101 {
@@ -149,6 +166,7 @@
 			reg = <0x0 0x101>;
 			enable-method = "psci";
 			clocks = <&cru ARMCLKB>;
+			cpu-idle-states = <&cpu_sleep>;
 		};
 	};
 
-- 
1.9.1
