From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Thu, 1 Dec 2016 16:27:41 +0100
Subject: [PATCH v3 1/9] clk: stm32f4: Update DT bindings documentation
In-Reply-To: <1480606069-5178-1-git-send-email-gabriel.fernandez@st.com>
References: <1480606069-5178-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1480606069-5178-2-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

Creation of dt include file for specific stm32f4 clocks.
These specific clocks are not derived from system clock (SYSCLOCK)
We should use index 1 to use these clocks in DT.
e.g. <&rcc 1 CLK_LSI>

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/clock/st,stm32-rcc.txt     | 15 +++++++++
 include/dt-bindings/clock/stm32f4-clock.h          | 37 ++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 include/dt-bindings/clock/stm32f4-clock.h

diff --git a/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt b/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
index 0532d81..8f93740 100644
--- a/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
+++ b/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
@@ -17,6 +17,9 @@ Required properties:
   property, containing a phandle to the clock device node, an index selecting
   between gated clocks and other clocks and an index specifying the clock to
   use.
+- clocks: External oscillator clock phandle
+  - high speed external clock signal (HSE)
+  - external I2S clock (I2S_CKIN)
 
 Example:
 
@@ -25,6 +28,7 @@ Example:
 		#clock-cells = <2>
 		compatible = "st,stm32f42xx-rcc", "st,stm32-rcc";
 		reg = <0x40023800 0x400>;
+		clocks = <&clk_hse>, <&clk_i2s_ckin>;
 	};
 
 Specifying gated clocks
@@ -66,6 +70,17 @@ The secondary index is bound with the following magic numbers:
 
 	0	SYSTICK
 	1	FCLK
+	2	CLK_LSI		(low-power clock source)
+	3	CLK_LSE		(generated from a 32.768 kHz low-speed external
+				 crystal or ceramic resonator)
+	4	CLK_HSE_RTC	(HSE division factor for RTC clock)
+	5	CLK_RTC		(real-time clock)
+	6	PLL_VCO_I2S	(vco frequency of I2S pll)
+	7	PLL_VCO_SAI	(vco frequency of SAI pll)
+	8	CLK_LCD		(LCD-TFT)
+	9	CLK_I2S		(I2S clocks)
+	10	CLK_SAI1	(audio clocks)
+	11	CLK_SAI2
 
 Example:
 
diff --git a/include/dt-bindings/clock/stm32f4-clock.h b/include/dt-bindings/clock/stm32f4-clock.h
new file mode 100644
index 0000000..5431f00
--- /dev/null
+++ b/include/dt-bindings/clock/stm32f4-clock.h
@@ -0,0 +1,37 @@
+/*
+ * stm32f4-clock.h
+ *
+ * Copyright (C) 2016 STMicroelectronics
+ * Author: Gabriel Fernandez for STMicroelectronics.
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+/*
+ * List of clocks wich are not derived from system clock (SYSCLOCK)
+ *
+ * The index of these clocks is the secondary index of DT bindings
+ * (see Documentatoin/devicetree/bindings/clock/st,stm32-rcc.txt)
+ *
+ * e.g:
+	<assigned-clocks = <&rcc 1 CLK_LSE>;
+*/
+
+#ifndef _DT_BINDINGS_CLK_STMF4_H
+#define _DT_BINDINGS_CLK_STMF4_H
+
+#define SYSTICK			0
+#define FCLK			1
+#define CLK_LSI			2
+#define CLK_LSE			3
+#define CLK_HSE_RTC		4
+#define CLK_RTC			5
+#define PLL_VCO_I2S		6
+#define PLL_VCO_SAI		7
+#define CLK_LCD			8
+#define CLK_I2S			9
+#define CLK_SAI1		10
+#define CLK_SAI2		11
+
+#define END_PRIMARY_CLK		12
+
+#endif
-- 
1.9.1
