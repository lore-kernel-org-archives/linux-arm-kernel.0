From: linux.amoon@gmail.com (Anand Moon)
Date: Sat, 23 May 2015 23:05:55 +0530
Subject: [PATCHv5 2/5] ARM: dts: Odroid-XU3 Enable TMU at Exynos5422 base
In-Reply-To: <555D20E1.3070308@samsung.com>
References: <1431499020-3912-1-git-send-email-linux.amoon@gmail.com>
 <1431499020-3912-3-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPca-2qdYOoMQOnu0jigOYwUvMTWZwdM2kRTkBXw-ws4yw@mail.gmail.com>
 <CANAwSgQ=30j4A_nCd26kzxi=rdsh32+Srwuc5EaJigLhJ2r4jA@mail.gmail.com>
 <CAJKOXPfC9nGEsYJ3qJ6m_iMsB=D8_6sOEpLQzEvmLry5zS5j3g@mail.gmail.com>
 <CANAwSgTOaz+mMhFZTeXYoXF+xPR2qon2Tkfsw5aqO42AK1m1-Q@mail.gmail.com>
 <CAJKOXPd_1rTZZCz66nQKidUOOEBmgUD+05fHUBvXN-VuD5mTCw@mail.gmail.com>
 <CANAwSgTbjmSxhJj4o2pnD5pR2V9JbQ3az+TSSCDwgwNnvF7P9w@mail.gmail.com>
 <CAJKOXPcQGnc1O9-MwqeNwsQE3ax1n8nvad4Sqt47NYKnOSmJPg@mail.gmail.com>
 <CADoNuNfuDCn_vvACc0=xj0MjdKr4pYcj_-Xh0--Q8_qciuW5YA@mail.gmail.com>
 <CANAwSgSyoesxQG9hBj3KfBb_5CiqUrHWbkUymU3LYcKOnLdOzA@mail.gmail.com>
 <555D20E1.3070308@samsung.com>
