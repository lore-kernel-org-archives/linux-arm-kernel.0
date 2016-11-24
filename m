From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Thu, 24 Nov 2016 16:14:17 +0100
Subject: [PATCH v2 1/7] MFD: add bindings for stm32 general purpose timer
 driver
In-Reply-To: <1480000463-9625-1-git-send-email-benjamin.gaignard@st.com>
References: <1480000463-9625-1-git-send-email-benjamin.gaignard@st.com>
Message-ID: <1480000463-9625-2-git-send-email-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bindings information for stm32 general purpose timer

version 2:
- rename stm32-mfd-timer to stm32-gptimer
- only keep one compatible string

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../bindings/mfd/stm32-general-purpose-timer.txt   | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt

diff --git a/Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt b/Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt
new file mode 100644
index 0000000..2f10e67
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt
@@ -0,0 +1,43 @@
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
+			See ..reset/st,stm32-rcc.txt
+
+Optional subnodes:
+- pwm:			See ../pwm/pwm-stm32.txt
+- iiotimer:		See ../iio/timer/stm32-iio-timer.txt
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
+		iiotimer1 at 0 {
+			compatible = "st,stm32-iio-timer";
+			interrupts = <27>;
+			st,input-triggers-names = TIM5_TRGO,
+						  TIM2_TRGO,
+						  TIM4_TRGO,
+						  TIM3_TRGO;
+			st,output-triggers-names = TIM1_TRGO;
+		};
+	};
-- 
1.9.1
