From: addy.ke@rock-chips.com (addy ke)
Date: Tue, 24 Jun 2014 11:58:43 +0800
Subject: [PATCH 1/2] documentation: add rockchip spi documentation
In-Reply-To: <1403582324-9485-1-git-send-email-addy.ke@rock-chips.com>
References: <1403582324-9485-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <1403582324-9485-2-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: addy ke <addy.ke@rock-chips.com>
---
 .../devicetree/bindings/spi/spi-rockchip.txt       | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-rockchip.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.txt b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
new file mode 100644
index 0000000..ce9c881
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
@@ -0,0 +1,51 @@
+* Rockchip SPI Controller
+
+The Rockchip SPI controller is used to interface with various devices such as flash
+and display controllers using the SPI communication interface.
+
+Required SoC Specific Properties:
+
+- compatible: should be one of the following.
+    - rockchip,rk3066-spi: for rk3066, rk3188 and rk3288 platforms.
+- reg: physical base address of the controller and length of memory mapped
+       region.
+- interrupts: The interrupt number to the cpu. The interrupt specifier format
+              depends on the interrupt controller.
+- clocks: Must contain an entry for each entry in clock-names.
+- clock-names: Shall be "spiclk" for the transfer-clock, and "apb_pclk" for
+			   the peripheral clock.
+
+Optional properties:
+- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
+		Documentation/devicetree/bindings/dma/dma.txt
+- dma-names: DMA request names should include "tx" and "rx" if present.
+
+Example:
+
+- SoC Specific Portion:
+
+	spi0: spi at ff110000 {
+		compatible = "rockchip,rockchip-spi";
+		reg = <0xff110000 0x1000>;
+		dmas = <&pdma1 11>, <&pdma1 12>;
+		dma-names = "tx", "rx";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi0_clk &spi0_tx &spi0_rx &spi0_cs0 &spi0_cs1>;
+		clocks = <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
+		clock-names = "spiclk", "apb_pclk";
+		status = "disabled";
+	};
+
+- Board Specific Portion:
+
+	&spi0 {
+		status = "okay";
+		spi_test at 00 {
+			compatible = "rockchip,spi_test";
+			reg = <0>;
+			spi-max-frequency = <24000000>;
+		};
+	};
-- 
1.8.3.2
