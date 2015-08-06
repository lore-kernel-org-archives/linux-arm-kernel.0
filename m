From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 06 Aug 2015 15:06:21 +0900
Subject: [PATCH-v2 2/2] regulator: 88pm800: Add support for configuration
 of dual phase on BUCK1
In-Reply-To: <55C2F8CC.1010308@linaro.org>
References: <1437495782-15767-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1437495782-15767-3-git-send-email-vaibhav.hiremath@linaro.org>
 <CAJKOXPcMd9VvfA48kaBa0BYeHAfHTu6MzAbQv0HuRy9wbgz0wg@mail.gmail.com>
 <55C1CD47.3060400@linaro.org> <55C2A340.6020809@samsung.com>
 <55C2F8CC.1010308@linaro.org>
Message-ID: <55C2F95D.3060608@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.08.2015 15:03, Vaibhav Hiremath wrote:
> 
> 
> On Thursday 06 August 2015 05:28 AM, Krzysztof Kozlowski wrote:
>> On 05.08.2015 17:45, Vaibhav Hiremath wrote:
>>>
>>>
>>> On Thursday 23 July 2015 10:21 AM, Krzysztof Kozlowski wrote:
>>>> 2015-07-22 1:23 GMT+09:00 Vaibhav Hiremath
>>>> <vaibhav.hiremath@linaro.org>:
>>>>> 88PM860 device supports dual phase mode on BUCK1 output.
>>>>> In normal usecase, BUCK1A and BUCK1B operates independently with 3A
>>>>> capacity. And they both can work as a dual phase providing 6A
>>>>> capacity.
>>>>>
>>>>> This patch updates the regulator driver to read the respective
>>>>> DT property and enable dual-phase mode on BUCK1.
>>>>>
>>>>> Note that, this is init time (one time) initialization.
>>>>>
>>>
>>> Sorry for delayed response, was on bed rest almost for week.
>>>
>>>>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>>>>> ---
>>>>>    drivers/regulator/88pm800.c | 31 +++++++++++++++++++++++++++++++
>>>>>    include/linux/mfd/88pm80x.h |  3 +++
>>>>>    2 files changed, 34 insertions(+)
>>>>
>>>> Don't you need to update the constraints also? I think the BUCK1
>>>> regulator has fixed constraint of 3 A:
>>>>     PM800_BUCK(buck1, BUCK1, BUCK_ENA, 0, 3000000, buck1_volt_range,
>>>> 0x55),
>>>> and now it can handle 6 A.
>>>>
>>>
>>> Actually, BUCK1A and BUCK1B both combined together provide 6A capacity.
>>> And as discussed earlier, we need board change for this.
>>>
>>> I am quite not sure.
>>
>> AFAIU the regulator driver creates one BUCK1 regulator with constraints
>> 3 A. However after your change the regulator will handle up to 6 A.
>>
>> This means that constraints set by driver are wrong.
>>
>> Additionally I can't find BUCK1A and BUCK1B regulators. Driver provides
>> only BUCK1.
>>
> 
> My patch does add BUCK1A and BUCK1B, please refer to the PATCH[4/5] of
> earlier series, which is accepted.
> 
> https://patchwork.kernel.org/patch/6810461/

Indeed.

> 
> 
>>>
>>> Should I read the property and update the constraint runtime during
>>> probe?
>>
>> Driver should provide real constraints. Find the proper way to do this.
>>
>> The pm800_regulator_info[] array is not const so you can change it in
>> whatever way you want (although it should be const for existing driver
>> because regulator core accepts const and passing it to driver_data is
>> not necessary).
>>
> 
> 
> Probably that is the only way to handle this.
> 
> how about,
> 
> As you mentioned, pm800_regulator_info[] is not constant, so I can
> update the constraint before regulator_register() and also do not
> register BUCK1B, if dual phase is enabled.
> 
> So in summary,
> 
> if (dual phase is enabled)
> {
>     Update constraint of BUCK1 to 6A
>     and do not register BUCK1B
> } else {
>     register both BUCK1A and BUCK1B with default constraint of 3A.
> }

This idea looks good to me.

Best regards,
Krzysztof
