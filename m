From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed,  5 Aug 2015 18:54:37 +0200
Subject: [PATCH] ARM: imx6: correct i.MX6 PCIe interrupt routing
Message-ID: <1438793677-19153-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PCIe interrupts are also routed through the GPC. This has been
missed from the conversion to stacked IRQ domains as the PCIe
controller uses an explicit interrupt map and thus doesn't inherit
the SoC global interrupt parent.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
This commit does not change the i.MX6SX PCIe node, as PCIe isn't
functional in mainline on this SoC and the DT node needs a major
rewrite to account for the specifics of this SoC anyway.
---
 arch/arm/boot/dts/imx6qdl.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index e6d13592080d..b57033e8c633 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -181,10 +181,10 @@
 			interrupt-names = "msi";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
-			interrupt-map = <0 0 0 1 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
-			                <0 0 0 2 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
-			                <0 0 0 3 &intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
-			                <0 0 0 4 &intc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map = <0 0 0 1 &gpc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 2 &gpc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 3 &gpc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 4 &gpc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clks IMX6QDL_CLK_PCIE_AXI>,
 				 <&clks IMX6QDL_CLK_LVDS1_GATE>,
 				 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
-- 
2.4.6
