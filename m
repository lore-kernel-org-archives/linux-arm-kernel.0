From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 13 Apr 2016 07:55:42 +0800
Subject: [PATCH v4 06/16] arm64: dts: add Hi6220 spi configuration nodes
In-Reply-To: <1460505352-13157-1-git-send-email-guodong.xu@linaro.org>
References: <1460505352-13157-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1460505352-13157-7-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhong Kaihua <zhongkaihua@huawei.com>

Add Hi6220 spi configuration nodes. Disable by default in hi6220.dtsi
and enable it in board dts for usage of 96boards LS mezzanine board.

Signed-off-by: Zhong Kaihua <zhongkaihua@huawei.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.com>
Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts   |  6 ++++++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi        | 15 +++++++++++++++
 arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi | 21 +++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 3d9e8b2..7545e36 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -40,6 +40,12 @@
 		      <0x00000000 0x06e00000 0x00000000 0x0060f000>,
 		      <0x00000000 0x07410000 0x00000000 0x36bf0000>;
 	};
+
+	soc {
+		spi0: spi at f7106000 {
+			status = "ok";
+		};
+	};
 };
 
 &uart2 {
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index df56571..7bcfffe 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -567,5 +567,20 @@
 			clocks = <&ao_ctrl 2>;
 			clock-names = "apb_pclk";
 		};
+
+		spi0: spi at f7106000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x0 0xf7106000 0x0 0x1000>;
+			interrupts = <0 50 4>;
+			bus-id = <0>;
+			enable-dma = <0>;
+			clocks = <&sys_ctrl HI6220_SPI_CLK>;
+			clock-names = "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi0_pmx_func &spi0_cfg_func>;
+			num-cs = <1>;
+			cs-gpios = <&gpio6 2 0>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi b/arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi
index 28806df..0916e84 100644
--- a/arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi
@@ -221,6 +221,15 @@
 					0xfc   MUX_M0	/* I2C2_SDA     (IOMG063) */
 				>;
 			};
+
+			spi0_pmx_func: spi0_pmx_func {
+				pinctrl-single,pins = <
+					0x1a0  MUX_M1   /* SPI0_DI      (IOMG104) */
+					0x1a4  MUX_M1	/* SPI0_DO	(IOMG105) */
+					0x1a8  MUX_M1	/* SPI0_CS_N	(IOMG106) */
+					0x1ac  MUX_M1	/* SPI0_CLK	(IOMG107) */
+				>;
+			};
 		};
 
 		pmx1: pinmux at f7010800 {
@@ -625,6 +634,18 @@
 				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
 				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
 			};
+
+			spi0_cfg_func: spi0_cfg_func {
+				pinctrl-single,pins = <
+					0x1b0  0x0	/* SPI0_DI	(IOCFG108) */
+					0x1b4  0x0	/* SPI0_DO	(IOCFG109) */
+					0x1b8  0x0	/* SPI0_CS_N	(IOCFG110) */
+					0x1bc  0x0	/* SPI0_CLK	(IOCFG111) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
 		};
 
 		pmx2: pinmux at f8001800 {
-- 
1.9.1
