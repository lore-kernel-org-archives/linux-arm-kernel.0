From: rob.lee@linaro.org (Rob Lee)
Date: Tue, 24 Jan 2012 18:46:31 -0600
Subject: [PATCH v3 0/7] Add common cpuidle code for consolidation.
In-Reply-To: <871uqoj23b.fsf@ti.com>
References: <1327379854-12403-1-git-send-email-rob.lee@linaro.org>
 <871uqoj23b.fsf@ti.com>
Message-ID: <CAMXH7KGeVtvW7ciHrDuK_a6b396RUXnU4eWb26nNMSk1jsDkyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2012 at 2:08 PM, Kevin Hilman <khilman@ti.com> wrote:
> Robert Lee <rob.lee@linaro.org> writes:
>
>> This patch series adds a new common cpuidle interface to consolidate code
>> commonly duplicated by various platforms. ?A patch was then made for each
>> platform that could immediately take advantage of this code. ?The platform
>> specific changes are not required by the common code and are only made for
>> consoldation.
>
> I noticed that the generic code uses ktime_get() for measuring time. ?On
> OMAP, we use getnstimeofday() because I while back I remember having
> problems with the interaction of CPUidle state measurements and system
> suspend. ?Any idle activity during system suspend/resume ktime_get()
> will WARN() because the timekeeping system has been suspended.
>

When I originally looked at which time mechanism to use, I convinced
myself that use getnstimeofday() on an SMP system could be susceptible
to error (or require extra handling) in the case whee a call was made
to do_settimeofday by another CPU that wasn't idle.  That seemed to
leave get_monotonic_bootime() or ktime_get().  Off the top of my head,
I don't remember how I settled on ktime_get, but get_monotonic_bootime
will try to account for "suspend" time. I'll look into this further.

> Off the top of my head, I don't remember the interactions that triggered
> this, but I guess all it would require the idle loop to be entered after
> the syscore_ops->suspend for the timekeeping subsystem (and before the
> syscore_ops ->resume.)
>
> Depending on what syscore_ops are registered, this could be rather
> platforms specific.
>
>> Maintainers and cpuidle idle developers of these platforms, please check to make
>> sure that you agree with the changes.
>
> In earlier version you mentioned that OMAP didn't quite fit the
> pattern. ?Do you have any suggestions for how to make OMAP fit.

Many platforms are only performing very basic idle operations and the
time keeping and interrupt disabling/enabling could be made into a
common wrapper.  But OMAP3 isn't that simple and so benefits by
performing its own time accounting to accurately account for only the
idle time (not the idle preparation time).  I think that's OK as the
current cpuidle functionality allows for this flexibility.  The less
flexible common code is just to remove unnecessary code duplication
that exists on several simpler idle implementations.  That said, I
could still look at using the common_cpuidle_init for OMAP3 to make
dynamically allocated driver and device objects and just not use
simple_enter.

I either missed OMAP4 implementation or it wasn't in the kernel
version I was using at the time.  It appears that the simple_enter
could be used for OMAP4 in its current form, though I think the
current implementation accounts for some "idle preparation" time that
perhaps it doesn't need to? (and thus shouldn't use the common
simple_enter).  Perhaps this amount of time is small enough that you
don't care about it or perhaps this is done to avoid time keeping
issues causes by the timer being disabled.  But it seems the current
OMAP4 implementation is only enabling cpuidle for one CPU?  The
current common_cpuidle_init expects o will create and register a
cpuidle_device for each cpu.  Perhaps that is not what you want?

>
>> Besides just code consolidation, a
>> default "WFI" state is now used with default parameters that different from your
>> original paramenters. The assumption is that if you have a WFI only idle state,
>> the parameters in the new default WFI are more realistic as a true WFI only
>> hardware state incurs minimal latency(<1us) or power penalty to enter and exit.
>> If your platform actually performs other platform specific functionality upon
>> entering WFI and the default parameters do not accurately reflect the
>> exit_latency and target_residency given in the common default state, please
>> say so.
>
> I'm not sure what you mean by "WFI only". ?On OMAP, WFI is the entry
> point for all the idle states, with varying latencies. ?The latencies
> are then dependent on how the states are programmed for the various
> power domains. ?Upon WFI, the hardware then takes over puts the
> powerdomains to their programmed states.
>

This text was just to describe the extra macro I threw in for use by
systems with a state that only performs the very basic ARM WFI
available to all (or most modern) ARM archs, sans any additional
platform specific functionality that may cause additional exit latency
or target residency time beyond the defaults I used for that macro.

> Kevin
