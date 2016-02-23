From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Tue, 23 Feb 2016 11:00:21 +0800
Subject: [PATCH v5 01/11] drm/hisilicon: Add device tree binding for hi6220
 display subsystem
In-Reply-To: <1456196431-19923-1-git-send-email-xinliang.liu@linaro.org>
References: <1456196431-19923-1-git-send-email-xinliang.liu@linaro.org>
Message-ID: <1456196431-19923-2-git-send-email-xinliang.liu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ADE display controller binding doc.
Add DesignWare DSI Host Controller v1.20a binding doc.

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

Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
---
 .../bindings/display/hisilicon/dw-dsi.txt          | 72 ++++++++++++++++++++++
 .../bindings/display/hisilicon/hisi-ade.txt        | 64 +++++++++++++++++++
 2 files changed, 136 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/hisilicon/dw-dsi.txt
 create mode 100644 Documentation/devicetree/bindings/display/hisilicon/hisi-ade.txt

diff --git a/Documentation/devicetree/bindings/display/hisilicon/dw-dsi.txt b/Documentation/devicetree/bindings/display/hisilicon/dw-dsi.txt
new file mode 100644
index 000000000000..0d234b5e19af
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
+- clocks: the clocks needed.
+- clock-names: the name of the clocks.
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
+		clock-names = "pclk_dsi";
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
index 000000000000..c1844b3ff878
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
+  Value should be "<0x0 0xf4100000 0x0 0x7800>".
+- reg-names: name of physical base. Value should be "ade_base".
+- hisilicon,noc-syscon: ADE NOC QoS syscon. Value should be "<&medianoc_ade>"
+- resets: The ADE reset controller node. Value should be "<&media_ctrl
+  MEDIA_ADE>".
+- interrupt: the ldi vblank interrupt number used.
+- clocks: the clocks needed. Three clocks are used in ADE driver:
+  ADE core clock, value should be "<&media_ctrl HI6220_ADE_CORE>";
+  ADE pixel clok, value should be "<&media_ctrl HI6220_ADE_PIX_SRC>";
+  media NOC QoS clock, value should be "<&media_ctrl HI6220_CODEC_JPEG>".
+- clock-names: the name of the clocks. Values should be "clk_ade_core",
+  "clk_codec_jpeg" and "clk_ade_pix".
+- assigned-clocks: clocks to be assigned rate.
+- assigned-clock-rates: clock rates which are assigned to assigned-clocks.
+  The rate of <&media_ctrl HI6220_ADE_CORE> could be "360000000" or
+  "180000000";
+  The rate of <&media_ctrl HI6220_CODEC_JPEG> could be less than "1440000000".
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
1.9.1
