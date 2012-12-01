From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Sat, 1 Dec 2012 09:33:30 +0530
Subject: [PATCH] ARM: DTS: CROS5250: Add max77686 device tree support
In-Reply-To: <CAD=FV=Xfbt25-_JMENLiR+N+oC-vPkjxR8brbqYtt4ZFr-60kw@mail.gmail.com>
References: <1354099900-24779-1-git-send-email-a.kesavan@samsung.com>
 <CAD=FV=Xfbt25-_JMENLiR+N+oC-vPkjxR8brbqYtt4ZFr-60kw@mail.gmail.com>
Message-ID: <CAM4voakrpSJX6WWU5EMD-sUPqgjeOdph-R1KUBYJTEPDbr=wgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

Thanks for the comments

[...]
> I don't believe this is right.  In the least the name is wrong since
> the LDO2 signal from max77686 actually goes to the EC as a signal for
> detecting the end of the PMIC power on sequence.  The signal
> "vdd_micom" is actually the LDO2 signal from tps65090.
>
> Current Chrome OS kernel tree doesn't have an entry for LDO2 so it is
> using whatever the bootloader setup, I believe.
I will use generic names such as "P1.8V_LDO_OUT2" to avoid confusion.

The regulator core assumes that a dt enabled machine will have all
constraints defined
and for those that are not it disables them. So, you may see some
instances listed here
that are not present in the chrome os kernel tree,

[...]
> In Chrome OS kernel tree these don't have names like this and are just
> named vdd_ldo3.  While I can see a point to being a little more
> specific, it can also be misleading.  This LDO not only provides
> "vdd_rtc" but also several other signals (I see it go to VDDQ_PRE1,
> VIO of the max77686 itself, ...  Maybe just keep the generic "vdd_do3"
> name?
>
> This comment also applies to most of the other definitions.
Sure, I 'll change them all.

[...]
> I see that several regulators that are in Chrome OS's kernel are not
> here, like LDO6, LDO11, LDO13, and LDO17.  Can you explain their
> absence?
These are unused LDOs on the snow and need not be listed.

>
>
>> +                               ldo7_reg: LDO7 {
>> +                                       regulator-name = "vdd10_xpll";
>> +                                       regulator-min-microvolt = <1100000>;
>> +                                       regulator-max-microvolt = <1100000>;
>
> This voltage doesn't match what Chrome OS has.  We have 1.0V.  Do you
> have a specific reason for increasing?
The default is 1.1V and the schematics I have shows 1.1V as well.
Looks like the one in
chrome os is incorrect.

[...]
>> +                               buck5_reg: BUCK5 {
>> +                                       regulator-name = "vdd18_adc";
>> +                                       regulator-min-microvolt = <1800000>;
>> +                                       regulator-max-microvolt = <1800000>;
>> +                                       regulator-always-on;
>
> I see you removed "regulator-boot-on;" compared to ChromeOS kernel.
> Can you explain why?
Will fix as it is "ON" at boot.

>
>> +                               };
>> +
>> +                               buck6_reg: BUCK6 {
>> +                                       regulator-name = "vdd_bat1";
>> +                                       regulator-min-microvolt = <1350000>;
>> +                                       regulator-max-microvolt = <1350000>;
>> +                                       regulator-always-on;
>> +                               };
>> +
>> +                               buck7_reg: BUCK7 {
>> +                                       regulator-name = "vdd_bat2";
>> +                                       regulator-min-microvolt = <2000000>;
>> +                                       regulator-max-microvolt = <2000000>;
>> +                                       regulator-always-on;
>> +                               };
>
> buck6 and buck7 aren't in Chrome OS kernel (so just using whatever the
> bootloader provided).  Specifying them here is fine (and these values
> look correct), but I'm not 100% convinced about the name (similar to
> LDOs, these signals go lots of places).
Naming will be fixed.

>
>> +
>> +                               buck8_reg: BUCK8 {
>> +                                       regulator-name = "vdd_emmc";
>> +                                       regulator-min-microvolt = <2850000>;
>> +                                       regulator-max-microvolt = <2850000>;
>> +                                       regulator-always-on;
>
> I see you removed "regulator-boot-on;" compared to ChromeOS kernel.
> Can you explain why?
BUCK8 is by default "OFF".

Will re-post on Tuesday.

Regards,
Abhilash
