From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 15 Feb 2018 13:46:50 +0000
Subject: [PATCH] arm64: dts: rockchip: Fix RK3328 UART DMAs
Message-ID: <564d3e93476ae7480f927b1137ec4d0301938f16.1518702332.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using a serial console on RK3328 provokes an error from
of_dma_request_slave_channel() since the UART nodes have a "dmas"
property but are missing the mandatory "dma-names" to go with it.

Replace the bogus "#dma-cells" - these UARTs are DMA channel consumers,
not providers - with the appropriate names instead. DMA still doesn't
actually work, since the PL330 driver doesn't quite implement everything
the 8250 driver demands, but at least it makes the DT correct.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index a037ee56fead..822488bdf364 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -318,7 +318,7 @@
 		clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
 		clock-names = "baudclk", "apb_pclk";
 		dmas = <&dmac 2>, <&dmac 3>;
-		#dma-cells = <2>;
+		dma-names = "tx", "rx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
 		reg-io-width = <4>;
@@ -333,7 +333,7 @@
 		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
 		clock-names = "sclk_uart", "pclk_uart";
 		dmas = <&dmac 4>, <&dmac 5>;
-		#dma-cells = <2>;
+		dma-names = "tx", "rx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&uart1_xfer &uart1_cts &uart1_rts>;
 		reg-io-width = <4>;
@@ -348,7 +348,7 @@
 		clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
 		clock-names = "baudclk", "apb_pclk";
 		dmas = <&dmac 6>, <&dmac 7>;
-		#dma-cells = <2>;
+		dma-names = "tx", "rx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&uart2m1_xfer>;
 		reg-io-width = <4>;
-- 
2.16.1.dirty
