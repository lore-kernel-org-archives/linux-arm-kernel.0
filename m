From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Wed, 29 Mar 2017 15:25:19 +0200
Subject: [PATCH v1 1/8] dt-bindings: Document STM32 DCMI bindings
In-Reply-To: <1490793926-6477-1-git-send-email-hugues.fruchet@st.com>
References: <1490793926-6477-1-git-send-email-hugues.fruchet@st.com>
Message-ID: <1490793926-6477-2-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds documentation of device tree bindings for the STM32 DCMI
(Digital Camera Memory Interface).

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 .../devicetree/bindings/media/st,stm32-dcmi.txt    | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/st,stm32-dcmi.txt

diff --git a/Documentation/devicetree/bindings/media/st,stm32-dcmi.txt b/Documentation/devicetree/bindings/media/st,stm32-dcmi.txt
new file mode 100644
index 0000000..f0dc709
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/st,stm32-dcmi.txt
@@ -0,0 +1,77 @@
+STMicroelectronics STM32 Digital Camera Memory Interface (DCMI)
+
+Required properties:
+- compatible: "st,stm32-dcmi"
+- reg: physical base address and length of the registers set for the device;
+- interrupts: should contain IRQ line for the DCMI;
+- clocks: list of clock specifiers, corresponding to entries in
+          the clock-names property;
+- clock-names: must contain "mclk", which is the DCMI peripherial clock.
+- resets: Reference to a reset controller
+- reset-names: see Documentation/devicetree/bindings/reset/st,stm32-rcc.txt
+
+DCMI supports a single port node with parallel bus. It should contain one
+'port' child node with child 'endpoint' node. Please refer to the bindings
+defined in Documentation/devicetree/bindings/media/video-interfaces.txt.
+
+Example:
+
+Device node example
+-------------------
+	dcmi: dcmi at 50050000 {
+		compatible = "st,stm32-dcmi";
+		reg = <0x50050000 0x400>;
+		interrupts = <78>;
+		resets = <&rcc STM32F4_AHB2_RESET(DCMI)>;
+		clocks = <&rcc 0 STM32F4_AHB2_CLOCK(DCMI)>;
+		clock-names = "mclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&dcmi_pins>;
+		dmas = <&dma2 1 1 0x414 0x3>;
+		dma-names = "tx";
+		status = "disabled";
+	};
+
+Board setup example
+-------------------
+
+&dcmi {
+	status = "okay";
+
+	port {
+		dcmi_0: endpoint at 0 {
+			remote-endpoint = <&ov2640_0>;
+			bus-width = <8>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			pclk-sample = <1>;
+		};
+	};
+};
+
+{
+	[...]
+	i2c at 0 {
+		ov2640: camera at 30 {
+			compatible = "ovti,ov2640";
+			reg = <0x30>;
+			resetb-gpios = <&stmpegpio 2 GPIO_ACTIVE_HIGH>;
+			pwdn-gpios = <&stmpegpio 0 GPIO_ACTIVE_LOW>;
+			clocks = <&clk_ext_camera>;
+			clock-names = "xvclk";
+			status = "okay";
+
+			port {
+				ov2640_0: endpoint {
+					remote-endpoint = <&dcmi_0>;
+				};
+			};
+		};
+	};
+
+	clk_ext_camera: clk-ext-camera {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+	};
+}
-- 
1.9.1
