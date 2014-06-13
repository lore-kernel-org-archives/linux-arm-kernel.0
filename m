From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 13 Jun 2014 19:14:01 +0200
Subject: [PATCH 4/4] ARM: dts: imx6qdl: Enable CODA960 VPU
In-Reply-To: <1402679641-868-1-git-send-email-p.zabel@pengutronix.de>
References: <1402679641-868-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1402679641-868-4-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds links to the on-chip SRAM and reset controller nodes
and switches the interrupts. Make the BIT processor interrupt, which exists on
all variants, the first one. The JPEG unit interrupt, which does not exist on
i.MX27 and i.MX5 thus is an optional second interrupt.
Use different compatible strings for i.MX6Q/D and i.MX6S/DL, as they have to
load separate firmware images for some reason.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl.dtsi  |  4 ++++
 arch/arm/boot/dts/imx6q.dtsi   |  4 ++++
 arch/arm/boot/dts/imx6qdl.dtsi | 10 ++++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 5c5f574..fbbdfca 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -110,3 +110,7 @@
 		      "di0_sel", "di1_sel",
 		      "di0", "di1";
 };
+
+&vpu {
+	compatible = "fsl,imx6dl-vpu", "cnm,coda960";
+};
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index addd3f8..2c1dbf8 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -291,3 +291,7 @@
 		};
 	};
 };
+
+&vpu {
+	compatible = "fsl,imx6q-vpu", "cnm,coda960";
+};
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index eca0971..2052303 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -315,9 +315,15 @@
 			};
 
 			vpu: vpu at 02040000 {
+				compatible = "cnm,coda960";
 				reg = <0x02040000 0x3c000>;
-				interrupts = <0 3 IRQ_TYPE_LEVEL_HIGH>,
-				             <0 12 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <0 12 IRQ_TYPE_LEVEL_HIGH>,
+				             <0 3 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "bit", "jpeg";
+				clocks = <&clks 168>, <&clks 168>;
+				clock-names = "per", "ahb";
+				resets = <&src 1>;
+				iram = <&ocram>;
 			};
 
 			aipstz at 0207c000 { /* AIPSTZ1 */
-- 
2.0.0
