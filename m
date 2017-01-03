From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 3 Jan 2017 21:28:54 +0800
Subject: [PATCH 3/5] arm64: dts: sun50i: add MMC nodes
In-Reply-To: <d4c2233c-95aa-4d72-1501-9ecb62f6cd82@arm.com>
References: <1483398226-29321-1-git-send-email-andre.przywara@arm.com>
 <1483398226-29321-4-git-send-email-andre.przywara@arm.com>
 <CAGb2v65GJFTnQZtWHCS7CAtA+Dry94o77aakPLr938BpQksLog@mail.gmail.com>
 <d4c2233c-95aa-4d72-1501-9ecb62f6cd82@arm.com>
Message-ID: <CAGb2v65GAvyDn1oMXy2cpOD5PFRoYYOk-VbsMPAX3SNFz2ukLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 3, 2017 at 6:48 PM, Andr? Przywara <andre.przywara@arm.com> wrote:
> On 03/01/17 02:52, Chen-Yu Tsai wrote:
>
> Hi,
>
>> On Tue, Jan 3, 2017 at 7:03 AM, Andre Przywara <andre.przywara@arm.com> wrote:
>>
>> A commit message explaining the mmc controllers would be nice.
>
> OK.
>
>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>> ---
>>>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 67 +++++++++++++++++++++++++++
>>>  1 file changed, 67 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>> index e0dcab8..c680566 100644
>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>> @@ -150,6 +150,32 @@
>>>                                 pins = "PB8", "PB9";
>>>                                 function = "uart0";
>>>                         };
>>> +
>>> +                       mmc0_pins: mmc0 at 0 {
>>> +                               pins = "PF0", "PF1", "PF2", "PF3", "PF4", "PF5";
>>> +                               function = "mmc0";
>>> +                               drive-strength = <30>;
>>> +                       };
>>> +
>>> +                       mmc0_default_cd_pin: mmc0_cd_pin at 0 {
>>> +                               pins = "PF6";
>>> +                               function = "gpio_in";
>>> +                               bias-pull-up;
>>> +                       };
>>
>> We are starting to drop pinmux nodes for gpio usage.
>
> And replacing them with what?
> Or do you mean they go in the individual board .dts files?
> In this case I believe having a default pin defined here would help to
> define it in every .dts.

Nope. I meant dropping them. Pinmux and gpio are orthogonal. One should not
need to specify a gpio pinmux to use it as a gpio. We added them because in
the past nothing was preventing someone from claiming an already muxed pin
as a gpio. On some platforms this is fine. For sunxi, this breaks the system,
as the gpio functions are muxed in.

The idea moving forward is that these cases should be guarded in the driver.
Of course we would have to deal with existing dtbs, but lets not add any more.

>>> +
>>> +                       mmc1_pins: mmc1 at 0 {
>>> +                               pins = "PG0", "PG1", "PG2", "PG3", "PG4", "PG5";
>>> +                               function = "mmc1";
>>> +                               drive-strength = <30>;
>>> +                       };
>>> +
>>> +                       mmc2_pins: mmc2 at 0 {
>>> +                               pins = "PC1", "PC5", "PC6", "PC8", "PC9",
>>> +                                      "PC10", "PC11", "PC12", "PC13", "PC14",
>>> +                                      "PC15", "PC16";
>>> +                               function = "mmc2";
>>> +                               drive-strength = <30>;
>>> +                       };
>>
>> Moreover I think you should split out the pinmux nodes to a separate patch.
>
> I can surely do, just wondering what's the rationale is behind that?

More or less the "do one thing in one patch" rationale. Of course you can
claim these are the defaults used in the reference design and pretty much
every board out there. Then it makes sense to do them together. :)

>
>>
>>>                 };
>>>
>>>                 uart0: serial at 1c28000 {
>>> @@ -240,6 +266,47 @@
>>>                         #size-cells = <0>;
>>>                 };
>>>
>>> +               mmc0: mmc at 1c0f000 {
>>> +                       compatible = "allwinner,sun50i-a64-mmc",
>>> +                                    "allwinner,sun5i-a13-mmc";
>>
>> Given that sun5i doesn't support mmc delay timings, and the A64 has
>> calibration and delay timings, I wouldn't call them compatible.
>>
>> Or are you claiming that for the A64 has a delay of 0 for the
>> currently supported speeds, so the calibration doesn't really
>> matter? If so this should be mentioned in the commit message.
>
> Yes, that's my observation: Driving it with sun5-a13-mmc just works.
> This sun5i driver version does not (and will never) support higher
> transfer modes anyway, so for that subset they are compatible. This
> opens up the door to other operating systems not having a particular
> driver for the A64, for instance, also older Linux kernels.
> I know that sunxi doesn't use this compatible feature much, but IMHO we
> should really start thinking about the DT not just being Linux specific
> - or even being specific to a certain Linux version. And this case here
> is a good example: An A13 MMC driver can drive this device - if there is
> no better driver (an A64 one) available.

Cool. Please put this in the commit log. :)

>
>>
>>> +                       reg = <0x01c0f000 0x1000>;
>>> +                       clocks = <&ccu 31>, <&ccu 75>;
>>
>> The clock / reset index macros are in the tree now.
>> Please switch to them.
>
> The include file is in the tree, but it isn't used in the current HEAD
> (as in #included and the actual macros being used in the .dtsi).
> So I was wondering if there is a patch pending for that?

Not yet I think. Perhaps Maxime will do one once he gets back from vacation?

Regards
ChenYu

>
> Cheers,
> Andre
>
>>> +                       clock-names = "ahb", "mmc";
>>> +                       resets = <&ccu 8>;
>>> +                       reset-names = "ahb";
>>> +                       interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
>>> +                       status = "disabled";
>>> +                       #address-cells = <1>;
>>> +                       #size-cells = <0>;
>>> +               };
>>> +
>>> +               mmc1: mmc at 1c10000 {
>>> +                       compatible = "allwinner,sun50i-a64-mmc",
>>> +                                    "allwinner,sun5i-a13-mmc";
>>> +                       reg = <0x01c10000 0x1000>;
>>> +                       clocks = <&ccu 32>, <&ccu 76>;
>>> +                       clock-names = "ahb", "mmc";
>>> +                       resets = <&ccu 9>;
>>> +                       reset-names = "ahb";
>>> +                       interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
>>> +                       status = "disabled";
>>> +                       #address-cells = <1>;
>>> +                       #size-cells = <0>;
>>> +               };
>>> +
>>> +               mmc2: mmc at 1c11000 {
>>> +                       compatible = "allwinner,sun50i-a64-emmc";
>>> +                       reg = <0x01c11000 0x1000>;
>>> +                       clocks = <&ccu 33>, <&ccu 77>;
>>> +                       clock-names = "ahb", "mmc";
>>> +                       resets = <&ccu 10>;
>>> +                       reset-names = "ahb";
>>> +                       interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
>>> +                       status = "disabled";
>>> +                       #address-cells = <1>;
>>> +                       #size-cells = <0>;
>>> +               };
>>> +
>>>                 gic: interrupt-controller at 1c81000 {
>>>                         compatible = "arm,gic-400";
>>>                         reg = <0x01c81000 0x1000>,
>>> --
>>> 2.8.2
>>>
>
