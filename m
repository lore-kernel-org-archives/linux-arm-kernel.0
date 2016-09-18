From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sun, 18 Sep 2016 09:21:52 +0800
Subject: [PATCH v2 3/4] arm64: dts: add Allwinner A64 SoC .dtsi
In-Reply-To: <20160917145121.GE17518@lukather>
References: <20160909201029.24530-1-maxime.ripard@free-electrons.com>
 <20160909201029.24530-4-maxime.ripard@free-electrons.com>
 <fad78d40-b595-633c-6d43-6246ec893635@arm.com>
 <20160917145121.GE17518@lukather>
Message-ID: <1006111474161712@web13g.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



17.09.2016, 22:56, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> On Thu, Sep 15, 2016 at 01:08:45AM +0100, Andr? Przywara wrote:
>> ?> --- a/MAINTAINERS
>> ?> +++ b/MAINTAINERS
>> ?> @@ -982,6 +982,7 @@ M: Chen-Yu Tsai <wens@csie.org>
>> ?> L: linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>> ?> S: Maintained
>> ?> N: sun[x456789]i
>> ?> +F: arch/arm64/boot/dts/allwinner/
>>
>> ?If you promise to not break it needlessly ;-)
>
> We started doing so since 4.7, and we're already fighting needlessly
> with maintainers because of that.
>
>> ?> + cpus {
>> ?> + #address-cells = <1>;
>> ?> + #size-cells = <0>;
>> ?> +
>> ?> + cpu at 0 {
>>
>> ?This is probably me to blame here since I put you up to it, but you need
>> ?"cpux" names (e.g. "cpu0: cpu at 0 {") to match the ones that the PMU node
>> ?references below. dtc will refuse to compile it otherwise.
>
> Gaah, yes, of course.
>
>> ?> + i2c1_pins: i2c1_pins {
>> ?> + allwinner,pins = "PH2", "PH3";
>> ?> + allwinner,function = "i2c1";
>> ?> + allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> ?> + allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> ?> + };
>> ?> +
>> ?> + uart0_pins_a: uart0 at 0 {
>> ?> + allwinner,pins = "PB8", "PB9";
>> ?> + allwinner,function = "uart0";
>> ?> + allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> ?> + allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> ?> + };
>>
>> ?So did I get this right that there is a strict "no user - no pins"
>> ?policy here?
>> ?I don't see a reason why we shouldn't have at least the other UART pins
>> ?described here as well - since they are a pure SoC property. That would
>> ?make it easier for people to enable them (with a simple, scripted fdt
>> ?one-liner command in U-Boot, for instance).
>
> To avoid having huge DT that are longer to load and parse, especially
> since every one wires it in the exact same way all the time. And the
> combination is just too high.
>
> On the A64, the UART0 can be exposed through PB9 and PF4 for TX, and
> PB8 and PF2 for RX. Even though the common usage would be to use PB8
> and PB9, or PF4 and PF6. But absolutely nothing prevents from using
> PB8 and PF4.
>
> You can then add CTS and RTS into the mix, and multiply that by the
> number of devices in the SoC.
>
>> ?I guess there will never be an official DT with more than 2 UARTs
>> ?enabled, although we have actually five UARTs on the headers on the
>> ?Pine64, for instance (and personally I am looking into using one as a
>> ?terminal server).
>
> We relaxed the rule lately however. Boards that have access to those
> UARTs on their headers can put a node in their DT with the right
> muxing filled already. Which brings you the simple, script fdt
> one-liner in U-Boot.
>
>> ?Also UART1 is connected to that WiFi/Bluetooth slot, having it enabled
>> ?should make BT work without further ado (but I haven't tested this).
>
> That's probably not true. You'll most likely need to enable a few
> regulators to have it working.

It seems that Andre has enabled the necessary regulator in the
newest version of his ARM Trusted Firmware...

>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
> ,
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
