From: jay.xu@rock-chips.com (Jianqun)
Date: Fri, 12 Sep 2014 18:54:55 +0800
Subject: [PATCH v2] ARM: dts: add rk3288 i2s controller
In-Reply-To: <1410509511-16667-1-git-send-email-jay.xu@rock-chips.com>
References: <1410509511-16667-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1410519295-18980-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dt for rk3288 i2s controller, since i2s clock pins and data pins
default to be GPIO, this patch also add pinctrl to mux them.

Tested on RK3288 board.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
change since v1:
- move i2s relate codes later in order by CPU address map

 arch/arm/boot/dts/rk3288.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 5950b0a..5b17718 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -271,6 +271,21 @@
 		status = "disabled";
 	};
 
+	i2s: i2s at ff890000 {
+		compatible = "rockchip,rk3288-i2s", "rockchip,rk3066-i2s";
+		reg = <0xff890000 0x10000>;
+		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		dmas = <&dmac_bus_s 0>, <&dmac_bus_s 1>;
+		dma-names = "tx", "rx";
+		clock-names = "i2s_hclk", "i2s_clk";
+		clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s0_clk>;
+		status = "disabled";
+	};
+
 	gic: interrupt-controller at ffc01000 {
 		compatible = "arm,gic-400";
 		interrupt-controller;
@@ -463,6 +478,17 @@
 			};
 		};
 
+		i2s0 {
+			i2s0_clk: i2s0_clk {
+				rockchip,pins = <6 0 RK_FUNC_1 &pcfg_pull_none>,
+						<6 1 RK_FUNC_1 &pcfg_pull_none>,
+						<6 2 RK_FUNC_1 &pcfg_pull_none>,
+						<6 3 RK_FUNC_1 &pcfg_pull_none>,
+						<6 4 RK_FUNC_1 &pcfg_pull_none>,
+						<6 8 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
 		sdmmc {
 			sdmmc_clk: sdmmc-clk {
 				rockchip,pins = <6 20 RK_FUNC_1 &pcfg_pull_none>;
-- 
1.9.1
