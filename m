From: sean@nyekjaer.dk (Sean Nyekjaer)
Date: Thu, 24 May 2018 21:46:59 +0200
Subject: [RESEND PATCH] ARM: dts: imx6q: Use correct SDMA script for SPI5 core
Message-ID: <20180524194659.2546-1-sean.nyekjaer@prevas.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the reference manual the shp_2_mcu / mcu_2_shp
scripts must be used for devices connected through the SPBA.

This fixes an issue we saw with DMA transfers.
Sometimes the SPI controller RX FIFO was not empty after a DMA
transfer and the driver got stuck in the next PIO transfer when
it read one word more than expected.

commit dd4b487b32a35 ("ARM: dts: imx6: Use correct SDMA script
for SPI cores") is fixing the same issue but only for SPI1 - 4.

Fixes: 677940258dd8e ("ARM: dts: imx6q: enable dma for ecspi5")

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6q.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index ae7b3f107893..5185300cc11f 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -96,7 +96,7 @@
 					clocks = <&clks IMX6Q_CLK_ECSPI5>,
 						 <&clks IMX6Q_CLK_ECSPI5>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 11 7 1>, <&sdma 12 7 2>;
+					dmas = <&sdma 11 8 1>, <&sdma 12 8 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
-- 
2.17.0
