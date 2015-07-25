From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 25 Jul 2015 22:54:13 +0800
Subject: [PATCH 3/5] ARM: MCPM: make internal helpers private to the core
 code
In-Reply-To: <alpine.LFD.2.20.1507241109050.1806@knanqh.ubzr>
References: <1430496392-15956-1-git-send-email-nicolas.pitre@linaro.org>
 <1430496392-15956-4-git-send-email-nicolas.pitre@linaro.org>
 <CAGb2v65D7vtuV4kfg0HoM_pp4=UmY29AzpOP=E5WWGM5fPO9XA@mail.gmail.com>
 <alpine.LFD.2.20.1507241109050.1806@knanqh.ubzr>
Message-ID: <CAGb2v64KiT93nzbn04YXh8djHFpWgf0LOikScmKdou+EwimKFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 11:44 PM, Nicolas Pitre
<nicolas.pitre@linaro.org> wrote:
> On Fri, 24 Jul 2015, Chen-Yu Tsai wrote:
>
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
>
> Can you tell me more about the power control knobs at your disposal?  Do
> power gates become effective immediately or only when WFI is asserted?
>
> And can you configure things so a core may be powered up asynchronously
> from an IRQ?

The above probably wasn't clear enough. Power gates, reset controls and
SMP/WFI/WFE status are mapped to various mmio registers. The controls
are effective immediately.

The power gates and reset controls can only be manually controlled.
There is no mainline support for the embedded controller yet, and I
doubt Allwinner's firmware supports it either, as their kernel also
does power sequencing itself. In a nutshell, the kernel is on its
own, we do not support wakeups with IRQs.

>> Previously I was using __mcpm_cluster_state() to check if the last core
>> in a cluster was to be powered off, and thus the whole cluster could be
>> turned off as well.
>> I could also check if the individual power gates or
>> resets are asserted, but if a core was already scheduled to be brought
>> up, and MCPM common framework didn't call .cluster_powerup, there might
>> be a problem.
>
> I fail to see how a core could be scheduled to be brought up without
> deasserting its reset line somehow though.

My point is could there be a race condition in the sequence of events?
Say .*_powerup() deasserted the reset lines _after_ we checked them
in .wait_for_powerdown(). As Dave mentioned, .wait_for_powerdown() is
not called with the MCPM lock held.

But I've resolved to waiting for L2 WFI before powering off clusters.

>> Any suggestions? Maybe export __mcpm_cluster_state() so platform code
>> can know what's going to happen?
>
> The cluster state may change unexpectedly.  There is a special locking
> sequence and state machine needed to make this information reliable.
> Simply returning the current state wouldn't be enough to ensure
> it can be used race free.

I see.

> As Dave stated, we might have to supplement the MCPM core code with
> special methods involving a surviving CPU to perform the power-down
> operation on the dying CPU's behalf.  Doing this in .wait_for_powerdown
> is just an abuse of the API.

The other users I looked at all had other pieces of hardware taking care
of this, so I couldn't really understand where I could put this.

If adding another callback to handle this is acceptable, then I can
look into it.

> It also brings up the question if MCPM is actually necessary in that
> case or if you can do without its complexity.  For example, you may look
> at commit 905cdf9dda5d for such a case.  It mainly depends on whether or
> not cores (and the cluster) may be awaken asynchronously upon assertion
> of an IRQ in the context of cpuidle. If the hardware doesn't support
> that then MCPM doesn't bring you any actual benefit.
>
> So it depends on your hardware capabilities.

If they're just in WFI, then yes (I think). If they're powered down, they
need surviving cores to power them up.

But I had the impression that MCPM was trying to host common code for
multi-cluster management, such as core reference counting, proper locking
and maybe other stuff. With the MCPM framework, I reimplemented SMP
bringup and CPU hotplugging on the A80 with just half of LOC compared to
Allwinner's implementation, which is just a variation of another
platform's custom MCPM code.


Regards
ChenYu
