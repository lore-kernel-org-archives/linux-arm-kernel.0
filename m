From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 15 May 2015 09:12:11 +0900
Subject: [PATCHv5 2/5] ARM: dts: Odroid-XU3 Enable TMU at Exynos5422 base
In-Reply-To: <CANAwSgTOaz+mMhFZTeXYoXF+xPR2qon2Tkfsw5aqO42AK1m1-Q@mail.gmail.com>
References: <1431499020-3912-1-git-send-email-linux.amoon@gmail.com>
 <1431499020-3912-3-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPca-2qdYOoMQOnu0jigOYwUvMTWZwdM2kRTkBXw-ws4yw@mail.gmail.com>
 <CANAwSgQ=30j4A_nCd26kzxi=rdsh32+Srwuc5EaJigLhJ2r4jA@mail.gmail.com>
 <CAJKOXPfC9nGEsYJ3qJ6m_iMsB=D8_6sOEpLQzEvmLry5zS5j3g@mail.gmail.com>
 <CANAwSgTOaz+mMhFZTeXYoXF+xPR2qon2Tkfsw5aqO42AK1m1-Q@mail.gmail.com>
Message-ID: <CAJKOXPd_1rTZZCz66nQKidUOOEBmgUD+05fHUBvXN-VuD5mTCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-15 1:16 GMT+09:00 Anand Moon <linux.amoon@gmail.com>:
> On 13 May 2015 at 14:02, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
>> 2015-05-13 17:21 GMT+09:00 Anand Moon <linux.amoon@gmail.com>:
>>> On 13 May 2015 at 12:51, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
>>>> 2015-05-13 15:36 GMT+09:00 Anand Moon <linux.amoon@gmail.com>:
>>>>> This changes enables TMU IP block on the Exynos5422 Odroid-XU3
>>>>> device.
>>>>>
>>>>> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
>>>>> Acked-by: Lukasz Majewski <l.majewski@samsung.com>
>>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>>> ---
>>>>>  arch/arm/boot/dts/exynos5422-odroidxu3.dts | 25 +++++++++++++++++++++++++
>>>>>  1 file changed, 25 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
>>>>> index 9446e28..cd78816 100644
>>>>> --- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
>>>>> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
>>>>> @@ -319,6 +319,31 @@
>>>>>                 #cooling-cells = <2>;
>>>>>                 cooling-levels = <0 130 170 230>;
>>>>>         };
>>>>> +
>>>>> +       tmu at 10060000 {
>>>>
>>>> Here and for other overrides please use label notation, like:
>>>>
>>>> &tmu_cpu0 {
>>>>               ...
>>>> };
>>>>
>>>>> +               vtmu-supply = <&ldo10_reg>;
>>>>
>>>> I am curious, how did you find that LDO10 supplies TMU unit?
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>
>>> Hi Krzysztof,
>>>
>>> I have re-base my work on earlier Lukasz Majewski patches.
>>>
>>> https://patchwork.kernel.org/patch/5693201/
>>
>> NAK.
>> I am sorry, but this is not sufficient explanation. Actually such
>> explanation could mean that you did just blindly copied everything
>> instead of developing it.
>>
>> You cannot use some regulator here just because some Exynos4 boards
>> use it. You have to be sure that this regulator supplies this part of
>> SoC or device.
>
> Hi Krzysztof,
>
> After going through the schematics, I came to understanding that their is
> missing regulator related to TEMP SE in the exynos5422-odroidxu3.dts.
>
> Below is the schematic of the board.
>
> http://dn.odroid.com/5422/ODROID-XU3/Schematics/XU3_MAIN_REV0.2.PDF
>
>   ldo18_reg: LDO18 {
>                                          regulator-name = "vdd_ldo18";
>                                          regulator-min-microvolt = <1800000>;
>                                          regulator-max-microvolt = <1800000>;
>                                          regulator-always-on;
>                                };

The output of LDO18 goes to VDD_EMMC_1V8. This is not regulator for TMU.

I think the schematics are missing some of details but it can be deducted that:
1. TEMP SE is supplied by VDD18_TS power domain. It consists of 5
pairs of pins (XTSTEST_OUT[0-4], XTSEXT_RES[0-4]).
2. The VDD18_TS01, VDD18_TS23 and VDD18_TS4 are wired to the LDO7 of
S2MPS11 PMIC.
3. I confirmed with the Exynos5422 datasheet that these
VDD18_TS{01,23,4} supply the XTSTEST pins (OUT and RES).

So the LDO7 it is... but before using it there is a caveat. The LDO7
is also connected to VDD of MIPI, HDMI and few more. So when you use
this regulator in TMU it may be turned off by TMU driver (e.g. during
unbind). In such case these other blocks also should be tested and
checked whether they take this regulator and enable it.

Best regards,
Krzysztof
