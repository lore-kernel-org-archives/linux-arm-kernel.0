From: o.schinagl@ultimaker.com (Olliver Schinagl)
Date: Fri, 11 Sep 2015 08:37:36 +0200
Subject: [PATCH v2 1/1] ARM: dts: sun7i: Enable axp209 driver on olinuxino
 lime2
In-Reply-To: <CAGb2v67GTAM3tqOUOmUjKmWGyewJar2NWAzF4bk4g+-7Yfdm0A@mail.gmail.com>
References: <1441805204-6037-1-git-send-email-o.schinagl@ultimaker.com>
 <1441805204-6037-2-git-send-email-o.schinagl@ultimaker.com>
 <20150910181315.GM9885@lukather>
 <CAGb2v67GTAM3tqOUOmUjKmWGyewJar2NWAzF4bk4g+-7Yfdm0A@mail.gmail.com>
Message-ID: <1025948D-A8F7-4E5A-98AF-03801A53DE23@ultimaker.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey chen,

On September 11, 2015 4:57:03 AM CEST, Chen-Yu Tsai <wens@csie.org> wrote:
>On Fri, Sep 11, 2015 at 2:13 AM, Maxime Ripard
><maxime.ripard@free-electrons.com> wrote:
>> Hi Oliver,
>>
>> On Wed, Sep 09, 2015 at 03:26:44PM +0200, Olliver Schinagl wrote:
>>> The Olimex OLinuXino Lime2 uses the same AXP209 as was recently
>>> introduced this driver for its power regulation.
>>>
>>> Signed-off-by: Olliver Schinagl <o.schinagl@ultimaker.com>
>>> ---
>>>  arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 87
>+++++++++----------------
>>>  1 file changed, 31 insertions(+), 56 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
>b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
>>> index d5c796c..dd90a1d 100644
>>> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
>>> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
>>> @@ -71,14 +71,6 @@
>>>                       default-state = "on";
>>>               };
>>>       };
>>> -
>>> -     reg_axp_ipsout: axp_ipsout {
>>> -             compatible = "regulator-fixed";
>>> -             regulator-name = "axp-ipsout";
>>> -             regulator-min-microvolt = <5000000>;
>>> -             regulator-max-microvolt = <5000000>;
>>> -             regulator-always-on;
>>> -     };
>>
>> Why are you removing that regulator?
>
>This is really just a placeholder, rather than an actual regulator.
>
>From the bindings:
>
>- <input>-supply: a phandle to the regulator supply node. May be
>omitted if
>                inputs are unregulated, such as using the IPSOUT output
>                  from the PMIC.
>
>
>>>  };
>>>
>>>  &ahci {
>>> @@ -86,6 +78,10 @@
>>>       status = "okay";
>>>  };
>>>
>>> +&cpu0 {
>>> +     cpu-supply = <&reg_dcdc2>;
>>> +};
>>> +
>>>  &ehci0 {
>>>       status = "okay";
>>>  };
>>> @@ -112,57 +108,9 @@
>>>       status = "okay";
>>>
>>>       axp209: pmic at 34 {
>>> -             compatible = "x-powers,axp209";
>>>               reg = <0x34>;
>>>               interrupt-parent = <&nmi_intc>;
>>>               interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>>> -
>>> -             interrupt-controller;
>>> -             #interrupt-cells = <1>;
>>> -
>>> -             acin-supply = <&reg_axp_ipsout>;
>>> -             vin2-supply = <&reg_axp_ipsout>;
>>> -             vin3-supply = <&reg_axp_ipsout>;
>>> -             ldo24in-supply = <&reg_axp_ipsout>;
>>> -             ldo3in-supply = <&reg_axp_ipsout>;
>>
>> And these supplies?
>>
>>> -             regulators {
>>> -                     vdd_rtc: ldo1 {
>>> -                             regulator-min-microvolt = <1300000>;
>>> -                             regulator-max-microvolt = <1300000>;
>>> -                             regulator-always-on;
>>> -                     };
>>> -
>>> -                     avcc: ldo2 {
>>> -                             regulator-min-microvolt = <1800000>;
>>> -                             regulator-max-microvolt = <3300000>;
>>> -                             regulator-always-on;
>>> -                     };
>>> -
>>> -                     vcc_csi0: ldo3 {
>>> -                             regulator-min-microvolt = <700000>;
>>> -                             regulator-max-microvolt = <3500000>;
>>> -                             regulator-always-on;
>>> -                     };
>>> -
>>> -                     vcc_csi1: ldo4 {
>>> -                             regulator-min-microvolt = <1250000>;
>>> -                             regulator-max-microvolt = <3300000>;
>>> -                             regulator-always-on;
>>> -                     };
>>> -
>>> -                     vdd_cpu: dcdc2 {
>>> -                             regulator-min-microvolt = <700000>;
>>> -                             regulator-max-microvolt = <2275000>;
>>> -                             regulator-always-on;
>>> -                     };
>>> -
>>> -                     vdd_int: dcdc3 {
>>> -                             regulator-min-microvolt = <700000>;
>>> -                             regulator-max-microvolt = <3500000>;
>>> -                             regulator-always-on;
>>> -                     };
>>> -             };
>>>       };
>>>  };
>>>
>>> @@ -243,6 +191,33 @@
>>>       status = "okay";
>>>  };
>>>
>>> +#include "axp209.dtsi"
>>> +
>>> +&reg_dcdc2 {
>>> +     regulator-always-on;
>>> +     regulator-min-microvolt = <1000000>;
>>> +     regulator-max-microvolt = <1450000>;
>>
>> This is outside of the operating voltages of the CPU.
>>
>>> +     regulator-name = "vdd-cpu";
>>> +};
>>> +
>>> +&reg_dcdc3 {
>>> +     regulator-always-on;
>>> +     regulator-min-microvolt = <1000000>;
>>> +     regulator-max-microvolt = <1400000>;
>>> +     regulator-name = "vdd-int-dll";
>>> +};
>>> +
>>> +&reg_ldo1 {
>>> +     regulator-name = "vdd-rtc";
>>> +};
>>> +
>>> +&reg_ldo2 {
>>> +     regulator-always-on;
>>> +     regulator-min-microvolt = <3000000>;
>>> +     regulator-max-microvolt = <3000000>;
>>> +     regulator-name = "avcc";
>>
>> You're changing the boundaries, why?
>
>The old boundaries seem to be from a very old dts, where we were
>listing the regulators' supported voltage range, instead of what
>the SoC could take.
Is it very old? just checked the cubies in maxime's sunxi next and those where still there. I actually wrote these patches ages ago and forgot to submit them whats worse is on my behave, i didn't properly check for changes. Now that you mention it however, i do recall the discussion about these values. I will update them accordingly with the correct values.

Sorry,
Olliver

>
>Olliver you should explain all this in the commit log, probably
>starting with something like "update the dts to use axp209.dtsi
>, comply with axp20x bindings, and set proper voltage ranges for
>the regulators".
>
>>> +};
>>> +
>>>  &reg_usb0_vbus {
>>>       pinctrl-0 = <&usb0_vbus_pin_lime2>;
>>>       gpio = <&pio 2 17 GPIO_ACTIVE_HIGH>;
>>> --
>>> 2.1.4
>>
>> Thanks!
>> Maxime
>>
>> --
>> Maxime Ripard, Free Electrons
>> Embedded Linux, Kernel and Android engineering
>> http://free-electrons.com
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
