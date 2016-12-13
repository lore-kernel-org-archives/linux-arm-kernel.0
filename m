From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Tue, 13 Dec 2016 15:20:12 +0100
Subject: [PATCH v4 1/9] clk: stm32f4: Update DT bindings documentation
In-Reply-To: <1481638820-29324-1-git-send-email-gabriel.fernandez@st.com>
References: <1481638820-29324-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1481638820-29324-2-git-send-email-gabriel.fernandez@st.com>
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
 .../devicetree/bindings/clock/st,stm32-rcc.txt     | 17 ++++++++++
 include/dt-bindings/clock/stm32fx-clock.h          | 39 ++++++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 include/dt-bindings/clock/stm32fx-clock.h

diff --git a/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt b/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
index 0532d81..8f19d87 100644
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
@@ -66,6 +70,19 @@ The secondary index is bound with the following magic numbers:
 
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
+	12	CLK_I2SQ_PDIV	(post divisor of pll i2s q divisor)
+	13	CLK_SAIQ_PDIV	(post divisor of pll sai q divisor)
 
 Example:
 
diff --git a/include/dt-bindings/clock/stm32fx-clock.h b/include/dt-bindings/clock/stm32fx-clock.h
new file mode 100644
index 0000000..08bcab6
--- /dev/null
+++ b/include/dt-bindings/clock/stm32fx-clock.h
@@ -0,0 +1,39 @@
+/*
+ * stm32fx-clock.h
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
+#ifndef _DT_BINDINGS_CLK_STMFX_H
+#define _DT_BINDINGS_CLK_STMFX_H
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
+#define CLK_I2SQ_PDIV		12
+#define CLK_SAIQ_PDIV		13
+
+#define END_PRIMARY_CLK		14
+
+#endif
-- 
1.9.1
