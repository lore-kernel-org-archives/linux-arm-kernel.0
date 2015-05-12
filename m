From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 May 2015 13:51:40 +0100
Subject: [PATCH 03/13] ARM: STi: STiH416: Add DT nodes for PWM
In-Reply-To: <1431435110-22595-1-git-send-email-lee.jones@linaro.org>
References: <1431435110-22595-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1431435110-22595-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Supply top level nodes for the STiH416 based development boards.
The Pinctrl configuration has already been applied, so the only
missing piece of the DT puzzle is for a board's DTB to enable
the nodes.

Signed-off-by: Ajit Pal Singh <ajitpal.singh@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih416.dtsi | 44 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index eeb7afe..9ead8bb 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -104,7 +104,7 @@
 			interrupts	= <0 210 0>;
 			pinctrl-names 	= "default";
 			pinctrl-0 	= <&pinctrl_sbc_serial1>;
-			clocks          = <&clk_sysin>;
+			clocks		= <&clk_sysin>;
 		};
 
 		i2c at fed40000 {
@@ -445,5 +445,47 @@
 				 <&softreset STIH416_USB3_SOFTRESET>;
 			reset-names = "power", "softreset";
 		};
+
+		/* SAS PWM Module */
+		pwm0: pwm at fed10000 {
+			compatible	= "st,sti-pwm";
+			status		= "disabled";
+			#pwm-cells	= <2>;
+			reg		= <0xfed10000 0x68>;
+
+			pinctrl-names	= "default";
+			pinctrl-0 = 	<&pinctrl_pwm0_chan0_default
+					&pinctrl_pwm0_chan1_default
+					&pinctrl_pwm0_chan2_default
+					&pinctrl_pwm0_chan3_default>;
+
+			clock-names	= "pwm";
+			clocks		= <&clk_sysin>;
+			st,pwm-num-chan = <4>;
+		};
+
+		/* SBC PWM Module */
+		pwm1: pwm at fe510000 {
+			compatible	= "st,sti-pwm";
+			status		= "disabled";
+			#pwm-cells	= <2>;
+			reg		= <0xfe510000 0x68>;
+
+			pinctrl-names	= "default";
+			pinctrl-0	= <&pinctrl_pwm1_chan0_default
+					/*
+					 * Shared with SBC_OBS_NOTRST.  Don't
+					 * enable unless you really know what
+					 * you're doing.
+					 *
+					 * &pinctrl_pwm1_chan1_default
+					 */
+					&pinctrl_pwm1_chan2_default
+					&pinctrl_pwm1_chan3_default>;
+
+			clock-names	= "pwm";
+			clocks		= <&clk_sysin>;
+			st,pwm-num-chan = <3>;
+		};
 	};
 };
-- 
1.9.1
