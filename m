From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Thu, 21 Jul 2016 11:19:26 +0200
Subject: [PATCH v2 2/4] dt-bindings: Document the STM32 reset bindings
In-Reply-To: <1469092768-17489-1-git-send-email-gabriel.fernandez@st.com>
References: <1469092768-17489-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1469092768-17489-3-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Coquelin <mcoquelin.stm32@gmail.com>

This adds documentation of device tree bindings for the
STM32 reset controller.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 .../devicetree/bindings/clock/st,stm32-rcc.txt     | 42 ++++++++++++++++++----
 .../devicetree/bindings/reset/st,stm32-rcc.txt     |  6 ++++
 2 files changed, 41 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/st,stm32-rcc.txt

diff --git a/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt b/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
index fee3205..c209de6 100644
--- a/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
+++ b/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
@@ -1,16 +1,16 @@
 STMicroelectronics STM32 Reset and Clock Controller
 ===================================================
 
-The RCC IP is both a reset and a clock controller. This documentation only
-describes the clock part.
+The RCC IP is both a reset and a clock controller.
 
-Please also refer to clock-bindings.txt in this directory for common clock
-controller binding usage.
+Please refer to clock-bindings.txt for common clock controller binding usage.
+Please also refer to reset.txt for common reset controller binding usage.
 
 Required properties:
 - compatible: Should be "st,stm32f42xx-rcc"
 - reg: should be register base and length as documented in the
   datasheet
+- #reset-cells: 1, see below
 - #clock-cells: 2, device nodes should specify the clock in their "clocks"
   property, containing a phandle to the clock device node, an index selecting
   between gated clocks and other clocks and an index specifying the clock to
@@ -19,6 +19,7 @@ Required properties:
 Example:
 
 	rcc: rcc at 40023800 {
+		#reset-cells = <1>;
 		#clock-cells = <2>
 		compatible = "st,stm32f42xx-rcc", "st,stm32-rcc";
 		reg = <0x40023800 0x400>;
@@ -35,16 +36,23 @@ from the first RCC clock enable register (RCC_AHB1ENR, address offset 0x30).
 It is calculated as: index = register_offset / 4 * 32 + bit_offset.
 Where bit_offset is the bit offset within the register (LSB is 0, MSB is 31).
 
+To simplify the usage and to share bit definition with the reset and clock
+drivers of the RCC IP, macros are available to generate the index in
+human-readble format.
+
+For STM32F4 series, the macro are available here:
+ - include/dt-bindings/mfd/stm32f4-rcc.h
+
 Example:
 
 	/* Gated clock, AHB1 bit 0 (GPIOA) */
 	... {
-		clocks = <&rcc 0 0>
+		clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOA)>
 	};
 
 	/* Gated clock, AHB2 bit 4 (CRYP) */
 	... {
-		clocks = <&rcc 0 36>
+		clocks = <&rcc 0 STM32F4_AHB2_CLOCK(CRYP)>
 	};
 
 Specifying other clocks
@@ -61,5 +69,25 @@ Example:
 
 	/* Misc clock, FCLK */
 	... {
-		clocks = <&rcc 1 1>
+		clocks = <&rcc 1 STM32F4_APB1_CLOCK(TIM2)>
+	};
+
+
+Specifying softreset control of devices
+=======================================
+
+Device nodes should specify the reset channel required in their "resets"
+property, containing a phandle to the reset device node and an index specifying
+which channel to use.
+The index is the bit number within the RCC registers bank, starting from RCC
+base address.
+It is calculated as: index = register_offset / 4 * 32 + bit_offset.
+Where bit_offset is the bit offset within the register.
+For example, for CRC reset:
+  crc = AHB1RSTR_offset / 4 * 32 + CRCRST_bit_offset = 0x10 / 4 * 32 + 12 = 140
+
+example:
+
+	timer2 {
+		resets	= <&rcc STM32F4_APB1_RESET(TIM2)>;
 	};
diff --git a/Documentation/devicetree/bindings/reset/st,stm32-rcc.txt b/Documentation/devicetree/bindings/reset/st,stm32-rcc.txt
new file mode 100644
index 0000000..01db343
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/st,stm32-rcc.txt
@@ -0,0 +1,6 @@
+STMicroelectronics STM32 Peripheral Reset Controller
+====================================================
+
+The RCC IP is both a reset and a clock controller.
+
+Please see Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
-- 
1.9.1
