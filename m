From: sricharan@codeaurora.org (Sricharan R)
Date: Mon, 29 Jan 2018 10:41:24 +0530
Subject: [PATCH 10/15] ARM: dts: ipq4019: Add ipq4019-ap.dk07.1 common data
In-Reply-To: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
References: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1517202689-14212-11-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the common data for all dk07 based boards.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi | 128 ++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi

diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
new file mode 100644
index 0000000..af4e99d
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017, The Linux Foundation. All rights reserved.
+
+#include "qcom-ipq4019.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK07.1";
+	compatible = "qcom,ipq4019";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>; /* 512MB */
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		rsvd1 at 87000000 {
+			/* Reserved for other subsystem */
+			reg = <0x87000000 0x500000>;
+			no-map;
+		};
+
+		wifi_dump at 87500000 {
+			reg = <0x87500000 0x600000>;
+			no-map;
+		};
+
+		rsvd2 at 87B00000 {
+			/* Reserved for other subsystem */
+			reg = <0x87B00000 0x500000>;
+			no-map;
+		};
+	};
+
+	soc {
+		pinctrl at 1000000 {
+			serial_0_pins: serial0_pinmux {
+				mux {
+					pins = "gpio16", "gpio17";
+					function = "blsp_uart0";
+					bias-disable;
+				};
+			};
+
+			spi_1_pins: spi_1_pinmux {
+				mux {
+					pins = "gpio44", "gpio46", "gpio47";
+					function = "blsp_spi1";
+					bias-disable;
+				};
+				host_int {
+					pins = "gpio42";
+					function = "gpio";
+					input;
+				};
+				cs {
+					pins = "gpio45";
+					function = "gpio";
+					bias-pull-up;
+				};
+				wake {
+					pins = "gpio31";
+					function = "gpio";
+					output-high;
+				};
+				reset {
+					pins = "gpio49";
+					function = "gpio";
+					output-high;
+				};
+			};
+
+			i2c_0_pins: i2c_0_pinmux {
+				mux {
+					pins = "gpio20", "gpio21";
+					function = "blsp_i2c0";
+					bias-disable;
+				};
+			};
+		};
+
+		serial at 78af000 {
+			pinctrl-0 = <&serial_0_pins>;
+			pinctrl-names = "default";
+			status = "ok";
+		};
+
+		spi_1: spi at 78b6000 { /* BLSP1 QUP2 */
+			pinctrl-0 = <&spi_1_pins>;
+			pinctrl-names = "default";
+			status = "disabled";
+
+			spidev1: spi at 1 {
+				compatible = "spidev";
+				reg = <0>;
+				spi-max-frequency = <24000000>;
+			};
+		};
+
+		blsp_dma: dma at 7884000 {
+			status = "ok";
+		};
+
+		i2c_0: i2c at 78b7000 { /* BLSP1 QUP2 */
+			pinctrl-0 = <&i2c_0_pins>;
+			pinctrl-names = "default";
+			status = "ok";
+		};
+
+		pcie0: pci at 40000000 {
+			status = "ok";
+			perst-gpio = <&tlmm 38 0x1>;
+		};
+
+		qpic_bam: dma at 7984000{
+			status = "ok";
+		};
+
+		nand: qpic-nand at 79b0000 {
+			status = "ok";
+		};
+	};
+};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
