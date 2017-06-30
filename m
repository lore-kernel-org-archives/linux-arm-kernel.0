From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 30 Jun 2017 10:56:06 +0100
Subject: [PATCH 6/8] arm64: dts: allwinner: a64: add SCPI sensors support
In-Reply-To: <20170630095608.24943-1-andre.przywara@arm.com>
References: <20170630095608.24943-1-andre.przywara@arm.com>
Message-ID: <20170630095608.24943-7-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SCPI protocol allows various sensors to be exposed to the OS. The
list of supported sensors (and their kind) is provided by the SCPI
provider, which is in ARM Trusted Firmware. The current implementation
exports the temperature sensors, for instance.
Since the temperature sensor requires a clock to be running, we set
a fixed clock rate for this particular clock to prevent the Linux driver
from turning it off.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 58c3675..7cb1b04 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -163,6 +163,11 @@
 				clock-output-names = "cpu_clk";
 			};
 		};
+
+		scpi_sensors0: sensors {
+			compatible = "arm,scpi-sensors";
+			#thermal-sensor-cells = <1>;
+		};
 	};
 
 	soc {
@@ -307,6 +312,8 @@
 			clock-names = "hosc", "losc";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			assigned-clocks = <&ccu CLK_THS>;
+			assigned-clock-rates = <4000000>;
 		};
 
 		pio: pinctrl at 1c20800 {
-- 
2.9.0
