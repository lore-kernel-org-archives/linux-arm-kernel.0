From: leo.yan@linaro.org (Leo Yan)
Date: Mon,  3 Aug 2015 09:13:38 +0800
Subject: [PATCH v3 5/5] arm64: dts: add Hi6220's stub clock node
In-Reply-To: <1438564418-15948-1-git-send-email-leo.yan@linaro.org>
References: <1438564418-15948-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1438564418-15948-6-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable SRAM node and stub clock node for Hi6220; furthermore
add the CPU's clock so it will be used by cpufreq-dt driver.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index b42a9b7..94b8310 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -57,6 +57,17 @@
 			device_type = "cpu";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			clocks = <&stub_clock 0>;
+			clock-latency = <0>;
+			operating-points = <
+				/* kHz */
+				1200000  0
+				960000   0
+				729000   0
+				432000   0
+				208000   0
+			>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu1: cpu at 1 {
@@ -136,6 +147,11 @@
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
@@ -160,6 +176,13 @@
 			#clock-cells = <1>;
 		};
 
+		stub_clock: stub_clock {
+			compatible = "hisilicon,hi6220-stub-clk";
+			hisilicon,hi6220-clk-sram = <&sram>;
+			#clock-cells = <1>;
+			mboxes = <&mailbox 1>;
+		};
+
 		uart0: uart at f8015000 {	/* console */
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xf8015000 0x0 0x1000>;
-- 
1.9.1
