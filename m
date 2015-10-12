From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 12 Oct 2015 22:16:14 +0900
Subject: [PATCH 3/3] ARM: dts: exynos5422-odroidxu3: Added UHS-I bus speed
 support
In-Reply-To: <561BAFDF.2090501@samsung.com>
References: <1444578364-1384-1-git-send-email-linux.amoon@gmail.com>
 <1444578364-1384-3-git-send-email-linux.amoon@gmail.com>
 <561B48B7.1040201@samsung.com>
 <CANAwSgSk0yHGvnoVoTk9MnUqjyEw1+yzH=C-1s_wxVkpGRHCEg@mail.gmail.com>
 <561BAAB1.4020203@samsung.com> <561BAFDF.2090501@samsung.com>
Message-ID: <561BB29E.6090109@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 12.10.2015 o 22:04, Jaehoon Chung pisze:
> On 10/12/2015 09:42 PM, Krzysztof Kozlowski wrote:
>> W dniu 12.10.2015 o 19:46, Anand Moon pisze:
>>> Hi Krzysztof,
>>>
>>> On 12 October 2015 at 11:14, Krzysztof Kozlowski
>>> <k.kozlowski@samsung.com> wrote:
>>>> On 12.10.2015 00:46, Anand Moon wrote:
>>>>> Added support for UHS-I bus speed 50MB/s (SDR50, DDR50) 104MB/s (SDR104)
>>>>
>>>> This description is not entirely correct. The MMC driver already
>>>> supports these UHS speeds (you did not any code) so you rather enabled
>>>> it (description of bindings says "is supported").
>>>>
>>>> You mentioned DDR50 but I don't see respective property below.
>>> Looks like I missed it, I will add this in the next patch,
>>>>
>>>> How do you know that these modes are really supported? I don't know. Can
>>>> you convince me?
>>
>> That part was not answered...
> 
> In my experiment, it needs two requirements.
> One is that Host controller supported UHS-I mode or others, other is SD-card.
> In Anand's commit message, there is no information for this.
> 
> And 50MB/s or 104MB/s is not real performance. (Just theoretical values)
> It seems that can get those performances.

Right. But do you know if the host actually supports these?

> 
>>
>>>>
>>>
>>>>>
>>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>>>
>>>>> ---
>>>>> Changes based on git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git v4.4-next/dt-samsung branch
>>>>>
>>>>> Changes Fixed the UHS-I bus speed detedtion on cold boot.
>>>>
>>>> I don't get what is exactly fixed here. What was the error? What is the
>>>> outcome of this fix? The log below is before or after?
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>>>
>>>>> [    2.439806] mmc_host mmc1: Bus speed (slot 0) = 100000000Hz (slot req 100000000Hz, actual 100000000HZ div = 0)
>>>>> [    2.449729] mmc1: new ultra high speed SDR50 SDHC card at address aaaa
>>>>> [    2.455984] mmcblk0: mmc1:aaaa SL32G 29.7 GiB
>>>>> [    2.461743]  mmcblk0: p1 p2
>>>>
>>>>> ---
>>>>>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 4 ++++
>>>>>  1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>>>>> index 58c06d3..ba4a87b 100644
>>>>> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>>>>> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>>>>> @@ -364,6 +364,10 @@
>>>>>       pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
>>>>>       bus-width = <4>;
>>>>>       cap-sd-highspeed;
>>>>> +     sd-uhs-sdr12;
>>>>> +     sd-uhs-sdr25;
>>>>> +     sd-uhs-sdr50;
>>>>> +     sd-uhs-sdr104;
>>>>>  };
>>>>>
>>>>>  &pinctrl_0 {
>>>>>
>>>>
>>>
>>> Changes were made to support Sandisk Ultra UHS-I class 10 card support.
>>> OdroidXU3/XU4 board would not boot up using this card.
>>>
>>> Depending on the capability of the UHS-I card, the speed of the card
>>> is selected.
>>> I have just added the enhance capability feature to support them.
>>
>> So without these capabilities mentioned microSD card cannot be used? So
>> I have a UHS-I card, that one exactly:
>> http://www.samsung.com/us/support/owners/product/MB-MP32D/APC
>>
>> It works:
>> [    2.628365] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req
>> 50000000Hz, actual 50000000HZ div = 0)
>> [    2.693296] mmc1: new high speed SDHC card at address 0001
>> [    2.703867] mmcblk0: mmc1:0001 00000 29.8 GiB
>> [    2.708406]  mmcblk0: p1 p2
>>
>> This is just HS mode.
>>
>> In the same time isn't UHS-I backward compatible? Your report seems
>> surprising.
> 
> Right. it's not issue. just working as lower mode than its capability.

Anand's report mentions "board would not boot up" which seems quite
drastic. :)

Thanks Jaehoon for help in reviewing this patch.


Dear Anand,

Could you describe in more details observable issues, what is fixed or
what feature is added?

Best regards,
Krzysztof

> 
> Best Regards,
> Jaehoon Chung
> 
>>
>> Best regards,
>> Krzysztof
>>
>>>
>>> On warm boot: i.e reboot of the board.
>>> [    4.649073] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot
>>> req 50000000Hz, actual 50000000HZ div = 0)
>>> [    4.657555] mmc1: new high speed SDHC card at address aaaa
>>> [    4.663787] mmcblk0: mmc1:aaaa SL32G 29.7 GiB
>>> [    4.669206]  mmcblk0: p1 p2
>>>
>>> On cold boot:: ie: power on the board.
>>>
>>> [    4.630237] mmc_host mmc1: Bus speed (slot 0) = 100000000Hz (slot
>>> req 100000000Hz, actual 100000000HZ div = 0)
>>> [    4.639820] mmc1: new ultra high speed SDR50 SDHC card at address aaaa
>>> [    4.646266] mmcblk0: mmc1:aaaa SL32G 29.7 GiB
>>> [    4.650293] IRQ56 no longer affine to CPU7
>>> [    4.650581] CPU7: shutdown
>>> [    4.658293]  mmcblk0: p1 p2
>>>
>>> Note: Their is need to reset the PMIC
>>> S2MPS11_REG_L13CTRL/S2MPS11_REG_L19CTRL registers
>>>          to support this feature consistently on every reboot.
>>>
>>> -Anand Moon
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>> the body of a message to majordomo at vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>
>>
> 
