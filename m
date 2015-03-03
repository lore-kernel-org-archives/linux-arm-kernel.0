From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue, 3 Mar 2015 18:59:10 +0100
Subject: [PATCH v2 16/18] ARM: dts: Introduce STM32F429 MCU
In-Reply-To: <54F4A0F7.80606@suse.de>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1424455277-29983-17-git-send-email-mcoquelin.stm32@gmail.com>
 <54F4A0F7.80606@suse.de>
Message-ID: <CALszF6Bn7z+COs84BV622BXnpRSruLn-9y+vo51mQxrHkDdQyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

Thanks for this detailed review.

2015-03-02 18:42 GMT+01:00 Andreas F?rber <afaerber@suse.de>:
> Hi Maxime,
>
> Please don't put the whole world in To, that makes replying to you much
> harder. You can put maintainers in CC instead.
Ok.
>
> Am 20.02.2015 um 19:01 schrieb Maxime Coquelin:
>> The STMicrolectornics's STM32F419 MCU has the following main features:
>>  - Cortex-M4 core running up to @180MHz
>>  - 2MB internal flash, 256KBytes internal RAM
>>  - FMC controller to connect SDRAM, NOR and NAND memories
>>  - SD/MMC/SDIO support
>>  - Ethernet controller
>>  - USB OTFG FS & HS controllers
>>  - I2C, SPI, CAN busses support
>>  - Several 16 & 32 bits general purpose timers
>>  - Serial Audio interface
>>  - LCD controller
>>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> ---
>>  arch/arm/boot/dts/Makefile            |   1 +
>>  arch/arm/boot/dts/stm32f429-disco.dts |  41 ++++
>>  arch/arm/boot/dts/stm32f429.dtsi      | 396 ++++++++++++++++++++++++++++++++++
>>  3 files changed, 438 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/stm32f429-disco.dts
>>  create mode 100644 arch/arm/boot/dts/stm32f429.dtsi
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 91bd5bd..d7da0ef 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -442,6 +442,7 @@ dtb-$(CONFIG_ARCH_STI)+= stih407-b2120.dtb \
>>       stih416-b2000.dtb \
>>       stih416-b2020.dtb \
>>       stih416-b2020e.dtb
>> +dtb-$(CONFIG_ARCH_STM32)+= stm32f429-disco.dtb
>>  dtb-$(CONFIG_MACH_SUN4I) += \
>>       sun4i-a10-a1000.dtb \
>>       sun4i-a10-ba10-tvbox.dtb \
>> diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
>> new file mode 100644
>> index 0000000..0e79cc1
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/stm32f429-disco.dts
>> @@ -0,0 +1,41 @@
>
> Add a suitable license header here? There had been attempts to
> dual-license as GPL and MIT/X11.

I agree to add the dual GPL and MIT/X11 licence.

