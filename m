From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 16 Dec 2015 16:27:19 +0800
Subject: [PATCH 3/5] ARM: dts: rockchip: update the core dts for rk3036
In-Reply-To: <1450254441-3243-1-git-send-email-wxt@rock-chips.com>
References: <1450254441-3243-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1450254441-3243-4-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the core dts for rk3036 SoCs.

1) Add the display (lcdc, hdmi, vop...) device node.
2) modify the i2s name to i2s0 and i2s1.
   Although there is only one i2s IP inside the rk3036,
   we need use all of the gpios of i2s0 and i2s1.
   So, we add the i2s1 IP is the same with i2s0 to support the
   different gpios.
3) Add sdio for wifi module, sdmmc for sd card.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm/boot/dts/rk3036.dtsi | 225 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 221 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index f8758bf..574c56c 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -55,6 +55,7 @@
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
 		mshc0 = &emmc;
+		mshc1 = &sdmmc;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
@@ -145,6 +146,63 @@
 		};
 	};
 
+	lcdc_mmu: iommu at 10118300 {
+		compatible = "rockchip,iommu";
+		reg = <0x10118300 0x100>;
+		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "lcdc_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
+	lcdc: lcdc at 10118000 {
+		compatible = "rockchip,rk3036-lcdc";
+		reg = <0x10118000 0x19c>;
+		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_LCDC>, <&cru SCLK_LCDC>, <&cru HCLK_LCDC>;
+		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+		resets = <&cru SRST_LCDC1_A>, <&cru SRST_LCDC1_H>, <&cru SRST_LCDC1_D>;
+		reset-names = "axi", "ahb", "dclk";
+		iommus = <&lcdc_mmu>;
+
+		status = "disabled";
+
+		lcdc_out: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			lcdc_out_hdmi: endpoint at 0 {
+				reg = <1>;
+				remote-endpoint = <&hdmi_in_lcdc>;
+			};
+		};
+	};
+
+	hdmi: hdmi at 20034000 {
+		compatible = "rockchip,rk3036-inno-hdmi";
+		reg = <0x20034000 0x4000>;
+		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru  PCLK_HDMI>;
+		clock-names = "pclk";
+		rockchip,grf = <&grf>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_ctl>;
+		status = "disabled";
+
+		hdmi_in: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			hdmi_in_lcdc: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&lcdc_out_hdmi>;
+			};
+		};
+	};
+
+	display-subsystem {
+		compatible = "rockchip,display-subsystem";
+		ports = <&lcdc_out>;
+	};
+
 	gic: interrupt-controller at 10139000 {
 		compatible = "arm,gic-400";
 		interrupt-controller;
@@ -158,6 +216,21 @@
 		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	usbphy: phy {
+		compatible = "rockchip,rk3036-usb-phy";
+		rockchip,grf = <&grf>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		usbphy0: usb-phy0 {
+			#phy-cells = <0>;
+			reg = <0x17c>;
+			clocks = <&cru SCLK_OTGPHY0>;
+			clock-names = "phyclk";
+		};
+	};
+
 	usb_otg: usb at 10180000 {
 		compatible = "rockchip,rk3288-usb", "rockchip,rk3066-usb",
 				"snps,dwc2";
@@ -184,6 +257,30 @@
 		status = "disabled";
 	};
 
+	sdmmc: dwmmc at 10214000 {
+		compatible = "rockchip,rk3288-dw-mshc";
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
+		compatible = "rockchip,rk3288-dw-mshc";
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
@@ -209,18 +306,33 @@
 		status = "disabled";
 	};
 
-	i2s: i2s at 10220000 {
+	i2s0: i2s0 at 10220000 {
 		compatible = "rockchip,rk3036-i2s", "rockchip,rk3066-i2s";
 		reg = <0x10220000 0x4000>;
 		interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		dmas = <&pdma 0>, <&pdma 1>;
+		dma-names = "tx", "rx";
 		clock-names = "i2s_hclk", "i2s_clk";
 		clocks = <&cru HCLK_I2S>, <&cru SCLK_I2S>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s0_bus>;
+		status = "disabled";
+	};
+
+	i2s1: i2s1 at 10220000 {
+		compatible = "rockchip,rk3036-i2s", "rockchip,rk3066-i2s";
+		reg = <0x10220000 0x4000>;
+		interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		dmas = <&pdma 0>, <&pdma 1>;
 		dma-names = "tx", "rx";
+		clock-names = "i2s_hclk", "i2s_clk";
+		clocks = <&cru HCLK_I2S>, <&cru SCLK_I2S>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&i2s_bus>;
+		pinctrl-0 = <&i2s1_bus>;
 		status = "disabled";
 	};
 
@@ -378,6 +490,33 @@
 		clocks = <&cru PCLK_I2C0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c0_xfer>;
+	};
+
+	usb_otg: usb at 10180000 {
+		compatible = "rockchip,rk3288-usb", "rockchip,rk3066-usb",
+				"snps,dwc2";
+		reg = <0x10180000 0x40000>;
+		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_OTG0>;
+		clock-names = "otg";
+		dr_mode = "otg";
+		g-np-tx-fifo-size = <16>;
+		g-rx-fifo-size = <275>;
+		g-tx-fifo-size = <256 128 128 64 64 32>;
+		g-use-dma;
+		phys = <&usbphy0>;
+		phy-names = "usb2-phy";
+		status = "disabled";
+	};
+
+	usb_host: usb at 101c0000 {
+		compatible = "rockchip,rk3288-usb", "rockchip,rk3066-usb",
+				"snps,dwc2";
+		reg = <0x101c0000 0x40000>;
+		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_OTG1>;
+		clock-names = "otg";
+		dr_mode = "host";
 		status = "disabled";
 	};
 
@@ -463,6 +602,52 @@
 			};
 		};
 
