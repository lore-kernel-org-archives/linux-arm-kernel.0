From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 18 Feb 2014 16:34:47 +0100
Subject: [PATCH v4 7/7] ARM: dts: imx6sl: Add power-domain information to gpc
 node
In-Reply-To: <1392737687-25003-1-git-send-email-p.zabel@pengutronix.de>
References: <1392737687-25003-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1392737687-25003-8-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PGC that is part of GPC controls isolation and power sequencing of the
power domains. The PU power domain will be handled by the generic pm domain
framework and needs a phandle to the PU regulator to turn off power when
the domain is disabled.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6sl.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 28558f1..774e1fb 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -529,9 +529,27 @@
 			};
 
 			gpc: gpc at 020dc000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
 				compatible = "fsl,imx6sl-gpc", "fsl,imx6q-gpc";
 				reg = <0x020dc000 0x4000>;
 				interrupts = <0 89 0x04>;
+				pu-supply = <&reg_pu>;
+
+				pd_display: display-power-domain at 020dc240 {
+					compatible = "fsl,imx6q-power-domain";
+					reg = <0x020dc240 0x10>;
+				};
+
+				pd_pu: pu-power-domain at 020dc260 {
+					compatible = "fsl,imx6q-power-domain";
+					reg = <0x020dc260 0x10>;
+				};
+
+				pd_arm: cpu-power-domain at 020dc2a0 {
+					compatible = "fsl,imx6q-power-domain";
+					reg = <0x020dc2a0 0x10>;
+				};
 			};
 
 			gpr: iomuxc-gpr at 020e0000 {
-- 
1.8.5.3
