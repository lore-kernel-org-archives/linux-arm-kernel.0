From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 22 Nov 2011 09:48:54 +0800
Subject: [RFC PATCH 1/3] arm/imx6: describe clocks in device tree source
In-Reply-To: <1321926536-671-1-git-send-email-shawn.guo@linaro.org>
References: <1321926536-671-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1321926536-671-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds document for imx clock device tree bindings and then describes
imx6 clocks in dts.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../devicetree/bindings/clock/clock-imx.txt        |  124 +++
 arch/arm/boot/dts/imx6q.dtsi                       |  943 +++++++++++++++++++-
 2 files changed, 1058 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/clock-imx.txt

diff --git a/Documentation/devicetree/bindings/clock/clock-imx.txt b/Documentation/devicetree/bindings/clock/clock-imx.txt
new file mode 100644
index 0000000..5c597d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/clock-imx.txt
@@ -0,0 +1,124 @@
+* Device Tree Bindings for Freescale i.MX Clock
+
+== Clock Gate ==
+
+Required properties:
+- imx,clock-gate:  It's a two 32-bit integers array.  The first
+  integer specifies the offset of the gate register, and the second
+  one specifies the bit mask of the gate for this clock.
+
+== Clock Divider ==
+
+Required properties:
+- imx,clock-divider:  It's a five 32-bit integers array.  The first
+  integer specifies the offset of the divider register.  The second
+  and the third one specify the shift and width of the pre-divider
+  bits for the clock, which is not necessarily present and the values
+  can just be 0.  The last two specify the shift and width of the
+  post-divider bits.
+
+Optional properties:
+- imx,busy-divider:  Some imx clocks needs to wait for a busy status
+  cleared when the clock rate gets changed.  This property is a two
+  32-bit integers array.  The first integer specifies the offset of
+  the busy register, and the second one specifies the busy bit mask.
+
+== Clock Multiplexer ==
+
+Required properties:
+- imx,clock-multiplexer:  It's a three 32-bit integers array.  The
+  first integer specifies the offset of the multiplexer register.
+  The second and the third one specify the shift and width of the
+  multiplexer bits for this clock.
+
+Optional properties:
+- imx,busy-multiplexer:  Some imx clocks needs to wait for a busy
+  status cleared when the parent gets changed.  This property is a two
+  32-bit integers array.  The first integer specifies the offset of
+  the busy register, and the second one specifies the busy bit mask.
+
+A typical imx clock could have gate, divider, multiplexer, but it's
+also very true that a imx clock just has the subset of these three
+properties.
+
+When #clock-cells > 1, this single clock node actually describes
+multiple clocks.  Thus all the properties under the node should
+contains the description for all of the clocks, except properties
+clock-input and clock-input-name which are used to describe the
+parents of the clock.  That means only the clocks sharing the exactly
+same parents could possible described by single node.
+
+Examples:
+
+pll2_pfd_clk: pll2-pfd {
+	compatible = "fsl,imx6q-pfd";
+	#clock-cells = <3>;
+	imx,clock-gate = <0x100 0x80>,
+			 <0x100 0x8000>,
+			 <0x100 0x800000>;
+	imx,clock-divider = <0x100 0 0 0 6>,
+			    <0x100 0 0 8 6>,
+			    <0x100 0 0 16 6>;
+	clock-input = <&pll_bus_clk 0>;
+	clock-input-name = "pll2-bus";
+	clock-output-name = "pll2-pfd-352m",
+			    "pll2-pfd-594m",
+			    "pll2-pfd-400m";
+};
+
+usdhc_clk: usdhc {
+	compatible = "fsl,imx6q-clock";
+	#clock-cells = <4>;
+	imx,clock-gate = <0x80 0xc>,
+			 <0x80 0x30>,
+			 <0x80 0xc0>,
+			 <0x80 0x300>;
+	imx,clock-divider = <0x24 0 0 11 3>,
+			    <0x24 0 0 16 3>,
+			    <0x24 0 0 19 3>,
+			    <0x24 0 0 22 3>;
+	imx,clock-multiplexer = <0x1c 16 1>,
+				<0x1c 17 1>,
+				<0x1c 18 1>,
+				<0x1c 19 1>;
+	clock-input = <&pll2_pfd_clk 2 0 0>,
+		      <&pll2_pfd_clk 0 0 0>;
+	clock-input-name = "pll2-pfd-400m",
+			   "pll2-pfd-352m";
+	clock-output-name = "usdhc1",
+			    "usdhc2",
+			    "usdhc3",
+			    "usdhc3";
+};
+
+usdhc at 02190000 { /* uSDHC1 */
+	compatible = "fsl,imx6q-usdhc";
+	reg = <0x02190000 0x4000>;
+	interrupts = <0 22 0x04>;
+	clock-input = <&usdhc_clk 0 0 0 0>;
+	clock-input-name = "usdhc1";
+};
+
+usdhc at 02194000 { /* uSDHC2 */
+	compatible = "fsl,imx6q-usdhc";
+	reg = <0x02194000 0x4000>;
+	interrupts = <0 23 0x04>;
+	clock-input = <&usdhc_clk 1 0 0 0>;
+	clock-input-name = "usdhc2";
+};
+
+usdhc at 02198000 { /* uSDHC3 */
+	compatible = "fsl,imx6q-usdhc";
+	reg = <0x02198000 0x4000>;
+	interrupts = <0 24 0x04>;
+	clock-input = <&usdhc_clk 2 0 0 0>;
+	clock-input-name = "usdhc3";
+};
+
+usdhc at 0219c000 { /* uSDHC4 */
+	compatible = "fsl,imx6q-usdhc";
+	reg = <0x0219c000 0x4000>;
+	interrupts = <0 25 0x04>;
+	clock-input = <&usdhc_clk 3 0 0 0>;
+	clock-input-name = "usdhc4";
+};
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 7dda599..a5b9c5e 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -64,19 +64,922 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		ckil {
-			compatible = "fsl,imx-ckil", "fixed-clock";
-			clock-frequency = <32768>;
+		dummy_clk: dummy {
+			compatible = "dummy-clock";
+			#clock-cells = <1>;
+			clock-output-name = "dummy";
 		};
 
-		ckih1 {
-			compatible = "fsl,imx-ckih1", "fixed-clock";
-			clock-frequency = <0>;
+		ref_clk: ref {
+			compatible = "fixed-clock";
+			#clock-cells = <3>;
+			clock-frequency = <24000000 32768 0>;
+			clock-output-name = "osc",
+					    "ckil",
+					    "ckih";
 		};
 
-		osc {
-			compatible = "fsl,imx-osc", "fixed-clock";
-			clock-frequency = <24000000>;
+		pll_sys_clk: pll-sys {
+			compatible = "fsl,imx6q-pll-sys";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x0 0x2000>;
+			imx,clock-divider = <0x0 0 0 0 7>;
+			clock-input = <&ref_clk 0 0 0>;
+			clock-input-name = "osc";
+			clock-output-name = "pll1-sys";
+		};
+
+		pll_bus_clk: pll-bus {
+			compatible = "fsl,imx6q-pll";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x30 0x2000>;
+			imx,clock-divider = <0x30 0 0 0 1>;
+			clock-input = <&ref_clk 0 0 0>;
+			clock-input-name = "osc";
+			clock-output-name = "pll2-bus";
+		};
+
+		pll_usb_clk: pll-usb {
+			compatible = "fsl,imx6q-pll-usb";
+			#clock-cells = <2>;
+			imx,clock-gate = <0x10 0x2000>,
+					 <0x20 0x2000>;
+			imx,clock-divider = <0x10 0 0 0 2>,
+					    <0x20 0 0 0 2>;
+			clock-input = <&ref_clk 0 0 0>;
+			clock-input-name = "osc";
+			clock-output-name = "pll3-usb-otg",
+					    "pll7-usb-host";
+		};
+
+		pll_av_clk: pll-av {
+			compatible = "fsl,imx6q-pll-av";
+			#clock-cells = <2>;
+			imx,clock-gate = <0x70 0x2000>,
+					 <0xa0 0x2000>;
+			imx,clock-divider = <0x70 0 0 0 7>,
+					    <0xa0 0 0 0 7>;
+			clock-input = <&ref_clk 0 0 0>;
+			clock-input-name = "osc";
+			clock-output-name = "pll4-audio",
+					    "pll5-video";
+		};
+
+		pll_mlb_clk: pll-mlb {
+			compatible = "fsl,imx6q-pll";
+			#clock-cells = <1>;
+			imx,clock-gate = <0xd0 0x2000>;
+			clock-input = <&ref_clk 0 0 0>;
+			clock-input-name = "osc";
+			clock-output-name = "pll6-mlb";
+		};
+
+		pll_enet_clk: pll-enet {
+			compatible = "fsl,imx6q-pll-enet";
+			#clock-cells = <1>;
+			imx,clock-gate = <0xe0 0x182000>;
+			imx,clock-divider = <0xe0 0 0 0 2>;
+			clock-input = <&ref_clk 0 0 0>;
+			clock-input-name = "osc";
+			clock-output-name = "pll8-enet";
+		};
+
+		pll2_pfd_clk: pll2-pfd {
+			compatible = "fsl,imx6q-pfd";
+			#clock-cells = <3>;
+			imx,clock-gate = <0x100 0x80>,
+					 <0x100 0x8000>,
+					 <0x100 0x800000>;
+			imx,clock-divider = <0x100 0 0 0 6>,
+					    <0x100 0 0 8 6>,
+					    <0x100 0 0 16 6>;
+			clock-input = <&pll_bus_clk 0>;
+			clock-input-name = "pll2-bus";
+			clock-output-name = "pll2-pfd-352m",
+					    "pll2-pfd-594m",
+					    "pll2-pfd-400m";
+		};
+
+		pll3_pfd_clk: pll3-pfd {
+			compatible = "fsl,imx6q-pfd";
+			#clock-cells = <4>;
+			imx,clock-gate = <0xf0 0x80>,
+					 <0xf0 0x8000>,
+					 <0xf0 0x800000>,
+					 <0xf0 0x80000000>;
+			imx,clock-divider = <0xf0 0 0 0 6>,
+					    <0xf0 0 0 8 6>,
+					    <0xf0 0 0 16 6>,
+					    <0xf0 0 0 24 6>;
+			clock-input = <&pll_usb_clk 0 0>;
+			clock-input-name = "pll3-usb-otg";
+			clock-output-name = "pll3-pfd-720m",
+					    "pll3-pfd-540m",
+					    "pll3-pfd-508m",
+					    "pll3-pfd-454m";
+		};
+
+		pll2_div_clk: pll2-200m {
+			compatible = "divider-fixed-clock";
+			#clock-cells = <1>;
+			clock-divider = <2>;
+			clock-input = <&pll2_pfd_clk 2 0 0>;
+			clock-input-name = "pll2-pfd-400m";
+			clock-output-name = "pll2-200m";
+		};
+
+		pll3_div_clk: pll3-div {
+			compatible = "divider-fixed-clock";
+			#clock-cells = <3>;
+			clock-divider = <4 6 8>;
+			clock-input = <&pll_usb_clk 0 0>;
+			clock-input-name = "pll3-usb";
+			clock-output-name = "pll3-120m",
+					    "pll3-80m",
+					    "pll3-60m";
+		};
+
+		step_clk: step {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-multiplexer = <0xc 8 1>;
+			clock-input = <&ref_clk 0 0 0>,
+				      <&pll2_pfd_clk 2 0 0>;
+			clock-input-name = "osc",
+					   "pll2-pfd-400m";
+			clock-output-name = "step";
+		};
+
+		pll1_sw_clk: pll1-sw {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-multiplexer = <0xc 2 1>;
+			clock-input = <&pll_sys_clk 0>,
+				      <&step_clk 0>;
+			clock-input-name = "pll1-sys",
+					   "step";
+			clock-output-name = "pll1-sw";
+		};
+
+		periph_pre_clk: periph-pre {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <2>;
+			imx,clock-multiplexer = <0x18 18 2>,
+						<0x18 21 2>;
+			clock-input = <&pll_bus_clk 0>,
+				      <&pll2_pfd_clk 2 0 0>,
+				      <&pll2_pfd_clk 0 0 0>,
+				      <&pll2_div_clk 0>;
+			clock-input-name = "pll2-bus",
+					   "pll2-pfd-400m",
+					   "pll2-pfd-352m",
+					   "pll2-200m";
+			clock-output-name = "periph-pre",
+					    "periph2-pre";
+		};
+
+		periph_clk2_clk: periph-clk2 {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <2>;
+			imx,clock-divider = <0x14 0 0 27 3>,
+					    <0x14 0 0 0 3>;
+			imx,clock-multiplexer = <0x18 12 1>,
+						<0x18 20 1>;
+			clock-input = <&pll_usb_clk 0 0>,
+				      <&ref_clk 0 0 0>;
+			clock-input-name = "pll3-usb-otg",
+					   "osc";
+			clock-output-name = "periph-clk2",
+					    "periph2-clk2";
+		};
+
+		periph_clk: periph {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-multiplexer = <0x14 25 1>;
+			imx,busy-multiplexer = <0x48 0x20>;
+			clock-input = <&periph_pre_clk 0 0>,
+				      <&periph_clk2_clk 0 0>;
+			clock-input-name = "periph-pre",
+					   "periph-clk2";
+			clock-output-name = "periph";
+		};
+
+		periph2_clk: periph2 {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-multiplexer = <0x14 26 1>;
+			imx,busy-multiplexer = <0x48 0x8>;
+			clock-input = <&periph_pre_clk 1 0>,
+				      <&periph_clk2_clk 1 0>;
+			clock-input-name = "periph2-pre",
+					   "periph2-clk2";
+			clock-output-name = "periph2";
+		};
+
+		axi_clk: axi {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-divider = <0x14 0 0 16 3>;
+			imx,busy-divider = <0x48 0x1>;
+			imx,clock-multiplexer = <0x14 6 2>;
+			clock-input = <&periph_clk 0>,
+				      <&pll2_pfd_clk 2 0 0>,
+				      <&pll3_pfd_clk 1 0 0 0>;
+			clock-input-name = "periph",
+					   "pll2-pfd-400m",
+					   "pll3-pfd-540m";
+			clock-output-name = "axi";
+		};
+
+		mmdc_ch0_axi_clk: mmdc-ch0-axi {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x74 0x300000>;
+			imx,clock-divider = <0x14 0 0 19 3>;
+			imx,busy-divider = <0x48 0x10>;
+			clock-input = <&periph_clk 0>;
+			clock-input-name = "periph";
+			clock-output-name = "mmdc-ch0-axi";
+		};
+
+		mmdc_ch1_axi_clk: mmdc-ch1-axi {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x74 0xc00000>;
+			imx,clock-divider = <0x14 0 0 3 3>;
+			imx,busy-divider = <0x48 0x4>;
+			clock-input = <&periph2_clk 0>;
+			clock-input-name = "periph2";
+			clock-output-name = "mmdc-ch1-axi";
+		};
+
+		arm_clk: arm {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-divider = <0x10 0 0 0 3>;
+			imx,busy-divider = <0x48 0x10000>;
+			clock-input = <&pll1_sw_clk 0>;
+			clock-input-name = "pll1-sw";
+			clock-output-name = "arm";
+		};
+
+		ahb_clk: ahb {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-divider = <0x14 0 0 10 3>;
+			imx,busy-divider = <0x48 0x2>;
+			clock-input = <&periph_clk 0>;
+			clock-input-name = "periph";
+			clock-output-name = "ahb";
+		};
+
+		ipg_clk: ipg {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-divider = <0x14 0 0 8 2>;
+			clock-input = <&ahb_clk 0>;
+			clock-input-name = "ahb";
+			clock-output-name = "ipg";
+		};
+
+		ipg_per_clk: ipg-per {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-divider = <0x1c 0 0 0 6>;
+			clock-input = <&ipg_clk 0>;
+			clock-input-name = "ipg";
+			clock-output-name = "ipg-per";
+		};
+
+		aips_tz_clk: aips-tz {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <2>;
+			imx,clock-gate = <0x68 0x3>,
+					 <0x68 0xc>;
+			clock-input = <&ahb_clk 0>;
+			clock-input-name = "ahb";
+			clock-output-name = "aips-tz1",
+					    "aips-tz2";
+		};
+
+		apbh_dma_clk: apbh-dma {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x68 0x30>;
+			clock-input = <&ahb_clk 0>;
+			clock-input-name = "ahb";
+			clock-output-name = "apbh-dma";
+		};
+
+		audio_clk: audio {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <3>;
+			imx,clock-gate = <0x6c 0x30000>,
+					 <0x68 0xc0>,
+					 <0x7c 0xc000>;
+			imx,clock-divider = <0x28 9 3 25 3>,
+					    <0x30 12 3 9 3>,
+					    <0x30 25 3 22 3>;
+			imx,clock-multiplexer = <0x20 19 2>,
+						<0x30 7 2>,
+						<0x30 20 2>;
+			clock-input = <&pll_av_clk 0 0>,
+				      <&pll3_pfd_clk 2 0 0 0>,
+				      <&pll3_pfd_clk 3 0 0 0>,
+				      <&pll_usb_clk 0 0>;
+			clock-input-name = "pll4-audio",
+					   "pll3-pfd-508m",
+					   "pll3-pfd-454m",
+					   "pll3-usb-otg";
+			clock-output-name = "esai",
+					    "asrc",
+					    "spdif";
+		};
+
+		can_root_clk: can-root {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-divider = <0x20 0 0 2 6>;
+			clock-input = <&pll_usb_clk 0 0>;
+			clock-input-name = "pll3-usb-otg";
+			clock-output-name = "can-root";
+		};
+
+		can_clk: can {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <4>;
+			imx,clock-gate = <0x68 0xc000>,
+					 <0x68 0x30000>,
+					 <0x68 0xc0000>,
+					 <0x68 0x300000>;
+			clock-input = <&can_root_clk 0>;
+			clock-input-name = "can-root";
+			clock-output-name = "can1",
+					    "can1-serial",
+					    "can2",
+					    "can2-serial";
+		};
+
+		ecspi_root_clk: ecspi-root {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-divider = <0x38 0 0 19 6>;
+			clock-input = <&pll3_div_clk 2 0 0>;
+			clock-input-name = "pll3-60m";
+			clock-output-name = "ecspi-root";
+		};
+
+		ecspi_clk: ecspi {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <5>;
+			imx,clock-gate = <0x6c 0x3>,
+					 <0x6c 0xc>,
+					 <0x6c 0x30>,
+					 <0x6c 0xc0>,
+					 <0x6c 0x300>;
+			clock-input = <&ecspi_root_clk 0>;
+			clock-input-name = "ecspi-root";
+			clock-output-name = "ecspi1",
+					    "ecspi2",
+					    "ecspi3",
+					    "ecspi4",
+					    "ecspi5";
+		};
+
+		enet_clk: enet {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x6c 0xc00>;
+			clock-input = <&ipg_clk 0>;
+			clock-input-name = "ipg";
+			clock-output-name = "enet";
+		};
+
+		gpt_clk: gpt {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <2>;
+			imx,clock-gate = <0x6c 0x300000>,
+					 <0x6c 0xc00000>;
+			clock-input = <&ipg_per_clk 0>;
+			clock-input-name = "ipg-per";
+			clock-output-name = "gpt",
+					    "gpt-serial";
+		};
+
+		gpu_axi_clk: gpu-axi {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <2>;
+			imx,clock-multiplexer = <0x18 0 1>,
+						<0x18 1 1>;
+			clock-input = <&axi_clk 0>,
+				      <&ahb_clk 0>;
+			clock-input-name = "axi",
+					   "ahb";
+			clock-output-name = "gpu2d-axi",
+					    "gpu3d-axi";
+		};
+
+		gpu2d_core_clk: gpu2d-core {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x6c 0x3000000>;
+			imx,clock-divider = <0x18 0 0 23 3>;
+			imx,clock-multiplexer = <0x18 16 2>;
+			clock-input = <&axi_clk 0>,
+				      <&pll_usb_clk 0 0>,
+				      <&pll2_pfd_clk 0 0 0>,
+				      <&pll2_pfd_clk 2 0 0>;
+			clock-input-name = "axi",
+					   "pll3-usb-otg",
+					   "pll2-pfd-352m",
+					   "pll2-pfd-400m";
+			clock-output-name = "gpu2d-core";
+		};
+
+		gpu3d_core_clk: gpu3d-core {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x6c 0xc000000>;
+			imx,clock-divider = <0x18 0 0 26 3>;
+			imx,clock-multiplexer = <0x18 4 2>;
+			clock-input = <&mmdc_ch0_axi_clk 0>,
+				      <&pll_usb_clk 0 0>,
+				      <&pll2_pfd_clk 1 0 0>,
+				      <&pll2_pfd_clk 2 0 0>;
+			clock-input-name = "mmdc-ch0-axi",
+					   "pll3-usb-otg",
+					   "pll2-pfd-594m",
+					   "pll2-pfd-400m";
+			clock-output-name = "gpu3d-core";
+		};
+
+		gpu3d_shader_clk: gpu3d-shader {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-divider = <0x18 0 0 29 3>;
+			imx,clock-multiplexer = <0x18 8 2>;
+			clock-input = <&mmdc_ch0_axi_clk 0>,
+				      <&pll_usb_clk 0 0>,
+				      <&pll2_pfd_clk 1 0 0>,
+				      <&pll3_pfd_clk 0 0 0 0>;
+			clock-input-name = "mmdc-ch0-axi",
+					   "pll3-usb-otg",
+					   "pll2-pfd-594m",
+					   "pll3-pfd-720m";
+			clock-output-name = "gpu3d-shader";
+		};
+
+		hdmi_iahb_clk: hdmi-iahb {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x70 0x3>;
+			clock-input = <&ahb_clk 0>;
+			clock-input-name = "ahb";
+			clock-output-name = "hdmi-iahb";
+		};
+
+		hdmi_isfr_clk: hdmi-isfr {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x70 0x3>;
+			clock-input = <&pll3_pfd_clk 1 0 0 0>;
+			clock-input-name = "pll3-pfd-540m";
+			clock-output-name = "hdmi-isfr";
+		};
+
+		i2c_clk: i2c {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <3>;
+			imx,clock-gate = <0x70 0xc0>,
+					 <0x70 0x300>,
+					 <0x70 0xc00>;
+			clock-input = <&ipg_per_clk 0>;
+			clock-input-name = "ipg-per";
+			clock-output-name = "i2c1",
+					    "i2c2",
+					    "i2c3";
+		};
+
+		iim_clk: iim {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x70 0x3000>;
+			clock-input = <&ipg_clk 0>;
+			clock-input-name = "ipg";
+			clock-output-name = "iim";
+		};
+
+		ipu_clk: ipu {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <2>;
+			imx,clock-gate = <0x74 0x3>,
+					 <0x74 0xc0>;
+			imx,clock-divider = <0x3c 0 0 11 3>,
+					    <0x3c 0 0 16 3>;
+			imx,clock-multiplexer = <0x3c 9 2>,
+						<0x3c 14 2>;
+			clock-input = <&mmdc_ch0_axi_clk 0>,
+				      <&pll2_pfd_clk 2 0 0>,
+				      <&pll3_div_clk 0 0 0>,
+				      <&pll3_pfd_clk 1 0 0 0>;
+			clock-input-name = "mmdc-ch0-axi",
+					   "pll2-pfd-400m",
+					   "pll3-120m",
+					   "pll3-pfd-540m";
+			clock-output-name = "ipu1",
+					    "ipu2";
+		};
+
+		ldb_di_clk: ldb-di {
+			compatible = "fsl,imx6q-ldb-di-clock";
+			#clock-cells = <2>;
+			imx,clock-gate = <0x74 0x3000>,
+					 <0x74 0xc000>;
+			imx,clock-divider = <0x20 0 0 10 1>,
+					    <0x20 0 0 11 1>;
+			imx,clock-multiplexer = <0x2c 9 3>,
+						<0x2c 12 3>;
+			clock-input = <&pll_av_clk 1 0>,
+				      <&pll2_pfd_clk 0 0 0>,
+				      <&pll2_pfd_clk 2 0 0>,
+				      <&pll3_pfd_clk 1 0 0 0>,
+				      <&pll_usb_clk 0 0>;
+			clock-input-name = "pll5-video",
+					   "pll2-pfd-352m",
+					   "pll2-pfd-400m",
+					   "pll3-pfd-540m",
+					   "pll3-usb-otg";
+			clock-output-name = "ldb-di0",
+					    "ldb-di1";
+		};
+
+		ipu_di_pre_clk: ipu-di-pre {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <4>;
+			imx,clock-divider = <0x34 0 0 3 3>,
+					    <0x34 0 0 12 3>,
+					    <0x38 0 0 3 3>,
+					    <0x38 0 0 12 3>;
+			imx,clock-multiplexer = <0x34 6 3>,
+						<0x34 15 3>,
+						<0x38 6 3>,
+						<0x38 15 3>;
+			clock-input = <&mmdc_ch0_axi_clk 0>,
+				      <&pll_usb_clk 0 0>,
+				      <&pll_av_clk 1 0>,
+				      <&pll2_pfd_clk 0 0 0>,
+				      <&pll2_pfd_clk 2 0 0>,
+				      <&pll3_pfd_clk 1 0 0 0>;
+			clock-input-name = "mmdc-ch0-axi",
+					   "pll3-usb-otg",
+					   "pll5-video",
+					   "pll2-pfd-352m",
+					   "pll2-pfd-400m",
+					   "pll3-pfd-540m";
+			clock-output-name = "ipu1-di0-pre",
+					    "ipu1-di1-pre",
+					    "ipu2-di0-pre",
+					    "ipu2-di1-pre";
+		};
+
+		ipu1_di0_clk: ipu1-di0 {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x74 0xc>;
+			imx,clock-multiplexer = <0x34 0 3>;
+			clock-input = <&ipu_di_pre_clk 0 0 0 0>,
+				      <&dummy_clk 0>,
+				      <&dummy_clk 0>,
+				      <&ldb_di_clk 0 0>,
+				      <&ldb_di_clk 1 0>;
+			clock-input-name = "ipu1-di0-pre",
+					   "dummy",
+					   "dummy",
+					   "ldb-di0",
+					   "ldb-di1";
+			clock-output-name = "ipu1-di0";
+		};
+
+		ipu1_di1_clk: ipu1-di1 {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x74 0x30>;
+			imx,clock-multiplexer = <0x34 9 3>;
+			clock-input = <&ipu_di_pre_clk 1 0 0 0>,
+				      <&dummy_clk 0>,
+				      <&dummy_clk 0>,
+				      <&ldb_di_clk 0 0>,
+				      <&ldb_di_clk 1 0>;
+			clock-input-name = "ipu1-di1-pre",
+					   "dummy",
+					   "dummy",
+					   "ldb-di0",
+					   "ldb-di1";
+			clock-output-name = "ipu1-di1";
+		};
+
+		ipu2_di0_clk: ipu2-di0 {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x74 0x300>;
+			imx,clock-multiplexer = <0x38 0 3>;
+			clock-input = <&ipu_di_pre_clk 2 0 0 0>,
+				      <&dummy_clk 0>,
+				      <&dummy_clk 0>,
+				      <&ldb_di_clk 0 0>,
+				      <&ldb_di_clk 1 0>;
+			clock-input-name = "ipu2-di0-pre",
+					   "dummy",
+					   "dummy",
+					   "ldb-di0",
+					   "ldb-di1";
+			clock-output-name = "ipu2-di0";
+		};
+
+		ipu2_di1_clk: ipu2-di1 {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x74 0xc00>;
+			imx,clock-multiplexer = <0x38 9 3>;
+			clock-input = <&ipu_di_pre_clk 3 0 0 0>,
+				      <&dummy_clk 0>,
+				      <&dummy_clk 0>,
+				      <&ldb_di_clk 0 0>,
+				      <&ldb_di_clk 1 0>;
+			clock-input-name = "ipu2-di1-pre",
+					   "dummy",
+					   "dummy",
+					   "ldb-di0",
+					   "ldb-di1";
+			clock-output-name = "ipu2-di1";
+		};
+
+		hsi_tx_clk: hsi-tx {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x74 0x30000>;
+			imx,clock-divider = <0x30 0 0 29 3>;
+			imx,clock-multiplexer = <0x30 28 1>;
+			clock-input = <&pll3_div_clk 0 0 0>,
+				      <&pll2_pfd_clk 2 0 0>;
+			clock-input-name = "pll3-120m",
+					   "pll2-pfd-400m";
+			clock-output-name = "hsi-tx";
+		};
+
+		mlb_clk: mlb {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x74 0xc0000>;
+			clock-input = <&pll_mlb_clk 0>;
+			clock-input-name = "pll6-mlb";
+			clock-output-name = "mlb";
+		};
+
+		mmdc_ipg_clk: mmdc-ipg {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <2>;
+			imx,clock-gate = <0x74 0x3000000>,
+					 <0x74 0xc000000>;
+			clock-input = <&ipg_clk 0>;
+			clock-input-name = "ipg";
+			clock-output-name = "mmdc-ch0-ipg",
+					    "mmdc-ch1-ipg";
+		};
+
+		openvg_axi_clk: openvg-axi {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x74 0xc000000>;
+			clock-input = <&axi_clk 0>;
+			clock-input-name = "axi";
+			clock-output-name = "openvg-axi";
+		};
+
+		pcie_axi_clk: pcie-axi {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x78 0x3>;
+			imx,clock-multiplexer = <0x18 10 1>;
+			clock-input = <&axi_clk 0>,
+				      <&ahb_clk 0>;
+			clock-input-name = "axi",
+					   "ahb";
+			clock-output-name = "pcie-axi";
+		};
+
+		pwm_clk: pwm {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <4>;
+			imx,clock-gate = <0x78 0x30000>,
+					 <0x78 0xc0000>,
+					 <0x78 0x300000>,
+					 <0x78 0xc00000>;
+			clock-input = <&ipg_per_clk 0>;
+			clock-input-name = "ipg-per";
+			clock-output-name = "pwm1",
+					    "pwm2",
+					    "pwm3",
+					    "pwm4";
+		};
+
+		sata_clk: sata {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x7c 0x30>;
+			clock-input = <&ipg_clk 0>;
+			clock-input-name = "ipg";
+			clock-output-name = "sata";
+		};
+
+		sdma_clk: sdma {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x7c 0xc0>;
+			clock-input = <&ahb_clk 0>;
+			clock-input-name = "ahb";
+			clock-output-name = "sdma";
+		};
+
+		spba_clk: spba {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x7c 0x3000>;
+			clock-input = <&ipg_clk 0>;
+			clock-input-name = "ipg";
+			clock-output-name = "spba";
+		};
+
+		ssi_clk: ssi {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <3>;
+			imx,clock-gate = <0x7c 0xc0000>,
+					 <0x7c 0x300000>,
+					 <0x7c 0xc00000>;
+			imx,clock-divider = <0x28 6 3 0 6>,
+					    <0x2c 6 3 0 6>,
+					    <0x28 6 3 0 6>;
+			imx,clock-multiplexer = <0x1c 10 2>,
+						<0x1c 12 2>,
+						<0x1c 14 2>;
+			clock-input = <&pll3_pfd_clk 2 0 0 0>,
+				      <&pll3_pfd_clk 3 0 0 0>,
+				      <&pll_av_clk 0 0>;
+			clock-input-name = "pll3-pfd-508m",
+					   "pll3-pfd-454m",
+					   "pll4-audio";
+			clock-output-name = "ssi1",
+					    "ssi2",
+					    "ssi3";
+		};
+
+		uart_clk: uart {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <2>;
+			imx,clock-gate = <0x7c 0x3000000>,
+					 <0x7c 0xc000000>;
+			imx,clock-divider = <0x24 0 0 0 6>,
+					    <0x24 0 0 0 6>;
+			clock-input = <&pll3_div_clk 1 0 0>;
+			clock-input-name = "pll3-80m";
+			clock-output-name = "uart",
+					    "uart-serial";
+		};
+
+		usboh3_clk: usboh3 {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x80 0x3>;
+			clock-input = <&ipg_clk 0>;
+			clock-input-name = "ipg";
+			clock-output-name = "usboh3";
+		};
+
+		usdhc_clk: usdhc {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <4>;
+			imx,clock-gate = <0x80 0xc>,
+					 <0x80 0x30>,
+					 <0x80 0xc0>,
+					 <0x80 0x300>;
+			imx,clock-divider = <0x24 0 0 11 3>,
+					    <0x24 0 0 16 3>,
+					    <0x24 0 0 19 3>,
+					    <0x24 0 0 22 3>;
+			imx,clock-multiplexer = <0x1c 16 1>,
+						<0x1c 17 1>,
+						<0x1c 18 1>,
+						<0x1c 19 1>;
+			clock-input = <&pll2_pfd_clk 2 0 0>,
+				      <&pll2_pfd_clk 0 0 0>;
+			clock-input-name = "pll2-pfd-400m",
+					   "pll2-pfd-352m";
+			clock-output-name = "usdhc1",
+					    "usdhc2",
+					    "usdhc3",
+					    "usdhc3";
+		};
+
+		enfc_clk: enfc {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x70 0xc000>;
+			imx,clock-divider = <0x2c 18 3 21 6>;
+			imx,clock-multiplexer = <0x2c 16 2>;
+			clock-input = <&pll2_pfd_clk 0 0 0>,
+				      <&pll_bus_clk 0>,
+				      <&pll_usb_clk 0 0>,
+				      <&pll2_pfd_clk 2 0 0>;
+			clock-input-name = "pll2-pfd-352m",
+					   "pll2-bus",
+					   "pll3-usb-otg",
+					   "pll2-pfd-400m";
+			clock-output-name = "enfc";
+		};
+
+		gpmi_bch_apb_clk: gpmi-bch-apb {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x78 0x3000000>;
+			clock-input = <&usdhc_clk 2 0 0 0>;
+			clock-input-name = "usdhc3";
+			clock-output-name = "gpmi-bch-apb";
+		};
+
+		gpmi_bch_clk: gpmi-bch {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x78 0xc000000>;
+			clock-input = <&usdhc_clk 3 0 0 0>;
+			clock-input-name = "usdhc4";
+			clock-output-name = "gpmi-bch";
+		};
+
+		gpmi_io_clk: gpmi-io {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x78 0x30000000>;
+			clock-input = <&enfc_clk 0>;
+			clock-input-name = "enfc";
+			clock-output-name = "gpmi-io";
+		};
+
+		gpmi_apb_clk: gpmi-apb {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x78 0xc0000000>;
+			clock-input = <&usdhc_clk 2 0 0 0>;
+			clock-input-name = "usdhc3";
+			clock-output-name = "gpmi-apb";
+		};
+
+		emi_clk: emi {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <2>;
+			imx,clock-gate = <0x80 0xc00>,
+					 <0x80 0xc00>;
+			imx,clock-divider = <0x1c 0 0 20 3>,
+					    <0x1c 0 0 23 3>;
+			imx,clock-multiplexer = <0x1c 27 2>,
+						<0x1c 29 2>;
+			clock-input = <&axi_clk 0>,
+				      <&pll_usb_clk 0 0>,
+				      <&pll2_pfd_clk 2 0 0>,
+				      <&pll2_pfd_clk 0 0 0>;
+			clock-input-name = "axi",
+					   "pll3-usb-otg",
+					   "pll2-pfd-400m",
+					   "pll2-pfd-352m";
+			clock-output-name = "emi",
+					    "emi-slow";
+		};
+
+		vdo_axi_clk: vdo-axi {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x80 0x3000>;
+			imx,clock-multiplexer = <0x18 11 1>;
+			clock-input = <&axi_clk 0>,
+				      <&ahb_clk 0>;
+			clock-input-name = "axi",
+					   "ahb";
+			clock-output-name = "vdo-axi";
+		};
+
+		vpu_axi_clk: vpu-axi {
+			compatible = "fsl,imx6q-clock";
+			#clock-cells = <1>;
+			imx,clock-gate = <0x80 0xc000>;
+			imx,clock-divider = <0x24 0 0 25 3>;
+			imx,clock-multiplexer = <0x18 14 2>;
+			clock-input = <&axi_clk 0>,
+				      <&pll2_pfd_clk 2 0 0>,
+				      <&pll2_pfd_clk 0 0 0>;
+			clock-input-name = "axi",
+					   "pll2-pfd-400m",
+					   "pll2-pfd-352m";
+			clock-output-name = "vpu-axi";
 		};
 	};
 
@@ -169,6 +1072,8 @@
 					compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
 					reg = <0x02020000 0x4000>;
 					interrupts = <0 26 0x04>;
+					clock-input = <&uart_clk 0 0>;
+					clock-input-name = "uart";
 					status = "disabled";
 				};
 
@@ -245,6 +1150,8 @@
 				compatible = "fsl,imx6q-gpt";
 				reg = <0x02098000 0x4000>;
 				interrupts = <0 55 0x04>;
+				clock-input = <&gpt_clk 0 0>,
+					      <&gpt_clk 1 0>;
 			};
 
 			gpio0: gpio at 0209c000 { /* GPIO1 */
@@ -426,6 +1333,8 @@
 				compatible = "fsl,imx6q-fec";
 				reg = <0x02188000 0x4000>;
 				interrupts = <0 118 0x04 0 119 0x04>;
+				clock-input = <&enet_clk 0>;
+				clock-input-name = "enet";
 				status = "disabled";
 			};
 
