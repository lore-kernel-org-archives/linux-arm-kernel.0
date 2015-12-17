From: wxt@rock-chips.com (Caesar Wang)
Date: Thu, 17 Dec 2015 22:21:49 +0800
Subject: [PATCH v1 3/6] ARM: dts: add the sdio/sdmmc node for rk3036
In-Reply-To: <1450362112-8075-1-git-send-email-wxt@rock-chips.com>
References: <1450362112-8075-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1450362112-8075-4-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In general, the sdio/sdmmc is used by the wifi module
and sd card.

let's add the node for these function.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm/boot/dts/rk3036.dtsi | 72 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 11a8078..947d070 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -55,6 +55,8 @@
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
 		mshc0 = &emmc;
+		mshc1 = &sdmmc;
+		mshc2 = &sdio;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
@@ -215,6 +217,30 @@
 		status = "disabled";
 	};
 
+	sdmmc: dwmmc at 10214000 {
+		compatible = "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc";
+		clock-frequency = <37500000>;
+		clock-freq-min-max = <400000 37500000>;
+		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
+		clock-names = "biu", "ciu";
+		fifo-depth = <0x100>;
+		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0x10214000 0x4000>;
+		status = "disabled";
+	};
+
+	sdio: dwmmc at 10218000 {
+		compatible = "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc";
+		clock-freq-min-max = <400000 37500000>;
+		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
+			<&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
+		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
+		fifo-depth = <0x100>;
+		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0x10218000 0x4000>;
+		status = "disabled";
+	};
+
 	emmc: dwmmc at 1021c000 {
 		compatible = "rockchip,rk3288-dw-mshc";
 		reg = <0x1021c000 0x4000>;
@@ -511,6 +537,52 @@
 			};
 		};
 
+		sdmmc {
+			sdmmc_clk: sdmmc-clk {
+				rockchip,pins = <1 16 RK_FUNC_1 &pcfg_pull_none>;
+			};
+
+			sdmmc_cmd: sdmmc-cmd {
+				rockchip,pins = <1 15 RK_FUNC_1 &pcfg_pull_default>;
+			};
+
+			sdmmc_cd: sdmcc-cd {
+				rockchip,pins = <1 17 RK_FUNC_1 &pcfg_pull_default>;
+			};
+
+			sdmmc_bus1: sdmmc-bus1 {
+				rockchip,pins = <1 18 RK_FUNC_1 &pcfg_pull_default>;
+			};
+
+			sdmmc_bus4: sdmmc-bus4 {
+				rockchip,pins = <1 18 RK_FUNC_1 &pcfg_pull_default>,
+						<1 19 RK_FUNC_1 &pcfg_pull_default>,
+						<1 20 RK_FUNC_1 &pcfg_pull_default>,
+						<1 21 RK_FUNC_1 &pcfg_pull_default>;
+			};
+		};
+
+		sdio {
+			sdio_bus1: sdio-bus1 {
+				rockchip,pins = <0 11 RK_FUNC_1 &pcfg_pull_default>;
+			};
+
+			sdio_bus4: sdio-bus4 {
+				rockchip,pins = <0 11 RK_FUNC_1 &pcfg_pull_default>,
+						<0 12 RK_FUNC_1 &pcfg_pull_default>,
+						<0 13 RK_FUNC_1 &pcfg_pull_default>,
+						<0 14 RK_FUNC_1 &pcfg_pull_default>;
+			};
+
+			sdio_cmd: sdio-cmd {
+				rockchip,pins = <0 8 RK_FUNC_1 &pcfg_pull_default>;
+			};
+
+			sdio_clk: sdio-clk {
+				rockchip,pins = <0 9 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
 		emmc {
 			/*
 			 * We run eMMC at max speed; bump up drive strength.
-- 
1.9.1
