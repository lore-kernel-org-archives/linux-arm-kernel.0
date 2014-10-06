From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 6 Oct 2014 20:16:47 +0800
Subject: [PATCH 3/3] ARM: sun7i: cubieboard2: Enable the AXP209
In-Reply-To: <20141006120717.GI4090@lukather>
References: <1411243596-15117-1-git-send-email-maxime.ripard@free-electrons.com>
 <1411243596-15117-4-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v67j6bqY7tU6ky9r1nSx_2ZaqqvNX5CAuoPwfX_1McXS0g@mail.gmail.com>
 <20141006120717.GI4090@lukather>
Message-ID: <CAGb2v65goZ6nf2Bk3m4oZWHv98+F=ZZSEcKx+9ni-JRgMCqokw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

BTW,

On Mon, Oct 6, 2014 at 8:07 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Oct 03, 2014 at 04:49:25PM +0800, Chen-Yu Tsai wrote:
>> Hi,
>>
>> On Sun, Sep 21, 2014 at 4:06 AM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > Add the AXP209 PMIC with the regulators in use on the cubie2.
>> >
>> > The RTC regulator can be disabled, but since the RTC driver doesn't grab the
>> > regulator for now, the driver wouldn't work anymore.

This is wrong. The RTC regulator, i.e. LDO1, can not be disabled.
>From the datasheet: "LDO1?30mA?????", or "Always effective/enabled".
And it is defined in the driver without enabling controls.

ChenYu

>> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> > ---
>> >  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts | 31 +++++++++++++++++++++++++++++
>> >  1 file changed, 31 insertions(+)
>> >
>> > diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
>> > index 53680983461a..f0b74a38a800 100644
>> > --- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
>> > +++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
>> > @@ -91,6 +91,29 @@
>> >
>> >                                 interrupt-controller;
>> >                                 #interrupt-cells = <1>;
>> > +
>> > +                               regulators {
>> > +                                       x-powers,dcdc-freq = <1500>;
>> > +
>> > +                                       vdd_cpu: dcdc2 {
>> > +                                               vin-supply = <&reg_axp_ipsout>;
>>
>> The driver ignores the vin-supply properties.
>>
>> I think the original intended design was to have
>>
>>     acin-supply = <&reg_axp_ipsout>;
>>     vin2-supply = <&reg_axp_ipsout>;
>>     vin3-supply = <&reg_axp_ipsout>;
>>     ldo24in-supply = <&reg_axp_ipsout>;
>>     ldo3in-supply = <&reg_axp_ipsout>;
>>     ldo5in-supply = <&reg_axp_ipsout>;
>>
>> under the axp209 node.
>>
>> With this change, the kernel does find the supplies:
>>
>> LDO1: 1300 mV
>> LDO1: supplied by axp-ipsout
>> LDO2: at 3000 mV
>> LDO2: supplied by axp-ipsout
>> LDO3: at 2275 mV
>> LDO3: supplied by axp-ipsout
>> LDO4: at 2800 mV
>> LDO4: supplied by axp-ipsout
>> LDO5: at 2800 mV
>> LDO5: supplied by axp-ipsout
>> DCDC2: at 1400 mV
>> DCDC2: supplied by axp-ipsout
>> DCDC3: at 1250 mV
>> DCDC3: supplied by axp-ipsout
>
> Wow. Thanks. I have no idea how I could have send this patch, and how
> I could merge it too.
>
> You're obviously right, I'll amend my queued patch.
>
>> P.S. my /sys/kernel/debug/regulator/supply_map is always empty.
>> Is that normal?
>
> Yeah, I have seen this too, I honestly have no idea :)
>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
