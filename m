From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Jan 2013 20:09:27 +0100
Subject: [PATCH] ARM: sunxi: Use the Synosys APB UART instead of ns8250
Message-ID: <1358190567-6304-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UART controller used in the A10/A13 is the Synopsys DesignWare 8250.
The wrong use of a regular 8250 driver may lead to a oops during kernel
boot with "irq 17: nobody cared", because the apb UART as an extra
interrupt that gets raised when writing to the LCR when busy.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sunxi.dtsi |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi.dtsi b/arch/arm/boot/dts/sunxi.dtsi
index 8bbc2bf..8b36abe 100644
--- a/arch/arm/boot/dts/sunxi.dtsi
+++ b/arch/arm/boot/dts/sunxi.dtsi
@@ -60,19 +60,21 @@
 		};
 
 		uart0: uart at 01c28000 {
-			compatible = "ns8250";
+			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
 			interrupts = <1>;
 			reg-shift = <2>;
+			reg-io-width = <4>;
 			clock-frequency = <24000000>;
 			status = "disabled";
 		};
 
 		uart1: uart at 01c28400 {
-			compatible = "ns8250";
+			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28400 0x400>;
 			interrupts = <2>;
 			reg-shift = <2>;
+			reg-io-width = <4>;
 			clock-frequency = <24000000>;
 			status = "disabled";
 		};
-- 
1.7.10.4
