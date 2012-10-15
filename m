From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 15 Oct 2012 15:56:39 +0800
Subject: [PATCH 7/7] ARM: tegra30: cpuidle: add LP2 driver for CPU0
In-Reply-To: <507885D4.10604@wwwdotorg.org>
References: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
 <1349691981-31038-8-git-send-email-josephl@nvidia.com>
 <5074AA0E.2080508@wwwdotorg.org>
 <1349954685.19413.207.camel@jlo-ubuntu-64.nvidia.com>
 <5076F5CB.4020200@wwwdotorg.org>
 <1350025676.20241.82.camel@jlo-ubuntu-64.nvidia.com>
 <507885D4.10604@wwwdotorg.org>
Message-ID: <1350287799.23354.23.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2012-10-13 at 05:04 +0800, Stephen Warren wrote:
> On 10/12/2012 01:07 AM, Joseph Lo wrote:
> > On Fri, 2012-10-12 at 00:37 +0800, Stephen Warren wrote:
> >> On 10/11/2012 05:24 AM, Joseph Lo wrote:
> >>> On Wed, 2012-10-10 at 06:49 +0800, Stephen Warren wrote:
> >>>> On 10/08/2012 04:26 AM, Joseph Lo wrote:
> >>>>> The cpuidle LP2 is a power gating idle mode. It support power gating
> >>>>> vdd_cpu rail after all cpu cores in LP2. For Tegra30, the CPU0 must
> >>>>> be last one to go into LP2. We need to take care and make sure whole
> >>>>> secondary CPUs were in LP2 by checking CPU and power gate status.
> >>>>> After that, the CPU0 can go into LP2 safely. Then power gating the
> >>>>> CPU rail.
> >>>>
> >>>>> diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
> >> b) If CPUn can't trigger rail-gating, then when CPUn is the last to
> >> enter LP2 of the whole complex, it needs to IPI to CPU0 to tell it to
> >> rail-gate, and simply power-gate itself. I believe this IPI interaction
> >> is exactly what coupled cpuidle is about, isn't it?
> > 
> > Yes, indeed. Actually, I had tried the coupled cpuidle on Tegra20. I
> > knew it a lot. But I met issues when porting it. It looks like a race
> > condition and becomes a dead lock caused by IPI missing. Anyway, we can
> > talk about it more detail when I try to upstream the coupled cpuidle
> > support for Tegra later.
> 
> Hmm. That sounds a little churny. Why can't we just use coupled cpuidle
> right from the start if the plan is to use it eventually anyway? From
> other comments, it sounds like you even already have the code basically
> working, but just need to iron out a bug or two?

Stephen,

Even though we have plan to use coupled cpuidle, I still prefer to go
with the LP2 driver first. Then adding one more patch to support coupled
cpuidle based on LP2 driver. This is good for history. And if there is
any issue, it's more easy to roll back to the stable one.

There is still one thing you should know. Because we are planning to
upstream "CPUquiet" framework that is a CPU auto hotplug mechanism. It
will auto hotplug the CPUs depends on the system is busy or not. So when
system is idle, there will be only one CPU online (i.e, CPU0). The
secondary CPUs will all be hot plugged (i.e, offline and power gate). We
need to think about do we still need coupled cpuidle on Tegra30 if we
are going to use "CPUquiet".

And Yes, I already had a work version on Tegra20 but I need to iron out
the IPI missing issue first. The LP2 driver of Tegra20 also not yet be
upstreamed.

Thanks,
Joseph
