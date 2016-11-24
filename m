From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Thu, 24 Nov 2016 15:45:41 +0100
Subject: [PATCH v2 1/9] clk: stm32f4: Update DT bindings documentation
In-Reply-To: <1479998749-20358-1-git-send-email-gabriel.fernandez@st.com>
References: <1479998749-20358-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1479998749-20358-2-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

Creation of dt include file for specific stm32f4 clocks.
These specific clocks are not derived from system clock (SYSCLOCK)
We should use index 1 to use these clocks in DT.
e.g. <&rcc 1 CLK_LSI>

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 .../devicetree/bindings/clock/st,stm32-rcc.txt     |  8 ++++++
 drivers/clk/clk-stm32f4.c                          |  9 +++++--
 include/dt-bindings/clock/stm32f4-clock.h          | 31 ++++++++++++++++++++++
 3 files changed, 46 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/clock/stm32f4-clock.h

diff --git a/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt b/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
index 0532d81..18e05c2 100644
--- a/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
+++ b/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
@@ -17,6 +17,8 @@ Required properties:
   property, containing a phandle to the clock device node, an index selecting
   between gated clocks and other clocks and an index specifying the clock to
   use.
+- clocks: External oscillator clock phandle
+  - high speed external clock signal (HSE)
 
 Example:
 
@@ -25,6 +27,7 @@ Example:
 		#clock-cells = <2>
 		compatible = "st,stm32f42xx-rcc", "st,stm32-rcc";
 		reg = <0x40023800 0x400>;
+		clocks = <&clk_hse>;
 	};
 
 Specifying gated clocks
@@ -66,6 +69,11 @@ The secondary index is bound with the following magic numbers:
 
 	0	SYSTICK
 	1	FCLK
+	2	CLK_LSI		(low-power clock source)
+	3	CLK_LSE		(generated from a 32.768 kHz low-speed external
+				 crystal or ceramic resonator)
+	4	CLK_HSE_RTC	(HSE division factor for RTC clock)
+	5	CLK_RTC		(real-time clock)
 
 Example:
 
diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 5eb05db..39965ab 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -28,6 +28,13 @@
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 
+/*
+ * Include list of clocks wich are not derived from system clock (SYSCLOCK)
+ * The index of these clocks is the secondary index of DT bindings
+ *
+ */
+#include <dt-bindings/clock/stm32f4-clock.h>
+
 #define STM32F4_RCC_PLLCFGR		0x04
 #define STM32F4_RCC_CFGR		0x08
 #define STM32F4_RCC_AHB1ENR		0x30
@@ -208,8 +215,6 @@ struct stm32f4_gate_data {
 	{ STM32F4_RCC_APB2ENR, 26,	"ltdc",		"apb2_div" },
 };
 
-enum { SYSTICK, FCLK, CLK_LSI, CLK_LSE, CLK_HSE_RTC, CLK_RTC, END_PRIMARY_CLK };
-
 /*
  * This bitmask tells us which bit offsets (0..192) on STM32F4[23]xxx
  * have gate bits associated with them. Its combined hweight is 71.
diff --git a/include/dt-bindings/clock/stm32f4-clock.h b/include/dt-bindings/clock/stm32f4-clock.h
new file mode 100644
index 0000000..3132b6a
--- /dev/null
+++ b/include/dt-bindings/clock/stm32f4-clock.h
@@ -0,0 +1,31 @@
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
+
+#define END_PRIMARY_CLK		6
+
+#endif
-- 
1.9.1
