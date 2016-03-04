From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Fri,  4 Mar 2016 18:54:27 +0800
Subject: [PATCH v7 01/11] drm/hisilicon: Add device tree binding for hi6220
 display subsystem
In-Reply-To: <1457088877-131022-1-git-send-email-xinliang.liu@linaro.org>
References: <1457088877-131022-1-git-send-email-xinliang.liu@linaro.org>
Message-ID: <1457088877-131022-2-git-send-email-xinliang.liu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ADE display controller binding doc.
Add DesignWare DSI Host Controller v1.20a binding doc.

v7: Acked by Rob Herring.
v6:
- Cleanup values part of reg and clocks properties.
- Change "pclk_dsi" clock name to "pclk".
v5:
- Remove endpoint unit address of dsi output port.
- Add "hisilicon,noc-syscon" property for ADE NOC QoS syscon.
- Add "resets" property for ADE reset.
v4:
- Describe more specific of clocks and ports.
- Fix indentation.
v3:
- Make ade as the drm master node.
- Use assigned-clocks to set clock rate.
- Use ports to connect display relavant nodes.
v2:
- Move dt binding docs to bindings/display/hisilicon directory.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/display/hisilicon/dw-dsi.txt          | 72 ++++++++++++++++++++++
 .../bindings/display/hisilicon/hisi-ade.txt        | 64 +++++++++++++++++++
 2 files changed, 136 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/hisilicon/dw-dsi.txt
 create mode 100644 Documentation/devicetree/bindings/display/hisilicon/hisi-ade.txt

diff --git a/Documentation/devicetree/bindings/display/hisilicon/dw-dsi.txt b/Documentation/devicetree/bindings/display/hisilicon/dw-dsi.txt
new file mode 100644
index 000000000000..d270bfe4e4e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/hisilicon/dw-dsi.txt
@@ -0,0 +1,72 @@
+Device-Tree bindings for DesignWare DSI Host Controller v1.20a driver
+
+A DSI Host Controller resides in the middle of display controller and external
+HDMI converter or panel.
+
+Required properties:
+- compatible: value should be "hisilicon,hi6220-dsi".
+- reg: physical base address and length of dsi controller's registers.
+- clocks: contains APB clock phandle + clock-specifier pair.
+- clock-names: should be "pclk".
+- ports: contains DSI controller input and output sub port.
+  The input port connects to ADE output port with the reg value "0".
+  The output port with the reg value "1", it could connect to panel or
+  any other bridge endpoints.
+  See Documentation/devicetree/bindings/graph.txt for more device graph info.
+
+A example of HiKey board hi6220 SoC and board specific DT entry:
+Example:
+
+SoC specific:
+	dsi: dsi at f4107800 {
+		compatible = "hisilicon,hi6220-dsi";
+		reg = <0x0 0xf4107800 0x0 0x100>;
+		clocks = <&media_ctrl  HI6220_DSI_PCLK>;
+		clock-names = "pclk";
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* 0 for input port */
+			port at 0 {
+				reg = <0>;
+				dsi_in: endpoint {
+					remote-endpoint = <&ade_out>;
+				};
+			};
+		};
+	};
+
+
+Board specific:
+	&dsi {
+		status = "ok";
+
+		ports {
+			/* 1 for output port */
+			port at 1 {
+				reg = <1>;
+
+				dsi_out0: endpoint at 0 {
+					remote-endpoint = <&adv7533_in>;
+				};
+			};
+		};
+	};
+
+	&i2c2 {
+		...
+
+		adv7533: adv7533 at 39 {
+			...
+
+			port {
+				adv7533_in: endpoint {
+					remote-endpoint = <&dsi_out0>;
+				};
+			};
+		};
+	};
+
diff --git a/Documentation/devicetree/bindings/display/hisilicon/hisi-ade.txt b/Documentation/devicetree/bindings/display/hisilicon/hisi-ade.txt
new file mode 100644
index 000000000000..38dc9d60eef8
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/hisilicon/hisi-ade.txt
@@ -0,0 +1,64 @@
+Device-Tree bindings for hisilicon ADE display controller driver
+
+ADE (Advanced Display Engine) is the display controller which grab image
+data from memory, do composition, do post image processing, generate RGB
+timing stream and transfer to DSI.
+
+Required properties:
+- compatible: value should be "hisilicon,hi6220-ade".
+- reg: physical base address and length of the ADE controller's registers.
+- hisilicon,noc-syscon: ADE NOC QoS syscon.
+- resets: The ADE reset controller node.
+- interrupt: the ldi vblank interrupt number used.
+- clocks: a list of phandle + clock-specifier pairs, one for each entry
+  in clock-names.
+- clock-names: should contain:
+  "clk_ade_core" for the ADE core clock.
+  "clk_codec_jpeg" for the media NOC QoS clock, which use the same clock with
+  jpeg codec.
+  "clk_ade_pix" for the ADE pixel clok.
+- assigned-clocks: Should contain "clk_ade_core" and "clk_codec_jpeg" clocks'
+  phandle + clock-specifier pairs.
+- assigned-clock-rates: clock rates, one for each entry in assigned-clocks.
+  The rate of "clk_ade_core" could be "360000000" or "180000000";
+  The rate of "clk_codec_jpeg" could be or less than "1440000000".
+  These rate values could be configured according to performance and power
+  consumption.
+- port: the output port. This contains one endpoint subnode, with its
+  remote-endpoint set to the phandle of the connected DSI input endpoint.
+  See Documentation/devicetree/bindings/graph.txt for more device graph info.
+
+Optional properties:
+- dma-coherent: Present if dma operations are coherent.
+
+
+A example of HiKey board hi6220 SoC specific DT entry:
+Example:
+
+	ade: ade at f4100000 {
+		compatible = "hisilicon,hi6220-ade";
+		reg = <0x0 0xf4100000 0x0 0x7800>;
+		reg-names = "ade_base";
+		hisilicon,noc-syscon = <&medianoc_ade>;
+		resets = <&media_ctrl MEDIA_ADE>;
+		interrupts = <0 115 4>; /* ldi interrupt */
+
+		clocks = <&media_ctrl HI6220_ADE_CORE>,
+			 <&media_ctrl HI6220_CODEC_JPEG>,
+			 <&media_ctrl HI6220_ADE_PIX_SRC>;
+		/*clock name*/
+		clock-names  = "clk_ade_core",
+			       "clk_codec_jpeg",
+			       "clk_ade_pix";
+
+		assigned-clocks = <&media_ctrl HI6220_ADE_CORE>,
+			<&media_ctrl HI6220_CODEC_JPEG>;
+		assigned-clock-rates = <360000000>, <288000000>;
+		dma-coherent;
+
+		port {
+			ade_out: endpoint {
+				remote-endpoint = <&dsi_in>;
+			};
+		};
+	};
-- 
2.7.1
