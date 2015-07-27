From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 27 Jul 2015 00:43:28 -0400 (EDT)
Subject: [PATCH 3/5] ARM: MCPM: make internal helpers private to the core
 code
In-Reply-To: <CAGb2v64KiT93nzbn04YXh8djHFpWgf0LOikScmKdou+EwimKFg@mail.gmail.com>
References: <1430496392-15956-1-git-send-email-nicolas.pitre@linaro.org>
 <1430496392-15956-4-git-send-email-nicolas.pitre@linaro.org>
 <CAGb2v65D7vtuV4kfg0HoM_pp4=UmY29AzpOP=E5WWGM5fPO9XA@mail.gmail.com>
 <alpine.LFD.2.20.1507241109050.1806@knanqh.ubzr>
 <CAGb2v64KiT93nzbn04YXh8djHFpWgf0LOikScmKdou+EwimKFg@mail.gmail.com>
Message-ID: <alpine.LFD.2.20.1507270004440.1806@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 25 Jul 2015, Chen-Yu Tsai wrote:

> On Fri, Jul 24, 2015 at 11:44 PM, Nicolas Pitre
> <nicolas.pitre@linaro.org> wrote:
> > On Fri, 24 Jul 2015, Chen-Yu Tsai wrote:
> >
> >> Hi,
> >>
> >> On Sat, May 2, 2015 at 12:06 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> >> > This concerns the following helpers:
> >> >
> >> >         __mcpm_cpu_going_down()
> >> >         __mcpm_cpu_down()
> >> >         __mcpm_outbound_enter_critical()
> >> >         __mcpm_outbound_leave_critical()
> >> >         __mcpm_cluster_state()
> >> >
> >> > They are and should only be used by the core code now.  Therefore their
> >> > declarations are removed from mcpm.h and their definitions are made
> >> > static, hence the need to move them before their users which accounts
> >> > for the bulk of this patch.
> >>
> >> I'm looking for some advice. On the Allwinner A80, at least on mainline,
> >> there is no external PMU or embedded controller in charge of power
> >> controls. What this means is that I'm doing power sequencing in the
> >> kernel as part of the MCPM calls, specifically powering down cores and
> >> clusters in the .wait_for_powerdown callback. (I don't think it's
> >> reasonable or even possible to power down stuff in .*_powerdown_prepare)
> >
> > Can you tell me more about the power control knobs at your disposal?  Do
> > power gates become effective immediately or only when WFI is asserted?
> >
> > And can you configure things so a core may be powered up asynchronously
> > from an IRQ?
> 
> The above probably wasn't clear enough. Power gates, reset controls and
> SMP/WFI/WFE status are mapped to various mmio registers. The controls
> are effective immediately.
> 
> The power gates and reset controls can only be manually controlled.
> There is no mainline support for the embedded controller yet, and I
> doubt Allwinner's firmware supports it either, as their kernel also
> does power sequencing itself. In a nutshell, the kernel is on its
> own, we do not support wakeups with IRQs.
> 
> >> Previously I was using __mcpm_cluster_state() to check if the last core
> >> in a cluster was to be powered off, and thus the whole cluster could be
> >> turned off as well.
> >> I could also check if the individual power gates or
> >> resets are asserted, but if a core was already scheduled to be brought
> >> up, and MCPM common framework didn't call .cluster_powerup, there might
> >> be a problem.
> >
> > I fail to see how a core could be scheduled to be brought up without
> > deasserting its reset line somehow though.
> 
> My point is could there be a race condition in the sequence of events?
> Say .*_powerup() deasserted the reset lines _after_ we checked them
> in .wait_for_powerdown(). As Dave mentioned, .wait_for_powerdown() is
> not called with the MCPM lock held.

In theory this should never happen.  Even if .wait_for_powerdown() was 
prevented from running concurrently with .*_powerup(), nothing would 
prevent .*_powerup() from running the moment .wait_for_powerdown() 
has returned.  So it is up to the higher level not to power up a CPU and 
wait for it to be down at the same time since this simply makes no 
sense... unless it really wants the CPU back right away.

> But I've resolved to waiting for L2 WFI before powering off clusters.
> 
> >> Any suggestions? Maybe export __mcpm_cluster_state() so platform code
> >> can know what's going to happen?
> >
> > The cluster state may change unexpectedly.  There is a special locking
> > sequence and state machine needed to make this information reliable.
> > Simply returning the current state wouldn't be enough to ensure
> > it can be used race free.
> 
> I see.
> 
> > As Dave stated, we might have to supplement the MCPM core code with
> > special methods involving a surviving CPU to perform the power-down
> > operation on the dying CPU's behalf.  Doing this in .wait_for_powerdown
> > is just an abuse of the API.
> 
> The other users I looked at all had other pieces of hardware taking care
> of this, so I couldn't really understand where I could put this.

I think what should be done in this case is simply to put the task of 
killing the CPU power on a work queue that gets executed by another CPU. 
Queueing the necessary work could be done from the MCPM core code the 
moment a special method exists in the machine backend structure. The 
work callback would take the MCPM lock, make sure the CPU/cluster state 
is "DOWN" and call that special method.

A call to .wait_for_powerdown() should not be responsible for the actual 
power down. It should remain optional.

> If adding another callback to handle this is acceptable, then I can
> look into it.

Please be my guest.


Nicolas