Message-ID: <CANAwSgQzYvmquo9fcUPLK5XHqo1G=HYHc-YuhUvtw2yYaDi9GA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 May 2015 at 05:33, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> On 20.05.2015 23:59, Anand Moon wrote:
>> On 20 May 2015 at 08:57, Dongjin Kim <tobetter@gmail.com> wrote:
>>> Hello Kryzsztof,
>>>
>>> Are you able to check if TMU is under VDDI power domain from Exynos5422
>>> datasheet?
>>> If it is, XU3 use BUCK3 for TMU and more internal blocks.
>>>
>>> Thank you,
>>> Dongjin.
>>>
>>> On Tue, May 19, 2015 at 4:42 PM, Krzysztof Kozlowski
>>> <k.kozlowski@samsung.com> wrote:
>>>>
>>>> 2015-05-19 16:28 GMT+09:00 Anand Moon <linux.amoon@gmail.com>:
>>>>> On 15 May 2015 at 05:42, Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>>>> wrote:
>>>>>> 2015-05-15 1:16 GMT+09:00 Anand Moon <linux.amoon@gmail.com>:
>>>>>>> On 13 May 2015 at 14:02, Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>>>>>> wrote:
>>>>>>>> 2015-05-13 17:21 GMT+09:00 Anand Moon <linux.amoon@gmail.com>:
>>>>>>>>> On 13 May 2015 at 12:51, Krzysztof Kozlowski
>>>>>>>>> <k.kozlowski@samsung.com> wrote:
>>>>>>>>>> 2015-05-13 15:36 GMT+09:00 Anand Moon <linux.amoon@gmail.com>:
>>>>>>>>>>> This changes enables TMU IP block on the Exynos5422 Odroid-XU3
>>>>>>>>>>> device.
>>>>>>>>>>>
>>>>>>>>>>> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
>>>>>>>>>>> Acked-by: Lukasz Majewski <l.majewski@samsung.com>
>>>>>>>>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>>>>>>>>> ---
>>>>>>>>>>>  arch/arm/boot/dts/exynos5422-odroidxu3.dts | 25
>>>>>>>>>>> +++++++++++++++++++++++++
>>>>>>>>>>>  1 file changed, 25 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
>>>>>>>>>>> b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
>>>>>>>>>>> index 9446e28..cd78816 100644
>>>>>>>>>>> --- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
>>>>>>>>>>> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
>>>>>>>>>>> @@ -319,6 +319,31 @@
>>>>>>>>>>>                 #cooling-cells = <2>;
>>>>>>>>>>>                 cooling-levels = <0 130 170 230>;
>>>>>>>>>>>         };
>>>>>>>>>>> +
>>>>>>>>>>> +       tmu at 10060000 {
>>>>>>>>>>
>>>>>>>>>> Here and for other overrides please use label notation, like:
>>>>>>>>>>
>>>>>>>>>> &tmu_cpu0 {
>>>>>>>>>>               ...
>>>>>>>>>> };
>>>>>>>>>>
>>>>>>>>>>> +               vtmu-supply = <&ldo10_reg>;
>>>>>>>>>>
>>>>>>>>>> I am curious, how did you find that LDO10 supplies TMU unit?
>>>>>>>>>>
>>>>>>>>>> Best regards,
>>>>>>>>>> Krzysztof
>>>>>>>>>
>>>>>>>>> Hi Krzysztof,
>>>>>>>>>
>>>>>>>>> I have re-base my work on earlier Lukasz Majewski patches.
>>>>>>>>>
>>>>>>>>> https://patchwork.kernel.org/patch/5693201/
>>>>>>>>
>>>>>>>> NAK.
>>>>>>>> I am sorry, but this is not sufficient explanation. Actually such
>>>>>>>> explanation could mean that you did just blindly copied everything
>>>>>>>> instead of developing it.
>>>>>>>>
>>>>>>>> You cannot use some regulator here just because some Exynos4 boards
>>>>>>>> use it. You have to be sure that this regulator supplies this part of
>>>>>>>> SoC or device.
>>>>>>>
>>>>>>> Hi Krzysztof,
>>>>>>>
>>>>>>> After going through the schematics, I came to understanding that their
>>>>>>> is
>>>>>>> missing regulator related to TEMP SE in the exynos5422-odroidxu3.dts.
>>>>>>>
>>>>>>> Below is the schematic of the board.
>>>>>>>
>>>>>>> http://dn.odroid.com/5422/ODROID-XU3/Schematics/XU3_MAIN_REV0.2.PDF
>>>>>>>
>>>>>>>   ldo18_reg: LDO18 {
>>>>>>>                                          regulator-name = "vdd_ldo18";
>>>>>>>                                          regulator-min-microvolt =
>>>>>>> <1800000>;
>>>>>>>                                          regulator-max-microvolt =
>>>>>>> <1800000>;
>>>>>>>                                          regulator-always-on;
>>>>>>>                                };
>>>>>>
>>>>>> The output of LDO18 goes to VDD_EMMC_1V8. This is not regulator for
>>>>>> TMU.
>>>>>>
>>>>>> I think the schematics are missing some of details but it can be
>>>>>> deducted that:
>>>>>> 1. TEMP SE is supplied by VDD18_TS power domain. It consists of 5
>>>>>> pairs of pins (XTSTEST_OUT[0-4], XTSEXT_RES[0-4]).
>>>>>> 2. The VDD18_TS01, VDD18_TS23 and VDD18_TS4 are wired to theL DO7 of
>>>>>> S2MPS11 PMIC.
>>>>>> 3. I confirmed with the Exynos5422 datasheet that these
>>>>>> VDD18_TS{01,23,4} supply the XTSTEST pins (OUT and RES).
>>>>>>
>>>>>> So the LDO7 it is... but before using it there is a caveat. The LDO7
>>>>>> is also connected to VDD of MIPI, HDMI and few more. So when you use
>>>>>> this regulator in TMU it may be turned off by TMU driver (e.g. during
>>>>>> unbind). In such case these other blocks also should be tested and
>>>>>> checked whether they take this regulator and enable it.
>>>>>
>>>>> hi Krzysztof,
>>>>>
>>>>> I tried to use the LDO7 regulator for TMU but it failed to register.
>>>>>
>>>>> [    3.231329] ina2xx 0-0045: power monitor ina231 (Rshunt = 10000 uOhm)
>>>>> [    3.237691] thermal thermal_zone0: failed to read out thermal zone
>>>>> (-22)
>>>>> [    3.243033] exynos-tmu 10060000.tmu: Looking up vtmu-supply from
>>>>> device tree
>>>>> [    3.243936] thermal thermal_zone1: failed to read out thermal zone
>>>>> (-22)
>>>>> [    3.249791] exynos-tmu 10064000.tmu: Looking up vtmu-supply from
>>>>> device tree
>>>>> [    3.250677] thermal thermal_zone2: failed to read out thermal zone
>>>>> (-22)
>>>>> [    3.256410] exynos-tmu 10068000.tmu: Looking up vtmu-supply from
>>>>> device tree
>>>>> [    3.257345] thermal thermal_zone3: failed to read out thermal zone
>>>>> (-22)
>>>>> [    3.263050] exynos-tmu 1006c000.tmu: Looking up vtmu-supply from
>>>>> device tree
>>>>> [    3.263984] thermal thermal_zone4: failed to read out thermal zone
>>>>> (-22)
>>>>> [    3.269769] exynos-tmu 100a0000.tmu: Looking up vtmu-supply from
>>>>> device tree
>>>>> [    3.270363] usb 5-1: New USB device found, idVendor=0424,
>>>>> idProduct=9514
>>>>> [    3.276389] usb 5-1: New USB device strings: Mfr=0, Product=0,
>>>>> SerialNumber=0
>>>>
>>>> Indeed.
>>>>
>>
>> Hi Krzysztof/Dongjin
>>
>> BUCK3 is option for TMU as suggested by Dongjin
>
> What do you mean by that? VDD_INT is one of important regulators. It
> supplies many parts of chip and should not be disabled during exynos-tmu
> driver removal.
>
> Of course it wouldn't because it is "always-on"... so what is the
> benefit of using it in exynos-tmu?
>
> What about regulator supplying TMU sensors? Shouldn't it be enabled? Is
> it the same?
>
> Before posting a new solution please be sure that you have sufficient
> answer for each of these questions. Anwser that "someone told me so"
> unfortunately is not sufficient :).
>
>
>
>> Earlier I have some missing CONFIG option's hence It was not working.
>> Now its registering with TMU.
>>
>> Bellow is the output device tree.
>>
>> root at odroidxu3: cd /sys/firmware/devicetree/base/
>> root at odroidxu3:/sys/firmware/devicetree/base# cat tmu at 10060000/status
>> okay
>> root at odroidxu3:/sys/firmware/devicetree/base#
>> root at odroidxu3:/sys/firmware/devicetree/base# cat tmu at 10064000/status
>> okay
>> root at odroidxu3:/sys/firmware/devicetree/base# cat tmu at 10068000/status
>> okay
>> root at odroidxu3:/sys/firmware/devicetree/base# cat tmu at 1006c000/status
>> okay
>> root at odroidxu3:/sys/firmware/devicetree/base# cat tmu at 100a0000/status
>> okay
>> root at odroidxu3:/sys/firmware/devicetree/base#
>
> If you looked at the driver then you would know, that above status does
> not mean anything for this discussion about regulator. You could use
> EMMC regulator (which you proposed) and the results would be the same.
>
> Best regards,
> Krzysztof
>

