From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Thu, 13 Sep 2012 09:26:52 +0200
Subject: [PATCH 5/7] ARM: OMAP2+: PM debug: trace the functional power
 domains states
In-Reply-To: <874nn2st0m.fsf@deeprootsystems.com>
References: <1347443732-7411-1-git-send-email-j-pihet@ti.com>
 <1347443732-7411-6-git-send-email-j-pihet@ti.com>
 <874nn2st0m.fsf@deeprootsystems.com>
Message-ID: <CAORVsuXTwGcVfda6sSHqHh3hc7E8DPussxAo1J_vEd2p6LHkQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Kevin,

On Thu, Sep 13, 2012 at 1:47 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> Trace the power domain transitions using the functional power states,
>> which include the power and logic states.
>
> Just to be clear, this means that a trace will only contain functional
> power state changes, not logical ones, correct?
Correct! The trace reports functional states, while pr_err and
pr_debug statements (added by patch 6/7) are present for hardcore
debugging on the functional and internal states.

>
>> While at it, fix the trace in the case a power domain did not hit
>> the desired state, as reported by Paul Walmsley.
>
> What was broken here?  needs a bit more description.
Ok will do

> To me it sounds
> like a fix that should be a separate patch.
I kept the fix in this patch since it matches $SUBJECT. Can be split
if needed though.

Thanks for reviewing!
Jean

>
>> Reported-by: Paul Walmsley <paul@pwsan.com>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> ---
>>  arch/arm/mach-omap2/powerdomain.c |   23 +++++++++++++----------
>>  1 files changed, 13 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
>> index 267241f..2277ad3 100644
>> --- a/arch/arm/mach-omap2/powerdomain.c
>> +++ b/arch/arm/mach-omap2/powerdomain.c
>> @@ -144,7 +144,7 @@ static void _update_logic_membank_counters(struct powerdomain *pwrdm)
>>  static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
>>  {
>>
>> -     int prev, state, trace_state = 0;
>> +     int prev, next, state, trace_state;
>>
>>       if (pwrdm == NULL)
>>               return -EINVAL;
>> @@ -165,10 +165,10 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
>>                * If the power domain did not hit the desired state,
>>                * generate a trace event with both the desired and hit states
>>                */
>> -             if (state != prev) {
>> +             next = pwrdm_read_next_fpwrst(pwrdm);
>> +             if (next != prev) {
>>                       trace_state = (PWRDM_TRACE_STATES_FLAG |
>> -                                    ((state & OMAP_POWERSTATE_MASK) << 8) |
>> -                                    ((prev & OMAP_POWERSTATE_MASK) << 0));
>> +                                    (next << 8) | (prev << 0));
>>                       trace_power_domain_target(pwrdm->name, trace_state,
>>                                                 smp_processor_id());
>>               }
>> @@ -723,6 +723,10 @@ int pwrdm_set_fpwrst(struct powerdomain *pwrdm, enum pwrdm_func_state fpwrst)
>>               }
>>       }
>>
>> +     /* Trace the pwrdm desired target state */
>> +     trace_power_domain_target(pwrdm->name, next_fpwrst,
>> +                               smp_processor_id());
>
> Use of smp_processor_id() here will require the same care as pointed out
> by Roger Quadros in [PATCH] perf: Use raw_smp_processor_id insted of
> smp_processor_id.
>
> Kevin
>
>>       if (logic != pwrdm_read_logic_retst(pwrdm))
>>               pwrdm_set_logic_retst(pwrdm, logic);
>>
>> @@ -776,6 +780,10 @@ int pwrdm_set_next_fpwrst(struct powerdomain *pwrdm,
>>
>>       spin_lock_irqsave(&pwrdm->lock, flags);
>>
>> +     /* Trace the pwrdm desired target state */
>> +     trace_power_domain_target(pwrdm->name, fpwrst,
>> +                               smp_processor_id());
>> +
>>       ret = pwrdm_set_logic_retst(pwrdm, logic);
>>       if (ret)
>>               pr_err("%s: unable to set logic state %0x of powerdomain: %s\n",
>> @@ -821,13 +829,8 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
>>       pr_debug("powerdomain: setting next powerstate for %s to %0x\n",
>>                pwrdm->name, pwrst);
>>
>> -     if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst) {
>> -             /* Trace the pwrdm desired target state */
>> -             trace_power_domain_target(pwrdm->name, pwrst,
>> -                                       smp_processor_id());
>> -             /* Program the pwrdm desired target state */
>> +     if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst)
>>               ret = arch_pwrdm->pwrdm_set_next_pwrst(pwrdm, pwrst);
>> -     }
>>
>>       return ret;
>>  }
