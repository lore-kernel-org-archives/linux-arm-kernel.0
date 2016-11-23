From: stefan@agner.ch (Stefan Agner)
Date: Tue, 22 Nov 2016 16:42:04 -0800
Subject: [PATCH] ARM: dts: imx7d: fix LCDIF clock assignment
Message-ID: <20161123004204.10851-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eLCDIF IP of the i.MX 7 SoC knows multiple clocks and lists them
separately:

Clock      Clock Root              Description
apb_clk    MAIN_AXI_CLK_ROOT       AXI clock
pix_clk    LCDIF_PIXEL_CLK_ROOT    Pixel clock
ipg_clk_s  MAIN_AXI_CLK_ROOT       Peripheral access clock

All of them are switched by a single gate, which is part of the
IMX7D_LCDIF_PIXEL_ROOT_CLK clock. Hence using that clock also for
the AXI bus clock (clock-name "axi") makes sure the gate gets
enabled when accessing registers.

There seem to be no separate AXI display clock, and the clock is
optional. Hence remove the dummy clock.

This fixes kernel freezes when starting the X-Server (which
disables/re-enables the display controller).

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx7s.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 0d7d5ac..2b6cb05 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -643,9 +643,8 @@
 				reg = <0x30730000 0x10000>;
 				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_LCDIF_PIXEL_ROOT_CLK>,
-					<&clks IMX7D_CLK_DUMMY>,
-					<&clks IMX7D_CLK_DUMMY>;
-				clock-names = "pix", "axi", "disp_axi";
+					<&clks IMX7D_LCDIF_PIXEL_ROOT_CLK>;
+				clock-names = "pix", "axi";
 				status = "disabled";
 			};
 		};
-- 
2.10.2
