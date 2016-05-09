From: joel@jms.id.au (Joel Stanley)
Date: Mon,  9 May 2016 22:01:48 +0930
Subject: [PATCH 1/4] doc/devicetree: Add Aspeed clock bindings
In-Reply-To: <1462797111-14271-1-git-send-email-joel@jms.id.au>
References: <1462797111-14271-1-git-send-email-joel@jms.id.au>
Message-ID: <1462797111-14271-2-git-send-email-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 .../devicetree/bindings/clock/aspeed-clock.txt     | 156 +++++++++++++++++++++
 1 file changed, 156 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/aspeed-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/aspeed-clock.txt b/Documentation/devicetree/bindings/clock/aspeed-clock.txt
new file mode 100644
index 000000000000..968329406435
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/aspeed-clock.txt
@@ -0,0 +1,156 @@
+Device Tree Clock bindings for the Aspeed SoCs
+
+Aspeed SoCs have a fixed frequency input osciallator is used to create the PLL
+and APB clocks. We can determine these frequencies by reading registers that
+are set according to strapping bits.
+
+Forth generation boards
+-----------------------
+
+eg, ast2400.
+
+CLKIN:
+ - compatible : Must be "fixed-clock"
+ - #clock-cells : Should be 0
+ - clock-frequency: 48e6, 25e6 or 24e6 depending on the input clock
+
+PLL:
+
+Required properties:
+ - compatible : Must be "aspeed,g4-hpll-clock"
+ - #clock-cells : Should be 0
+ - reg : Should contain registers location and length
+ - clocks : Should contain phandle + clock-specifier for the input clock (clkin)
+
+Optional properties:
+ - clock-output-names : Should contain clock name
+
+
+APB:
+
+Required properties:
+ - compatible : Must be "aspeed,g4-apb-clock"
+ - #clock-cells : Should be 0
+ - reg : Should contain registers location and length
+ - clocks : Should contain phandle + clock-specifier for the h-pll
+
+Optional properties:
+ - clock-output-names : Should contain clock name
+
+
+For example:
+
+	clk_clkin: clk_clkin {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <48000000>;
+	};
+
+	clk_hpll: clk_hpll {
+		compatible = "aspeed,g4-hpll-clock";
+		#clock-cells = <0>;
+		reg = <0x1e6e2008 0x4>;
+	};
+
+	clk_apb: clk_apb at 1e6e2008 {
+		#clock-cells = <0>;
+		compatible = "aspeed,g4-apb-clock";
+		reg = <0x1e6e2008 0x4>;
+		clocks = <&clk_hpll>;
+	};
+
+
+
+Fifth generation boards
+-----------------------
+
+eg, ast2500.
+
+CLKIN:
+Required properties:
+ - compatible : Must be "fixed-clock"
+ - #clock-cells : Should be 0
+ - clock-frequency: 25000000 or 24000000 depending on the input clock
+
+H-PLL:
+
+Required properties:
+ - compatible : Must be "aspeed,g5-hpll-clock"
+ - #clock-cells : Should be 0
+ - reg : Should contain registers location and length
+ - clocks : Should contain phandle + clock-specifier for the input clock (clkin)
+
+Optional properties:
+ - clock-output-names : Should contain clock name
+
+AHB:
+
+Required properties:
+ - compatible : Must be "aspeed,g5-ahb-clock"
+ - #clock-cells : Should be 0
+ - reg : Should contain registers location and length
+ - clocks : Should contain phandle + clock-specifier for the the h-pll
+
+Optional properties:
+ - clock-output-names : Should contain clock name
+
+APB:
+
+Required properties:
+ - compatible : Must be "aspeed,g4-apb-clock"
+ - #clock-cells : Should be 0
+ - reg : Should contain registers location and length
+ - clocks : Should contain phandle + clock-specifier for the the h-pll
+
+Optional properties:
+ - clock-output-names : Should contain clock name
+
+For example:
+	clk_clkin: clk_clkin at 1e6e2070 {
+		#clock-cells = <0>;
+		compatible = "aspeed,g5-clkin-clock";
+		reg = <0x1e6e2070 0x04>;
+	};
+
+	clk_hpll: clk_hpll at 1e6e2024 {
+		#clock-cells = <0>;
+		compatible = "aspeed,g5-hpll-clock";
+		reg = <0x1e6e2024 0x4>;
+		clocks = <&clk_clkin>;
+	};
+
+	clk_ahb: clk_ahb at 1e6e2070 {
+		#clock-cells = <0>;
+		compatible = "aspeed,g5-ahb-clock";
+		reg = <0x1e6e2070 0x4>;
+		clocks = <&clk_hpll>;
+	};
+
+	clk_apb: clk_apb at 1e6e2008 {
+		#clock-cells = <0>;
+		compatible = "aspeed,g5-apb-clock";
+		reg = <0x1e6e2008 0x4>;
+		clocks = <&clk_hpll>;
+	};
+
+Common clocks
+-------------
+
+UART:
+
+All supported boards have a uart clock that is derived from a 24MHz reference.
+We have a clock driver for it as there is a register in the SCU that controls
+weather it will be divided down by 13 or not.
+
+Required properties:
+ - compatible : Must be "aspeed,uart-clock"
+ - #clock-cells : Should be 0
+ - reg : Should contain registers location and length
+
+For example:
+
+	clk_uart: clk_uart at 1e6e2008 {
+		#clock-cells = <0>;
+		compatible = "aspeed,uart-clock";
+		reg = <0x1e6e202c 0x4>;
+	};
-- 
2.8.1
