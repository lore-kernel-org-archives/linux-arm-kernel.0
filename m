From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 28 Feb 2014 17:03:46 +0100
Subject: [PATCH v5 4/5] ARM: dts: imx6sl: Add power-domain information to gpc
 node
In-Reply-To: <1393603427-6199-1-git-send-email-p.zabel@pengutronix.de>
References: <1393603427-6199-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1393603427-6199-5-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PGC that is part of GPC controls isolation and power sequencing of the
power domains. The PU power domain will be handled by the generic pm domain
framework. It needs a phandle to the PU regulator to turn off power when
the domain is disabled and a list of clocks to be enabled during powerup
for reset propagation.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes since v4:
 - Use OF power domain bindings
 - Added reset clocks
---
 arch/arm/boot/dts/imx6sl.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 28558f1..0e61262 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -529,9 +529,13 @@
 			};
 
 			gpc: gpc at 020dc000 {
-				compatible = "fsl,imx6sl-gpc", "fsl,imx6q-gpc";
+				compatible = "fsl,imx6sl-gpc";
 				reg = <0x020dc000 0x4000>;
 				interrupts = <0 89 0x04>;
+				pu-supply = <&reg_pu>;
+				clocks = <&clks IMX6SL_CLK_GPU2D_OVG>,
+					 <&clks IMX6SL_CLK_GPU2D_PODF>;
+				#power-domain-cells = <1>;
 			};
 
 			gpr: iomuxc-gpr at 020e0000 {
-- 
1.8.5.3
