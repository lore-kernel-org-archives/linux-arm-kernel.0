From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Wed, 18 Jan 2017 15:20:46 +0100
Subject: [PATCH v8 3/8] PWM: add pwm-stm32 DT bindings
In-Reply-To: <1484749251-14445-1-git-send-email-benjamin.gaignard@st.com>
References: <1484749251-14445-1-git-send-email-benjamin.gaignard@st.com>
Message-ID: <1484749251-14445-4-git-send-email-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define bindings for pwm-stm32

version 8:
- reword st,breakinput description.

version 6:
- change st,breakinput parameter format to make it usuable on stm32f7 too.

version 2:
- use parameters instead of compatible of handle the hardware configuration

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pwm/pwm-stm32.txt          | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
new file mode 100644
index 0000000..6dd0403
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
@@ -0,0 +1,35 @@
+STMicroelectronics STM32 Timers PWM bindings
+
+Must be a sub-node of an STM32 Timers device tree node.
+See ../mfd/stm32-timers.txt for details about the parent node.
+
+Required parameters:
+- compatible:		Must be "st,stm32-pwm".
+- pinctrl-names: 	Set to "default".
+- pinctrl-0: 		List of phandles pointing to pin configuration nodes for PWM module.
+			For Pinctrl properties see ../pinctrl/pinctrl-bindings.txt
+
+Optional parameters:
+- st,breakinput:	One or two <index level filter> to describe break input configurations.
+			"index" indicates on which break input (0 or 1) the configuration
+			should be applied.
+			"level" gives the active level (0=low or 1=high) of the input signal
+			for this configuration.
+			"filter" gives the filtering value to be applied.
+
+Example:
+	timers at 40010000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "st,stm32-timers";
+		reg = <0x40010000 0x400>;
+		clocks = <&rcc 0 160>;
+		clock-names = "clk_int";
+
+		pwm {
+			compatible = "st,stm32-pwm";
+			pinctrl-0	= <&pwm1_pins>;
+			pinctrl-names	= "default";
+			st,breakinput = <0 1 5>;
+		};
+	};
-- 
1.9.1
