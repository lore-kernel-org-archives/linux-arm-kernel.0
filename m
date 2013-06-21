From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 21 Jun 2013 16:48:08 +0200
Subject: [PATCH] at91: cpuidle: Fix target_residency
In-Reply-To: <51C4539B.3020506@linaro.org>
References: <1371818219-13060-1-git-send-email-daniel.lezcano@linaro.org>
 <51C45320.8090102@atmel.com> <51C4539B.3020506@linaro.org>
Message-ID: <51C467A8.60303@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/06/2013 15:22, Daniel Lezcano :
> On 06/21/2013 03:20 PM, Nicolas Ferre wrote:
>> On 21/06/2013 14:36, Daniel Lezcano :
>>> The following commit:
>>>
>>> commit 7e348b9012522fa0efd854d20d210d5e57fcedd1
>>> Author: Robert Lee <rob.lee@linaro.org>
>>> Date:   Tue Mar 20 15:22:43 2012 -0500
>>>
>>>       ARM: at91: Consolidate time keeping and irq enable
>>>
>>>       Enable core cpuidle timekeeping and irq enabling and remove that
>>>       handling from this code.
>>>
>>> introduced a zero to the state1 (suspend) target residency.
>>>
>>> [ ... ]
>>>
>>> +       .states[1]              = {
>>> +               .enter                  = at91_enter_idle,
>>> +               .exit_latency           = 10,
>>> +               .target_residency       = 100000,
>>> +               .flags                  = CPUIDLE_FLAG_TIME_VALID,
>>> +               .name                   = "RAM_SR",
>>> +               .desc                   = "WFI and DDR Self Refresh",
>>> +       },
>>>
>>> [ ... ]
>>>
>>> -       /* Wait for interrupt and RAM self refresh state */
>>> -       driver->states[1].enter = at91_enter_idle;
>>> -       driver->states[1].exit_latency = 10;
>>> -       driver->states[1].target_residency = 10000;
>>> -       driver->states[1].flags = CPUIDLE_FLAG_TIME_VALID;
>>> -       strcpy(driver->states[1].name, "RAM_SR");
>>> -       strcpy(driver->states[1].desc, "WFI and RAM Self Refresh");
>>>
>>> [ ... ]
>>>
>>> The cpuidle never enters this state since this commit.
>
> To be a bit more precise. With a periodic tick, the cpu never enters the
> state1 with both 10000 and 100000.
>
> With a tickless system, it enters to state1 much more often with the
> initial value, roughly x7 more.

BTW Daniel, I think I can stack this patch on my fixes-non-critical 
branch for 3.11: do you think that I should push for making it accepted 
for 3.10 (even if it seems very late)?

> BTW, I am surpised with a sam926*, CONFIG_NO_HZ=y is not in the default
> config.

Yes, indeed: we have to consider it.

Best regards,

>>> Fix it by setting the value to 10ms again.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>>
>>> ---
>>>    arch/arm/mach-at91/cpuidle.c |    2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
>>> index 69f9e3b..4ec6a6d 100644
>>> --- a/arch/arm/mach-at91/cpuidle.c
>>> +++ b/arch/arm/mach-at91/cpuidle.c
>>> @@ -51,7 +51,7 @@ static struct cpuidle_driver at91_idle_driver = {
>>>        .states[1]        = {
>>>            .enter            = at91_enter_idle,
>>>            .exit_latency        = 10,
>>> -        .target_residency    = 100000,
>>> +        .target_residency    = 10000,
>>>            .flags            = CPUIDLE_FLAG_TIME_VALID,
>>>            .name            = "RAM_SR",
>>>            .desc            = "WFI and DDR Self Refresh",
>>>
>>
>>
>
>


-- 
Nicolas Ferre