Hi Krzysztof,

I did some debugging on the this using powerdebug utility.
Using  LDO7 to control TMU seams to me correct option compared to BUCK3.

Setting LDO7 to control TMU I observed  following output on powerdebug.
I observed that the power drawn by the board on Odroid show is much
less compare to BUCK3 on the same setup.
I can see the HDMI output on Odroid-V2 display screen.
I have done some stress testing on this configuration and It worked correctly.

Powerdebug output using LDO7
---------------------------------------------------------------------------------------------------------------
PowerDebug 0.7.3     Clocks  Regulators  Sensors  Gpio
Name        Status      State       Type        Users       Microvolts
 Min u-volts Max u-volts
phy                                             0           0
 0           0
phy                                             0           0
 0           0
vdd_ldo1                enabled     voltage     0           1000000
 1000000     1000000
LDO1                                            0           0
 0           0
LDO2                    enabled     voltage     0           1800000
 0           0
vdd_ldo3                enabled     voltage     0           1800000
 1800000     1800000
LDO3                                            0           0
 0           0
LDO4                    enabled     voltage     0           1800000
 0           0
vdd_ldo5                enabled     voltage     0           1800000
 1800000     1800000
LDO5                                            0           0
 0           0
vdd_ldo6                enabled     voltage     0           1000000
 1000000     1000000
