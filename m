From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Fri,  2 Dec 2016 11:17:16 +0100
Subject: [PATCH v3 1/7] MFD: add bindings for stm32 general purpose timer
 driver
In-Reply-To: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
References: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
Message-ID: <1480673842-20804-2-git-send-email-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bindings information for stm32 general purpose timer

version 2:
- rename stm32-mfd-timer to stm32-gptimer
- only keep one compatible string

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../bindings/mfd/stm32-general-purpose-timer.txt   | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt

diff --git a/Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt b/Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt
new file mode 100644
index 0000000..4fc55d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt
@@ -0,0 +1,47 @@
+STM32 general purpose timer driver
+
+Required parameters:
+- compatible: must be "st,stm32-gptimer"
+
+- reg:			Physical base address and length of the controller's
+			registers.
+- clock-names: 		Set to "clk_int".
+- clocks: 		Phandle to the clock used by the timer module.
+			For Clk properties, please refer to ../clock/clock-bindings.txt
+
+Optional parameters:
+- resets:		Phandle to the parent reset controller.
+			See ../reset/st,stm32-rcc.txt
+
+Optional subnodes:
+- pwm:			See ../pwm/pwm-stm32.txt
+- timer:		See ../iio/timer/stm32-timer-trigger.txt
+
+Example:
+	gptimer1: gptimer1 at 40010000 {
+		compatible = "st,stm32-gptimer";
+		reg = <0x40010000 0x400>;
+		clocks = <&rcc 0 160>;
+		clock-names = "clk_int";
+
+		pwm1 at 0 {
+			compatible = "st,stm32-pwm";
+			st,pwm-num-chan = <4>;
+			st,breakinput;
+			st,complementary;
+		};
+
+		timer1 at 0 {
+			compatible = "st,stm32-timer-trigger";
+			interrupts = <27>;
+			st,input-triggers-names = TIM5_TRGO,
+						  TIM2_TRGO,
+						  TIM4_TRGO,
+						  TIM3_TRGO;
+			st,output-triggers-names = TIM1_TRGO,
+						   TIM1_CH1,
+						   TIM1_CH2,
+						   TIM1_CH3,
+						   TIM1_CH4;
+		};
+	};
-- 
1.9.1
