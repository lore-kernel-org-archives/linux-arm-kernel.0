From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 24 Jan 2017 13:43:19 +1100
Subject: linux-next: manual merge of the mfd tree with the arm-soc tree
Message-ID: <20170124134319.2a6ba85d@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the mfd tree got a conflict in:

  arch/arm/boot/dts/stm32f429.dtsi

between commits:

  3604ef9c8154 ("ARM: dts: stm32: Add ADC support to stm32f429")
  dd3feb755a4a ("ARM: dts: stm32: Add RTC support for STM32F429 MCU")

from the arm-soc tree and commit:

  9072b6b2ba83 ("ARM: dts: stm32: add Timers driver for stm32f429 MCU")

from the mfd tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/arm/boot/dts/stm32f429.dtsi
index f05a9d95ef23,b6089351c0d3..000000000000
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@@ -125,20 -218,73 +225,87 @@@
  			status = "disabled";
  		};
  
+ 		timers7: timers at 40001400 {
+ 			#address-cells = <1>;
+ 			#size-cells = <0>;
+ 			compatible = "st,stm32-timers";
+ 			reg = <0x40001400 0x400>;
+ 			clocks = <&rcc 0 133>;
+ 			clock-names = "int";
+ 			status = "disabled";
+ 
+ 			timer at 6 {
+ 				compatible = "st,stm32-timer-trigger";
+ 				reg = <6>;
+ 				status = "disabled";
+ 			};
+ 		};
+ 
+ 			timers12: timers at 40001800 {
+ 			#address-cells = <1>;
+ 			#size-cells = <0>;
+ 			compatible = "st,stm32-timers";
+ 			reg = <0x40001800 0x400>;
+ 			clocks = <&rcc 0 134>;
+ 			clock-names = "int";
+ 			status = "disabled";
+ 
+ 			pwm {
+ 				compatible = "st,stm32-pwm";
+ 				status = "disabled";
+ 			};
+ 
+ 			timer at 11 {
+ 				compatible = "st,stm32-timer-trigger";
+ 				reg = <11>;
+ 				status = "disabled";
+ 			};
+ 		};
+ 
+ 		timers13: timers at 40001c00 {
+ 			#address-cells = <1>;
+ 			#size-cells = <0>;
+ 			compatible = "st,stm32-timers";
+ 			reg = <0x40001C00 0x400>;
+ 			clocks = <&rcc 0 135>;
+ 			clock-names = "int";
+ 			status = "disabled";
+ 
+ 			pwm {
+ 				compatible = "st,stm32-pwm";
+ 				status = "disabled";
+ 			};
+ 		};
+ 
+ 		timers14: timers at 40002000 {
+ 			#address-cells = <1>;
+ 			#size-cells = <0>;
+ 			compatible = "st,stm32-timers";
+ 			reg = <0x40002000 0x400>;
+ 			clocks = <&rcc 0 136>;
+ 			clock-names = "int";
+ 			status = "disabled";
+ 
+ 			pwm {
+ 				compatible = "st,stm32-pwm";
+ 				status = "disabled";
+ 			};
+ 		};
+ 
 +		rtc: rtc at 40002800 {
 +			compatible = "st,stm32-rtc";
 +			reg = <0x40002800 0x400>;
 +			clocks = <&rcc 1 CLK_RTC>;
 +			clock-names = "ck_rtc";
 +			assigned-clocks = <&rcc 1 CLK_RTC>;
 +			assigned-clock-parents = <&rcc 1 CLK_LSE>;
 +			interrupt-parent = <&exti>;
 +			interrupts = <17 1>;
 +			interrupt-names = "alarm";
 +			st,syscfg = <&pwrcfg>;
 +			status = "disabled";
 +		};
 +
  		usart2: serial at 40004400 {
  			compatible = "st,stm32-usart", "st,stm32-uart";
  			reg = <0x40004400 0x400>;
@@@ -433,11 -616,20 +693,26 @@@
  				};
  			};
  
 +			adc3_in8_pin: adc at 200 {
 +				pins {
 +					pinmux = <STM32F429_PF10_FUNC_ANALOG>;
 +				};
 +			};
++
+ 			pwm1_pins: pwm at 1 {
+ 				pins {
+ 					pinmux = <STM32F429_PA8_FUNC_TIM1_CH1>,
+ 						 <STM32F429_PB13_FUNC_TIM1_CH1N>,
+ 						 <STM32F429_PB12_FUNC_TIM1_BKIN>;
+ 				};
+ 			};
+ 
+ 			pwm3_pins: pwm at 3 {
+ 				pins {
+ 					pinmux = <STM32F429_PB4_FUNC_TIM3_CH1>,
+ 						 <STM32F429_PB5_FUNC_TIM3_CH2>;
+ 				};
+ 			};
  		};
  
  		rcc: rcc at 40023810 {
