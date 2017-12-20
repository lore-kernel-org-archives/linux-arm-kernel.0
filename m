From: joel@jms.id.au (Joel Stanley)
Date: Wed, 20 Dec 2017 13:53:12 +1030
Subject: [PATCH v3 04/20] ARM: dts: aspeed: Add proper clock references
In-Reply-To: <20171220032328.30584-1-joel@jms.id.au>
References: <20171220032328.30584-1-joel@jms.id.au>
Message-ID: <20171220032328.30584-5-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This device tree will break existing kernels that do not have the clk
patches applied (no clocksource, as we don't know the speed of the APB
clock.  You can boot if you pass a lpj value on the command line, but
won't have a uart).

Older device trees running with the newer kernel will function as well
as pre-4.16 kernels. That is, that some IP blocks (i2c, pwm/tach, adc)
will not work as the kernel lacks reset controller and clock enabling.

This is being changed as existing device trees use fixed-clocks in order
to boot without a clk driver. The newly added clk driver provides proper
clock support, including gating, so we move the device trees over to
properly request clocks.

The SCU compatible string is updated as the g4-scu string made it into
the tree before we decided on aspeed,astX000-<ip> as the format for the
strings. The old string will be removed from the bindings in a future
patch.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 v3:
  - Add reset phandle to ADC node
 v2:
  - Add more detail to the commit message

adc reset

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 103 ++++++++++++++++----------------------
 arch/arm/boot/dts/aspeed-g5.dtsi | 105 ++++++++++++++++-----------------------
 2 files changed, 84 insertions(+), 124 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 9422f9cb1e11..b938759f799e 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "skeleton.dtsi"
+#include <dt-bindings/clock/aspeed-clock.h>
 
 / {
 	model = "Aspeed BMC";
@@ -106,47 +107,12 @@
 			ranges;
 
 			syscon: syscon at 1e6e2000 {
-				compatible = "aspeed,g4-scu", "syscon", "simple-mfd";
+				compatible = "aspeed,ast2400-scu", "syscon", "simple-mfd";
 				reg = <0x1e6e2000 0x1a8>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-
-                                clk_clkin: clk_clkin {
-                                        #clock-cells = <0>;
-                                        compatible = "fixed-clock";
-                                        clock-frequency = <48000000>;
-                                };
-
-                                clk_hpll: clk_hpll at 70 {
-                                        #clock-cells = <0>;
-                                        compatible = "aspeed,g4-hpll-clock", "fixed-clock";
-                                        reg = <0x70>;
-                                        clocks = <&clk_clkin>;
-                                        clock-frequency = <384000000>;
-                                };
-
-                                clk_ahb: clk_ahb at 70 {
-                                        #clock-cells = <0>;
-                                        compatible = "aspeed,g4-ahb-clock", "fixed-clock";
-                                        reg = <0x70>;
-                                        clocks = <&clk_hpll>;
-                                        clock-frequency = <192000000>;
-                                };
-
-                                clk_apb: clk_apb at 8 {
-                                        #clock-cells = <0>;
-                                        compatible = "aspeed,g4-apb-clock", "fixed-clock";
-                                        reg = <0x08>;
-                                        clocks = <&clk_hpll>;
-                                        clock-frequency = <48000000>;
-                                };
-
-                                clk_uart: clk_uart at 2c{
-                                        #clock-cells = <0>;
-                                        compatible = "aspeed,g4-uart-clock", "fixed-clock";
-                                        reg = <0x2c>;
-                                        clock-frequency = <24000000>;
-                                };
+				#clock-cells = <1>;
+				#reset-cells = <1>;
 
 				pinctrl: pinctrl {
 					compatible = "aspeed,g4-pinctrl";
@@ -156,7 +122,8 @@
 			adc: adc at 1e6e9000 {
 				compatible = "aspeed,ast2400-adc";
 				reg = <0x1e6e9000 0xb0>;
-				clocks = <&clk_apb>;
+				clocks = <&syscon ASPEED_CLK_APB>;
+				resets = <&syscon ASPEED_RESET_ADC>;
 				#io-channel-cells = <1>;
 				status = "disabled";
 			};
@@ -181,7 +148,7 @@
 				compatible = "aspeed,ast2400-timer";
 				reg = <0x1e782000 0x90>;
 				interrupts = <16 17 18 35 36 37 38 39>;
-				clocks = <&clk_apb>;
+				clocks = <&syscon ASPEED_CLK_APB>;
 				clock-names = "PCLK";
 			};
 
@@ -190,7 +157,7 @@
 				reg = <0x1e783000 0x20>;
 				reg-shift = <2>;
 				interrupts = <9>;
-				clocks = <&clk_uart>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART1CLK>;
 				no-loopback-test;
 				status = "disabled";
 			};
@@ -200,7 +167,7 @@
 				reg = <0x1e784000 0x20>;
 				reg-shift = <2>;
 				interrupts = <10>;
-				clocks = <&clk_uart>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART5CLK>;
 				no-loopback-test;
 				status = "disabled";
 			};
@@ -219,8 +186,8 @@
 				compatible = "aspeed,ast2400-vuart";
 				reg = <0x1e787000 0x40>;
 				reg-shift = <2>;
-				interrupts = <10>;
-				clocks = <&clk_uart>;
+				interrupts = <8>;
+				clocks = <&syscon ASPEED_CLK_APB>;
 				no-loopback-test;
 				status = "disabled";
 			};
