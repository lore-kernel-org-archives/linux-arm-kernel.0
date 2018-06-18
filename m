From: codrin.ciubotariu@microchip.com (Codrin Ciubotariu)
Date: Mon, 18 Jun 2018 17:12:35 +0300
Subject: [PATCH v5 1/5] dt-bindings: clk: at91: add an I2S mux clock
In-Reply-To: <20180618141239.10892-1-codrin.ciubotariu@microchip.com>
References: <20180618141239.10892-1-codrin.ciubotariu@microchip.com>
Message-ID: <20180618141239.10892-2-codrin.ciubotariu@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2S mux clock can be used to select the I2S input clock. The
available parents are the peripheral and the generated clocks.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v5:
	- specified clock's parent;
	- added a newline before adding the clock's compatible string;

 .../devicetree/bindings/clock/at91-clock.txt  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
index 51c259a92d02..d0adbf5ae144 100644
--- a/Documentation/devicetree/bindings/clock/at91-clock.txt
+++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
@@ -91,6 +91,9 @@ Required properties:
 		at91 audio pll output on AUDIOPLLCLK that feeds the PMC
 		and can be used by peripheral clock or generic clock
 
+	"atmel,sama5d2-clk-i2s-mux" (under pmc node):
+		at91 I2S clock source selection
+
 Required properties for SCKC node:
 - reg : defines the IO memory reserved for the SCKC.
 - #size-cells : shall be 0 (reg is used to encode clk id).
@@ -507,3 +510,35 @@ For example:
 			atmel,clk-output-range = <0 83000000>;
 		};
 	};
+
+Required properties for I2S mux clocks:
+- #size-cells : shall be 0 (reg is used to encode I2S bus id).
+- #address-cells : shall be 1 (reg is used to encode I2S bus id).
+- name: device tree node describing a specific mux clock.
+	* #clock-cells : from common clock binding; shall be set to 0.
+	* clocks : shall be the mux clock parent phandles; shall be 2 phandles:
+	  peripheral and generated clock; the first phandle shall belong to the
+	  peripheral clock and the second one shall belong to the generated
+	  clock; "clock-indices" property can be user to specify
+	  the correct order.
+	* reg: I2S bus id of the corresponding mux clock.
+	  e.g. reg = <0>; for i2s0, reg = <1>; for i2s1
+
+For example:
+	i2s_clkmux {
+		compatible = "atmel,sama5d2-clk-i2s-mux";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2s0muxck: i2s0_muxclk {
+			clocks = <&i2s0_clk>, <&i2s0_gclk>;
+			#clock-cells = <0>;
+			reg = <0>;
+		};
+
+		i2s1muxck: i2s1_muxclk {
+			clocks = <&i2s1_clk>, <&i2s1_gclk>;
+			#clock-cells = <0>;
+			reg = <1>;
+		};
+	};
-- 
2.17.1
