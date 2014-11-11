From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 11 Nov 2014 19:12:47 -0200
Subject: [PATCH] ARM: dts: imx6qdl: Enable CODA960 VPU
Message-ID: <1415740367-326-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

This patch adds links to the on-chip SRAM and reset controller nodes
and switches the interrupts. Make the BIT processor interrupt, which exists on
all variants, the first one. The JPEG unit interrupt, which does not exist on
i.MX27 and i.MX5 thus is an optional second interrupt.
Use different compatible strings for i.MX6Q/D and i.MX6S/DL, as they have to
load separate firmware images for some reason.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6dl.dtsi  | 4 ++++
 arch/arm/boot/dts/imx6q.dtsi   | 4 ++++
 arch/arm/boot/dts/imx6qdl.dtsi | 8 ++++++++
 3 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 44d8876..1ac2fe7 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -118,3 +118,7 @@
 		      "di0_sel", "di1_sel",
 		      "di0", "di1";
 };
+
+&vpu {
+	compatible = "fsl,imx6dl-vpu", "cnm,coda960";
+};
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index e9f3646..85f72e6 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -308,3 +308,7 @@
 		};
 	};
 };
+
+&vpu {
+	compatible = "fsl,imx6q-vpu", "cnm,coda960";
+};
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 9596ed5..e529308 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -333,9 +333,17 @@
 			};
 
 			vpu: vpu at 02040000 {
+				compatible = "cnm,coda960";
 				reg = <0x02040000 0x3c000>;
 				interrupts = <0 3 IRQ_TYPE_LEVEL_HIGH>,
 				             <0 12 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "bit", "jpeg";
+				clocks = <&clks IMX6QDL_CLK_VPU_AXI>,
+					 <&clks IMX6QDL_CLK_MMDC_CH0_AXI>,
+					 <&clks IMX6QDL_CLK_OCRAM>;
+				clock-names = "per", "ahb", "ocram";
+				resets = <&src 1>;
+				iram = <&ocram>;
 			};
 
 			aipstz at 0207c000 { /* AIPSTZ1 */
-- 
1.9.1
