From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 13 May 2015 23:23:45 +0800
Subject: [RFC][PATCH 1/2] dt-bindings: drm/mediatek: Add Mediatek DRM dts
 binding
In-Reply-To: <1431530626-31493-1-git-send-email-ck.hu@mediatek.com>
References: <1431530626-31493-1-git-send-email-ck.hu@mediatek.com>
Message-ID: <1431530626-31493-2-git-send-email-ck.hu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch includes
1. Mediatek DRM Device binding
2. Mediatek DSI Device binding
3. Mediatek CRTC Main Device binding
4. Mediatek DDP Device binding

Signed-off-by: CK Hu <ck.hu@mediatek.com>
---
 .../bindings/drm/mediatek/mediatek,crtc-main.txt   | 38 ++++++++++++++++++++++
 .../bindings/drm/mediatek/mediatek,ddp.txt         | 22 +++++++++++++
 .../bindings/drm/mediatek/mediatek,drm.txt         | 27 +++++++++++++++
 .../bindings/drm/mediatek/mediatek,dsi.txt         | 20 ++++++++++++
 4 files changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/drm/mediatek/mediatek,crtc-main.txt
 create mode 100644 Documentation/devicetree/bindings/drm/mediatek/mediatek,ddp.txt
 create mode 100644 Documentation/devicetree/bindings/drm/mediatek/mediatek,drm.txt
 create mode 100644 Documentation/devicetree/bindings/drm/mediatek/mediatek,dsi.txt

diff --git a/Documentation/devicetree/bindings/drm/mediatek/mediatek,crtc-main.txt b/Documentation/devicetree/bindings/drm/mediatek/mediatek,crtc-main.txt
new file mode 100644
index 0000000..5c6c420
--- /dev/null
+++ b/Documentation/devicetree/bindings/drm/mediatek/mediatek,crtc-main.txt
@@ -0,0 +1,38 @@
+Mediatek CRTC Main Device
+================================
+
+The Mediatek CRTC Main device is a crtc device of DRM system.
+
+Required properties:
+- compatible: "mediatek,<chip>-crtc-main"
+- interrupts: The interrupt signal from the CRTC Main block.
+- reg: Physical base address and length of the controller's registers
+- clocks: device clocks
+  See Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
+- ddp: phandle of ddp device which control display data path.
+
+Example:
+
+crtc_main: crtc at 1400c000 {
+	compatible = "mediatek,mt8173-crtc-main";
+	interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_LOW>;
+	reg = <0 0x1400c000 0 0x1000>,	/* OVL0 */
+	      <0 0x1400e000 0 0x1000>,	/* RDMA0 */
+	      <0 0x14013000 0 0x1000>,	/* COLOR0 */
+	      <0 0x14015000 0 0x1000>,	/* AAL */
+	      <0 0x1401a000 0 0x1000>,	/* UFOE */
+	      <0 0x14023000 0 0x1000>;	/* OD */
+	clocks = <&mmsys MM_DISP_OVL0>,
+		 <&mmsys MM_DISP_RDMA0>,
+		 <&mmsys MM_DISP_COLOR0>,
+		 <&mmsys MM_DISP_AAL>,
+		 <&mmsys MM_DISP_UFOE>,
+		 <&mmsys MM_DISP_OD>;
+	clock-names = "ovl0_disp",
+		      "rdma0_disp",
+		      "color0_disp",
+		      "aal_disp",
+		      "ufoe_disp",
+		      "od_disp";
+	ddp = <&ddp>;
+};
\ No newline at end of file
diff --git a/Documentation/devicetree/bindings/drm/mediatek/mediatek,ddp.txt b/Documentation/devicetree/bindings/drm/mediatek/mediatek,ddp.txt
new file mode 100644
index 0000000..77cf630
--- /dev/null
+++ b/Documentation/devicetree/bindings/drm/mediatek/mediatek,ddp.txt
@@ -0,0 +1,22 @@
+Mediatek DDP Device
+================================
+
+The Mediatek DDP device control the display data path.
+
+Required properties:
+- compatible: "mediatek,<chip>-ddp"
+- reg: Physical base address and length of the controller's registers
+- power-domains: a phandle to DDP power domain node.
+- clocks: device clocks
+  See Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
+
+Example:
+
+ddp: ddp at 14000000 {
+	compatible = "mediatek,mt8173-ddp";
+	reg = <0 0x14000000 0 0x100>,	/* CONFIG */
+	      <0 0x14020000 0 0x1000>;	/* MUTEX */
+	power-domains = <&scpsys MT8173_POWER_DOMAIN_DIS>;
+	clocks = <&mmsys MM_MUTEX_32K>;
+	clock-names = "mutex_disp";
+};
\ No newline at end of file
diff --git a/Documentation/devicetree/bindings/drm/mediatek/mediatek,drm.txt b/Documentation/devicetree/bindings/drm/mediatek/mediatek,drm.txt
new file mode 100644
index 0000000..c4a5702
--- /dev/null
+++ b/Documentation/devicetree/bindings/drm/mediatek/mediatek,drm.txt
@@ -0,0 +1,27 @@
+Mediatek DRM Device
+================================
+
+The Mediatek DRM device is a device needed to list all
+display component nodes that comprise the display subsystem.
+And it list the memory-related interface.
+
+Required properties:
+- compatible: "mediatek,<chip>-drm"
+- larb: Should contain a list of phandles pointing to larb device.
+  larb definitions as defined in
+  Documentation/devicetree/bindings/soc/mediatek/mediatek,smi-larb.txt
+- iommus: required a iommu node
+- connectors: Should contain a list of phandles pointing to connector device.
+  connector device should be one component of this master.
+- crtcs: Should contain a list of phandles pointing to crtc device.
+  crtc device should be one component of this master.
+
+Example:
+
+drm0: drm {
+	compatible = "mediatek,mt8173-drm";
+	larb = <&larb0>;
+	iommus = <&iommu M4U_PORT_DISP_OVL0>;
+	connectors = <&dsi>;
+	crtcs = <&crtc_main>;
+};
\ No newline at end of file
diff --git a/Documentation/devicetree/bindings/drm/mediatek/mediatek,dsi.txt b/Documentation/devicetree/bindings/drm/mediatek/mediatek,dsi.txt
new file mode 100644
index 0000000..16e3eb3
--- /dev/null
+++ b/Documentation/devicetree/bindings/drm/mediatek/mediatek,dsi.txt
@@ -0,0 +1,20 @@
+Mediatek DSI Device
+================================
+
+The Mediatek DSI device is a connector device of DRM system.
+
+Required properties:
+- compatible: "mediatek,<chip>-dsi"
+- reg: Physical base address and length of the controller's registers
+- clocks: device clocks
+  See Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
+
+Example:
+
+dsi: dsi at 10215000 {
+	compatible = "mediatek,mt8173-dsi";
+	reg = <0 0x1401B000 0 0x1000>,	/* DSI0 */
+	      <0 0x10215000 0 0x1000>;  /* MIPITX */
+	clocks = <&mmsys MM_DSI0_ENGINE>,	<&mmsys MM_DSI0_DIGITAL>;
+	clock-names = "dsi0_engine_disp_ck", "dsi0_digital_disp_ck";
+};
\ No newline at end of file
-- 
1.8.1.1.dirty