@@ -438,6 +1347,8 @@
 				compatible = "fsl,imx6q-usdhc";
 				reg = <0x02190000 0x4000>;
 				interrupts = <0 22 0x04>;
+				clock-input = <&usdhc_clk 0 0 0 0>;
+				clock-input-name = "usdhc1";
 				status = "disabled";
 			};
 
@@ -445,6 +1356,8 @@
 				compatible = "fsl,imx6q-usdhc";
 				reg = <0x02194000 0x4000>;
 				interrupts = <0 23 0x04>;
+				clock-input = <&usdhc_clk 1 0 0 0>;
+				clock-input-name = "usdhc2";
 				status = "disabled";
 			};
 
@@ -452,6 +1365,8 @@
 				compatible = "fsl,imx6q-usdhc";
 				reg = <0x02198000 0x4000>;
 				interrupts = <0 24 0x04>;
+				clock-input = <&usdhc_clk 2 0 0 0>;
+				clock-input-name = "usdhc3";
 				status = "disabled";
 			};
 
@@ -459,6 +1374,8 @@
 				compatible = "fsl,imx6q-usdhc";
 				reg = <0x0219c000 0x4000>;
 				interrupts = <0 25 0x04>;
+				clock-input = <&usdhc_clk 3 0 0 0>;
+				clock-input-name = "usdhc4";
 				status = "disabled";
 			};
 
@@ -547,6 +1464,8 @@
 				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
 				reg = <0x021e8000 0x4000>;
 				interrupts = <0 27 0x04>;
+				clock-input = <&uart_clk 0 0>;
+				clock-input-name = "uart";
 				status = "disabled";
 			};
 
@@ -554,6 +1473,8 @@
 				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
 				reg = <0x021ec000 0x4000>;
 				interrupts = <0 28 0x04>;
+				clock-input = <&uart_clk 0 0>;
+				clock-input-name = "uart";
 				status = "disabled";
 			};
 
@@ -561,6 +1482,8 @@
 				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
 				reg = <0x021f0000 0x4000>;
 				interrupts = <0 29 0x04>;
+				clock-input = <&uart_clk 0 0>;
+				clock-input-name = "uart";
 				status = "disabled";
 			};
 
@@ -568,6 +1491,8 @@
 				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
 				reg = <0x021f4000 0x4000>;
 				interrupts = <0 30 0x04>;
+				clock-input = <&uart_clk 0 0>;
+				clock-input-name = "uart";
 				status = "disabled";
 			};
 		};
-- 
1.7.4.1
