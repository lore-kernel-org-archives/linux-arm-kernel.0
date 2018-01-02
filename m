From: ludovic.Barre@st.com (Ludovic Barre)
Date: Tue, 2 Jan 2018 16:01:51 +0100
Subject: [PATCH v3 7/7] ARM: dts: stm32: add initial support of stm32mp157c
 eval board
In-Reply-To: <1514905311-12925-1-git-send-email-ludovic.Barre@st.com>
References: <1514905311-12925-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1514905311-12925-8-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

Add support of stm32mp157c evaluation board (part number: STM32MP157C-EV1)
split in 2 elements:
-Daughter board (part number: STM32MP157C-ED1)
 which includes CPU, memory and power supply
-Mother board (part number: STM32MP157C-EM1)
 which includes external peripherals (like display, camera,...)
 and extension connectors.

The daughter board can run alone, this is why the device tree files
are split in two layers, for the complete evaluation board (ev1)
and for the daughter board alone (ed1).

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
---
 arch/arm/boot/dts/Makefile                |  6 ++++--
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 13 +++++++++++++
 arch/arm/boot/dts/stm32mp157c-ed1.dts     | 28 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp157c-ev1.dts     | 18 ++++++++++++++++++
 4 files changed, 63 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/stm32mp157c-ed1.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157c-ev1.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d0381e9..d72c71c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -839,7 +839,7 @@ dtb-$(CONFIG_ARCH_STI) += \
 	stih410-b2120.dtb \
 	stih410-b2260.dtb \
 	stih418-b2199.dtb
-dtb-$(CONFIG_ARCH_STM32)+= \
+dtb-$(CONFIG_ARCH_STM32) += \
 	stm32f429-disco.dtb \
 	stm32f469-disco.dtb \
 	stm32f746-disco.dtb \
@@ -847,7 +847,9 @@ dtb-$(CONFIG_ARCH_STM32)+= \
 	stm32429i-eval.dtb \
 	stm32746g-eval.dtb \
 	stm32h743i-eval.dtb \
-	stm32h743i-disco.dtb
+	stm32h743i-disco.dtb \
+	stm32mp157c-ed1.dtb \
+	stm32mp157c-ev1.dtb
 dtb-$(CONFIG_MACH_SUN4I) += \
 	sun4i-a10-a1000.dtb \
 	sun4i-a10-ba10-tvbox.dtb \
diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index 440276a..7ac65f4 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -145,6 +145,19 @@
 				ngpios = <8>;
 				gpio-ranges = <&pinctrl 0 160 8>;
 			};
+
+			uart4_pins_a: uart4 at 0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('G', 11, AF6)>; /* UART4_TX */
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('B', 2, AF8)>; /* UART4_RX */
+					bias-disable;
+				};
+			};
 		};
 
 		pinctrl_z: pin-controller-z {
diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
new file mode 100644
index 0000000..78ccdd3
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright (C) STMicroelectronics 2017 - All Rights Reserved 
+ * Author: Ludovic Barre <ludovic.barre@st.com> for STMicroelectronics.
+ */
+/dts-v1/;
+
+#include "stm32mp157c.dtsi"
+#include "stm32mp157-pinctrl.dtsi"
+
+/ {
+	model = "STMicroelectronics STM32MP157C eval daughter";
+	compatible = "st,stm32mp157c-ed1", "st,stm32mp157";
+
+	chosen {
+		stdout-path = "serial3:115200n8";
+	};
+
+	memory {
+		reg = <0xC0000000 0x40000000>;
+	};
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart4_pins_a>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
new file mode 100644
index 0000000..42e1769b
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright (C) STMicroelectronics 2017 - All Rights Reserved 
+ * Author: Ludovic Barre <ludovic.barre@st.com> for STMicroelectronics.
+ */
+/dts-v1/;
+
+#include "stm32mp157c-ed1.dts"
+
+/ {
+	model = "STMicroelectronics STM32MP157C eval daughter on eval mother";
+	compatible = "st,stm32mp157c-ev1", "st,stm32mp157c-ed1", "st,stm32mp157";
+
+	chosen {
+		stdout-path = "serial3:115200n8";
+	};
+};
+
-- 
2.7.4
