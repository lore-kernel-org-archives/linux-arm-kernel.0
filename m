From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 18 Dec 2013 07:41:57 +0900
Subject: [PATCH 01/04] ARM: shmobile: r7s72100 GPIO and PINCTRL device
 nodes
In-Reply-To: <1836950.NOThFz7jV4@avalon>
References: <20131217050232.727.9552.sendpatchset@w520>
 <20131217050242.727.69737.sendpatchset@w520>
 <1836950.NOThFz7jV4@avalon>
Message-ID: <CANqRtoScxzFUzVcck3tPPb6k35TWDKHgf9J-K+WxkERcmsmrQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Wed, Dec 18, 2013 at 1:29 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> Thank you for the patch.
>
> On Tuesday 17 December 2013 14:02:42 Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Add support for r7s72100 PFC and GPIO device nodes port0 -> port11
>> and jtagport0.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>> ---
>>
>>  arch/arm/boot/dts/r7s72100.dtsi |  154 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 154 insertions(+)
>>
>> --- 0001/arch/arm/boot/dts/r7s72100.dtsi
>> +++ work/arch/arm/boot/dts/r7s72100.dtsi      2013-11-27 16:06:36.000000000
> +0900
>> @@ -14,6 +14,22 @@
>>       #address-cells = <1>;
>>       #size-cells = <1>;
>>
>> +     aliases {
>> +             gpio0 = &port0;
>> +             gpio1 = &port1;
>> +             gpio2 = &port2;
>> +             gpio3 = &port3;
>> +             gpio4 = &port4;
>> +             gpio5 = &port5;
>> +             gpio6 = &port6;
>> +             gpio7 = &port7;
>> +             gpio8 = &port8;
>> +             gpio9 = &port9;
>> +             gpio10 = &port10;
>> +             gpio11 = &port11;
>> +             gpio12 = &jtagport0;
>> +     };
>> +
>>       cpus {
>>               #address-cells = <1>;
>>               #size-cells = <0>;
>> @@ -33,4 +49,142 @@
>>               reg = <0xe8201000 0x1000>,
>>                       <0xe8202000 0x1000>;
>>       };
>> +
>> +     pfc: pfc at fcfe3300 {
>> +             compatible = "renesas,pfc-r7s72100";
>> +             reg = <0xfcfe3300 0x400>, /* PM, PMC, PFC, PFCE */
>> +                       <0xfcfe3a00 0x100>, /* PFCAE */
>> +                       <0xfcfe7000 0x300>, /* PIBC, PBDC, PIPC */
>> +                       <0xfcfe7b40 0x04>, /* JPMC */
>> +                       <0xfcfe7b90 0x04>, /* JPMCSR */
>> +                       <0xfcfe7f00 0x04>; /* JPIBC */
>> +     };
>> +
>> +     port0: gpio at fcfe3100 {
>> +             compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
>> +             reg = <0xfcfe3100 0x4>, /* PSR */
>> +                       <0xfcfe3200 0x2>, /* PPR */
>> +                       <0xfcfe3800 0x4>; /* PMSR */
>> +             #gpio-cells = <2>;
>> +             gpio-controller;
>> +             gpio-ranges = <&pfc 0 0 6>;
>> +     };
>> +
>> +     port1: gpio at fcfe3104 {
>> +             compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
>> +             reg = <0xfcfe3104 0x4>, /* PSR */
>> +                       <0xfcfe3204 0x2>, /* PPR */
>> +                       <0xfcfe3804 0x4>; /* PMSR */
>> +             #gpio-cells = <2>;
>> +             gpio-controller;
>> +             gpio-ranges = <&pfc 0 16 16>;
>
> As P0 has 6 pins only this should ideally be
>
>                 gpio-ranges = <&pfc 0 6 16>;
>
> Otherwise the PFC driver will expose pins that don't exist. However, that
> would require computing the pin numbers in the PFC driver differently, as we
> currently just use the bank * 16 + index formula. Given that we only have
> three ports with less than 16 pins we could come up with a not overly complex
> formula that can be evaluated at compile time. Something like this should do.
>
> #define RZ_PORT_PIN(bank, pin) \
>         (bank) < 1 ? (pin) : \
>         (bank) < 6 ? 6 + (((bank) - 1) * 16) + (pin)) : \
>         (bank) < 10 ? 6 + 11 + 4 * 16 + (((bank) - 6) * 16) + (pin)) : \
>         6 + 11 + 8 + 7 * 16 + (((bank) - 10) * 16) + (pin))

Uhm, well, you can make the mapping more compact yes, but I'm not sure
if I agree that it becomes any better. Isn't it better to simply
follow the per-port setup that the manual defines? Is there an actual
problem with having unused GPIOs?

Actually, I prefer going in the opposite direction so I would like to
share the simple version of RZ_PORT_PIN() in a header file like we do
with RCAR_GP_PIN() in <linux/platform_data/gpio-rcar.h>. This because
we would like to use the same macro in the GPIO driver and in the
current PFC code (and potentially more PFCs using the same GPIO
driver).

Please let me know what you think.

Cheers,

/ magnus
