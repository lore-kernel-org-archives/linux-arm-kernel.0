From: eric@anholt.net (Eric Anholt)
Date: Tue, 18 Apr 2017 16:32:34 -0700
Subject: [PATCH] ARM: dts: bcm-cygnus: Add 911360's V3D device.
Message-ID: <20170418233234.13374-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This loads the VC4 driver on the 911360_entphn platform (with the
corresponding series sent to dri-devel), which is supported by master
of the Mesa tree.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi      | 13 +++++++++++++
 arch/arm/boot/dts/bcm911360_entphn.dts |  8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index f52750c6d3ed..907a5e843364 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -406,6 +406,19 @@
 			status = "disabled";
 		};
 
+		v3d: v3d at 180a2000 {
+			compatible = "brcm,cygnus-v3d";
+			reg = <0x180a2000 0x1000>;
+			clocks = <&mipipll BCM_CYGNUS_MIPIPLL_CH2_V3D>;
+			clock-names = "v3d_clk";
+			interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		vc4: gpu {
+			compatible = "brcm,cygnus-vc4";
+		};
+
 		adc: adc at 180a6000 {
 			compatible = "brcm,iproc-static-adc";
 			#io-channel-cells = <1>;
diff --git a/arch/arm/boot/dts/bcm911360_entphn.dts b/arch/arm/boot/dts/bcm911360_entphn.dts
index 8b3800f46288..037621c13290 100644
--- a/arch/arm/boot/dts/bcm911360_entphn.dts
+++ b/arch/arm/boot/dts/bcm911360_entphn.dts
@@ -57,6 +57,14 @@
 	};
 };
 
+&v3d {
+	assigned-clocks =
+		<&mipipll BCM_CYGNUS_MIPIPLL>,
+		<&mipipll BCM_CYGNUS_MIPIPLL_CH2_V3D>;
+	assigned-clock-rates = <525000000>, <300000000>;
+	status = "okay";
+};
+
 &uart3 {
 	status = "okay";
 };
-- 
2.11.0