hdmi        okay                                0           0
 0           0
hdmi        okay                                0           0
 0           0
LDO6                                            0           0
 0           0
vdd_ldo7                enabled     voltage     0           1800000
 1800000     1800000
hdmi        okay                                0           0
 0           0
tmu         okay                                0           0
 0           0
tmu         okay                                0           0
 0           0
tmu         okay                                0           0
 0           0
tmu         okay                                0           0
 0           0
tmu         okay                                0           0
 0           0
LDO7                                            0           0
 0           0
vdd_ldo8                enabled     voltage     0           1800000
 1800000     1800000
LDO8                                            0           0
 0           0
vdd_ldo9                enabled     voltage     0           3000000
 3000000     3000000
LDO9                                            0           0
 0           0

Powerdebug output using BUCK3.
--------------------------------------------------------------------------------------------------------------------------
PowerDebug 0.7.3     Clocks  Regulators  Sensors  Gpio
Name        Status      State       Type        Users       Microvolts
 Min u-volts Max u-volts
LDO21                   disabled    voltage     0           1800000
 0           0
LDO22                   disabled    voltage     0           1200000
 0           0
LDO23                   enabled     voltage     0           1100000
 0           0
tsp_io                  enabled     voltage     0           2800000
 2800000     2800000
LDO24                                           0           0
 0           0
LDO25                   disabled    voltage     0           1800000
 0           0
vdd_ldo26               enabled     voltage     0           3000000
 3000000     3000000
LDO26                                           0           0
 0           0
LDO27                   enabled     voltage     0           1000000
 0           0
LDO28                   disabled    voltage     0           3300000
 0           0
LDO29                   disabled    voltage     0           1800000
 0           0
LDO30                   disabled    voltage     0           1800000
 0           0
LDO31                   disabled    voltage     0           1800000
 0           0
LDO32                   disabled    voltage     0           1800000
 0           0
LDO33                   disabled    voltage     0           1800000
 0           0
LDO34                   disabled    voltage     0           3000000
 0           0
LDO35                   disabled    voltage     0           1600000
 0           0
LDO36                   disabled    voltage     0           1800000
 0           0
LDO37                   disabled    voltage     0           1800000
 0           0
LDO38                   disabled    voltage     0           2800000
 0           0
vdd_mif                 enabled     voltage     0           1100000
 800000      1300000
BUCK1                                           0           0
 0           0
vdd_arm                 enabled     voltage     0           1000000
 800000      1500000
BUCK2                                           0           0
 0           0
vdd_int                 enabled     voltage     0           1000000
 800000      1400000
tmu         okay                                0           0
 0           0
tmu         okay                                0           0
 0           0
tmu         okay                                0           0
 0           0
tmu         okay                                0           0
 0           0
tmu         okay                                0           0
 0           0
BUCK3                                           0           0
 0           0
vdd_g3d                 enabled     voltage     0           1000000
 800000      1400000
BUCK4                                           0           0
 0           0
vdd_mem                 enabled     voltage     0           1200000
 800000      1400000
BUCK5                                           0           0
 0           0
vdd_kfc                 enabled     voltage     0           1025000
 800000      1500000

So I would like to go with LDO7.

Please share your thoughts.

-Anand Moon
