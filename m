From: sricharan@codeaurora.org (Sricharan R)
Date: Mon, 29 Jan 2018 10:41:29 +0530
Subject: [PATCH 15/15] ARM: dts: ipq8074: Enable few peripherals for hk01 board
In-Reply-To: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
References: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1517202689-14212-16-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts | 99 +++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
index 6a838b5..69a1b0c 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
+++ b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
@@ -21,6 +21,7 @@
 
 	aliases {
 		serial0 = &blsp1_uart5;
+		serial1 = &serial_blsp2;
 	};
 
 	chosen {
@@ -41,6 +42,46 @@
 					bias-disable;
 				};
 			};
+
+			 i2c_0_pins: i2c_0_pinmux {
+				  mux {
+					   pins = "gpio42", "gpio43";
+					   function = "blsp1_i2c";
+					   drive-strength = <8>;
+					   bias-disable;
+				  };
+			 };
+
+			 spi_0_pins: spi_0_pins {
+				  mux {
+					   pins = "gpio38", "gpio39", "gpio40", "gpio41";
+					   function = "blsp0_spi";
+					   drive-strength = <8>;
+					   bias-disable;
+				  };
+			 };
+
+			 hsuart_pins: hsuart_pins {
+				  mux {
+					   pins = "gpio46", "gpio47", "gpio48", "gpio49";
+					   function = "blsp2_uart";
+					   drive-strength = <8>;
+					   bias-disable;
+				  };
+			 };
+
+			 qpic_pins: qpic_pins {
+				mux {
+					   pins = "gpio0", "gpio1", "gpio2", "gpio3", "gpio4",
+						"gpio5", "gpio6", "gpio7", "gpio8", "gpio9",
+						   "gpio10", "gpio11", "gpio12", "gpio13",
+						"gpio14", "gpio15", "gpio16", "gpio17";
+					   function = "qpic";
+					   drive-strength = <8>;
+					   bias-disable;
+				  };
+			};
+
 		};
 
 		serial at 78b3000 {
@@ -48,5 +89,63 @@
 			pinctrl-names = "default";
 			status = "ok";
 		};
+
+		spi_0: spi at 78b5000 {
+			 pinctrl-0 = <&spi_0_pins>;
+			 pinctrl-names = "default";
+			 status = "ok";
+
+			 m25p80 at 0 {
+				  #address-cells = <1>;
+				  #size-cells = <1>;
+				compatible = "n25q128a11", "jedec,spi-nor";
+				  reg = <0>;
+				  spi-max-frequency = <50000000>;
+			 };
+		};
+
+		serial_blsp2: serial at 78B1000 {
+			 pinctrl-0 = <&hsuart_pins>;
+			 pinctrl-names = "default";
+			 status = "ok";
+		};
+
+		i2c_0 at 78b6000 {
+			 pinctrl-0 = <&i2c_0_pins>;
+			 pinctrl-names = "default";
+			 status = "ok";
+		};
+
+		i2c_1 at 78b7000 {
+			 status = "disabled";
+		};
+
+		dma at 7984000 {
+			 status = "ok";
+		};
+
+		nand at 79b0000 {
+			 pinctrl-0 = <&qpic_pins>;
+			 pinctrl-names = "default";
+			 status = "ok";
+
+			nand at 0 {
+				reg = <0>;
+				nand-ecc-strength = <4>;
+				nand-ecc-step-size = <512>;
+				nand-bus-width = <8>;
+			};
+
+		};
+
+		pcie0: pci at 20000000 {
+			status = "ok";
+			perst-gpio = <&tlmm 58 0x1>;
+		};
+
+		pcie1: pci at 10000000 {
+			status = "ok";
+			perst-gpio = <&tlmm 61 0x1>;
+		};
 	};
 };
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
