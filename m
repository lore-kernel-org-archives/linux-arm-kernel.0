From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 21 Mar 2014 08:00:04 +0000
Subject: [PATCH 1/2] ARM: STi: stih416: Add support for the FSM Serial Flash
 Controller
Message-ID: <1395388805-15840-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we add the necessary device nodes required for successful device
probing and Pinctrl setup for the FSM when booting on an STiH416 (Orly2).

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
Acked-by Angus Clark <angus.clark@st.com>
Acked-by: Brian Norris <computersforpeace@gmail.com>
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih416-pinctrl.dtsi | 13 +++++++++++++
 arch/arm/boot/dts/stih416.dtsi         | 13 +++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/stih416-pinctrl.dtsi b/arch/arm/boot/dts/stih416-pinctrl.dtsi
index b29ff4b..81df8e7 100644
--- a/arch/arm/boot/dts/stih416-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih416-pinctrl.dtsi
@@ -210,6 +210,19 @@
 					};
 				};
 			};
+
+			fsm {
+				pinctrl_fsm: fsm {
+					st,pins {
+						spi-fsm-clk  = <&PIO12 2 ALT1 OUT>;
+						spi-fsm-cs   = <&PIO12 3 ALT1 OUT>;
+						spi-fsm-mosi = <&PIO12 4 ALT1 OUT>;
+						spi-fsm-miso = <&PIO12 5 ALT1 IN>;
+						spi-fsm-hol  = <&PIO12 6 ALT1 OUT>;
+						spi-fsm-wp   = <&PIO12 7 ALT1 OUT>;
+					};
+				};
+			};
 		};
 
 		pin-controller-rear {
diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index b7ab47b..1e24b9e 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -145,5 +145,18 @@
 
 			status		= "disabled";
 		};
+
+		/* FSM */
+		spifsm: spifsm at fe902000 {
+			compatible	   = "st,spi-fsm";
+			reg		   = <0xfe902000 0x1000>;
+			pinctrl-0	   = <&pinctrl_fsm>;
+
+			st,syscfg	   = <&syscfg_rear>;
+			st,boot-device-reg = <0x958>;
+			st,boot-device-spi = <0x1a>;
+
+			status = "disabled";
+		};
 	};
 };
-- 
1.8.3.2