@@ -265,7 +232,7 @@
 				reg = <0x1e78d000 0x20>;
 				reg-shift = <2>;
 				interrupts = <32>;
-				clocks = <&clk_uart>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART2CLK>;
 				no-loopback-test;
 				status = "disabled";
 			};
@@ -275,7 +242,7 @@
 				reg = <0x1e78e000 0x20>;
 				reg-shift = <2>;
 				interrupts = <33>;
-				clocks = <&clk_uart>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART3CLK>;
 				no-loopback-test;
 				status = "disabled";
 			};
@@ -285,7 +252,7 @@
 				reg = <0x1e78f000 0x20>;
 				reg-shift = <2>;
 				interrupts = <34>;
-				clocks = <&clk_uart>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART4CLK>;
 				no-loopback-test;
 				status = "disabled";
 			};
@@ -316,7 +283,8 @@
 
 		reg = <0x40 0x40>;
 		compatible = "aspeed,ast2400-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <0>;
 		interrupt-parent = <&i2c_ic>;
@@ -331,7 +299,8 @@
 
 		reg = <0x80 0x40>;
 		compatible = "aspeed,ast2400-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <1>;
 		interrupt-parent = <&i2c_ic>;
@@ -346,7 +315,8 @@
 
 		reg = <0xc0 0x40>;
 		compatible = "aspeed,ast2400-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <2>;
 		interrupt-parent = <&i2c_ic>;
@@ -362,7 +332,8 @@
 
 		reg = <0x100 0x40>;
 		compatible = "aspeed,ast2400-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <3>;
 		interrupt-parent = <&i2c_ic>;
@@ -378,7 +349,8 @@
 
 		reg = <0x140 0x40>;
 		compatible = "aspeed,ast2400-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <4>;
 		interrupt-parent = <&i2c_ic>;
@@ -394,7 +366,8 @@
 
 		reg = <0x180 0x40>;
 		compatible = "aspeed,ast2400-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <5>;
 		interrupt-parent = <&i2c_ic>;
@@ -410,7 +383,8 @@
 
 		reg = <0x1c0 0x40>;
 		compatible = "aspeed,ast2400-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <6>;
 		interrupt-parent = <&i2c_ic>;
@@ -426,7 +400,8 @@
 
 		reg = <0x300 0x40>;
 		compatible = "aspeed,ast2400-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <7>;
 		interrupt-parent = <&i2c_ic>;
@@ -442,7 +417,8 @@
 
 		reg = <0x340 0x40>;
 		compatible = "aspeed,ast2400-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <8>;
 		interrupt-parent = <&i2c_ic>;
@@ -458,7 +434,8 @@
 
 		reg = <0x380 0x40>;
 		compatible = "aspeed,ast2400-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <9>;
 		interrupt-parent = <&i2c_ic>;
@@ -474,7 +451,8 @@
 
 		reg = <0x3c0 0x40>;
 		compatible = "aspeed,ast2400-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <10>;
 		interrupt-parent = <&i2c_ic>;
