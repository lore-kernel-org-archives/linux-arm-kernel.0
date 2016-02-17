From: raveendra.padasalagi@broadcom.com (Raveendra Padasalagi)
Date: Wed, 17 Feb 2016 15:13:46 +0530
Subject: [PATCH v2 3/3] ARM: dts: use syscon in cygnus touchscreen dt node
In-Reply-To: <1455702226-20599-1-git-send-email-raveendra.padasalagi@broadcom.com>
References: <1455702226-20599-1-git-send-email-raveendra.padasalagi@broadcom.com>
Message-ID: <1455702226-20599-4-git-send-email-raveendra.padasalagi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In Cygnus SOC touch screen controller registers are shared
with ADC and flex timer. Using readl/writel could lead to
race condition. So in such case register access is handled
through syscon framework API's in the touch screen driver.
This feature is enabled if "brcm,iproc-touchscreen-syscon"
compatible string is selected in touchscreen dt node.

So this patch enables syscon support in touchscreen driver
by adding necessary properties in touchscreen dt node.

Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 3878793..79678c1 100644
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
-			compatible = "brcm,iproc-touchscreen";
-			reg = <0x180a6000 0x40>;
+			compatible = "brcm,iproc-touchscreen-syscon";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ts_syscon = <&ts_adc_syscon>;
 			clocks = <&asiu_clks BCM_CYGNUS_ASIU_ADC_CLK>;
 			clock-names = "tsc_clk";
 			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.9.1
