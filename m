From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Thu, 24 Nov 2016 16:14:21 +0100
Subject: [PATCH v2 5/7] IIO: add bindings for stm32 IIO timer driver
In-Reply-To: <1480000463-9625-1-git-send-email-benjamin.gaignard@st.com>
References: <1480000463-9625-1-git-send-email-benjamin.gaignard@st.com>
Message-ID: <1480000463-9625-6-git-send-email-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define bindings for stm32 IIO timer

version 2:
- only keep one compatible
- add DT parameters to set lists of the triggers:
  one list describe the triggers created by the device
  another one give the triggers accepted by the device

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../bindings/iio/timer/stm32-iio-timer.txt         | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt

diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt b/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
new file mode 100644
index 0000000..840b417
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
@@ -0,0 +1,41 @@
+timer IIO trigger bindings for STM32
+
+Must be a sub-node of STM32 general purpose timer driver
+
+Required parameters:
+- compatible:		must be "st,stm32-iio-timer"
+- interrupts:		Interrupt for this device
+			See ../interrupt-controller/st,stm32-exti.txt
+
+Optional parameters:
+- st,input-triggers-names:	List of the possible input triggers for
+				the device
+- st,output-triggers-names:	List of the possible output triggers for
+				the device
+
+Possible triggers are defined in include/dt-bindings/iio/timer/st,stm32-iio-timer.h
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
