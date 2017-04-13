From: vikas.manocha@st.com (Vikas Manocha)
Date: Wed, 12 Apr 2017 17:27:03 -0700
Subject: [PATCH v3] ARM: dts: stm32f7: add stm32f769I & stm32f746 discovery
 board support
Message-ID: <1492043225-22424-1-git-send-email-vikas.manocha@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stm32f769I & stm32f746 are MCUs of stm32f7 family. Here are the major
specs of the two boards:

stm32f769I discovery board:
	- Cortex-M7 core @216MHz
	- 2MB mcu internal flash
	- 512KB internal sram
	- 16MB sdram memory
	- 64MB qspi flash memory
	- 4 inch wvga LCD-TFT Display

stm32f746 discovery board:
	- Cortex-M7 core @216MHz
	- 1MB mcu internal flash
	- 320KB internal sram
	- 8MB sdram memory
	- 16MB qspi flash memory
	- 4.3 inch 480x272 LCD-TFT display

Signed-off-by: Vikas Manocha <vikas.manocha@st.com>
---
Changed in v3:
- fixed usart pin muxing for stm32f746 board, correct one is usart1_pins_pa9_pb7.
- Added patch version in the patch title, was missed in v2.

Changed in v2:
- moved pin muxing from board dts file to soc dtsi

 arch/arm/boot/dts/Makefile            |  2 +
 arch/arm/boot/dts/stm32f746-disco.dts | 74 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32f746.dtsi      | 12 ++++++
 arch/arm/boot/dts/stm32f769-disco.dts | 74 +++++++++++++++++++++++++++++++++++
 4 files changed, 162 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32f746-disco.dts
 create mode 100644 arch/arm/boot/dts/stm32f769-disco.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0118084..a119f74 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -763,6 +763,8 @@ dtb-$(CONFIG_ARCH_STI) += \
 dtb-$(CONFIG_ARCH_STM32)+= \
 	stm32f429-disco.dtb \
 	stm32f469-disco.dtb \
+	stm32f746-disco.dtb \
+	stm32f769-disco.dtb \
 	stm32429i-eval.dtb \
 	stm32746g-eval.dtb
 dtb-$(CONFIG_MACH_SUN4I) += \
diff --git a/arch/arm/boot/dts/stm32f746-disco.dts b/arch/arm/boot/dts/stm32f746-disco.dts
new file mode 100644
index 0000000..52e5834
--- /dev/null
+++ b/arch/arm/boot/dts/stm32f746-disco.dts
@@ -0,0 +1,74 @@
+/*
+ * Copyright 2017 - Vikas MANOCHA <vikas.manocha@st.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "stm32f746.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "STMicroelectronics STM32F746-DISCO board";
+	compatible = "st,stm32f746-disco", "st,stm32f746";
+
+	chosen {
+		bootargs = "root=/dev/ram";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		reg = <0xC0000000 0x800000>;
+	};
+
+	aliases {
+		serial0 = &usart1;
+	};
+
+};
+
+&clk_hse {
+	clock-frequency = <25000000>;
+};
+
+&usart1 {
+	pinctrl-0 = <&usart1_pins_pa9_pb7>;
+	pinctrl-names = "default";
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index f321ffe..82becbb 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -287,6 +287,18 @@
 					bias-disable;
 				};
 			};
+			usart1_pins_pa9_pb7: usart1 at 1 {
+				pins1 {
+					pinmux = <STM32F746_PA9_FUNC_USART1_TX>;
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+				pins2 {
+					pinmux = <STM32F746_PB7_FUNC_USART1_RX>;
+					bias-disable;
+				};
+			};
 		};
 
 		rcc: rcc at 40023800 {
diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/stm32f769-disco.dts
new file mode 100644
index 0000000..166728a
--- /dev/null
+++ b/arch/arm/boot/dts/stm32f769-disco.dts
@@ -0,0 +1,74 @@
+/*
+ * Copyright 2017 - Vikas MANOCHA <vikas.manocha@st.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "stm32f746.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "STMicroelectronics STM32F769-DISCO board";
+	compatible = "st,stm32f769-disco", "st,stm32f7";
+
+	chosen {
+		bootargs = "root=/dev/ram";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		reg = <0xC0000000 0x1000000>;
+	};
+
+	aliases {
+		serial0 = &usart1;
+	};
+
+};
+
+&clk_hse {
+	clock-frequency = <25000000>;
+};
+
+&usart1 {
+	pinctrl-0 = <&usart1_pins_a>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
1.9.1
