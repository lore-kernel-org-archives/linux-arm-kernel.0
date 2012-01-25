From: khilman@ti.com (Kevin Hilman)
Date: Wed, 25 Jan 2012 10:58:44 -0800
Subject: [PATCH v3 0/7] Add common cpuidle code for consolidation.
In-Reply-To: <CAMXH7KGeVtvW7ciHrDuK_a6b396RUXnU4eWb26nNMSk1jsDkyw@mail.gmail.com>
 (Rob Lee's message of "Tue, 24 Jan 2012 18:46:31 -0600")
References: <1327379854-12403-1-git-send-email-rob.lee@linaro.org>
 <871uqoj23b.fsf@ti.com>
 <CAMXH7KGeVtvW7ciHrDuK_a6b396RUXnU4eWb26nNMSk1jsDkyw@mail.gmail.com>
Message-ID: <87fwf3ehi3.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Lee <rob.lee@linaro.org> writes:

> On Tue, Jan 24, 2012 at 2:08 PM, Kevin Hilman <khilman@ti.com> wrote:
>> Robert Lee <rob.lee@linaro.org> writes:
>>
>>> This patch series adds a new common cpuidle interface to consolidate code
>>> commonly duplicated by various platforms. ?A patch was then made for each
>>> platform that could immediately take advantage of this code. ?The platform
>>> specific changes are not required by the common code and are only made for
>>> consoldation.
>>
>> I noticed that the generic code uses ktime_get() for measuring time. ?On
>> OMAP, we use getnstimeofday() because I while back I remember having
>> problems with the interaction of CPUidle state measurements and system
>> suspend. ?Any idle activity during system suspend/resume ktime_get()
>> will WARN() because the timekeeping system has been suspended.
>>
>
> When I originally looked at which time mechanism to use, I convinced
> myself that use getnstimeofday() on an SMP system could be susceptible
> to error (or require extra handling) in the case whee a call was made
> to do_settimeofday by another CPU that wasn't idle.  That seemed to
> leave get_monotonic_bootime() or ktime_get().  Off the top of my head,
> I don't remember how I settled on ktime_get, but get_monotonic_bootime
> will try to account for "suspend" time. I'll look into this further.

It might be the case now that with syscore_ops, the timekeeping
suspend/resume is happening early enought that the system will not go
idle before the syscore_ops are done, so you would never see this WARN.
That being said,  any platforms that add syscore_ops could introduce
callbacks that could potentially allow a CPU to hit idle, and you'd get
this WARN from the timekeeping susbystem.

>> Off the top of my head, I don't remember the interactions that triggered
>> this, but I guess all it would require the idle loop to be entered after
>> the syscore_ops->suspend for the timekeeping subsystem (and before the
>> syscore_ops ->resume.)
>>
>> Depending on what syscore_ops are registered, this could be rather
>> platforms specific.
>>
>>> Maintainers and cpuidle idle developers of these platforms, please check to make
>>> sure that you agree with the changes.
>>
>> In earlier version you mentioned that OMAP didn't quite fit the
>> pattern. ?Do you have any suggestions for how to make OMAP fit.
>
> Many platforms are only performing very basic idle operations and the
> time keeping and interrupt disabling/enabling could be made into a
> common wrapper.  But OMAP3 isn't that simple and so benefits by
> performing its own time accounting to accurately account for only the
> idle time (not the idle preparation time).  I think that's OK as the
> current cpuidle functionality allows for this flexibility.  The less
> flexible common code is just to remove unnecessary code duplication
> that exists on several simpler idle implementations.  That said, I
> could still look at using the common_cpuidle_init for OMAP3 to make
> dynamically allocated driver and device objects and just not use
> simple_enter.
>
> I either missed OMAP4 implementation or it wasn't in the kernel
> version I was using at the time.  It appears that the simple_enter
> could be used for OMAP4 in its current form, though I think the
> current implementation accounts for some "idle preparation" time that
> perhaps it doesn't need to? (and thus shouldn't use the common
> simple_enter).  Perhaps this amount of time is small enough that you
> don't care about it or perhaps this is done to avoid time keeping
> issues causes by the timer being disabled.  But it seems the current
> OMAP4 implementation is only enabling cpuidle for one CPU?  The
> current common_cpuidle_init expects o will create and register a
> cpuidle_device for each cpu.  Perhaps that is not what you want?

For current mainline, that is what we want.   Since the CPUs are coupled
(in a cluster), they cannot hit low power states independently.  The way
it is currently implemented in mainline is that CPUidle will not take
effect until one of the CPUs is hot-unplugged.

However, we want to get away from this to a more fine-grained approach.
Colin Cross has proposed support for coupled cpuidle states[1] which
will allow more flexibility in supporting idle states for coupled CPUs.
This is the direction we are going for OMAP4.

Kevin

[1] http://marc.info/?l=linux-omap&m=132442632512812&w=2
