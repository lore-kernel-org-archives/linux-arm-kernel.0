From: tanzilli@acmesystems.it (Sergio Tanzilli)
Date: Mon, 1 Jun 2015 18:26:42 +0200
Subject: [PATCH 16/16] ARM: at91/dt: Add Acme Arietta G25
In-Reply-To: <556C85E6.9060107@atmel.com>
References: <1432921649-21943-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1432921649-21943-17-git-send-email-alexandre.belloni@free-electrons.com>
 <556C85E6.9060107@atmel.com>
Message-ID: <CAG+hDbsbSJzRzzW52Kfy8TMaGS1vFcHv-P6SSkcXzD=DR34=dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas

at91-ariettag25.dtb is ok for me. I'll change the name on DT generator.


at91-ariettag25.dtb is better than at91-arietta.dtb because probably
we'll exit with different Atmel cpu on arietta very soon

thanks

Sergio


On 1 June 2015 at 18:18, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> Le 29/05/2015 19:47, Alexandre Belloni a ?crit :
>> Add a minimum Device Tree for Acme Arietta G25.
>> http://acme.systems/arietta
>>
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> Cc: Sergio Tanzilli <tanzilli@acmesystems.it>
>> ---
>>  arch/arm/boot/dts/Makefile              |  1 +
>>  arch/arm/boot/dts/at91-acme-arietta.dts | 75 +++++++++++++++++++++++++++++++++
>>  2 files changed, 76 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/at91-acme-arietta.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 8c3da289a00b..96a169e6ea56 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -31,6 +31,7 @@ dtb-$(CONFIG_SOC_SAM_V4_V5) += \
>>       at91sam9n12ek.dtb \
>>       at91sam9rlek.dtb \
>>       at91-ariag25.dtb \
>> +     at91-acme-arietta.dtb \
>
> Do you want to have the additional vendor name here? We already have 2
> boards by ACME and they don't have this type of name:
> at91-foxg20.dtb
> at91-ariag25.dtb
>
> So I'd prefer to use "at91-arietta.dtb" or "at91-ariettag25.dtb" or any
> kind or variant from these ones... I know it may come from the ACME DT
> generator tool, but it could be strange at first sight.
>
> Sergio, do you have an opinion? In relation with eventual future
> products, which is your preferred name?
>
>
>>       at91-cosino_mega2560.dtb \
>>       at91-kizboxmini.dtb \
>>       at91sam9g15ek.dtb \
>> diff --git a/arch/arm/boot/dts/at91-acme-arietta.dts b/arch/arm/boot/dts/at91-acme-arietta.dts
>> new file mode 100644
>> index 000000000000..142d588ad6bf
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/at91-acme-arietta.dts
>> @@ -0,0 +1,75 @@
>> +/*
>> + * Device Tree file for Arietta G25
>> + * This device tree is minimal, to activate more peripherals, see:
>> + * http://dts.acmesystems.it/arietta/
>
> Yes, absolutely: link to the DT generator is a big plus here.
>
>
>> + */
>> +/dts-v1/;
>> +#include "at91sam9g25.dtsi"
>> +/ {
>> +     model = "Acme Systems Arietta G25";
>> +     compatible = "acme,ariettag25", "atmel,at91sam9x5", "atmel,at91sam9";
>> +
>
> Don't we need to add a "alias" group here, to be sure that the
> "stdout-path" is always good whatever appends to the underlying
> at91sam9g25.dtsi (nitpicking, I know ;-)) ?
>
>> +     chosen {
>> +             stdout-path = "serial0:115200n8";
>> +     };
>> +
>> +     memory {
>> +             reg = <0x20000000 0x8000000>;
>> +     };
>> +
>> +     clocks {
>> +             slow_xtal {
>> +                     clock-frequency = <32768>;
>> +             };
>> +
>> +             main_xtal {
>> +                     clock-frequency = <12000000>;
>> +             };
>> +     };
>> +
>> +     ahb {
>> +             apb {
>> +                     mmc0: mmc at f0008000 {
>> +                             pinctrl-0 = <
>> +                               &pinctrl_mmc0_slot0_clk_cmd_dat0
>> +                               &pinctrl_mmc0_slot0_dat1_3>;
>> +                             status = "okay";
>> +
>> +                             slot at 0 {
>> +                                     reg = <0>;
>> +                                     bus-width = <4>;
>> +                             };
>> +                     };
>> +
>> +                     usb2: gadget at f803c000 {
>> +                             status = "okay";
>> +                     };
>> +
>> +                     dbgu: serial at fffff200 {
>> +                             status = "okay";
>> +                     };
>> +
>> +                     rtc at fffffeb0 {
>> +                             status = "okay";
>> +                     };
>> +             };
>> +
>> +             usb0: ohci at 00600000 {
>> +                     status = "okay";
>> +                     num-ports = <3>;
>> +             };
>> +
>> +             usb1: ehci at 00700000 {
>> +                     status = "okay";
>> +             };
>> +     };
>> +
>> +     leds {
>> +             compatible = "gpio-leds";
>> +             arietta_led {
>> +                     label = "arietta_led";
>> +                     gpios = <&pioB 8 GPIO_ACTIVE_HIGH>; /* PB8 */
>> +                     linux,default-trigger = "heartbeat";
>> +             };
>> +     };
>> +};
>>
>
>
> --
> Nicolas Ferre



-- 
Sergio Tanzilli
tanzilli at acmesystems.it
Acme Systems srl
http://www.acmesystems.it