>
>> +/dts-v1/;
>> +#include "stm32f429.dtsi"
>> +
>> +/ {
>> +     model = "STMicroelectronics's STM32F429i-DISCO board";
>
> "'s" seems uncommon here and "s's" looks wrong. Just use
> "STMicroelectronics STM32F429I-DISCO board"?

Ok, it will be fixed in v3.

>
>> +     compatible = "st,stm32f429i-disco", "st,stm32f429";
>> +
>> +     chosen {
>> +             bootargs = "console=ttyS0,115200 root=/dev/ram rdinit=/linuxrc";
>> +             linux,stdout-path = &usart1;
>
> I have actually been using USART3, following a guide I found on GitHub.
> Which pins do you use for USART1, and is one better than the other?

I used U-boot from Emcraft, which uses USART1, that is the only reason
I used this one.
Regarding USART3, I had a look at your boot-wrapper, and you configure
the USART3 to PC10/PC11 pins.

>From the schematics, I see the PC10 pin is connected to the LCD.


>
>> +     };
>> +
>> +     memory {
>> +             reg = <0xd0000000 0x800000>;
>
> I have it at 0x90000000!

Ok. But you use a specific setting:
https://github.com/afaerber/afboot-stm32/blob/master/foo.c#L338

By default this is the PC Card bank (Bank 4) at 0x90000000.

Maybe you could change your boot-wrapper to use also the default setting?

>
>> +     };
>> +
>> +     aliases {
>> +             ttyS0 = &usart1;
>
> Why ttyS0 here? Shouldn't that be serial0 by convention?

I was not aware of this. Do you know whether it is documented somewhere?
Anyway, I will change to serial0 in next version.

>
>> +     };
>> +
>> +     soc {
>> +             usart1: usart at 40011000 {
>> +                     status = "okay";
>> +             };
>
> This is a new target, so please use the new-style &usart1 {...};
> reference rather than replicating the hierarchy.
Ok.

>
>> +
>> +             leds {
>
> These LEDs are definitely not on the SoC, they're on the board. Please
> move one level up.

Ok.

>
>> +                     compatible = "gpio-leds";
>
> In this file you're being parsimonious with newline, yet in the .dtsi
> you unnecessarily add newlines before the trailing status property.
>
>> +                     red {
>> +                             #gpio-cells = <2>;
>
> This looks weird. Drop it?

Yes.

>
>> +                             label = "Front Panel LED";
>
> "Front Panel"? Both LEDs are on the front, and several other
> architectures avoid spaces in the label for accessing it from /sys.

That's an unfortunate copy/paste. For sure it has no meaning here.

>
>> +                             gpios = <&gpiog 14 0>;
>
> GPIO_ACTIVE_HIGH
Ok.

>
>> +                             linux,default-trigger = "heartbeat";
>
> Suggest to leave both off by default.
Ok.

>
>> +                     };
>> +                     green {
>> +                             #gpio-cells = <2>;
>
> Ditto.
>
>> +                             gpios = <&gpiog 13 0>;
>
> Ditto.
>
>> +                             default-state = "off";
>> +                     };
>> +             };
>> +     };
>> +};
>> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
>> new file mode 100644
>> index 0000000..5b3442a
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/stm32f429.dtsi
>> @@ -0,0 +1,396 @@
>> +/*
>> + * Device tree for STM32F429
>
> License?

Yes. I will do the same as for the board file.

>
>> + */
>> +#include "armv7-m.dtsi"
>> +#include <dt-bindings/pinctrl/pinctrl-stm32.h>
>> +#include <dt-bindings/reset/st,stm32f429.h>
>> +
>> +/ {
>> +
>> +     aliases {
>> +             gpio0 = &gpioa;
>> +             gpio1 = &gpiob;
>> +             gpio2 = &gpioc;
>> +             gpio3 = &gpiod;
>> +             gpio4 = &gpioe;
>> +             gpio5 = &gpiof;
>> +             gpio6 = &gpiog;
>> +             gpio7 = &gpioh;
>> +             gpio8 = &gpioi;
>> +             gpio9 = &gpioj;
>> +             gpio10 = &gpiok;
>> +     };
>> +
>> +     clocks {
>> +             clk_sysclk: clk-sysclk {
>> +                     #clock-cells = <0>;
>> +                     compatible = "fixed-clock";
>> +                     clock-frequency = <180000000>;
>> +             };
>> +
>> +             clk_hclk: clk-hclk {
>> +                     #clock-cells = <0>;
>> +                     compatible = "fixed-clock";
>> +                     clock-frequency = <180000000>;
>> +             };
>> +
>> +             clk_pclk1: clk-pclk1 {
>> +                     #clock-cells = <0>;
>> +                     compatible = "fixed-clock";
>> +                     clock-frequency = <45000000>;
>> +             };
>> +
>> +             clk_pclk2: clk-pclk2 {
>> +                     #clock-cells = <0>;
>> +                     compatible = "fixed-clock";
>> +                     clock-frequency = <90000000>;
>> +             };
>> +
>> +             clk_pmtr1: clk-pmtr1 {
>> +                     #clock-cells = <0>;
>> +                     compatible = "fixed-clock";
>> +                     clock-frequency = <90000000>;
>> +             };
>> +
>> +             clk_pmtr2: clk-pmtr2 {
>> +                     #clock-cells = <0>;
>> +                     compatible = "fixed-clock";
>> +                     clock-frequency = <180000000>;
>> +             };
>> +
>> +             clk_systick: clk-systick {
>> +                     compatible = "fixed-factor-clock";
>> +                     clocks = <&clk_hclk>;
>> +                     #clock-cells = <0>;
>> +                     clock-div = <8>;
>> +                     clock-mult = <1>;
>> +             };
>
> Most of these should be replaceable with my clk driver.
>

I agree, but adding more drivers is likely to delay the STM32 machine
to be merged.
Once this first round accepted, it will be easier for others to contribute.
It will help to have sooner a good support of the machine.

Does that look reasonable for you?

>> +     };
>> +
>> +     systick: timer at e000e010 {
>> +             clocks = <&clk_systick>;
>> +
>> +             status = "okay";
>> +     };
>
> &systick {...};
Ok.

>
>> +
>> +     soc {
>> +             reset: reset at 40023810 {
>> +                     #reset-cells = <1>;
>> +                     compatible = "st,stm32-reset";
>> +                     reg = <0x40023810 0x18>;
>> +             };
>
> Still, this feels wrong, given that it's an RCC IP block...
Ok, this was already pointed out by Philipp.
I will rework the driver so that the node covers the full RCC IP.


>
>> +
>> +             pin-controller {
>> +                     #address-cells = <1>;
>> +                     #size-cells = <1>;
>> +                     compatible = "st,stm32-pinctrl";
>> +                     ranges = <0 0x40020000 0x3000>;
>> +
>> +                     gpioa: gpio at 40020000 {
>> +                             gpio-controller;
>> +                             #gpio-cells = <2>;
>> +                             reg = <0x0 0x400>;
>> +                             resets = <&reset GPIOA_RESET>;
>> +                             st,bank-name = "GPIOA";
>> +                     };
>> +
>> +                     gpiob: gpio at 40020400 {
>> +                             gpio-controller;
>> +                             #gpio-cells = <2>;
>> +                             reg = <0x400 0x400>;
>> +                             resets = <&reset GPIOB_RESET>;
>> +                             st,bank-name = "GPIOB";
>> +                     };
>> +
>> +                     gpioc: gpio at 40020800 {
>> +                             gpio-controller;
>> +                             #gpio-cells = <2>;
>> +                             reg = <0x800 0x400>;
>> +                             resets = <&reset GPIOC_RESET>;
>> +                             st,bank-name = "GPIOC";
>> +                     };
>> +
>> +                     gpiod: gpio at 40020c00 {
>> +                             gpio-controller;
>> +                             #gpio-cells = <2>;
>> +                             reg = <0xc00 0x400>;
>> +                             resets = <&reset GPIOD_RESET>;
>> +                             st,bank-name = "GPIOD";
>> +                     };
>> +
>> +                     gpioe: gpio at 40021000 {
>> +                             gpio-controller;
>> +                             #gpio-cells = <2>;
>> +                             reg = <0x1000 0x400>;
>> +                             resets = <&reset GPIOE_RESET>;
>> +                             st,bank-name = "GPIOE";
>> +                     };
>> +
>> +                     gpiof: gpio at 40021400 {
>> +                             gpio-controller;
>> +                             #gpio-cells = <2>;
>> +                             reg = <0x1400 0x400>;
>> +                             resets = <&reset GPIOF_RESET>;
>> +                             st,bank-name = "GPIOF";
>> +                     };
>> +
>> +                     gpiog: gpio at 40021800 {
>> +                             gpio-controller;
>> +                             #gpio-cells = <2>;
>> +                             reg = <0x1800 0x400>;
>> +                             resets = <&reset GPIOG_RESET>;
>> +                             st,bank-name = "GPIOG";
>> +                     };
>> +
>> +                     gpioh: gpio at 40021c00 {
>> +                             gpio-controller;
>> +                             #gpio-cells = <2>;
>> +                             reg = <0x1c00 0x400>;
>> +                             resets = <&reset GPIOH_RESET>;
>> +                             st,bank-name = "GPIOH";
>> +                     };
>> +
>> +                     gpioi: gpio at 40022000 {
>> +                             gpio-controller;
>> +                             #gpio-cells = <2>;
>> +                             reg = <0x2000 0x400>;
>> +                             resets = <&reset GPIOI_RESET>;
>> +                             st,bank-name = "GPIOI";
>> +                     };
>> +
>> +                     gpioj: gpio at 40022400 {
>> +                             gpio-controller;
>> +                             #gpio-cells = <2>;
>> +                             reg = <0x2400 0x400>;
>> +                             resets = <&reset GPIOJ_RESET>;
>> +                             st,bank-name = "GPIOJ";
>> +                     };
>> +
>> +                     gpiok: gpio at 40022800 {
>> +                             gpio-controller;
>> +                             #gpio-cells = <2>;
>> +                             reg = <0x2800 0x400>;
>> +                             resets = <&reset GPIOK_RESET>;
>> +                             st,bank-name = "GPIOK";
>> +                     };
>> +
>> +                     usart1 {
>> +                             pinctrl_usart1: usart1-0 {
>> +                                     st,pins {
>> +                                             tx = <&gpioa 9 ALT7 NO_PULL PUSH_PULL LOW_SPEED>;
>> +                                             rx = <&gpioa 10 ALT7 NO_PULL>;
>> +                                     };
>> +                             };
>> +                     };
>> +
>> +                     usart2 {
>> +                             pinctrl_usart2: usart2-0 {
>> +                                     st,pins {
>> +                                             tx = <&gpioa 2 ALT7 NO_PULL PUSH_PULL LOW_SPEED>;
>> +                                             rx = <&gpioa 3 ALT7 NO_PULL>;
>> +                                     };
>> +                             };
>> +                     };
>> +
>> +                     usart3 {
>> +                             pinctrl_usart3: usart3-0 {
>> +                                     st,pins {
>> +                                             tx = <&gpiob 10 ALT7 NO_PULL PUSH_PULL LOW_SPEED>;
>> +                                             rx = <&gpiob 11 ALT7 NO_PULL>;
>> +                                     };
>> +                             };
>> +                     };
>> +
>> +                     usart4 {
>> +                             pinctrl_usart4: usart4-0 {
>> +                                     st,pins {
>> +                                             tx = <&gpioa 0 ALT8 NO_PULL PUSH_PULL LOW_SPEED>;
>> +                                             rx = <&gpioa 1 ALT8 NO_PULL>;
>> +                                     };
>> +                             };
>> +                     };
>> +
>> +                     usart5 {
>> +                             pinctrl_usart5: usart5-0 {
>> +                                     st,pins {
>> +                                             tx = <&gpioc 12 ALT8 NO_PULL PUSH_PULL LOW_SPEED>;
>> +                                             rx = <&gpiod 2 ALT8 NO_PULL>;
>> +                                     };
>> +                             };
>> +                     };
>> +
>> +                     usart6 {
>> +                             pinctrl_usart6: usart6-0 {
>> +                                     st,pins {
>> +                                             tx = <&gpioc 6 ALT8 NO_PULL PUSH_PULL LOW_SPEED>;
>> +                                             rx = <&gpioc 7 ALT8 NO_PULL>;
>> +                                     };
>> +                             };
>> +                     };
>> +
>> +                     usart7 {
>> +                             pinctrl_usart7: usart7-0 {
>> +                                     st,pins {
>> +                                             tx = <&gpioe 8 ALT8 NO_PULL PUSH_PULL LOW_SPEED>;
>> +                                             rx = <&gpioe 7 ALT8 NO_PULL>;
>> +                                     };
>> +                             };
>> +                     };
>> +
>> +                     usart8 {
>> +                             pinctrl_usart8: usart8-0 {
>> +                                     st,pins {
>> +                                             tx = <&gpioe 1 ALT8 NO_PULL PUSH_PULL LOW_SPEED>;
>> +                                             rx = <&gpioe 0 ALT8 NO_PULL>;
>> +                                     };
>> +                             };
>> +                     };
>
> Can't the outer level be avoided here to save space and indentation?
Yes. I will rework this too.

>
>> +             };
>> +
>> +             timer2: timer at 40000000 {
>> +                     compatible = "st,stm32-timer";
>> +                     reg = <0x40000000 0x400>;
>> +                     interrupts = <28>;
>> +                     resets = <&reset TIM2_RESET>;
>> +                     clocks = <&clk_pmtr1>;
>> +
>> +                     status = "disabled";
>> +             };
>> +
>> +             timer3: timer at 40000400 {
>> +                     compatible = "st,stm32-timer";
>> +                     reg = <0x40000400 0x400>;
>> +                     interrupts = <29>;
>> +                     resets = <&reset TIM3_RESET>;
>> +                     clocks = <&clk_pmtr1>;
>> +
>> +                     status = "disabled";
>> +             };
>> +
>> +             timer4: timer at 40000800 {
>> +                     compatible = "st,stm32-timer";
>> +                     reg = <0x40000800 0x400>;
>> +                     interrupts = <30>;
>> +                     resets = <&reset TIM4_RESET>;
>> +                     clocks = <&clk_pmtr1>;
>> +
>> +                     status = "disabled";
>> +             };
>> +
>> +             timer5: timer at 40000c00 {
>> +                     compatible = "st,stm32-timer";
>> +                     reg = <0x40000c00 0x400>;
>> +                     interrupts = <50>;
>> +                     resets = <&reset TIM5_RESET>;
>> +                     clocks = <&clk_pmtr1>;
>> +             };
>> +
>> +             timer6: timer at 40001000 {
>> +                     compatible = "st,stm32-timer";
>> +                     reg = <0x40001000 0x400>;
>> +                     interrupts = <54>;
>> +                     resets = <&reset TIM6_RESET>;
>> +                     clocks = <&clk_pmtr1>;
>> +
>> +                     status = "disabled";
>> +             };
>> +
>> +             timer7: timer at 40001400 {
>> +                     compatible = "st,stm32-timer";
>> +                     reg = <0x40001400 0x400>;
>> +                     interrupts = <55>;
>> +                     resets = <&reset TIM7_RESET>;
>> +                     clocks = <&clk_pmtr1>;
>> +
>> +                     status = "disabled";
>> +             };
>> +
>> +             usart1: usart at 40011000 {
>> +                     compatible = "st,stm32-usart";
>> +                     reg = <0x40011000 0x400>;
>> +                     interrupts = <37>;
>> +                     clocks = <&clk_pclk2>;
>> +                     pinctrl-names = "default";
>> +                     pinctrl-0 = <&pinctrl_usart1>;
>> +
>> +                     status = "disabled";
>> +             };
>> +
>> +             usart2: usart at 40004400 {
>> +                     compatible = "st,stm32-usart";
>> +                     reg = <0x40004400 0x400>;
>> +                     interrupts = <38>;
>> +                     clocks = <&clk_pclk1>;
>> +                     pinctrl-names = "default";
>> +                     pinctrl-0 = <&pinctrl_usart1>;
>
> Copy&paste, also below. Is this really .dtsi material?

Sorry, I am not sure to understand what you mean.
Could you elaborate please?

>
>> +
>> +                     status = "disabled";
>> +             };
>> +
>> +             usart3: usart at 40004800 {
>> +                     compatible = "st,stm32-usart";
>> +                     reg = <0x40004800 0x400>;
>> +                     interrupts = <39>;
>> +                     clocks = <&clk_pclk1>;
>> +                     pinctrl-names = "default";
>> +                     pinctrl-0 = <&pinctrl_usart1>;
>> +
>> +                     status = "disabled";
>> +             };
>> +
>> +             usart4: usart at 40004c00 {
>> +                     compatible = "st,stm32-usart";
>> +                     reg = <0x40004c00 0x400>;
>> +                     interrupts = <52>;
>> +                     clocks = <&clk_pclk1>;
>> +                     pinctrl-names = "default";
>> +                     pinctrl-0 = <&pinctrl_usart1>;
>> +
>> +                     status = "disabled";
>> +             };
>> +
>> +             usart5: usart at 40005000 {
>> +                     compatible = "st,stm32-usart";
>> +                     reg = <0x40005000 0x400>;
>> +                     interrupts = <53>;
>> +                     clocks = <&clk_pclk1>;
>> +                     pinctrl-names = "default";
>> +                     pinctrl-0 = <&pinctrl_usart1>;
>> +
>> +                     status = "disabled";
>> +             };
>> +
>> +             usart6: usart at 40011400 {
>> +                     compatible = "st,stm32-usart";
>> +                     reg = <0x40011400 0x400>;
>> +                     interrupts = <71>;
>> +                     clocks = <&clk_pclk2>;
>> +                     pinctrl-names = "default";
>> +                     pinctrl-0 = <&pinctrl_usart1>;
>> +
>> +                     status = "disabled";
>> +             };
>> +
>> +             usart7: usart at 40007800 {
>
> Please order all nodes by unit address, not by label.
Ok.

>
>> +                     compatible = "st,stm32-usart";
>> +                     reg = <0x40007800 0x400>;
>> +                     interrupts = <82>;
>> +                     clocks = <&clk_pclk1>;
>> +                     pinctrl-names = "default";
>> +                     pinctrl-0 = <&pinctrl_usart1>;
>> +
>> +                     status = "disabled";
>> +             };
>> +
>> +             usart8: usart at 40007c00 {
>> +                     compatible = "st,stm32-usart";
>> +                     reg = <0x40007c00 0x400>;
>> +                     interrupts = <83>;
>> +                     clocks = <&clk_pclk1>;
>> +                     pinctrl-names = "default";
>> +                     pinctrl-0 = <&pinctrl_usart1>;
>> +
>> +                     status = "disabled";
>> +             };
>
> I remember two of them not being USART but UART? Similarly, two of them
> support flow control (or two don't?), for which we would either need a
> property or two different compatible strings.

I have to check what would best fit to handle these differences.
I will come back to you later on this point.

Thanks!
Maxime

>
>> +     };
>> +};
>
> Regards,
> Andreas
>
> --
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
> GF: Felix Imend?rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu,
> Graham Norton; HRB 21284 (AG N?rnberg)
>
