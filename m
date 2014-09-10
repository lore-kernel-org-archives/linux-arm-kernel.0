From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 10 Sep 2014 20:46:54 +0200
Subject: [PATCH 5/6] ARM: dts: rockchip: add emmc nodes for rk3066 and rk3188
In-Reply-To: <1410374815-20208-1-git-send-email-heiko@sntech.de>
References: <1410374815-20208-1-git-send-email-heiko@sntech.de>
Message-ID: <1410374815-20208-6-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the controller node, pinctrl settings for the customizable pins
and sort the controllers like on rk3288 as emmc, sdmmc, sdio for
handling convenience.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a.dtsi | 21 +++++++++++++++++++++
 arch/arm/boot/dts/rk3188.dtsi  | 21 +++++++++++++++++++++
 arch/arm/boot/dts/rk3xxx.dtsi  | 14 ++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 8021eed..ad9c2db 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -179,6 +179,27 @@
 			bias-disable;
 		};
 
+		emmc {
+			emmc_clk: emmc-clk {
+				rockchip,pins = <RK_GPIO3 31 RK_FUNC_2 &pcfg_pull_default>;
+			};
+
+			emmc_cmd: emmc-cmd {
+				rockchip,pins = <RK_GPIO4 9 RK_FUNC_2 &pcfg_pull_default>;
+			};
+
+			emmc_rst: emmc-rst {
+				rockchip,pins = <RK_GPIO4 10 RK_FUNC_2 &pcfg_pull_default>;
+			};
+
+			/*
+			 * The data pins are shared between nandc and emmc and
+			 * not accessible through pinctrl. Also they should've
+			 * been already set correctly by firmware, as
+			 * flash/emmc is the boot-device.
+			 */
+		};
+
 		i2c0 {
 			i2c0_xfer: i2c0-xfer {
 				rockchip,pins = <RK_GPIO2 28 RK_FUNC_1 &pcfg_pull_none>,
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 573ef61..9a1ff0b 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -147,6 +147,27 @@
 			bias-disable;
 		};
 
+		emmc {
+			emmc_clk: emmc-clk {
+				rockchip,pins = <RK_GPIO0 24 RK_FUNC_2 &pcfg_pull_default>;
+			};
+
+			emmc_cmd: emmc-cmd {
+				rockchip,pins = <RK_GPIO0 26 RK_FUNC_2 &pcfg_pull_default>;
+			};
+
+			emmc_rst: emmc-rst {
+				rockchip,pins = <RK_GPIO0 27 RK_FUNC_2 &pcfg_pull_default>;
+			};
+
+			/*
+			 * The data pins are shared between nandc and emmc and
+			 * not accessible through pinctrl. Also they should've
+			 * been already set correctly by firmware, as
+			 * flash/emmc is the boot-device.
+			 */
+		};
+
 		i2c0 {
 			i2c0_xfer: i2c0-xfer {
 				rockchip,pins = <RK_GPIO1 24 RK_FUNC_1 &pcfg_pull_none>,
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 7bcd698..c383f5c 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -26,6 +26,9 @@
 		i2c2 = &i2c2;
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
+		mshc0 = &emmc;
+		mshc1 = &mmc0;
+		mshc2 = &mmc1;
 		spi0 = &spi0;
 		spi1 = &spi1;
 	};
@@ -137,6 +140,17 @@
 		status = "disabled";
 	};
 
+	emmc: dwmmc at 1021c000 {
+		compatible = "rockchip,rk2928-dw-mshc";
+		reg = <0x1021c000 0x1000>;
+		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+
+		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>;
+		clock-names = "biu", "ciu";
+
+		status = "disabled";
+	};
+
 	pmu: pmu at 20004000 {
 		compatible = "rockchip,rk3066-pmu", "syscon";
 		reg = <0x20004000 0x100>;
-- 
2.0.1
