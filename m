From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Mon, 30 Nov 2015 02:09:14 +0800
Subject: [PATCH v2 2/3] ARM: dts: sun8i: Add Allwinner A83T dtsi
In-Reply-To: <20151025202012.GT10947@lukather>
References: <1445557577-27383-1-git-send-email-vishnupatekar0510@gmail.com>
 <1445557577-27383-3-git-send-email-vishnupatekar0510@gmail.com>
 <20151025202012.GT10947@lukather>
Message-ID: <CAEzqOZsiwbaKwH4J5CjaHoX6rdgj6kq3opvBUXiGJRfum_Se8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Maxime,
Sorry for delayed response.

On Mon, Oct 26, 2015 at 4:20 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Fri, Oct 23, 2015 at 07:46:16AM +0800, Vishnu Patekar wrote:
>> +     memory {
>> +             reg = <0x40000000 0x80000000>;
>> +     };
>> +
>> +     timer {
>> +             compatible = "arm,armv7-timer";
>> +             interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +                          <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +                          <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +                          <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>
> Shouldn't the number of CPUs be 8?
Yes, It should be 8, also need to change in gic node to 8 CPUs.
No, smp support till now, still I'll change it in next patch version.
>
>> +             clock-frequency = <24000000>;
>> +             arm,cpu-registers-not-fw-configured;
>> +     };
>
> Is there some u-boot support for this SoC yet?
recently, I've posted the v2 of u-boot patch.
>
> If so, both the memory node and the clock-frequency and
> arm,cpu-registers-not-fw-configured properties are useless (and
> harmful for the latter).
Correct, As, timer support is added in u-boot, I'll remove these two.
>
>> +     soc at 01c00000 {
>
> Please remove the address. It's both wrong and useless.
>
>> +             compatible = "simple-bus";
>> +             #address-cells = <1>;
>> +             #size-cells = <1>;
>> +             ranges;
>> +
>> +             gic: interrupt-controller at 01c81000 {
>> +                     compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
>> +                     reg = <0x01c81000 0x1000>,
>> +                           <0x01c82000 0x1000>,
>> +                           <0x01c84000 0x2000>,
>> +                           <0x01c86000 0x2000>;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <3>;
>> +                     interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>> +             };
>> +
>> +             pio: pinctrl at 01c20800 {
>> +                     compatible = "allwinner,sun8i-a83t-pinctrl";
>> +                     interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
>
> Please align these lines with the first one, like you did for the
> GIC's reg for example.
Okie.
>
>> +                     reg = <0x01c20800 0x400>;
>> +                     clocks = <&osc24M>;
>> +                     gpio-controller;
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <3>;
>> +                     #gpio-cells = <3>;
>> +
>> +                     i2c0_pins_a: i2c0 at 0 {
>> +                             allwinner,pins = "PH0", "PH1";
>> +                             allwinner,function = "i2c0";
>> +                             allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> +                             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> +                     };
>> +
>> +                     i2c1_pins_a: i2c1 at 0 {
>> +                             allwinner,pins = "PH2", "PH3";
>> +                             allwinner,function = "i2c1";
>> +                             allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> +                             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> +                     };
>> +
>> +                     i2c2_pins_a: i2c2 at 0 {
>> +                             allwinner,pins = "PH4", "PH5";
>> +                             allwinner,function = "i2c2";
>> +                             allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> +                             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> +                     };
>> +
>> +                     mmc0_pins_a: mmc0 at 0 {
>> +                             allwinner,pins = "PF0", "PF1", "PF2",
>> +                                              "PF3", "PF4", "PF5";
>> +                             allwinner,function = "mmc0";
>> +                             allwinner,drive = <SUN4I_PINCTRL_30_MA>;
>> +                             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> +                     };
>> +
>> +                     mmc1_pins_a: mmc1 at 0 {
>> +                             allwinner,pins = "PG0", "PG1", "PG2",
>> +                                              "PG3", "PG4", "PG5";
>> +                             allwinner,function = "mmc1";
>> +                             allwinner,drive = <SUN4I_PINCTRL_30_MA>;
>> +                             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> +                     };
>> +
>> +                     mmc2_8bit_pins: mmc2_8bit {
>> +                             allwinner,pins = "PC5", "PC6", "PC8",
>> +                                              "PC9", "PC10", "PC11",
>> +                                              "PC12", "PC13", "PC14",
>> +                                              "PC15";
>> +                             allwinner,function = "mmc2";
>> +                             allwinner,drive = <SUN4I_PINCTRL_30_MA>;
>> +                             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> +                     };
>> +
>> +                     uart0_pins_a: uart0 at 0 {
>> +                             allwinner,pins = "PF2", "PF4";
>> +                             allwinner,function = "uart0";
>> +                             allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> +                             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> +                     };
>> +
>> +                     uart0_pins_b: uart0 at 1 {
>> +                             allwinner,pins = "PB9", "PB10";
>> +                             allwinner,function = "uart0";
>> +                             allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> +                             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> +                     };
>
> Are you going to use all these options?
Not, only uart0_pins_a and uart0_pins_b and mmc0_pins_a will be used for now.
As, these are not enabled, I don't see any harm in keeping those here.

Let me know in case you want to remove, I'll do it.

>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
