From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 15 Mar 2018 15:02:10 -0300
Subject: [PATCH] ARM: dts: imx7: Move tempmon node out of bus
Message-ID: <1521136930-14660-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Move tempmon node from soc node to root node.
    
tempmon node does not have any register properties and thus
shouldn't be placed on the bus.
    
This fixes the following build warning with W=1:

arch/arm/boot/dts/imx7d-cl-som-imx7.dtb: Warning (simple_bus_reg): Node /soc/aips-bus at 30000000/tempmon missing or empty reg/ranges property

Fixes: de25b9bb4a40 ("ARM: dts: imx7s: add temperature monitor support")
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx7s.dtsi | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 4d42335..c9b56dc 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -173,6 +173,17 @@
 		};
 	};
 
+	tempmon: tempmon {
+		compatible = "fsl,imx7d-tempmon";
+		interrupt-parent = <&gpc>;
+		interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+		fsl,tempmon =<&anatop>;
+		nvmem-cells = <&tempmon_calib>,
+			<&tempmon_temp_grade>;
+		nvmem-cell-names = "calib", "temp_grade";
+		clocks = <&clks IMX7D_PLL_SYS_MAIN_CLK>;
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupt-parent = <&intc>;
@@ -540,16 +551,6 @@
 				};
 			};
 
-			tempmon: tempmon {
-				compatible = "fsl,imx7d-tempmon";
-				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
-				fsl,tempmon =<&anatop>;
-				nvmem-cells = <&tempmon_calib>,
-					<&tempmon_temp_grade>;
-				nvmem-cell-names = "calib", "temp_grade";
-				clocks = <&clks IMX7D_PLL_SYS_MAIN_CLK>;
-			};
-
 			anatop: anatop at 30360000 {
 				compatible = "fsl,imx7d-anatop", "fsl,imx6q-anatop",
 					"syscon", "simple-bus";
-- 
2.7.4
