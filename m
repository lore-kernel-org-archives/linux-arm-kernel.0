From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 30 Jun 2017 14:01:53 +0800
Subject: arm64: dts: rockchip: add SdioAudio pd control for rk3399
Message-ID: <1498802513-535-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SdioAudio power domain includes the i2s/spdif/spi5/sdio.

So this patch adds the pd control for rk3399 i2s/spdif/spi5/sdio, in order
to save more power consumption.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes note:
- As the Jeffy fixes the spi'cs issue recently as follows:
aa09938 spi: rockchip: Disable Runtime PM when chip select is asserted
c863795 spi: rockchip: Set GPIO_SS flag to enable Slave Select with GPIO CS
c351587 spi: rockchip: fix error handling when probe
- Posted this CL to support the SdioAudio power domain as commnets on
  https://chromium-review.googlesource.com/#/c/378562/

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 33e17d7..a1dd0da 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -289,6 +289,7 @@
 		fifo-depth = <0x100>;
 		resets = <&cru SRST_SDIO0>;
 		reset-names = "reset";
+		power-domains = <&power RK3399_PD_SDIOAUDIO>;
 		status = "disabled";
 	};
 
@@ -678,6 +679,7 @@
 		pinctrl-0 = <&spi5_clk &spi5_tx &spi5_rx &spi5_cs0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		power-domains = <&power RK3399_PD_SDIOAUDIO>;
 		status = "disabled";
 	};
 
@@ -952,6 +954,11 @@
 					 <&cru SCLK_SDMMC>;
 				pm_qos = <&qos_sd>;
 			};
+			pd_sdioaudio at RK3399_PD_SDIOAUDIO {
+				reg = <RK3399_PD_SDIOAUDIO>;
+				clocks = <&cru HCLK_SDIO>;
+				pm_qos = <&qos_sdioaudio>;
+			};
 			pd_vio at RK3399_PD_VIO {
 				reg = <RK3399_PD_VIO>;
 				#address-cells = <1>;
@@ -1372,6 +1379,7 @@
 		clocks = <&cru SCLK_SPDIF_8CH>, <&cru HCLK_SPDIF>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&spdif_bus>;
+		power-domains = <&power RK3399_PD_SDIOAUDIO>;
 		status = "disabled";
 	};
 
@@ -1386,6 +1394,7 @@
 		clocks = <&cru SCLK_I2S0_8CH>, <&cru HCLK_I2S0_8CH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s0_8ch_bus>;
+		power-domains = <&power RK3399_PD_SDIOAUDIO>;
 		status = "disabled";
 	};
 
@@ -1399,6 +1408,7 @@
 		clocks = <&cru SCLK_I2S1_8CH>, <&cru HCLK_I2S1_8CH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s1_2ch_bus>;
+		power-domains = <&power RK3399_PD_SDIOAUDIO>;
 		status = "disabled";
 	};
 
@@ -1410,6 +1420,7 @@
 		dma-names = "tx", "rx";
 		clock-names = "i2s_clk", "i2s_hclk";
 		clocks = <&cru SCLK_I2S2_8CH>, <&cru HCLK_I2S2_8CH>;
+		power-domains = <&power RK3399_PD_SDIOAUDIO>;
 		status = "disabled";
 	};
 
-- 
2.7.4
