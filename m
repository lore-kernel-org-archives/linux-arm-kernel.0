From: r-woodruff2@ti.com (Woodruff, Richard)
Date: Thu, 21 Jul 2011 16:22:40 -0500
Subject: [PATCH] ARM: do not mark CPU 0 as hotpluggable
In-Reply-To: <20110721074511.GK26574@n2100.arm.linux.org.uk>
References: <1311204745-6276-1-git-send-email-mturquette@ti.com>
	<20110721074511.GK26574@n2100.arm.linux.org.uk>
Message-ID: <13B9B4C6EF24D648824FF11BE896716203F2398A8A@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Russell King - ARM Linux

> On Wed, Jul 20, 2011 at 04:32:25PM -0700, Mike Turquette wrote:
> > A quick poll of the ARM platforms that implement CPU Hotplug support
> > shows that every platform treats CPU 0 as a special case that cannot be
> > hotplugged.  In fact every platform has identical code for
> > platform_cpu_die which returns -EPERM in the case of CPU 0.
> 
> Are you sure that's just not because everyone copied what Realview has
> been doing (highly likely)?
> 
> I suspect that there's no reason that CPU0 can't be taken down, especially
> on those platforms which don't take the CPU fully offline but just put it
> into a WFI loop.
> 
> Those which restart the CPUs through the boot loader probably detect CPU0
> as the boot CPU, so they probably can't take CPU0 down.

This was a hot topic a couple years back for hw folks...

On 443x when you go to ARM-MPCore power states other than normal (dormant, powered-off) there are hardware and ti-trustzone-monitor constraints which dictate the CPU power state transition matrix (cpu1 can't make all calls cpu0 can and some hardware combinations were not validated).

For MPU-domain (mpcore-cluster + l2cache ++) and its sub-domains (cpu0, cpu1, ...) there exists ability to set multiple states which wfi is a gate into (on, inactive, retention, partial-off, off). A big matrix of possible states results. Things were coded and system tested for only a subset of these. The ARM code did line up with these constraints.

Maybe an offline to simple wfi loop is ok, but other lower states could not be entered from that state.

Some folks were talking about relaxing cpu0/cpu1 constraints moving forward.  Doing this could result in many more states-combinations to be validated at hardware level. Do you think Linux code would be simplified/enhanced such that it is worth the extra hardware validation effort?
