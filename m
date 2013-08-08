From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu,  8 Aug 2013 09:19:17 +0200
Subject: [PATCH v3 17/19] clk: at91: add PMC clk device tree binding doc.
In-Reply-To: <1375937608-3773-1-git-send-email-b.brezillon@overkiz.com>
References: <1375937608-3773-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1375946357-9775-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds new at91 clks dt bindings documentation.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 .../devicetree/bindings/clock/at91-clock.txt       |  312 ++++++++++++++++++++
 1 file changed, 312 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/at91-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
new file mode 100644
index 0000000..04739da
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
@@ -0,0 +1,312 @@
+Device Tree Clock bindings for arch-at91
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : shall be one of the following:
+	"atmel,at91rm9200-pmc" or
+	"atmel,at91sam9g45-pmc" or
+	"atmel,at91sam9n12-pmc" or
+	"atmel,at91sam9x5-pmc" or
+	"atmel,at91sam9g35-pmc" or
+	"atmel,sama5d3-pmc":
+		at91 PMC (Power Management Controller)
+		All at91 specific clocks (clocks defined below) must be child
+		node of the PMC node.
+
+	"atmel,at91rm9200-clk-main":
+		at91 main oscillator
+
+	"atmel,at91rm9200-clk-master" or
+	"atmel,at91sam9x5-clk-master":
+		at91 master clock
+
+	"atmel,at91sam9x5-clk-peripheral" or
+	"atmel,at91rm9200-clk-peripheral":
+		at91 peripheral clocks
+
+	"atmel,at91rm9200-clk-pll" or
+	"atmel,at91sam9g45-clk-pll" or
+	"atmel,at91sam9g20-clk-pllb" or
+	"atmel,sama5d3-clk-pll":
+		at91 pll clocks
+
+	"atmel,at91sam9x5-clk-plldiv":
+		at91 plla divisor
+
+	"atmel,at91rm9200-clk-programmable" or
+	"atmel,at91sam9g45-clk-programmable" or
+	"atmel,at91sam9x5-clk-programmable":
+		at91 programmable clocks
+
+	"atmel,at91sam9x5-clk-smd":
+		at91 SMD (Soft Modem) clock
+
+	"atmel,at91rm9200-clk-system":
+		at91 system clocks
+
+	"atmel,at91rm9200-clk-usb" or
+	"atmel,at91sam9x5-clk-usb":
+		at91 usb clock
+
+	"atmel,at91sam9x5-clk-utmi":
+		at91 utmi clock
+
+Required properties for PMC node:
+- reg : defines the IO memory reserved for the PMC.
+- interrupts : shall be set to PMC interrupt line.
+- interrupt-controller : tell that the PMC is an interrupt controller 
+- #interrupt-cells : must be set to 2. The first cell encodes the interrupt id
+		     the second cell encodes the interrupt type.
+For example:
+ 	pmc: pmc at fffffc00 {
+		compatible = "atmel,sama5d3-pmc";
+		interrupts = <AT91_ID_SYS IRQ_TYPE_LEVEL_HIGH 7>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		/* put at91 clocks here */
+	};
+
+Required properties for main clock:
+- interrupt-parent : must reference the PMC node.
+- interrupts : shall be set to "<AT91_PMC_MOSCS IRQ_TYPE_LEVEL_HIGH>".
+- #clock-cells : from common clock binding; shall be set to 0.
+- clocks (optional if clock-frequency is provided) : shall be the slow clock
+	phandle. This clock is used to compute the main clock rate if
+	"clock-frequency" is not provided.
+- clock-frequency: the main oscillator frequency.Prefer the use of
+	"clock-frequency" over automatic clock rate computation.
+
+For example:
+	main: mainck {
+		compatible = "atmel,at91rm9200-clk-main";
+		interrupt-parent = <&pmc>;
+		interrupts = <AT91_PMC_MOSCS IRQ_TYPE_LEVEL_HIGH>;
+		#clock-cells = <0>;
+		clocks = <&ck32k>;
+		clock-frequency = <18432000>;
+	};
+
+Required properties for master clock:
+- interrupt-parent : must reference the PMC node.
+- interrupts : shall be set to "<AT91_PMC_MCKRDY IRQ_TYPE_LEVEL_HIGH>".
+- #clock-cells : from common clock binding; shall be set to 0.
+- clocks : shall be the master clock sources (see atmel datasheet) phandles.
+	e.g. "<&ck32k>, <&main>, <&plla>, <&pllb>".
+- atmel,clk-output-range : minimum and maximum clock frequency (two u32
+			   fields).
+	   e.g. output = <0 133000000>; <=> 0 to 133MHz.
+- atmel,clk-divisors : master clock divisors table (four u32 fields).
+		0 <=> reserved value.
+		e.g. divisors = <1 2 4 6>;
+- atmel,master-clk-have-div3-pres : some SoC use the reserved value 7 in the
+				    PRES field as CLOCK_DIV3 (e.g sam9x5).
+
+For example:
+	mck: mck {
+		compatible = "atmel,at91rm9200-clk-master";
+		interrupt-parent = <&pmc>;
+		interrupts = <AT91_PMC_MCKRDY IRQ_TYPE_LEVEL_HIGH>;
+		#clock-cells = <0>;
+		atmel,clk-output-range = <0 133000000>;
+		atmel,clk-divisors = <1 2 4 0>;
+	};
+
+Required properties for peripheral clocks:
+- #clock-cells : from common clock binding; shall be set to 1. The second cell
+	is used to encode the peripheral id. Peripheral ids are defined in
+	atmel's SoC datasheets.
+- clocks : shall be the master clock phandle.
+	e.g. clocks = <&mck>;
+- name: device tree node describing a specific system clock.
+	* atmel,clk-id: peripheral id. Peripheral id macros should be used.
+	* atmel,clk-default-divisor (optional, only available for
+	  "atmel,at91sam9x5-clk-peripheral"): sam9x5 and sama5d3 SoC provides
+	  configurable peripheral clock divisor. If you define this property
+	  (u32), the default divisor will be applied when enabling
+	  peripheral clock. If not provided the peripheral clock is not
+	  divided.
+
+For example:
+	periph: periphck {
+		compatible = "atmel,at91sam9x5-clk-peripheral";
+		#clock-cells = <1>;
+		clocks = <&mck>;
+
+		pioA_clk {
+			atmel,clk-id = <AT91SAM9X5_ID_PIOA>;
+			atmel,clk-default-divisor = <1>;
+		};
+
+		pioB_clk {
+			atmel,clk-id = <AT91SAM9X5_ID_PIOB>;
+			atmel,clk-default-divisor = <2>;
+		};
+	};
+
+
+Required properties for pll clocks:
+- interrupt-parent : must reference the PMC node.
+- interrupts : shall be set to "<AT91_PMC_LOCKA IRQ_TYPE_LEVEL_HIGH>".
+- #clock-cells : from common clock binding; shall be set to 0.
+- clocks : shall be the main clock phandle.
+- atmel,clk-id : pll id. PLL id macros should be used.
+- atmel,clk-input-range : minimum and maximum source clock frequency (two u32
+			  fields).
+	  e.g. input = <1 32000000>; <=> 1 to 32MHz.
+- #atmel,pll-clk-output-range-cells : number of cells reserved for pll output
+				      range description. Sould be set to 2, 3
+				      or 4.
+	* 1st and 2nd cells represent the frequency range (min-max).
+	* 3rd cell is optional and represents the OUT field value for the given
+	  range.
+	* 4th cell is optional and represents the ICPLL field (PLLICPR
+	  register)
+- atmel,pll-clk-output-ranges : pll output frequency ranges + optional parameter
+				depending on #atmel,pll-output-range-cells
+				property value.
+
+For example:
+	plla: pllack {
+		compatible = "atmel,at91sam9g45-clk-pll";
+		interrupt-parent = <&pmc>;
+		interrupts = <AT91_PMC_LOCKA IRQ_TYPE_LEVEL_HIGH>;
+		#clock-cells = <0>;
+		clocks = <&main>;
+		atmel,clk-id = <AT91_PLLA_CLK>;
+		atmel,clk-input-range = <2000000 32000000>;
+		#atmel,pll-clk-output-range-cells = <4>;
+		atmel,pll-clk-output-ranges = <74500000 800000000 0 0
+					       69500000 750000000 1 0
+					       64500000 700000000 2 0
+					       59500000 650000000 3 0
+					       54500000 600000000 0 1
+					       49500000 550000000 1 1
+					       44500000 500000000 2 1
+					       40000000 450000000 3 1>;
+	};
+
+Required properties for plldiv clocks:
+- #clock-cells : from common clock binding; shall be set to 0.
+- clocks : shall be the plla clock phandle.
+
+For example:
+	plladiv: plladivck {
+		compatible = "atmel,at91sam9x5-clk-plldiv";
+		#clock-cells = <0>;
+		clocks = <&plla>;
+	};
+
+Required properties for programmable clocks:
+- interrupt-parent : must reference the PMC node.
+- #clock-cells : from common clock binding; shall be set to 1. The second cell
+	is used to encode the programmable clock id.
+	Peripheral ids are in atmel's SoC
+	datasheets.
+- clocks : shall be the programmable clock source phandles.
+	e.g. clocks = <&clk32k>, <&main>, <&plla>, <&pllb>;
+- name: device tree node describing a specific prog clock.
+	* atmel,clk-id : programmable clock id (register offset from  PCKx
+			 register).
+	* interrupts : shall be set to
+		       "<AT91_PMC_PCKRDY(id) IRQ_TYPE_LEVEL_HIGH>".
+
+For example:
+	prog: progck {
+		compatible = "atmel,at91sam9g45-clk-programmable";
+		interrupt-parent = <&pmc>;
+		#clock-cells = <1>;
+		clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>, <&mck>;
+
+		prog0 {
+			atmel,clk-id = <0>;
+			interrupts = <AT91_PMC_PCKRDY(0) IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		prog1 {
+			atmel,clk-id = <1>;
+			interrupts = <AT91_PMC_PCKRDY(1) IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+
+Required properties for smd clock:
+- #clock-cells : from common clock binding; shall be set to 0.
+- clocks : shall be the smd clock source phandles.
+	e.g. clocks = <&plladiv>, <&utmi>;
+
+For example:
+	smd: smdck {
+		compatible = "atmel,at91sam9x5-clk-smd";
+		#clock-cells = <0>;
+		clocks = <&plladiv>, <&utmi>;
+	};
+
+Required properties for system clocks:
+- #clock-cells : from common clock binding; shall be set to 1. The second cell
+	is used to encode the system clock id (bit used in SCER/SCDR register).
+- name: device tree node describing a specific system clock.
+	* id: system clock id (bit position in SCER/SCDR/SCSR registers).
+	      System clock id macros should be used.
+
+For example:
+	system: systemck {
+		compatible = "atmel,at91rm9200-clk-system";
+		#clock-cells = <1>;
+
+		ddrck {
+			atmel,clk-id = <AT91_DDRCK_SYS_CLK>;
+		};
+
+		uhpck {
+			atmel,clk-id = <AT91_UHP_SYS_CLK>;
+		};
+
+		udpck {
+			atmel,clk-id = <AT91_UDP_SYS_CLK>;
+		};
+	};
+
+
+Required properties for usb clock:
+- #clock-cells : from common clock binding; shall be set to 0.
+- clocks : shall be the smd clock source phandles.
+	e.g. clocks = <&pllb>;
+- atmel,clk-divisors (only available for "atmel,at91rm9200-clk-usb"):
+	usb clock divisor table.
+	e.g. divisors = <1 2 4 0>;
+- atmel,usb-clk-src0-unused (only available for "atmel,at91sam9x5-clk-usb"):
+	Some SoC (sam9n12) use usb source 0 to disable the usb clock.
+
+For example:
+	usb: usbck {
+		compatible = "atmel,at91sam9x5-clk-usb";
+		#clock-cells = <0>;
+		clocks = <&plladiv>, <&utmi>;
+	};
+
+	usb: usbck {
+		compatible = "atmel,at91rm9200-clk-usb";
+		#clock-cells = <0>;
+		clocks = <&pllb>;
+		atmel,clk-divisors = <1 2 4 0>;
+	};
+
+
+Required properties for utmi clock:
+- interrupt-parent : must reference the PMC node.
+- interrupts : shall be set to "<AT91_PMC_LOCKU IRQ_TYPE_LEVEL_HIGH>".
+- #clock-cells : from common clock binding; shall be set to 0.
+- clocks : shall be the main clock source phandle.
+
+For example:
+	utmi: utmick {
+		compatible = "atmel,at91sam9x5-clk-utmi";
+		interrupt-parent = <&pmc>;
+		interrupts = <AT91_PMC_LOCKU IRQ_TYPE_LEVEL_HIGH>;
+		#clock-cells = <0>;
+		clocks = <&main>;
+	};
-- 
1.7.9.5