+		sdmmc {
+			sdmmc_clk: sdmmc-clk {
+				rockchip,pins = <1 16 RK_FUNC_1 &pcfg_pull_none>;
+			};
+
+			sdmmc_cmd: sdmmc-cmd {
+				rockchip,pins = <1 15 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			sdmmc_cd: sdmcc-cd {
+				rockchip,pins = <1 17 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			sdmmc_bus1: sdmmc-bus1 {
+				rockchip,pins = <1 18 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			sdmmc_bus4: sdmmc-bus4 {
+				rockchip,pins = <1 18 RK_FUNC_1 &pcfg_pull_up>,
+						<1 19 RK_FUNC_1 &pcfg_pull_up>,
+						<1 20 RK_FUNC_1 &pcfg_pull_up>,
+						<1 21 RK_FUNC_1 &pcfg_pull_up>;
+			};
+		};
+
+		sdio {
+			sdio_bus1: sdio-bus1 {
+				rockchip,pins = <0 11 RK_FUNC_1 &pcfg_pull_none>;
+			};
+
+			sdio_bus4: sdio-bus4 {
+				rockchip,pins = <0 11 RK_FUNC_1 &pcfg_pull_none>,
+						<0 12 RK_FUNC_1 &pcfg_pull_none>,
+						<0 13 RK_FUNC_1 &pcfg_pull_none>,
+						<0 14 RK_FUNC_1 &pcfg_pull_none>;
+			};
+
+			sdio_cmd: sdio-cmd {
+				rockchip,pins = <0 8 RK_FUNC_1 &pcfg_pull_none>;
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
@@ -488,6 +673,15 @@
 			};
 		};
 
+		hdmi {
+			hdmi_ctl: hdmi-ctl {
+				rockchip,pins = <1 8  RK_FUNC_1 &pcfg_pull_none>,
+						<1 9  RK_FUNC_1 &pcfg_pull_none>,
+						<1 10 RK_FUNC_1 &pcfg_pull_none>,
+						<1 11 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
 		i2c0 {
 			i2c0_xfer: i2c0-xfer {
 				rockchip,pins = <0 0 RK_FUNC_1 &pcfg_pull_none>,
@@ -509,8 +703,8 @@
 			};
 		};
 
-		i2s {
-			i2s_bus: i2s-bus {
+		i2s0 {
+			i2s0_bus: i2s0-bus {
 				rockchip,pins = <1 0 RK_FUNC_1 &pcfg_pull_none>,
 						<1 1 RK_FUNC_1 &pcfg_pull_none>,
 						<1 2 RK_FUNC_1 &pcfg_pull_none>,
@@ -518,6 +712,29 @@
 						<1 4 RK_FUNC_1 &pcfg_pull_none>,
 						<1 5 RK_FUNC_1 &pcfg_pull_none>;
 			};
+
+			i2s0_bus8ch: i2s0-bus8ch {
+				rockchip,pins = <1 0 RK_FUNC_1 &pcfg_pull_none>,
+						<1 1 RK_FUNC_1 &pcfg_pull_none>,
+						<1 2 RK_FUNC_1 &pcfg_pull_none>,
+						<1 3 RK_FUNC_1 &pcfg_pull_none>,
+						<1 4 RK_FUNC_1 &pcfg_pull_none>,
+						<1 5 RK_FUNC_1 &pcfg_pull_none>,
+						<2 28 RK_FUNC_1 &pcfg_pull_none>,
+						<2 29 RK_FUNC_1 &pcfg_pull_none>,
+						<2 30 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		i2s1 {
+			i2s1_bus: i2s1-bus {
+				rockchip,pins = <0 8 RK_FUNC_2 &pcfg_pull_none>,
+						<0 9 RK_FUNC_2 &pcfg_pull_none>,
+						<0 11 RK_FUNC_2 &pcfg_pull_none>,
+						<0 12 RK_FUNC_2 &pcfg_pull_none>,
+						<0 13 RK_FUNC_2 &pcfg_pull_none>,
+						<0 14 RK_FUNC_2 &pcfg_pull_none>;
+			};
 		};
 
 		uart0 {
-- 
1.9.1
