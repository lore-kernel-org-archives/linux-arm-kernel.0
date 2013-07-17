From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed, 17 Jul 2013 15:55:41 +0200
Subject: [PATCH v2 11/42] ARM: at91: add PMC clk device tree binding doc.
In-Reply-To: <1374068069-13496-1-git-send-email-b.brezillon@overkiz.com>
References: <1374068069-13496-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1374069341-14216-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the documentation of the dt bindings used by at91 clks.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 .../devicetree/bindings/clock/at91-clock.txt       |  262 ++++++++++++++++++++
 1 file changed, 262 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/at91-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
new file mode 100644
index 0000000..ca98783
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
@@ -0,0 +1,262 @@
+Device Tree Clock bindings for arch-at91
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : shall be one of the following:
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
+
+Required properties for main clock:
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
+		#clock-cells = <0>;
+		clocks = <&ck32k>;
+		clock-frequency = <18432000>;
+	};
+
+Required properties for master clock:
+- #clock-cells : from common clock binding; shall be set to 0.
+- clocks : shall be the master clock sources (see atmel datasheet) phandles.
+	e.g. "<&ck32k>, <&main>, <&plla>, <&pllb>".
+- characteristics : device tree node describing master clock characteristics.
+	You can find these characteristics in atmel's SoC datasheets.
+	* output : minimum and maximum clock frequency (two u32 fields).
+		e.g. output = <0 133000000>; <=> 0 to 133MHz.
+	* divisors : master clock divisors table (four u32 fields).
+		0 <=> reserved value.
+		e.g. divisors = <1 2 4 6>;
+	* have-div3-pres : some SoC use the reserved value 7 in the PRES field
+		as CLOCK_DIV3 (e.g sam9x5).
+
+For example:
+	mck: mck {
+		compatible = "atmel,at91rm9200-clk-master";
+		#clock-cells = <0>;
+		characteristics = {
+			output = <0 133000000>;
+			divisors = <1 2 4 0>;
+		};
+	};
+
+Required properties for peripheral clocks:
+- #clock-cells : from common clock binding; shall be set to 1. The second cell
+	is used to encode the peripheral id. Peripheral ids are defined in
+	atmel's SoC datasheets.
+- clocks : shall be the master clock phandle.
+	e.g. clocks = <&mck>;
+- name at id: device tree node describing a specific system clock.
+	* id: peripheral id.
+	* default-divisor (optional, only available for
+	  "atmel,at91sam9x5-clk-peripheral"): sam9x5 and sama5d3 SoC provides
+	  configurable peripheral clock divisor. If you define this property
+	  (u32), the default divisor will be applied when enabling
+	  peripheral clock. If not provided the peripheral clock is not divided.
+
+For example:
+	periph: periphck {
+		compatible = "atmel,at91sam9x5-clk-peripheral";
+		#clock-cells = <1>;
+		clocks = <&mck>;
+
+		pioA_clk at 1 {
+			id = <1>;
+			default-divisor = <1>;
+		};
+
+		pioB_clk at 2 {
+			id = <2>;
+			default-divisor = <2>;
+		};
+	};
+
+
+Required properties for pll clocks:
+- #clock-cells : from common clock binding; shall be set to 0.
+- clocks : shall be the main clock phandle.
+- id : pll id
+	* 0 <=> plla
+	* 1 <=> pllb
+- characteristics : device tree node describing pll clock characteristics.
+	You can find these characteristics in atmel's SoC datasheets.
+	* input : minimum and maximum source clock frequency (two u32 fields).
+		e.g. input = <1 32000000>; <=> 1 to 32MHz.
+	* output : output frequency ranges.
+	* out: out field value for output frequency ranges.
+	* icpll (not available on some SoC): icpll field value for output
+		frequency ranges.
+
+For example:
+	plla: pllack {
+		compatible = "atmel,at91sam9g45-clk-pll";
+		#clock-cells = <0>;
+		clocks = <&main>;
+		id = <0>;
+		input = <2000000 32000000>;
+		output = <74500000 800000000
+			  69500000 750000000
+			  64500000 700000000
+			  59500000 650000000
+			  54500000 600000000
+			  49500000 550000000
+			  44500000 500000000
+			  40000000 450000000>;
+		out = <0 1 2 3 0 1 2 3>;
+		icpll = <0 0 0 0 1 1 1 1>;
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
+- #clock-cells : from common clock binding; shall be set to 1. The second cell
+	is used to encode the programmable clock id.
+	Peripheral ids are in atmel's SoC
+	datasheets.
+- clocks : shall be the programmable clock source phandles.
+	e.g. clocks = <&clk32k>, <&main>, <&plla>, <&pllb>;
+- name at id: device tree node describing a specific prog clock.
+	* id: programmable clock id (register offset from  PCKx register).
+
+For example:
+	prog: progck {
+		compatible = "atmel,at91sam9g45-clk-programmable";
+		#clock-cells = <1>;
+		clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>, <&mck>;
+
+		prog0 at 0 {
+			id = <0>;
+		};
+
+		prog1 at 1 {
+			id = <1>;
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
+- name at id: device tree node describing a specific system clock.
+	* id: system clock id (bit position in SCER/SCDR/SCSR registers).
+
+For example:
+	system: systemck {
+		compatible = "atmel,at91rm9200-clk-system";
+		#clock-cells = <1>;
+
+		ddrck at 2 {
+			id = <2>;
+		};
+
+		uhpck at 6 {
+			id = <6>;
+		};
+
+		udpck at 7 {
+			id = <7>;
+		};
+	};
+
+
+Required properties for usb clock:
+- #clock-cells : from common clock binding; shall be set to 0.
+- clocks : shall be the smd clock source phandles.
+	e.g. clocks = <&pllb>;
+- divisors (only available for "atmel,at91rm9200-clk-usb"):
+	usb clock divisor table.
+	e.g. divisors = <1 2 4 0>;
+- usbs0-unused (only available for "atmel,at91sam9x5-clk-usb"):
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
+		divisors = <1 2 4 0>;
+	};
+
+
+Required properties for utmi clock:
+- #clock-cells : from common clock binding; shall be set to 0.
+- clocks : shall be the main clock source phandle.
+
+For example:
+	utmi: utmick {
+		compatible = "atmel,at91sam9x5-clk-utmi";
+		#clock-cells = <0>;
+		clocks = <&main>;
+	};
-- 
1.7.9.5
