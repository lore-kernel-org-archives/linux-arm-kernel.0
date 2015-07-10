From: jianwei.wang@freescale.com (Jianwei Wang)
Date: Fri, 10 Jul 2015 15:26:54 +0800
Subject: [PATCH v6 3/4] arm/dts/ls1021a: Add DCU dts node
In-Reply-To: <1436513215-43423-1-git-send-email-jianwei.wang@freescale.com>
References: <1436513215-43423-1-git-send-email-jianwei.wang@freescale.com>
Message-ID: <1436513215-43423-3-git-send-email-jianwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DCU node, DCU is a display controller of Freescale
named 2D-ACE.

Signed-off-by: Alison Wang <b18965@freescale.com>
Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
Signed-off-by: Jianwei Wang <jianwei.wang@freescale.com>
---
 .../devicetree/bindings/drm/fsl-dcu/fsl,dcu.txt    | 49 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 arch/arm/boot/dts/ls1021a.dtsi                     | 10 +++++
 3 files changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/drm/fsl-dcu/fsl,dcu.txt

diff --git a/Documentation/devicetree/bindings/drm/fsl-dcu/fsl,dcu.txt b/Documentation/devicetree/bindings/drm/fsl-dcu/fsl,dcu.txt
new file mode 100644
index 0000000..d65631d
--- /dev/null
+++ b/Documentation/devicetree/bindings/drm/fsl-dcu/fsl,dcu.txt
@@ -0,0 +1,49 @@
+Device Tree bindings for Freescale DCU DRM Driver
+
+Required properties:
+- compatible:           Should be one of
+	* "fsl,ls1021a-dcu".
+	* "fsl,vf610-dcu".
+- reg:                  Address and length of the register set for dcu.
+- clocks:               From common clock binding: handle to dcu clock.
+- clock-names:          From common clock binding: Shall be "dcu".
+- display:              The phandle to display node.
+
+Required properties:
+- bits-per-pixel:       <16> for RGB565,
+			<24> for RGB888,
+			<32> for RGB8888.
+
+Required timing node for dispplay sub-node:
+- display-timings:      Refer to binding doc display-timing.txt for details.
+
+Examples:
+dcu: dcu at 2ce0000 {
+	compatible = "fsl,ls1021a-dcu";
+	reg = <0x0 0x2ce0000 0x0 0x10000>;
+	clocks = <&platform_clk 0>;
+	clock-names = "dcu";
+	big-endian;
+	display = <&display>;
+
+	display: display at 0 {
+		bits-per-pixel = <24>;
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: nl4827hc19 {
+				clock-frequency = <10870000>;
+				hactive = <480>;
+				vactive = <272>;
+				hback-porch = <2>;
+				hfront-porch = <2>;
+				vback-porch = <1>;
+				vfront-porch = <1>;
+				hsync-len = <41>;
+				vsync-len = <2>;
+				hsync-active = <1>;
+				vsync-active = <1>;
+			};
+		};
+	};
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 9047c2b..b8d6ef5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3410,6 +3410,7 @@ M:	Alison Wang <alison.wang@freescale.com>
 L:	dri-devel at lists.freedesktop.org
 S:	Supported
 F:	drivers/gpu/drm/fsl-dcu/
+F:	Documentation/devicetree/bindings/drm/fsl-dcu/
 F:	Documentation/devicetree/bindings/panel/nec,nl4827hc19_05b.txt
 
 DRM DRIVERS FOR NVIDIA TEGRA
diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c70bb27..6d6e3e2 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -383,6 +383,16 @@
 				 <&platform_clk 1>;
 		};
 
+		dcu: dcu at 2ce0000 {
+			compatible = "fsl,ls1021a-dcu";
+			reg = <0x0 0x2ce0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&platform_clk 0>;
+			clock-names = "dcu";
+			big-endian;
+			status = "disabled";
+		};
+
 		mdio0: mdio at 2d24000 {
 			compatible = "gianfar";
 			device_type = "mdio";
-- 
2.1.0.27.g96db324
