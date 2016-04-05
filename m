From: guodong.xu@linaro.org (Guodong Xu)
Date: Tue,  5 Apr 2016 21:27:30 +0800
Subject: [PATCH v3 06/16] arm64: dts: add Hi6220 spi configuration nodes
In-Reply-To: <1459862860-9775-1-git-send-email-guodong.xu@linaro.org>
References: <1459862860-9775-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1459862860-9775-7-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhong Kaihua <zhongkaihua@huawei.com>

Add Hi6220 spi configuration nodes

Signed-off-by: Zhong Kaihua <zhongkaihua@huawei.com>
Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts   |  1 +
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi        | 15 +++++++++++++++
 arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi | 21 +++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 985a2ad..5c9ee31 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -20,6 +20,7 @@
 		serial1 = &uart1; /* BT UART */
 		serial2 = &uart2; /* LS Expansion UART0 */
 		serial3 = &uart3; /* LS Expansion UART1 */
+		spi0 = &spi_0;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index c65d8dc..8b74eeb 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -587,5 +587,20 @@
 			clock-names = "apb_pclk";
 			status = "ok";
 		};
+
+		spi_0: spi at f7106000 {
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
+			status = "ok";
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
