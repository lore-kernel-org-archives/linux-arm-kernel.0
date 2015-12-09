From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed,  9 Dec 2015 12:48:25 +0100
Subject: [PATCH v2 12/14] ARM: dts: imx6: add Vivante GPU nodes
In-Reply-To: <1449661707-30532-1-git-send-email-l.stach@pengutronix.de>
References: <1449661707-30532-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1449661707-30532-12-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the device nodes for 2D, 3D and VG GPU cores.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl.dtsi  |  5 +++++
 arch/arm/boot/dts/imx6q.dtsi   | 15 +++++++++++++++
 arch/arm/boot/dts/imx6qdl.dtsi | 22 ++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 4b0ec0703825..51c517a5cafd 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -104,6 +104,11 @@
 		compatible = "fsl,imx-display-subsystem";
 		ports = <&ipu1_di0>, <&ipu1_di1>;
 	};
+
+	gpu-subsystem {
+		compatible = "fsl,imx-gpu-subsystem";
+		cores = <&gpu_2d>, <&gpu_3d>;
+	};
 };
 
 &gpt {
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 399103b8e2c9..77d618b2870c 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -153,6 +153,16 @@
 			status = "disabled";
 		};
 
+		gpu_vg: gpu at 02204000 {
+			compatible = "vivante,gc";
+			reg = <0x02204000 0x4000>;
+			interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks IMX6QDL_CLK_OPENVG_AXI>,
+				 <&clks IMX6QDL_CLK_GPU2D_CORE>;
+			clock-names = "bus", "core";
+			power-domains = <&gpc 1>;
+		};
+
 		ipu2: ipu at 02800000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -225,6 +235,11 @@
 		compatible = "fsl,imx-display-subsystem";
 		ports = <&ipu1_di0>, <&ipu1_di1>, <&ipu2_di0>, <&ipu2_di1>;
 	};
+
+	gpu-subsystem {
+		compatible = "fsl,imx-gpu-subsystem";
+		cores = <&gpu_2d>, <&gpu_3d>, <&gpu_vg>;
+	};
 };
 
 &hdmi {
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 2b6cc8bf3c5c..018975b867e1 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -119,6 +119,28 @@
 			status = "disabled";
 		};
 
+
+		gpu_2d: gpu at 00134000 {
+			compatible = "vivante,gc";
+			reg = <0x00134000 0x4000>;
+			interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks IMX6QDL_CLK_GPU2D_AXI>,
+				 <&clks IMX6QDL_CLK_GPU2D_CORE>;
+			clock-names = "bus", "core";
+			power-domains = <&gpc 1>;
+		};
+
+		gpu_3d: gpu at 00130000 {
+			compatible = "vivante,gc";
+			reg = <0x00130000 0x4000>;
+			interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks IMX6QDL_CLK_GPU3D_AXI>,
+				 <&clks IMX6QDL_CLK_GPU3D_CORE>,
+				 <&clks IMX6QDL_CLK_GPU3D_SHADER>;
+			clock-names = "bus", "core", "shader";
+			power-domains = <&gpc 1>;
+		};
+
 		hdmi: hdmi at 0120000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.6.2