@@ -490,7 +468,8 @@
 
 		reg = <0x400 0x40>;
 		compatible = "aspeed,ast2400-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <11>;
 		interrupt-parent = <&i2c_ic>;
@@ -506,7 +485,8 @@
 
 		reg = <0x440 0x40>;
 		compatible = "aspeed,ast2400-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <12>;
 		interrupt-parent = <&i2c_ic>;
@@ -522,7 +502,8 @@
 
 		reg = <0x480 0x40>;
 		compatible = "aspeed,ast2400-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <13>;
 		interrupt-parent = <&i2c_ic>;
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 069f13df19d1..1af600b48475 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "skeleton.dtsi"
+#include <dt-bindings/clock/aspeed-clock.h>
 
 / {
 	model = "Aspeed BMC";
@@ -140,55 +141,18 @@
 			ranges;
 
 			syscon: syscon at 1e6e2000 {
-				compatible = "aspeed,g5-scu", "syscon", "simple-mfd";
+				compatible = "aspeed,ast2500-scu", "syscon", "simple-mfd";
 				reg = <0x1e6e2000 0x1a8>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-
-				clk_clkin: clk_clkin at 70 {
-					#clock-cells = <0>;
-					compatible = "aspeed,g5-clkin-clock", "fixed-clock";
-					reg = <0x70>;
-					clock-frequency = <24000000>;
-				};
-
-				clk_hpll: clk_hpll at 24 {
-					#clock-cells = <0>;
-					compatible = "aspeed,g5-hpll-clock", "fixed-clock";
-					reg = <0x24>;
-					clocks = <&clk_clkin>;
-					clock-frequency = <792000000>;
-				};
-
-				clk_ahb: clk_ahb at 70 {
-					#clock-cells = <0>;
-					compatible = "aspeed,g5-ahb-clock", "fixed-clock";
-					reg = <0x70>;
-					clocks = <&clk_hpll>;
-					clock-frequency = <198000000>;
-				};
-
-				clk_apb: clk_apb at 8 {
-					#clock-cells = <0>;
-					compatible = "aspeed,g5-apb-clock", "fixed-clock";
-					reg = <0x08>;
-					clocks = <&clk_hpll>;
-					clock-frequency = <24750000>;
-				};
-
-				clk_uart: clk_uart at 2c {
-					#clock-cells = <0>;
-					compatible = "aspeed,uart-clock", "fixed-clock";
-					reg = <0x2c>;
-					clock-frequency = <24000000>;
-				};
+				#clock-cells = <1>;
+				#reset-cells = <1>;
 
 				pinctrl: pinctrl {
 					compatible = "aspeed,g5-pinctrl";
 					aspeed,external-nodes = <&gfx &lhc>;
 
 				};
-
 			};
 
 			gfx: display at 1e6e6000 {
@@ -200,7 +164,8 @@
 			adc: adc at 1e6e9000 {
 				compatible = "aspeed,ast2500-adc";
 				reg = <0x1e6e9000 0xb0>;
-				clocks = <&clk_apb>;
+				clocks = <&syscon ASPEED_CLK_APB>;
+				resets = <&syscon ASPEED_RESET_ADC>;
 				#io-channel-cells = <1>;
 				status = "disabled";
 			};
@@ -225,7 +190,7 @@
 				compatible = "aspeed,ast2400-timer";
 				reg = <0x1e782000 0x90>;
 				interrupts = <16 17 18 35 36 37 38 39>;
-				clocks = <&clk_apb>;
+				clocks = <&syscon ASPEED_CLK_APB>;
 				clock-names = "PCLK";
 			};
 
@@ -234,7 +199,7 @@
 				reg = <0x1e783000 0x20>;
 				reg-shift = <2>;
 				interrupts = <9>;
-				clocks = <&clk_uart>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART1CLK>;
 				no-loopback-test;
 				status = "disabled";
 			};
@@ -244,7 +209,7 @@
 				reg = <0x1e784000 0x20>;
 				reg-shift = <2>;
 				interrupts = <10>;
-				clocks = <&clk_uart>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART5CLK>;
 				no-loopback-test;
 				status = "disabled";
 			};
