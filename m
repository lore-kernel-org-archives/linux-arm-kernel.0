From: rob.lee@linaro.org (Rob Lee)
Date: Tue, 28 Feb 2012 09:50:56 -0600
Subject: [PATCH v5 1/9] cpuidle: Add commonly used functionality for
 consolidation
In-Reply-To: <CAJOA=zNZ2xh34DTZc1gJwy0O6d=E=wdP4_sq_zrj3qjLcbj0kw@mail.gmail.com>
References: <1330318063-25460-1-git-send-email-rob.lee@linaro.org>
 <1330318063-25460-2-git-send-email-rob.lee@linaro.org>
 <CAJOA=zNZ2xh34DTZc1gJwy0O6d=E=wdP4_sq_zrj3qjLcbj0kw@mail.gmail.com>
Message-ID: <CAMXH7KFbH2HFwFgMu+XfrFKSEGTvD_H09EN2atHUJa9pz7ESYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 6:49 PM, Turquette, Mike <mturquette@ti.com> wrote:
> On Sun, Feb 26, 2012 at 8:47 PM, Robert Lee <rob.lee@linaro.org> wrote:
>> +/**
>> + * cpuidle_enter_wrap - performing timekeeping and irq around enter function
>> + * @dev: pointer to a valid cpuidle_device object
>> + * @drv: pointer to a valid cpuidle_driver object
>> + * @index: index of the target cpuidle state.
>> + */
>> +static inline int cpuidle_wrap_enter(struct cpuidle_device *dev,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct cpuidle_driver *drv, int index,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? int (*enter)(struct cpuidle_device *dev,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct cpuidle_driver *drv, int index))
>> +{
>> + ? ? ? ktime_t time_start, time_end;
>> + ? ? ? s64 diff;
>> +
>> + ? ? ? time_start = ktime_get();
>> +
>> + ? ? ? index = enter(dev, drv, index);
>> +
>> + ? ? ? time_end = ktime_get();
>> +
>> + ? ? ? local_irq_enable();
>> +
>> + ? ? ? diff = ktime_to_us(ktime_sub(time_end, time_start));
>> + ? ? ? if (diff > INT_MAX)
>> + ? ? ? ? ? ? ? diff = INT_MAX;
>> +
>> + ? ? ? dev->last_residency = (int) diff;
>> +
>> + ? ? ? return index;
>> +}
>
> Hi Rob,
>
> In a previous series I brought up the idea of not accounting for time
> if a C-state transition fails. ?My post on that thread can be found
> here:
> http://article.gmane.org/gmane.linux.ports.arm.kernel/149293/
>
> How do you feel about adding something like the following?
>
> if (IS_ERR(index))
> ? ? ? ?dev->last_residency = 0;
> ? ? ? ?return index;
>
> Obviously it will up to the platforms to figure out how to propagate
> that error up from their respective low power code.

To be completely clear on what you're asking for, from
cpuidle_idle_call in drivers/cpuidle/cpuidle.c:

...
	target_state = &drv->states[next_state];

	trace_power_start(POWER_CSTATE, next_state, dev->cpu);
	trace_cpu_idle(next_state, dev->cpu);

	entered_state = target_state->enter(dev, drv, next_state);

	trace_power_end(dev->cpu);
	trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);

	if (entered_state >= 0) {
		/* Update cpuidle counters */
		/* This can be moved to within driver enter routine
		 * but that results in multiple copies of same code.
		 */
		dev->states_usage[entered_state].time +=
				(unsigned long long)dev->last_residency;
		dev->states_usage[entered_state].usage++;
	}
...

Note the "if (entered_state >= 0)".  This ultimately prevents the
cpuidle device time accounting upon an negative value being returned.
So are you asking for the if(IS_ERR(index)) check to prevent the
unnecessary last_residency time calculation in the wrapper, or to make
sure a last_residency is zero upon failure?  (or both?)

It seems like a bug (or lack or documentation at best) in the code
that exists today to not zero out dev->last_residency upon a negative
return value as this value is used by the governors upon the next
idle.  So to ensure last_residency is 0 upon failure, I think it'd be
best to add that to an new else statement immediately following the
"if (entered_state >=))" so that any platform cpuidle driver that
returns a negative will have the last_residency zeroed out, not just
those that use en_core_tk_irqen.

>
> Regards,
> Mike
