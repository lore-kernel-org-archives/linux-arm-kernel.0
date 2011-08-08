From: will.deacon@arm.com (Will Deacon)
Date: Mon, 8 Aug 2011 21:25:52 +0100
Subject: [PATCH 4/6] ARM: smp: set thread_info->cpu to hardware CPU
	number for boot thread
In-Reply-To: <20110808200256.GE19367@n2100.arm.linux.org.uk>
References: <1312823424-9654-1-git-send-email-will.deacon@arm.com>
	<1312823424-9654-5-git-send-email-will.deacon@arm.com>
	<4E401DF2.10801@codeaurora.org>
	<20110808181459.GB10072@e102144-lin.cambridge.arm.com>
	<20110808200256.GE19367@n2100.arm.linux.org.uk>
Message-ID: <20110808202551.GA10666@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Aug 08, 2011 at 09:02:56PM +0100, Russell King - ARM Linux wrote:
> On Mon, Aug 08, 2011 at 07:14:59PM +0100, Will Deacon wrote:
> > Can be. I just followed suit with secondary_start_kernel, but smp.c doesn't
> > seem to be consistent anyway so I'll add the specifier.
> 
> Actually, it's probably much better to keep logical CPU0 as the boot CPU.
> The hotplug code makes the assumption that the lowest online CPU number
> is the boot CPU.

Yes, you're right. I only tested this on a dual-core platform so I didn't
get a chance to play with hotplug (except to see that it failed, like I
expected). That assumption is also in the generic code so I guess it's
easier to leave it be.

> So unless we want even more pain, I suggest we just ensure logical CPU0
> is the boot CPU.

Right. Ensuring the logical CPU number isn't too hard, but we should aim to
support an arbitrary physical CPU number for the boot ID, even if most
platforms can't cater for that at the moment.

> We're already fairly clean on our interactions between CPU numbering and
> the hardware CPU numbering - there's only a limited number of places where
> the two interact.  Those are the GIC, IPI, secondary CPU bringup, and
> hotplug code.  I suggest that we preserve the independence, and introduce
> a mapping between logical CPU numbering and hardware CPU numbering.

This was my initial approach but then I thought I'd try and cheat my messing
with the logical numbering. I'll look at implementing the mapping and then
updating the GIC and friends to indirect their CPU number lookups through
that instead. I'll post it as its own series since it will be more than just
a simple hack now.

Stay tuned...

Cheers,

Will
