From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 25 Jul 2015 22:41:44 +0800
Subject: [PATCH 3/5] ARM: MCPM: make internal helpers private to the core
 code
In-Reply-To: <20150724111557.GJ10670@e103592.cambridge.arm.com>
References: <1430496392-15956-1-git-send-email-nicolas.pitre@linaro.org>
 <1430496392-15956-4-git-send-email-nicolas.pitre@linaro.org>
 <CAGb2v65D7vtuV4kfg0HoM_pp4=UmY29AzpOP=E5WWGM5fPO9XA@mail.gmail.com>
 <20150724111557.GJ10670@e103592.cambridge.arm.com>
Message-ID: <CAGb2v64ZFzyUc-ESc=-AeNPVYMXqRf0QEE3eEq7YOFqUBpvvEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 7:15 PM, Dave Martin <Dave.Martin@arm.com> wrote:
> On Fri, Jul 24, 2015 at 11:54:18AM +0800, Chen-Yu Tsai wrote:
>> Hi,
>>
>> On Sat, May 2, 2015 at 12:06 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>> > This concerns the following helpers:
>> >
>> >         __mcpm_cpu_going_down()
>> >         __mcpm_cpu_down()
>> >         __mcpm_outbound_enter_critical()
>> >         __mcpm_outbound_leave_critical()
>> >         __mcpm_cluster_state()
>> >
>> > They are and should only be used by the core code now.  Therefore their
>> > declarations are removed from mcpm.h and their definitions are made
>> > static, hence the need to move them before their users which accounts
>> > for the bulk of this patch.
>>
>> I'm looking for some advice. On the Allwinner A80, at least on mainline,
>> there is no external PMU or embedded controller in charge of power
>> controls. What this means is that I'm doing power sequencing in the
>> kernel as part of the MCPM calls, specifically powering down cores and
>> clusters in the .wait_for_powerdown callback. (I don't think it's
>> reasonable or even possible to power down stuff in .*_powerdown_prepare)
>>
>> Previously I was using __mcpm_cluster_state() to check if the last core
>> in a cluster was to be powered off, and thus the whole cluster could be
>> turned off as well. I could also check if the individual power gates or
>> resets are asserted, but if a core was already scheduled to be brought
>> up, and MCPM common framework didn't call .cluster_powerup, there might
>> be a problem.
>
> It's been a while since I looked at this stuff in detail, so Nico
> may want to put me right ... but here's my 2 cents:
>
>
> __mcpm_cluster_state() should be considered an implementation detail of
> mcpm.  If you feel you need to call it from your driver code, that's
> a warning that your code is probably racy -- unless you can explain
> otherwise.
>
> When you say you have no external power controller, does this mean
> that you need to poll in Linux for the affected cpus/clusters to reach
> WFI and then hit the relevant clamps, clocks and/or regulators
> yourself?

That's right. Polling a specific register to check for WFI, and gating
the cores. Clocks and external regulators haven't been implemented yet.

(I've also run into a problem where the cores in cluster 0 don't stay
 in WFI, but I think that's probably an implementation bug on my end.)

> If so you're effectively implementing a multithreaded power controller
> in software, suggesting that you need some state tracking and locking
> between the various mcpm methods in your code.  However, you can use
> the normal locking and atomics APIs for this.
>
> Since the MCPM lock is held when calling all the relevant methods
> except for wait_for_powerdown(), this nearly satisfies the locking
> requirement by itself.  You are correct that the hardware operations
> associated with physically powering things down will need to be
> done in wait_for_powerdown() though, and the MCPM lock is not held
> when calling that.

This was my reason for choosing MCPM, not having to handle all the
locking myself.

> This would motivate two solutions that I can see:
>
>  a) Expose the mcpm lock so that driver code can lock/unlock it
>     during critical regions in wait_for_powerdown().

>From a users' standpoint, having to do the locking myself is not
so appealing, as the interactions with the rest of the framework
is not as clear, and an overall view of the framework is lacking
for now.

>  b) Refactor wait_for_powerdown() so that the locking, sleeping
>     and timeout code is moved into the mcpm generic code, and
>     the wait_for_powerdown() method is replaced with something
>     like "cpu_is_powered_down()".

This seems to be reversing some patch? Maybe a new (optional)
callback for people who need this? AFAIK other platforms seem
to have some embedded controller that deals with this.

The A80 actually hase an embedded controller, but no documents
are available, and the original firmware from Allwinner is not
open source. Furthermore, in Allwinner's kernel, the kernel was
in charge of loading the firmware, a bit backwards IMHO.

Thanks!


Regards
ChenYu

> Further to this, this "software power controller" really just maps one
> power sequencing model onto another, so there's a chance it could be
> a generic mcpm driver than can be reused across multiple platforms.
>
> Cheers
> ---Dave
>
