From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Wed, 26 Oct 2016 17:11:21 +0200
Subject: [PATCH 3/5] ARM: dts: Add STM32F746 MCU and STM32746g-EVAL board
In-Reply-To: <1477494683-29890-1-git-send-email-alexandre.torgue@st.com>
References: <1477494683-29890-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1477494683-29890-4-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The STMicrolectornics's STM32F746 MCU has the following main features:
 - Cortex-M7 core running up to @216MHz
 - 1MB internal flash, 320KBytes internal RAM (+4KB of backup SRAM)
 - FMC controller to connect SDRAM, NOR and NAND memories
 - Dual mode QSPI
 - SD/MMC/SDIO support
 - Ethernet controller
 - USB OTFG FS & HS controllers
 - I2C, SPI, CAN busses support
 - Several 16 & 32 bits general purpose timers
 - Serial Audio interface
 - LCD controller
 - HDMI-CEC
 - SPDIFRX

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index befcd26..343dda2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -721,7 +721,8 @@ dtb-$(CONFIG_ARCH_STI) += \
 dtb-$(CONFIG_ARCH_STM32)+= \
 	stm32f429-disco.dtb \
 	stm32f469-disco.dtb \
-	stm32429i-eval.dtb
+	stm32429i-eval.dtb \
+	stm32746g-eval.dtb
 dtb-$(CONFIG_MACH_SUN4I) += \
 	sun4i-a10-a1000.dtb \
 	sun4i-a10-ba10-tvbox.dtb \
diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/stm32746g-eval.dts
new file mode 100644
index 0000000..aa03fac
--- /dev/null
+++ b/arch/arm/boot/dts/stm32746g-eval.dts
@@ -0,0 +1,96 @@
+/*
+ * Copyright 2015 - Maxime Coquelin <mcoquelin.stm32@gmail.com>
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
+	model = "STMicroelectronics STM32746g-EVAL board";
+	compatible = "st,stm32746g-eval", "st,stm32f746";
+
+	chosen {
+		bootargs = "root=/dev/ram";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		reg = <0xc0000000 0x2000000>;
+	};
+
+	aliases {
+		serial0 = &usart1;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		green {
+			gpios = <&gpiof 10 1>;
+			linux,default-trigger = "heartbeat";
+		};
+		red {
+			gpios = <&gpiob 7 1>;
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		autorepeat;
+		button at 0 {
+			label = "Wake up";
+			linux,code = <KEY_WAKEUP>;
+			gpios = <&gpioc 13 0>;
+		};
+	};
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
diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
new file mode 100644
index 0000000..f321ffe
--- /dev/null
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -0,0 +1,304 @@
+/*
+ * Copyright 2015 - Maxime Coquelin <mcoquelin.stm32@gmail.com>
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
+#include "skeleton.dtsi"
+#include "armv7-m.dtsi"
+#include <dt-bindings/pinctrl/stm32f746-pinfunc.h>
+
+/ {
+	clocks {
+		clk_hse: clk-hse {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <0>;
+		};
+	};
+
+	soc {
+		timer2: timer at 40000000 {
+			compatible = "st,stm32-timer";
+			reg = <0x40000000 0x400>;
+			interrupts = <28>;
+			clocks = <&rcc 0 128>;
+			status = "disabled";
+		};
+
+		timer3: timer at 40000400 {
+			compatible = "st,stm32-timer";
+			reg = <0x40000400 0x400>;
+			interrupts = <29>;
+			clocks = <&rcc 0 129>;
+			status = "disabled";
+		};
+
+		timer4: timer at 40000800 {
+			compatible = "st,stm32-timer";
+			reg = <0x40000800 0x400>;
+			interrupts = <30>;
+			clocks = <&rcc 0 130>;
+			status = "disabled";
+		};
+
+		timer5: timer at 40000c00 {
+			compatible = "st,stm32-timer";
+			reg = <0x40000c00 0x400>;
+			interrupts = <50>;
+			clocks = <&rcc 0 131>;
+		};
+
+		timer6: timer at 40001000 {
+			compatible = "st,stm32-timer";
+			reg = <0x40001000 0x400>;
+			interrupts = <54>;
+			clocks = <&rcc 0 132>;
+			status = "disabled";
+		};
+
+		timer7: timer at 40001400 {
+			compatible = "st,stm32-timer";
+			reg = <0x40001400 0x400>;
+			interrupts = <55>;
+			clocks = <&rcc 0 133>;
+			status = "disabled";
+		};
+
+		usart2: serial at 40004400 {
+			compatible = "st,stm32f7-usart", "st,stm32f7-uart";
+			reg = <0x40004400 0x400>;
+			interrupts = <38>;
+			clocks =  <&rcc 0 145>;
+			status = "disabled";
+		};
+
+		usart3: serial at 40004800 {
+			compatible = "st,stm32f7-usart", "st,stm32f7-uart";
+			reg = <0x40004800 0x400>;
+			interrupts = <39>;
+			clocks = <&rcc 0 146>;
+			status = "disabled";
+		};
+
+		usart4: serial at 40004c00 {
+			compatible = "st,stm32f7-uart";
+			reg = <0x40004c00 0x400>;
+			interrupts = <52>;
+			clocks = <&rcc 0 147>;
+			status = "disabled";
+		};
+
+		usart5: serial at 40005000 {
+			compatible = "st,stm32f7-uart";
+			reg = <0x40005000 0x400>;
+			interrupts = <53>;
+			clocks = <&rcc 0 148>;
+			status = "disabled";
+		};
+
+		usart7: serial at 40007800 {
+			compatible = "st,stm32f7-usart", "st,stm32f7-uart";
+			reg = <0x40007800 0x400>;
+			interrupts = <82>;
+			clocks = <&rcc 0 158>;
+			status = "disabled";
+		};
+
+		usart8: serial at 40007c00 {
+			compatible = "st,stm32f7-usart", "st,stm32f7-uart";
+			reg = <0x40007c00 0x400>;
+			interrupts = <83>;
+			clocks = <&rcc 0 159>;
+			status = "disabled";
+		};
+
+		usart1: serial at 40011000 {
+			compatible = "st,stm32f7-usart", "st,stm32f7-uart";
+			reg = <0x40011000 0x400>;
+			interrupts = <37>;
+			clocks = <&rcc 0 164>;
+			status = "disabled";
+		};
+
+		usart6: serial at 40011400 {
+			compatible = "st,stm32f7-usart", "st,stm32f7-uart";
+			reg = <0x40011400 0x400>;
+			interrupts = <71>;
+			clocks = <&rcc 0 165>;
+			status = "disabled";
+		};
+
+		syscfg: system-config at 40013800 {
+			compatible = "syscon";
+			reg = <0x40013800 0x400>;
+		};
+
+		exti: interrupt-controller at 40013c00 {
+			compatible = "st,stm32-exti";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x40013C00 0x400>;
+			interrupts = <1>, <2>, <3>, <6>, <7>, <8>, <9>, <10>, <23>, <40>, <41>, <42>, <62>, <76>;
+		};
+
+		pin-controller {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "st,stm32f746-pinctrl";
+			ranges = <0 0x40020000 0x3000>;
+			interrupt-parent = <&exti>;
+			st,syscfg = <&syscfg 0x8>;
+			pins-are-numbered;
+
+			gpioa: gpio at 40020000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x0 0x400>;
+				clocks = <&rcc 0 256>;
+				st,bank-name = "GPIOA";
+			};
+
+			gpiob: gpio at 40020400 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x400 0x400>;
+				clocks = <&rcc 0 257>;
+				st,bank-name = "GPIOB";
+			};
+
+			gpioc: gpio at 40020800 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x800 0x400>;
+				clocks = <&rcc 0 258>;
+				st,bank-name = "GPIOC";
+			};
+
+			gpiod: gpio at 40020c00 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0xc00 0x400>;
+				clocks = <&rcc 0 259>;
+				st,bank-name = "GPIOD";
+			};
+
+			gpioe: gpio at 40021000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1000 0x400>;
+				clocks = <&rcc 0 260>;
+				st,bank-name = "GPIOE";
+			};
+
+			gpiof: gpio at 40021400 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1400 0x400>;
+				clocks = <&rcc 0 261>;
+				st,bank-name = "GPIOF";
+			};
+
+			gpiog: gpio at 40021800 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1800 0x400>;
+				clocks = <&rcc 0 262>;
+				st,bank-name = "GPIOG";
+			};
+
+			gpioh: gpio at 40021c00 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1c00 0x400>;
+				clocks = <&rcc 0 263>;
+				st,bank-name = "GPIOH";
+			};
+
+			gpioi: gpio at 40022000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x2000 0x400>;
+				clocks = <&rcc 0 264>;
+				st,bank-name = "GPIOI";
+			};
+
+			gpioj: gpio at 40022400 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x2400 0x400>;
+				clocks = <&rcc 0 265>;
+				st,bank-name = "GPIOJ";
+			};
+
+			gpiok: gpio at 40022800 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x2800 0x400>;
+				clocks = <&rcc 0 266>;
+				st,bank-name = "GPIOK";
+			};
+
+			usart1_pins_a: usart1 at 0 {
+				pins1 {
+					pinmux = <STM32F746_PA9_FUNC_USART1_TX>;
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+				pins2 {
+					pinmux = <STM32F746_PA10_FUNC_USART1_RX>;
+					bias-disable;
+				};
+			};
+		};
+
+		rcc: rcc at 40023800 {
+			#clock-cells = <2>;
+			compatible = "st,stm32f42xx-rcc", "st,stm32-rcc";
+			reg = <0x40023800 0x400>;
+			clocks = <&clk_hse>;
+		};
+	};
+};
+
+&systick {
+	clocks = <&rcc 1 0>;
+	status = "okay";
+};
-- 
1.9.1
