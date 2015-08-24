From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Mon, 24 Aug 2015 08:40:05 +0000
Subject: [PATCH v4 2/5] ARM: bcm2835: add DT for the bcm2835 auxiliar devices
In-Reply-To: <1440405608-3995-1-git-send-email-kernel@martin.sperl.org>
References: <1440405608-3995-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1440405608-3995-3-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add device tree definitions for auxiliar bcm2835 devices:
* spi1
* spi2
* uart1

This also include a device to get used by the relevant
device-drivers (via a shared register) to enable/disable
the HW-block.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 arch/arm/boot/dts/bcm2835.dtsi |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 301c73f..4e6fc61 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -158,6 +158,43 @@
 		arm-pmu {
 			compatible = "arm,arm1176-pmu";
 		};
+
+		aux_enable: aux_enable at 0x7e215004 {
+			compatible = "brcm,bcm2835-aux";
+			reg = <0x7e215004 0x04>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		uart1: uart at 7e215040 {
+			compatible = "brcm,bcm2835-aux-uart";
+			reg = <0x7e215040 0x40>;
+			interrupts = <1 29>;
+			brcm,aux-enable = <&aux_enable 1>;
+			status = "disabled";
+		};
+
+		spi1: spi at 7e215080 {
+			compatible = "brcm,bcm2835-aux-spi";
+			reg = <0x7e215080 0x40>;
+			brcm,aux-enable = <&aux_enable 2>;
+			interrupts = <1 29>;
+			clocks = <&clk_spi>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi2: spi at 7e2150c0 {
+			compatible = "brcm,bcm2835-aux-spi";
+			reg = <0x7e2150c0 0x40>;
+			brcm,aux-enable = <&aux_enable 4>;
+			interrupts = <1 29>;
+			clocks = <&clk_spi>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 	};

 	clocks {
--
1.7.10.4
