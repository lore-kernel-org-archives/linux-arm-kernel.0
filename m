From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Tue, 28 Feb 2017 17:51:18 +0100
Subject: [PATCH v3 5/6] dt-bindings: iio: stm32-adc: add external interrupt
 trigger
In-Reply-To: <1488300679-3259-1-git-send-email-fabrice.gasnier@st.com>
References: <1488300679-3259-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1488300679-3259-6-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document support for EXTI trigger. STM32 ADC can use external interrupt
line as trigger source for conversions.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 .../devicetree/bindings/iio/adc/st,stm32-adc.txt    | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
index 5dfc88e..9e4af7f 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
@@ -57,6 +57,10 @@ Optional properties:
 - dmas: Phandle to dma channel for this ADC instance.
   See ../../dma/dma.txt for details.
 - dma-names: Must be "rx" when dmas property is being used.
+- io-triggers: Phandle to external interrupt trigger (e.g. EXTI). Must be
+  phandle to EXTI11 on stm32f4. See ../iio-bindings.txt for details on trigger
+  consumer.
+- io-trigger-names: Must be "exti" when io-triggers property is being used.
 
 Example:
 	adc: adc at 40012000 {
@@ -88,3 +92,20 @@ Example:
 		...
 		other adc child nodes follow...
 	};
+
+Example with EXTI11 trigger:
+	trig: interrupt-trigger {
+		#io-trigger-cells = <0>;
+		compatible = "interrupt-trigger";
+		interrupts = <11 0>;
+		interrupt-parent = <&gpioa>;
+	}
+
+	adc: adc at 40012000 {
+		...
+		adc at 0 {
+			...
+			io-triggers = <&trig>;
+			io-trigger-names = "exti";
+		};
+	};
-- 
1.9.1
