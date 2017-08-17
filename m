From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Thu, 17 Aug 2017 12:11:39 +0200
Subject: [RFC 2/3] arm64: dts: realtek: Add irq mux to RTD1295
In-Reply-To: <20170817101140.32000-1-afaerber@suse.de>
References: <20170817101140.32000-1-afaerber@suse.de>
Message-ID: <20170817101140.32000-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update UART nodes with interrupts.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/realtek/rtd1295.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/realtek/rtd1295.dtsi b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
index 2d2d84b573e3..77063e984db9 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
@@ -112,6 +112,14 @@
 			#reset-cells = <1>;
 		};
 
+		iso_irq_mux: interrupt-controller at 98007000 {
+			compatible = "realtek,rtd1295-iso-irq-mux";
+			reg = <0x98007000 0x100>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
 		iso_reset: reset-controller at 98007088 {
 			compatible = "realtek,rtd1295-reset";
 			reg = <0x98007088 0x4>;
@@ -124,16 +132,28 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clock-frequency = <27000000>;
+			interrupt-parent = <&iso_irq_mux>;
+			interrupts = <2>;
 			resets = <&iso_reset RTD1295_ISO_RSTN_UR0>;
 			status = "disabled";
 		};
 
+		irq_mux: interrupt-controller at 9801b000 {
+			compatible = "realtek,rtd1295-irq-mux";
+			reg = <0x9801b000 0x100>;
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
 		uart1: serial at 9801b200 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x9801b200 0x100>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clock-frequency = <432000000>;
+			interrupt-parent = <&irq_mux>;
+			interrupts = <3>, <5>;
 			resets = <&reset2 RTD1295_RSTN_UR1>;
 			status = "disabled";
 		};
@@ -144,6 +164,8 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clock-frequency = <432000000>;
+			interrupt-parent = <&irq_mux>;
+			interrupts = <8>, <13>;
 			resets = <&reset2 RTD1295_RSTN_UR2>;
 			status = "disabled";
 		};
-- 
2.12.3
