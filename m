From: rob.lee@linaro.org (Rob Lee)
Date: Mon, 6 Feb 2012 10:38:48 -0600
Subject: [RFC PATCH v4 1/4] cpuidle: Add time keeping and irq enabling
In-Reply-To: <CAJOA=zOhKtt5GohHfYp6=xVTODR2a_RGkDNTwozbusrBSsqE+w@mail.gmail.com>
References: <1328065215-28108-1-git-send-email-rob.lee@linaro.org>
 <1328065215-28108-2-git-send-email-rob.lee@linaro.org>
 <CAMbhsRQxgvRN0skteFxeDBqmUArTa3wu2uZPqowDnBTSWuqScg@mail.gmail.com>
 <CAJOA=zOhKtt5GohHfYp6=xVTODR2a_RGkDNTwozbusrBSsqE+w@mail.gmail.com>
Message-ID: <CAMXH7KEDkXsmAn6kfcN4XtWCYjWhCONqRH141vdYutZ6ykDmXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 4, 2012 at 4:06 PM, Turquette, Mike <mturquette@ti.com> wrote:
> On Sat, Feb 4, 2012 at 11:02 AM, Colin Cross <ccross@google.com> wrote:
>> On Tue, Jan 31, 2012 at 7:00 PM, Robert Lee <rob.lee@linaro.org> wrote:
>>> Make necessary changes to add implement time keepign and irq enabling
>> keeping
>>> in the core cpuidle code. ?This will allow the remove of these
>>> functionalities from the platform cpuidle implementations.
>>>
>>> Signed-off-by: Robert Lee <rob.lee@linaro.org>
>>> ---
>>> ?drivers/cpuidle/cpuidle.c | ? 75 +++++++++++++++++++++++++++++++++++---------
>>> ?include/linux/cpuidle.h ? | ? 26 ++++++++++-----
>>> ?2 files changed, 76 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>>> index 59f4261..8ea0fc3 100644
>>> --- a/drivers/cpuidle/cpuidle.c
>>> +++ b/drivers/cpuidle/cpuidle.c
>>> @@ -57,14 +57,18 @@ static int __cpuidle_register_device(struct cpuidle_device *dev);
>>> ?* cpuidle_idle_call - the main idle loop
>>> ?*
>>> ?* NOTE: no locks or semaphores should be used here
>>> + * NOTE: Should only be called from a local irq disabled context
>>> ?* return non-zero on failure
>>> + *
>>> ?*/
>>> ?int cpuidle_idle_call(void)
>>> ?{
>>> ? ? ? ?struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
>>> ? ? ? ?struct cpuidle_driver *drv = cpuidle_get_driver();
>>> ? ? ? ?struct cpuidle_state *target_state;
>>> - ? ? ? int next_state, entered_state;
>>> + ? ? ? int idx, ret = 0;
>>> + ? ? ? ktime_t t1, t2;
>>> + ? ? ? s64 diff;
>>>
>>> ? ? ? ?if (off)
>>> ? ? ? ? ? ? ? ?return -ENODEV;
>>> @@ -86,37 +90,76 @@ int cpuidle_idle_call(void)
>>> ?#endif
>>>
>>> ? ? ? ?/* ask the governor for the next state */
>>> - ? ? ? next_state = cpuidle_curr_governor->select(drv, dev);
>>> + ? ? ? idx = cpuidle_curr_governor->select(drv, dev);
>>> +
>>> + ? ? ? target_state = &drv->states[idx];
>>> +
>>> + ? ? ? /*
>>> + ? ? ? ?* Check with the device to see if it can enter this state or if another
>>> + ? ? ? ?* state should be used.
>>> + ? ? ? ?*/
>>> + ? ? ? if (target_state->pre_enter) {
>>> + ? ? ? ? ? ? ? idx = target_state->
>>> + ? ? ? ? ? ? ? ? ? ? ? pre_enter(dev, drv, idx);
>> Unnecessary line wrap and braces.
>>
>> What's the point of the pre_enter call? ?This seems very similar to
>> the prepare call that was removed in 3.2. ?Drivers can already demote
>
> Hi Colin,
>
> I asked Rob to re-introduce the .prepare callback (not .pre_enter).
>
> The short version of why I requested this is so that I can experiment
> with modifying wake-up latency and theshold values dynamically based
> on PM QoS constraints. ?For an OMAP-specific example, I'd like to see
> our C-states no longer model both MPU and CORE power domains, and
> instead only model the MPU. ?Then when entering idle the PM QoS
> constraints against the CORE power domain's wake-up latency can be
> considered in the .prepare callback which will affect the C-state
> parameters as well as program the CORE low power target state.
>
> .pre_enter isn't really right for the above case so I'm happy for it
> to be dropped, but I'll probably re-introduce something like .prepare
> in the future...
>

Hey Mike, yes, this pre_enter has it's own purpose that appears
separate from the reasoning for the prepare function you mention here.
 Perhaps it would be best to re-add the prepare function and make use
of it in the OMAP code all in one patch series so that it doesn't get
removed again due to apparent lack of use in the upstream kernel.  I'm
sure we'll discuss it further this week in person.

> Regards,
> Mike
>
>> the target state in their enter call. ?The only thing you do between
>> pre_enter and enter is trace and account for the time. ?Is there some
>> long call you don't want included in the idle time? ?Some
>> documentation would help, and you need to very clearly define the
>> semantics of when post_enter gets called when pre_enter or enter
>> return errors.
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
