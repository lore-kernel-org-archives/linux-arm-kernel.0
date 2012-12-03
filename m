From: dianders@chromium.org (Doug Anderson)
Date: Mon, 3 Dec 2012 08:13:15 -0800
Subject: [PATCH] ARM: DTS: CROS5250: Add max77686 device tree support
In-Reply-To: <CAM4voakrpSJX6WWU5EMD-sUPqgjeOdph-R1KUBYJTEPDbr=wgA@mail.gmail.com>
References: <1354099900-24779-1-git-send-email-a.kesavan@samsung.com>
 <CAD=FV=Xfbt25-_JMENLiR+N+oC-vPkjxR8brbqYtt4ZFr-60kw@mail.gmail.com>
 <CAM4voakrpSJX6WWU5EMD-sUPqgjeOdph-R1KUBYJTEPDbr=wgA@mail.gmail.com>
Message-ID: <CAD=FV=VyEJyaxD5ruZxy2o7F_Y13rw5x0yjG5ewjEmRQcSnvuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 30, 2012 at 8:03 PM, Abhilash Kesavan
<kesavan.abhilash@gmail.com> wrote:
> Hi Doug,
>
> Thanks for the comments
>
> [...]
>> I don't believe this is right.  In the least the name is wrong since
>> the LDO2 signal from max77686 actually goes to the EC as a signal for
>> detecting the end of the PMIC power on sequence.  The signal
>> "vdd_micom" is actually the LDO2 signal from tps65090.
>>
>> Current Chrome OS kernel tree doesn't have an entry for LDO2 so it is
>> using whatever the bootloader setup, I believe.
> I will use generic names such as "P1.8V_LDO_OUT2" to avoid confusion.
>
> The regulator core assumes that a dt enabled machine will have all
> constraints defined
> and for those that are not it disables them. So, you may see some
> instances listed here
> that are not present in the chrome os kernel tree,

This makes sense to me an explains why the regulators listed as "off"
are simply not listed in your version.  Thanks!  :)

>
> [...]
>> In Chrome OS kernel tree these don't have names like this and are just
>> named vdd_ldo3.  While I can see a point to being a little more
>> specific, it can also be misleading.  This LDO not only provides
>> "vdd_rtc" but also several other signals (I see it go to VDDQ_PRE1,
>> VIO of the max77686 itself, ...  Maybe just keep the generic "vdd_do3"
>> name?
>>
>> This comment also applies to most of the other definitions.
> Sure, I 'll change them all.
>
> [...]
>> I see that several regulators that are in Chrome OS's kernel are not
>> here, like LDO6, LDO11, LDO13, and LDO17.  Can you explain their
>> absence?
> These are unused LDOs on the snow and need not be listed.
>
>>
>>
>>> +                               ldo7_reg: LDO7 {
>>> +                                       regulator-name = "vdd10_xpll";
>>> +                                       regulator-min-microvolt = <1100000>;
>>> +                                       regulator-max-microvolt = <1100000>;
>>
>> This voltage doesn't match what Chrome OS has.  We have 1.0V.  Do you
>> have a specific reason for increasing?
> The default is 1.1V and the schematics I have shows 1.1V as well.
> Looks like the one in
> chrome os is incorrect.

On one schematic I have (Daisy 0210) it is listed as PP1000_LDO7 which
means 1.0 V.  On Snow's schematic (0912) it is listed as
P1.0V_LDO_OUT7.  The pin on the exynos that it's connected to a pins
on exynos called VDD10_EPLL, VDD10_VPLL, ....  To me that strongly
implies 1.0 volts, though given the fact that exynos runs has clocks
with "266" in the name that run at 300 MHz I wouldn't bet my life on
it.  The pin name "VDD10_VPLL" matches what I see in the 1.1 version
of the user's guide.

Ah, I think I finally found it.

Table 63-2 Recommended Operating Conditions.

That lists VDD10_XPLL as a typical of 1.1V

Ugh, whoever, thought that it was a good idea to put voltage levels
and clocks speeds in signal names should be given a talking to.  I'll
file a bug for Chrome OS about this.


>
> [...]
>>> +                               buck5_reg: BUCK5 {
>>> +                                       regulator-name = "vdd18_adc";
>>> +                                       regulator-min-microvolt = <1800000>;
>>> +                                       regulator-max-microvolt = <1800000>;
>>> +                                       regulator-always-on;
>>
>> I see you removed "regulator-boot-on;" compared to ChromeOS kernel.
>> Can you explain why?
> Will fix as it is "ON" at boot.
>
>>
>>> +                               };
>>> +
>>> +                               buck6_reg: BUCK6 {
>>> +                                       regulator-name = "vdd_bat1";
>>> +                                       regulator-min-microvolt = <1350000>;
>>> +                                       regulator-max-microvolt = <1350000>;
>>> +                                       regulator-always-on;
>>> +                               };
>>> +
>>> +                               buck7_reg: BUCK7 {
>>> +                                       regulator-name = "vdd_bat2";
>>> +                                       regulator-min-microvolt = <2000000>;
>>> +                                       regulator-max-microvolt = <2000000>;
>>> +                                       regulator-always-on;
>>> +                               };
>>
>> buck6 and buck7 aren't in Chrome OS kernel (so just using whatever the
>> bootloader provided).  Specifying them here is fine (and these values
>> look correct), but I'm not 100% convinced about the name (similar to
>> LDOs, these signals go lots of places).
> Naming will be fixed.
>
>>
>>> +
>>> +                               buck8_reg: BUCK8 {
>>> +                                       regulator-name = "vdd_emmc";
>>> +                                       regulator-min-microvolt = <2850000>;
>>> +                                       regulator-max-microvolt = <2850000>;
>>> +                                       regulator-always-on;
>>
>> I see you removed "regulator-boot-on;" compared to ChromeOS kernel.
>> Can you explain why?
> BUCK8 is by default "OFF".
>
> Will re-post on Tuesday.

Thanks!

>
> Regards,
> Abhilash

-Doug
