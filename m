From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 21 Mar 2012 15:12:31 +0100
Subject: [RFC][PATCH 2/7] ARM: OMAP4: cpuidle - Declare the states with
 the driver declaration
In-Reply-To: <CAORVsuV-0xQx6W0iKGO_UduESFwdD-44vsBAcVXD0Yy-VB_eGw@mail.gmail.com>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
 <1332322070-24577-3-git-send-email-daniel.lezcano@linaro.org>
 <CAORVsuV-0xQx6W0iKGO_UduESFwdD-44vsBAcVXD0Yy-VB_eGw@mail.gmail.com>
Message-ID: <4F69E1CF.8030703@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2012 02:31 PM, Jean Pihet wrote:
> On Wed, Mar 21, 2012 at 10:27 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org>  wrote:
>> The cpuidle API allows to declare statically the states in the driver
>> structure. Let's use it.
>> We do no longer need the fill_cstate function called at runtime and
>> by the way adding more instructions at boot time.
>>
>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>> ---
>>   arch/arm/mach-omap2/cpuidle44xx.c |   56 +++++++++++++++++++++----------------
>>   1 files changed, 32 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
>> index 1210229..cd6bee7 100644
>> --- a/arch/arm/mach-omap2/cpuidle44xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
>> @@ -148,21 +148,38 @@ DEFINE_PER_CPU(struct cpuidle_device, omap4_idle_dev);
>>   struct cpuidle_driver omap4_idle_driver = {
>>         .name =         "omap4_idle",
>>         .owner =        THIS_MODULE,
>> +       .states = {
>> +               {
>> +                       /* C1 - CPU0 ON + CPU1 ON + MPU ON */
>> +                       .exit_latency = 2 + 2,
>> +                       .target_residency = 5,
>> +                       .flags = CPUIDLE_FLAG_TIME_VALID,
>> +                       .enter = omap4_enter_idle,
>> +                       .name = "C1",
>> +                       .desc = "MPUSS ON"
>> +               },
> ...
>> +       },
>> +       .state_count = OMAP4_NUM_STATES,
>>   };
>>
>> -static inline void _fill_cstate(struct cpuidle_driver *drv,
>> -                                       int idx, const char *descr)
>> -{
>> -       struct cpuidle_state *state =&drv->states[idx];
>> -
>> -       state->exit_latency     = cpuidle_params_table[idx].exit_latency;
>> -       state->target_residency = cpuidle_params_table[idx].target_residency;
>> -       state->flags            = CPUIDLE_FLAG_TIME_VALID;
>> -       state->enter            = omap4_enter_idle;
>> -       sprintf(state->name, "C%d", idx + 1);
>> -       strncpy(state->desc, descr, CPUIDLE_DESC_LEN);
>> -}
> I am OK with this change, which makes the code more readable (and so
> maintainable).
>
>> -
>>   static inline struct omap4_idle_statedata *_fill_cstate_usage(
>>                                         struct cpuidle_device *dev,
>>                                         int idx)
>> @@ -196,37 +213,28 @@ int __init omap4_idle_init(void)
>>         if ((!mpu_pd) || (!cpu0_pd) || (!cpu1_pd))
>>                 return -ENODEV;
>>
>> -
>> -       drv->safe_state_index = -1;
>>         dev =&per_cpu(omap4_idle_dev, cpu_id);
>>         dev->cpu = cpu_id;
>>
>> -       /* C1 - CPU0 ON + CPU1 ON + MPU ON */
>> -       _fill_cstate(drv, 0, "MPUSS ON");
>> -       drv->safe_state_index = 0;
> I would keep this or add a clear comment that C1 is the safe state.

Actually with the driver's states declaration, the safe_state_index is 
initialized to zero, which means the default safe_state is always 0 with 
the new API. But I can add the initialization anyway in the structure 
declaration if you want.

> ...
>
> Thanks,
> Jean
>
>> --
>> 1.7.5.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
