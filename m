From: guodong.xu@linaro.org (Guodong Xu)
Date: Thu, 15 Jun 2017 11:04:16 +0800
Subject: [PATCH v4 19/20] arm64: dts: hi3660: add sd/sdio device nodes
In-Reply-To: <20170615030417.14059-1-guodong.xu@linaro.org>
References: <20170615030417.14059-1-guodong.xu@linaro.org>
Message-ID: <20170615030417.14059-20-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Li Wei <liwei213@huawei.com>

Add sd/sdio device nodes for hi3660 soc

Signed-off-by: Li Wei <liwei213@huawei.com>
Signed-off-by: Chen Jun <chenjun14@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts |  8 ++++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 58 +++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index e579333..cec0b60 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -18,6 +18,8 @@
 	compatible = "hisilicon,hi3660-hikey960", "hisilicon,hi3660";
 
 	aliases {
+		mshc1 = &dwmmc1;
+		mshc2 = &dwmmc2;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
@@ -200,3 +202,9 @@
 	label = "HS-SPI1";
 	status = "okay";
 };
+
+&dwmmc1 {
+	vmmc-supply = <&ldo16>;
+	vqmmc-supply = <&ldo9>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 529cf08..f7ff593 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -786,5 +786,63 @@
 			reset-gpios = <&gpio11 1 0 >;
 			status = "ok";
 		};
+
+		/* SD */
+		dwmmc1: dwmmc1 at ff37f000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cd-inverted;
+			compatible = "hisilicon,hi3660-dw-mshc";
+			num-slots = <1>;
+			bus-width = <0x4>;
+			disable-wp;
+			cap-sd-highspeed;
+			supports-highspeed;
+			card-detect-delay = <200>;
+			reg = <0x0 0xff37f000 0x0 0x1000>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3660_CLK_GATE_SD>,
+				<&crg_ctrl HI3660_HCLK_GATE_SD>;
+			clock-names = "ciu", "biu";
+			clock-frequency = <3200000>;
+			resets = <&crg_rst 0x94 18>;
+			cd-gpios = <&gpio25 3 0>;
+			hisilicon,peripheral-syscon = <&sctrl>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&sd_pmx_func
+				     &sd_clk_cfg_func
+				     &sd_cfg_func>;
+			sd-uhs-sdr12;
+			sd-uhs-sdr25;
+			sd-uhs-sdr50;
+			sd-uhs-sdr104;
+			status = "disabled";
+
+			slot at 0 {
+				reg = <0x0>;
+				bus-width = <4>;
+				disable-wp;
+			};
+		};
+
+		/* SDIO */
+		dwmmc2: dwmmc2 at ff3ff000 {
+			compatible = "hisilicon,hi3660-dw-mshc";
+			reg = <0x0 0xff3ff000 0x0 0x1000>;
+			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+			num-slots = <1>;
+			clocks = <&crg_ctrl HI3660_CLK_GATE_SDIO0>,
+				 <&crg_ctrl HI3660_HCLK_GATE_SDIO0>;
+			clock-names = "ciu", "biu";
+			resets = <&crg_rst 0x94 20>;
+			card-detect-delay = <200>;
+			supports-highspeed;
+			keep-power-in-suspend;
+			pinctrl-names = "default";
+			pinctrl-0 = <&sdio_pmx_func
+				     &sdio_clk_cfg_func
+				     &sdio_cfg_func>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.10.2
