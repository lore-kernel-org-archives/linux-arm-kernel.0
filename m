From: linux-arm@overkiz.com (Boris BREZILLON)
Date: Sat, 12 May 2012 10:53:57 +0200
Subject: [PATCH 4/5] ARM: at91: add pmc clks definition into device tree
In-Reply-To: <1336812838-3649-1-git-send-email-linux-arm@overkiz.com>
References: <1336812838-3649-1-git-send-email-linux-arm@overkiz.com>
Message-ID: <1336812838-3649-5-git-send-email-linux-arm@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch defines some clks for at91sam9260 and sam9g20 SoC.
All peripherals clocks are not defined yet (only usart, GPIO).

---
 arch/arm/boot/dts/at91sam9260.dtsi |  299 +++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/at91sam9g20.dtsi |   44 ++++++
 2 files changed, 342 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index f4605ff..a5379cd 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -64,8 +64,305 @@
 			};
 
 			pmc: pmc at fffffc00 {
-				compatible = "atmel,at91rm9200-pmc";
+				compatible = "atmel,at91-pmc";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0xfffffc00 0x100>;
+				interrupts = <1 4>;
+
+				capabilities = <0xf031f77 0x1>; /*	SC{ER,DR,SR}, PC{ER,DR,SR}, MOR,
+													MCFR, PLL{AR,BR}, MCKR, PCK{0,1},
+													I{ER,DR,SR,MR}, PLLICPR */
+
+
+				slow: osc at 0 {
+					compatible = "atmel,at91-pmc-slow", "fixed-rate";
+					reg = <0>;
+					clock-frequency = <32768>;
+					#clock-cells = <0>;
+					clock-output-names = "slow";
+
+					characteristics {
+						output = <22000 42000>;
+					};
+				};
+
+				main: osc at 1 {
+					compatible = "atmel,at91-pmc-main", "fixed-rate";
+					reg = <1>;
+
+					#clock-cells = <0>;
+					clock-output-names = "main";
+
+					characteristics {
+						output = <3000000 20000000>;
+					};
+				};
+
+				plla: pll at 0 {
+					compatible = "atmel,at91-pmc-pll";
+					reg = <0>;
+
+					#clock-cells = <0>;
+					clocks = <&main>;
+					clock-output-names = "plla";
+
+					mask = <0xf8000000>;
+
+					characteristics {
+						input = <1000000 32000000>;
+						output = <
+								0 0 /* icpll = 0, out = 0 => no such conf*/
+								0 0 /* icpll = 0, out = 1 => no such conf*/
+								0 0 /* icpll = 0, out = 2 => no such conf*/
+								0 0 /* icpll = 0, out = 3 => no such conf*/
+								80000000 160000000 /* icpll = 1, out = 0 => 80 to 160MHz */
+								0 0 /* icpll = 1, out = 1 => no such conf*/
+								150000000 240000000 /* icpll = 1, out = 2 => 80 to 160MHz */
+								0 0 /* icpll = 1, out = 3 => no such conf*/
+							 >;
+					};
+
+				};
+
+				pllb: pll at 1 {
+					compatible = "atmel,at91-pmc-pll";
+					reg = <1>;
+
+					#clock-cells = <0>;
+					clocks = <&main>;
+					clock-output-names = "pllb";
+
+					mask = <0xf8000000>;
+
+					characteristics {
+						input = <1000000 32000000>;
+						output = <
+								0 0 /* icpll = 0, out = 0 => no such conf*/
+								0 0 /* icpll = 0, out = 1 => no such conf*/
+								0 0 /* icpll = 0, out = 2 => no such conf*/
+								0 0 /* icpll = 0, out = 3 => no such conf*/
+								80000000 160000000 /* icpll = 1, out = 0 => 80 to 160MHz */
+								0 0 /* icpll = 1, out = 1 => no such conf*/
+								150000000 240000000 /* icpll = 1, out = 2 => 80 to 160MHz */
+								0 0 /* icpll = 0, out = 3 => no such conf*/
+							 >;
+					};
+
+				};
+
+				pres: master at 0 {
+					compatible = "atmel,at91-pmc-pres";
+					offset = <0x2>;
+
+					#clock-cells = <0>;
+					clocks = <&slow>, <&main>, <&plla>, <&pllb>;
+					clock-output-names = "pres";
+				};
+
+				master: master at 1 {
+					compatible = "atmel,at91-pmc-master";
+					divisors = <1 2 4 6>;
+
+					#clock-cells = <0>;
+					clocks = <&pres>;
+					clock-output-names = "mck";
+
+					lookup at 0 {
+						compatible = "clk-lookup";
+						conid = "mck";
+					};
+
+					lookup at 1 {
+						compatible = "clk-lookup";
+						condid = "usart";
+						devid = "fffff200.serial";
+					};
+
+					characteristics {
+						output = <0 94500000>; /* master clock range at 1.65V*/
+					};
+
+				};
+
+				proc: sys at 0 {
+					compatible = "atmel,at91-pmc-proc";
+					divisor;
+
+					#clock-cells = <0>;
+					clocks = <&pres>;
+					clock-output-names = "proc";
+
+					characteristics {
+						output = <0 189000000>; /* proc clock range at 1.65V*/
+					};
+
+				};
+
+				prog0: sys at 8 {
+					compatible = "atmel,at91-pmc-prog", "atmel,at91-pmc-sys";
+					reg = <8>;
+					css-length = <2>;
+					pres-offset = <2>;
+
+					#clock-cells = <0>;
+					clocks = <&slow>, <&main>, <&plla>, <&pllb>;
+					clock-output-names = "prog0";
+
+				};
+
+				prog1: sys at 9 {
+					compatible = "atmel,at91-pmc-prog", "atmel,at91-pmc-sys";
+					reg = <9>;
+					css-length = <2>;
+					pres-offset = <2>;
+
+					#clock-cells = <0>;
+					clocks = <&slow>, <&main>, <&plla>, <&pllb>;
+					clock-output-names = "prog1";
+
+				};
+
+				usart0ck: periph at 6 {
+					compatible = "atmel,at91-pmc-periph";
+					reg = <6>;
+
+					#clock-cells = <0>;
+					clocks = <&master>;
+
+					clock-output-names = "fffb0000.serial";
+
+					lookup at 0 {
+						compatible = "clk-lookup";
+						conid = "usart";
+						devid = "fffb0000.serial";
+					};
+				};
+
+				usart1ck: periph at 7 {
+					compatible = "atmel,at91-pmc-periph";
+					reg = <7>;
+
+					#clock-cells = <0>;
+					clocks = <&master>;
+
+					clock-output-names = "fffb4000.serial";
+
+					lookup at 0 {
+						compatible = "clk-lookup";
+						conid = "usart";
+						devid = "fffb4000.serial";
+					};
+				};
+
+				usart2ck: periph at 8 {
+					compatible = "atmel,at91-pmc-periph";
+					reg = <8>;
+
+					#clock-cells = <0>;
+					clocks = <&master>;
+
+					clock-output-names = "fffb8000.serial";
+
+					lookup at 0 {
+						compatible = "clk-lookup";
+						conid = "usart";
+						devid = "fffb8000.serial";
+					};
+				};
+
+				usart3ck: periph at 23 {
+					compatible = "atmel,at91-pmc-periph";
+					reg = <23>;
+
+					#clock-cells = <0>;
+					clocks = <&master>;
+
+					clock-output-names = "fffd0000.serial";
+
+					lookup at 0 {
+						compatible = "clk-lookup";
+						conid = "usart";
+						devid = "fffd0000.serial";
+					};
+				};
+
+				usart4ck: periph at 24 {
+					compatible = "atmel,at91-pmc-periph";
+					reg = <24>;
+
+					#clock-cells = <0>;
+					clocks = <&master>;
+
+					clock-output-names = "fffd4000.serial";
+
+					lookup at 0 {
+						compatible = "clk-lookup";
+						conid = "usart";
+						devid = "fffd4000.serial";
+					};
+				};
+
+				usart5ck: periph at 25 {
+					compatible = "atmel,at91-pmc-periph";
+					reg = <25>;
+
+					#clock-cells = <0>;
+					clocks = <&master>;
+
+					clock-output-names = "fffd8000.serial";
+
+					lookup at 0 {
+						compatible = "clk-lookup";
+						conid = "usart";
+						devid = "fffd8000.serial";
+					};
+				};
+
+				pioAck: periph at 2 {
+					compatible = "atmel,at91-pmc-periph";
+					reg = <2>;
+
+					#clock-cells = <0>;
+					clocks = <&master>;
+
+					clock-output-names = "pioA";
+
+					lookup at 0 {
+						compatible = "clk-lookup";
+						conid = "pioA";
+					};
+				};
+
+				pioBck: periph at 3 {
+					compatible = "atmel,at91-pmc-periph";
+					reg = <3>;
+
+					#clock-cells = <0>;
+					clocks = <&master>;
+
+					clock-output-names = "pioB";
+
+					lookup at 0 {
+						compatible = "clk-lookup";
+						conid = "pioB";
+					};
+				};
+
+				pioCck: periph at 4 {
+					compatible = "atmel,at91-pmc-periph";
+					reg = <4>;
+
+					#clock-cells = <0>;
+					clocks = <&master>;
+
+					clock-output-names = "pioC";
+
+					lookup at 0 {
+						compatible = "clk-lookup";
+						conid = "pioC";
+					};
+				};
 			};
 
 			rstc at fffffd00 {
diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index 0eb1a75..ac80065 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -15,4 +15,48 @@
 	memory {
 		reg = <0x20000000 0x08000000>;
 	};
+
+	ahb {
+		apb {
+			pmc: pmc at fffffc00 {
+				plla: pll at 0 {
+
+					mask = <0xff000000>;
+
+					characteristics {
+						input = <2000000 32000000>;
+						output = <
+									745000000 800000000 /* icpll = 0, out = 0 => 745 to 800MHz */
+									695000000 750000000 /* icpll = 0, out = 1 => 695 to 750MHz */
+									645000000 700000000 /* icpll = 0, out = 2 => 645 to 700MHz */
+									595000000 650000000 /* icpll = 0, out = 3 => 595 to 650MHz */
+									545000000 600000000 /* icpll = 1, out = 0 => 545 to 600MHz */
+									495000000 550000000 /* icpll = 1, out = 1 => 495 to 550MHz */
+									445000000 500000000 /* icpll = 1, out = 2 => 445 to 500MHz */
+									400000000 450000000 /* icpll = 1, out = 3 => 400 to 450MHz */
+								 >;
+					};
+				};
+
+				pllb: pll at 1 {
+
+					mask = <0xffe00000>;
+
+					characteristics {
+						input = <2000000 32000000>;
+						output = <
+									30000000 100000000 /* icpll = 0, out = 0 => 30 to 100MHz */
+									0 0 /* icpll = 0, out = 1 => no such conf */
+									0 0 /* icpll = 0, out = 2 => no such conf */
+									0 0 /* icpll = 0, out = 3 => no such conf */
+									0 0 /* icpll = 1, out = 0 => no such conf */
+									0 0 /* icpll = 1, out = 1 => no such conf */
+									0 0 /* icpll = 1, out = 2 => no such conf */
+									0 0 /* icpll = 1, out = 3 => no such conf */
+								 >;
+					};
+				};
+			};
+		};
+	};
 };
-- 
1.7.9.5
