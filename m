From: wxt@rock-chips.com (Caesar Wang)
Date: Mon,  1 Feb 2016 15:30:07 +0800
Subject: [PATCH v4.1 9/9] ARM: dts: rockchip: support the spi for rk3036
In-Reply-To: <1453970618-4383-1-git-send-email-wxt@rock-chips.com>
References: <1453970618-4383-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1454311807-5359-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the needed spi node for rk3036 dts.

We have to use the 4 bus emmc to work if someone want to support
the spi devices, since the pins are re-used by emmc data[5-8] and spi.
In some caseswe need to support the spi devices, that will waste the
emmc performance.

Moment, the kylin/evb hasn't the spi devices to work, so maybe we need wait
the new required to enable in kylin/evb board.

Anyway, the spi should be needed land in rk3036 dts.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v4-->v4.1:
- Remove the unused, as Heiko comments on https://patchwork.kernel.org/patch/8147761/
- Modify the commit.

Changes in v4:
- Add this patch included in kylin series patches.

 arch/arm/boot/dts/rk3036.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 532f232..e62e28b 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -60,6 +60,7 @@
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
+		spi = &spi;
 	};
 
 	memory {
@@ -485,6 +486,21 @@
 		status = "disabled";
 	};
 
+	spi: spi at 20074000 {
+		compatible = "rockchip,rockchip-spi";
+		reg = <0x20074000 0x1000>;
+		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+		clocks =<&cru PCLK_SPI>, <&cru SCLK_SPI>;
+		clock-names = "apb-pclk","spi_pclk";
+		dmas = <&pdma 8>, <&pdma 9>;
+		dma-names = "tx", "rx";
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi_txd &spi_rxd &spi_clk &spi_cs0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3036-pinctrl";
 		rockchip,grf = <&grf>;
@@ -723,5 +739,29 @@
 			};
 			/* no rts / cts for uart2 */
 		};
+
+		spi {
+			spi_txd:spi-txd {
+				rockchip,pins = <1 29 RK_FUNC_3 &pcfg_pull_default>;
+			};
+
+			spi_rxd:spi-rxd {
+				rockchip,pins = <1 28 RK_FUNC_3 &pcfg_pull_default>;
+			};
+
+			spi_clk:spi-clk {
+				rockchip,pins = <2 0 RK_FUNC_2 &pcfg_pull_default>;
+			};
+
+			spi_cs0:spi-cs0 {
+				rockchip,pins = <1 30 RK_FUNC_3 &pcfg_pull_default>;
+
+			};
+
+			spi_cs1:spi-cs1 {
+				rockchip,pins = <1 31 RK_FUNC_3 &pcfg_pull_default>;
+
+			};
+		};
 	};
 };
-- 
1.9.1
