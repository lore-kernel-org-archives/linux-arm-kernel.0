From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 28 Aug 2017 12:53:44 +0200
Subject: [PATCH v2 3/3] arm64: dts: realtek: Add irq mux to RTD1295
In-Reply-To: <20170828105344.8338-1-afaerber@suse.de>
References: <20170828105344.8338-1-afaerber@suse.de>
Message-ID: <20170828105344.8338-4-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update UART nodes with interrupts.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2:
 * Rebased
 
 arch/arm64/boot/dts/realtek/rtd1295.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/realtek/rtd1295.dtsi b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
index c8b7bb642a9a..6918373e9b5c 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
@@ -93,21 +93,41 @@
 		/* Exclude up to 2 GiB of RAM */
 		ranges = <0x80000000 0x80000000 0x80000000>;
 
+		iso_irq_mux: interrupt-controller at 98007000 {
+			compatible = "realtek,rtd1295-iso-irq-mux";
+			reg = <0x98007000 0x100>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
 		uart0: serial at 98007800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x98007800 0x400>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clock-frequency = <27000000>;
+			interrupt-parent = <&iso_irq_mux>;
+			interrupts = <2>;
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
 			status = "disabled";
 		};
 
@@ -117,6 +137,8 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clock-frequency = <432000000>;
+			interrupt-parent = <&irq_mux>;
+			interrupts = <8>, <13>;
 			status = "disabled";
 		};
 
-- 
2.12.3
