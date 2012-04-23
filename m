From: khilman@ti.com (Kevin Hilman)
Date: Mon, 23 Apr 2012 10:08:01 -0700
Subject: [PATCH 02/17][V2] ARM: OMAP4: cpuidle - Declare the states with
 the driver declaration
In-Reply-To: <4F9561F7.3000306@linaro.org> (Daniel Lezcano's message of "Mon,
 23 Apr 2012 16:06:47 +0200")
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
 <1333570371-1389-3-git-send-email-daniel.lezcano@linaro.org>
 <87vcl8a5wb.fsf@ti.com> <4F901A03.9080000@linaro.org>
 <4F9561F7.3000306@linaro.org>
Message-ID: <878vhml6ku.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> On 04/19/2012 03:58 PM, Daniel Lezcano wrote:
>> On 04/10/2012 12:37 AM, Kevin Hilman wrote:
>>> Daniel Lezcano<daniel.lezcano@linaro.org>  writes:
>>>
>>>> The cpuidle API allows to declare statically the states in the driver
>>>> structure. Let's use it.
>>>> We do no longer need the fill_cstate function called at runtime and
>>>> by the way adding more instructions at boot time.
>>>>
>>>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>>>> Reviewed-by: Jean Pihet<j-pihet@ti.com>
>>>> Reviewed-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>>> ---
>>>>   arch/arm/mach-omap2/cpuidle44xx.c |   57
>>>> +++++++++++++++++++++---------------
>>>>   1 files changed, 33 insertions(+), 24 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c
>>>> b/arch/arm/mach-omap2/cpuidle44xx.c
>>>> index ee0bc50..6d86b59 100644
>>>> --- a/arch/arm/mach-omap2/cpuidle44xx.c
>>>> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
>>>> @@ -132,21 +132,39 @@ struct cpuidle_driver omap4_idle_driver = {
>>>>       .name                = "omap4_idle",
>>>>       .owner                = THIS_MODULE,
>>>>       .en_core_tk_irqen        = 1,
>>>> +    .states = {
>>>> +        {
>>>> +            /* C1 - CPU0 ON + CPU1 ON + MPU ON */
>>>> +            .exit_latency = 2 + 2,
>>>> +            .target_residency = 5,
>>>> +            .flags = CPUIDLE_FLAG_TIME_VALID,
>>>> +            .enter = omap4_enter_idle,
>>>> +            .name = "C1",
>>>> +            .desc = "MPUSS ON"
>>>> +        },
>>>> +        {
>>>> +                        /* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */
>>>> +            .exit_latency = 328 + 440,
>>>> +            .target_residency = 960,
>>>> +            .flags = CPUIDLE_FLAG_TIME_VALID,
>>>> +            .enter = omap4_enter_idle,
>>>> +            .name = "C2",
>>>> +            .desc = "MPUSS CSWR",
>>>> +        },
>>>> +        {
>>>> +            /* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
>>>> +            .exit_latency = 460 + 518,
>>>> +            .target_residency = 1100,
>>>> +            .flags = CPUIDLE_FLAG_TIME_VALID,
>>>> +            .enter = omap4_enter_idle,
>>>> +            .name = "C3",
>>>> +            .desc = "MPUSS OSWR",
>>>> +        },
>>>> +    },
>>>> +    .state_count = OMAP4_NUM_STATES,
>>>
>>> I think you can drop OMAP4_NUM_STATES here, and just use:
>>>
>>>     .state_count = ARRAY_SIZE(omap4_idle_driver.states),
>>>
>>> Then drop OMAP4_NUM_STATES all together in patch 3.
>>
>> Ok.
>
> I said 'ok' but it is not :)
>
> omap4_idle_driver.states has a fixed length which is CPUIDLE_STATE_MAX (8).
> We need to define it manually as 3 for now.

I don't see the connection between the two.

Why can't you use ARRAY_SIZE(), and just have an error check later in
the init to see if state_count > max.

Kevin
