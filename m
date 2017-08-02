From: andy.yan@rock-chips.com (Andy Yan)
Date: Wed,  2 Aug 2017 16:44:44 +0800
Subject: [PATCH v2 13/23] ARM: dts: rockchip: add i2c dt node for rv1108
In-Reply-To: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
References: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1501663484-12418-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are four i2c controllers on rv1108, add
device tree node for them.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

Changes in v2: None

 arch/arm/boot/dts/rv1108.dtsi | 72 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 452e397..124ed97 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -52,6 +52,10 @@
 	interrupt-parent = <&gic>;
 
 	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
@@ -154,11 +158,67 @@
 		status = "disabled";
 	};
 
+	i2c1: i2c at 10240000 {
+		compatible = "rockchip,rv1108-i2c";
+		reg = <0x10240000 0x1000>;
+		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+		rockchip,grf = <&grf>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&cru SCLK_I2C1>, <&cru PCLK_I2C1>;
+		clock-names = "i2c", "pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c1_xfer>;
+		status = "disabled";
+	};
+
+	i2c2: i2c at 10250000 {
+		compatible = "rockchip,rv1108-i2c";
+		reg = <0x10250000 0x1000>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		rockchip,grf = <&grf>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&cru SCLK_I2C2>, <&cru PCLK_I2C2>;
+		clock-names = "i2c", "pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c2m1_xfer>;
+		status = "disabled";
+	};
+
+	i2c3: i2c at 10260000 {
+		compatible = "rockchip,rv1108-i2c";
+		reg = <0x10260000 0x1000>;
+		interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+		rockchip,grf = <&grf>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&cru SCLK_I2C3>, <&cru PCLK_I2C3>;
+		clock-names = "i2c", "pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c3_xfer>;
+		status = "disabled";
+	};
+
 	grf: syscon at 10300000 {
 		compatible = "rockchip,rv1108-grf", "syscon";
 		reg = <0x10300000 0x1000>;
 	};
 
+	i2c0: i2c at 20000000 {
+		compatible = "rockchip,rv1108-i2c";
+		reg = <0x20000000 0x1000>;
+		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+		rockchip,grf = <&grf>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&cru SCLK_I2C0_PMU>, <&cru PCLK_I2C0_PMU>;
+		clock-names = "i2c", "pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c0_xfer>;
+		status = "disabled";
+	};
+
 	pmugrf: syscon at 20060000 {
 		compatible = "rockchip,rv1108-pmugrf", "syscon";
 		reg = <0x20060000 0x1000>;
@@ -343,6 +403,18 @@
 			input-enable;
 		};
 
+		pcfg_pull_none_smt: pcfg-pull-none-smt {
+			bias-disable;
+			input-schmitt-enable;
+		};
+
+		i2c0 {
+			i2c0_xfer: i2c0-xfer {
+				rockchip,pins = <0 RK_PB1 RK_FUNC_1 &pcfg_pull_none_smt>,
+						<0 RK_PB2 RK_FUNC_1 &pcfg_pull_none_smt>;
+			};
+		};
+
 		i2c1 {
 			i2c1_xfer: i2c1-xfer {
 				rockchip,pins = <2 RK_PD3 RK_FUNC_1 &pcfg_pull_up>,
-- 
2.7.4