@@ -269,8 +234,8 @@
 				compatible = "aspeed,ast2500-vuart";
 				reg = <0x1e787000 0x40>;
 				reg-shift = <2>;
-				interrupts = <10>;
-				clocks = <&clk_uart>;
+				interrupts = <8>;
+				clocks = <&syscon ASPEED_CLK_APB>;
 				no-loopback-test;
 				status = "disabled";
 			};
@@ -317,7 +282,7 @@
 				reg = <0x1e78d000 0x20>;
 				reg-shift = <2>;
 				interrupts = <32>;
-				clocks = <&clk_uart>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART2CLK>;
 				no-loopback-test;
 				status = "disabled";
 			};
@@ -327,7 +292,7 @@
 				reg = <0x1e78e000 0x20>;
 				reg-shift = <2>;
 				interrupts = <33>;
-				clocks = <&clk_uart>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART3CLK>;
 				no-loopback-test;
 				status = "disabled";
 			};
@@ -337,7 +302,7 @@
 				reg = <0x1e78f000 0x20>;
 				reg-shift = <2>;
 				interrupts = <34>;
-				clocks = <&clk_uart>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART4CLK>;
 				no-loopback-test;
 				status = "disabled";
 			};
@@ -368,7 +333,8 @@
 
 		reg = <0x40 0x40>;
 		compatible = "aspeed,ast2500-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <0>;
 		interrupt-parent = <&i2c_ic>;
@@ -383,7 +349,8 @@
 
 		reg = <0x80 0x40>;
 		compatible = "aspeed,ast2500-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <1>;
 		interrupt-parent = <&i2c_ic>;
@@ -398,7 +365,8 @@
 
 		reg = <0xc0 0x40>;
 		compatible = "aspeed,ast2500-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <2>;
 		interrupt-parent = <&i2c_ic>;
@@ -414,7 +382,8 @@
 
 		reg = <0x100 0x40>;
 		compatible = "aspeed,ast2500-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <3>;
 		interrupt-parent = <&i2c_ic>;
@@ -430,7 +399,8 @@
 
 		reg = <0x140 0x40>;
 		compatible = "aspeed,ast2500-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <4>;
 		interrupt-parent = <&i2c_ic>;
@@ -446,7 +416,8 @@
 
 		reg = <0x180 0x40>;
 		compatible = "aspeed,ast2500-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <5>;
 		interrupt-parent = <&i2c_ic>;
@@ -462,7 +433,8 @@
 
 		reg = <0x1c0 0x40>;
 		compatible = "aspeed,ast2500-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <6>;
 		interrupt-parent = <&i2c_ic>;
@@ -478,7 +450,8 @@
 
 		reg = <0x300 0x40>;
 		compatible = "aspeed,ast2500-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <7>;
 		interrupt-parent = <&i2c_ic>;
@@ -494,7 +467,8 @@
 
 		reg = <0x340 0x40>;
 		compatible = "aspeed,ast2500-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <8>;
 		interrupt-parent = <&i2c_ic>;
@@ -510,7 +484,8 @@
 
 		reg = <0x380 0x40>;
 		compatible = "aspeed,ast2500-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <9>;
 		interrupt-parent = <&i2c_ic>;
@@ -526,7 +501,8 @@
 
 		reg = <0x3c0 0x40>;
 		compatible = "aspeed,ast2500-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <10>;
 		interrupt-parent = <&i2c_ic>;
@@ -542,7 +518,8 @@
 
 		reg = <0x400 0x40>;
 		compatible = "aspeed,ast2500-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <11>;
 		interrupt-parent = <&i2c_ic>;
@@ -558,7 +535,8 @@
 
 		reg = <0x440 0x40>;
 		compatible = "aspeed,ast2500-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <12>;
 		interrupt-parent = <&i2c_ic>;
@@ -574,7 +552,8 @@
 
 		reg = <0x480 0x40>;
 		compatible = "aspeed,ast2500-i2c-bus";
-		clocks = <&clk_apb>;
+		clocks = <&syscon ASPEED_CLK_APB>;
+		resets = <&syscon ASPEED_RESET_I2C>;
 		bus-frequency = <100000>;
 		interrupts = <13>;
 		interrupt-parent = <&i2c_ic>;
-- 
2.15.1
