From: raveendra.padasalagi@broadcom.com (Raveendra Padasalagi)
Date: Tue,  9 Feb 2016 14:27:57 +0530
Subject: [PATCH 3/3] ARM: dts: use syscon in cygnus touchscreen dt node
In-Reply-To: <1455008277-8312-1-git-send-email-raveendra.padasalagi@broadcom.com>
References: <1455008277-8312-1-git-send-email-raveendra.padasalagi@broadcom.com>
Message-ID: <1455008277-8312-4-git-send-email-raveendra.padasalagi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In cygnus touch screen controller registers are shared with ADC
and flex timer. Using readl/writel could lead to race condition.
In such cases we need to support register access using syscon
framework based API's. So Added dt changes to use syscon.

Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 3878793..9190224 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -351,9 +351,16 @@
 					<&pinctrl 142 10 1>;
 		};
 
+		ts_adc_syscon: ts_adc_syscon at 0x180a6000 {
+			compatible = "syscon";
+			reg = <0x180a6000 0xc30>;
+		};
+
 		touchscreen: tsc at 180a6000 {
 			compatible = "brcm,iproc-touchscreen";
-			reg = <0x180a6000 0x40>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ts_syscon = <&ts_adc_syscon>;
 			clocks = <&asiu_clks BCM_CYGNUS_ASIU_ADC_CLK>;
 			clock-names = "tsc_clk";
 			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.9.1
