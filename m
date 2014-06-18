From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Jun 2014 16:28:24 +0100
Subject: [PATCH v2 3/7] ARM: stih416: Add DT nodes for PWM
In-Reply-To: <1403103172-19856-3-git-send-email-lee.jones@linaro.org>
References: <1403103172-19856-1-git-send-email-lee.jones@linaro.org>
 <1403103172-19856-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20140618152824.GF15956@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: stih416: Add DT nodes for PWM

Supply top level nodes for the STiH416 based development boards.
The Pinctrl configuration has already been applied, so the only
missing piece of the DT puzzle is for a board's DTB to enable
the nodes.

Signed-off-by: Lee Jones <lee.jones@linaro.org>

diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index 06473c5..f95e469 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -102,7 +102,7 @@
 			interrupts	= <0 210 0>;
 			pinctrl-names 	= "default";
 			pinctrl-0 	= <&pinctrl_sbc_serial1>;
-			clocks          = <&clk_sysin>;
+			clocks		= <&clk_sysin>;
 		};
 
 		i2c at fed40000 {
@@ -236,5 +236,45 @@
 			resets	= <&powerdown STIH416_KEYSCAN_POWERDOWN>,
 				  <&softreset STIH416_KEYSCAN_SOFTRESET>;
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
+		};
 	};
 };
