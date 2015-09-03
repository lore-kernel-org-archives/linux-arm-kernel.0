From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu,  3 Sep 2015 18:59:50 +0100
Subject: [PATCH v5 2/6] ARM: DT: STi: STiH407: Add c8sectpfe LinuxDVB DT node.
In-Reply-To: <1441303194-28211-1-git-send-email-peter.griffin@linaro.org>
References: <1441303194-28211-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1441303194-28211-3-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds in the required DT node for the c8sectpfe
Linux DVB demux driver which allows the tsin channels
to be used on an upstream kernel.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stihxxx-b2120.dtsi | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index 62994ae..f9fca10 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -6,6 +6,9 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+
+#include <dt-bindings/clock/stih407-clks.h>
+#include <dt-bindings/media/c8sectpfe.h>
 / {
 	soc {
 		sbc_serial0: serial at 9530000 {
@@ -85,5 +88,37 @@
 			status = "okay";
 		};
 
+		demux at 08a20000 {
+			compatible	= "st,stih407-c8sectpfe";
+			status		= "okay";
+			reg		= <0x08a20000 0x10000>,
+					  <0x08a00000 0x4000>;
+			reg-names	= "c8sectpfe", "c8sectpfe-ram";
+			interrupts	= <GIC_SPI 34 IRQ_TYPE_NONE>,
+					  <GIC_SPI 35 IRQ_TYPE_NONE>;
+			interrupt-names	= "c8sectpfe-error-irq",
+					  "c8sectpfe-idle-irq";
+			pinctrl-0	= <&pinctrl_tsin0_serial>;
+			pinctrl-1	= <&pinctrl_tsin0_parallel>;
+			pinctrl-2	= <&pinctrl_tsin3_serial>;
+			pinctrl-3	= <&pinctrl_tsin4_serial_alt3>;
+			pinctrl-4	= <&pinctrl_tsin5_serial_alt1>;
+			pinctrl-names	= "tsin0-serial",
+					  "tsin0-parallel",
+					  "tsin3-serial",
+					  "tsin4-serial",
+					  "tsin5-serial";
+			clocks		= <&clk_s_c0_flexgen CLK_PROC_STFE>;
+			clock-names	= "c8sectpfe";
+
+			/* tsin0 is TSA on NIMA */
+			tsin0: port at 0 {
+				tsin-num	= <0>;
+				serial-not-parallel;
+				i2c-bus		= <&ssc2>;
+				rst-gpio	= <&pio15 4 GPIO_ACTIVE_HIGH>;
+				dvb-card	= <STV0367_TDA18212_NIMA_1>;
+			};
+		};
 	};
 };
-- 
1.9.1
