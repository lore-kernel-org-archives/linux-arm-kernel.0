From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 28 Feb 2013 15:19:24 +0800
Subject: [PATCH 5/7] document: append hisilicon clock binding
In-Reply-To: <1362035966-17628-1-git-send-email-haojian.zhuang@linaro.org>
References: <1362035966-17628-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1362035966-17628-5-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add hisilicon clock binding document for device tree.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 .../devicetree/bindings/clock/hisilicon.txt        |   73 ++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/hisilicon.txt

diff --git a/Documentation/devicetree/bindings/clock/hisilicon.txt b/Documentation/devicetree/bindings/clock/hisilicon.txt
new file mode 100644
index 0000000..04fefc3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/hisilicon.txt
@@ -0,0 +1,73 @@
+Device Tree Clock bindings for arch-vt8500
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties for mux clocks:
+ - compatible : Shall be "hisilicon,hi3620-clk-mux".
+ - clocks : shall be the input parent clock phandle for the clock. This should
+	be the reference clock.
+ - clock-output-names : shall be reference name.
+ - #clock-cells : from common clock binding; shall be set to 0.
+ - hisilicon,hi3620-mux : array of mux register offset & mask bits
+
+Required properties for Hi3620 gate clocks:
+ - compatible : Shall be "hisilicon,hi3620-clk-gate".
+ - clocks : shall be the input parent clock phandle for the clock. This should
+	be the reference clock.
+ - clock-output-names : shall be reference name.
+ - #clock-cells : from common clock binding; shall be set to 0.
+ - hisilicon,hi3620-clkgate : array of enable register offset & enable bit
+ - hisilicon,hi3620-clkreset : array of reset register offset & enable bit
+
+Required properties for gate clocks:
+ - compatible : Shall be "hisilicon,clk-gate".
+ - clocks : shall be the input parent clock phandle for the clock. This should
+	be the reference clock.
+ - clock-output-names : shall be reference name.
+ - #clock-cells : from common clock binding; shall be set to 0.
+ - hisilicon,clkgate-inverted : bool value. True means that set-to-disable.
+
+Required properties for clock divider:
+ - compatible : Shall be "hisilicon,clk-div-table".
+ - clocks : shall be the input parent clock phandle for the clock. This should
+	be the reference clock.
+ - clock-output-names : shall be reference name.
+ - #clock-cells : from common clock binding; shall be set to 0.
+ - #hisilicon,clkdiv-table-cells : the number of parameters after phandle in
+   hisilicon,clkdiv-table property.
+ - hisilicon,clkdiv-table : list of value that are used to configure clock
+   divider. They're value of phandle, index & divider value.
+ - hisilicon,clkdiv : array of divider register offset & mask bits.
+
+Required properties for clock fixed factor divider:
+ - compatible : Shall be "hisilicon,fixed-factor".
+ - clocks : shall be the input parent clock phandle for the clock. This should
+	be the reference clock.
+ - clock-output-names : shall be reference name.
+ - #clock-cells : from common clock binding; shall be set to 0.
+ - hisilicon,fixed-factor : array of multiplier & divider.
+
+For example:
+	timclk1: clkgate at 38 {
+		compatible = "hisilicon,clk-gate";
+		#clock-cells = <0>;
+		clocks = <&refclk_timer1>;
+		clock-output-names = "timclk1";
+		hisilicon,clkgate-inverted;
+		hisilicon,clkgate = <0 18>;
+	};
+
+	dtable: clkdiv at 0 {
+		#hisilicon,clkdiv-table-cells = <2>;
+	};
+
+	div_cfgaxi: clkdiv at 2 {
+		compatible = "hisilicon,clk-div-table";
+		#clock-cells = <0>;
+		clocks = <&div_shareaxi>;
+		clock-output-names = "cfgAXI_div";
+		hisilicon,clkdiv-table = <&dtable 0x01 2>;
+		hisilicon,clkdiv = <0x100 0x60>;
+	};
-- 
1.7.10.4
