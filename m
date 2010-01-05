From: leif.lindholm@arm.com (Leif Lindholm)
Date: Tue, 5 Jan 2010 18:09:39 -0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v2)
In-Reply-To: <20100104193400.GB13537@shareable.org>
References: <20091218182007.GF5527@n2100.arm.linux.org.uk>
	<1261243122.4637.9.camel@pc1117.cambridge.arm.com>
	<20091219172833.GA6187@n2100.arm.linux.org.uk>
	<F74D5D79E8EA1244A97ECCA56C4D01DB771E2EDD86@BUNGLE.Emea.Arm.com>
	<20100104193400.GB13537@shareable.org>
Message-ID: <000001ca8e32$3f84feb0$be8efc10$@lindholm@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Jamie Lokier [mailto:jamie at shareable.org]
> Sent: 04 January 2010 19:34

> There is no need to return to userspace, as you know that userspace
> will immediately retry the instruction, or respond to a signal.
> 
> So you can loop, as long as you:
> 
>    1. Allow other tasks to run by calling cond_resched().
>    2. Break out of the loop if signal_pending().

Thanks for these suggestions - I will be posting an updated patch that does
this shortly.
 
> If someone executes SWP on uncached or device memory and it's not an
> intentional DOS (e.g. worked with older ARMs), they won't expect the
> instruction to loop at that point.

True, but difficult to solve in a clean way (see below).

> Faulting would be better. Is it feasible to detect when this has
> happened and send a SIGBUS signal instead of looping?

Only if the processor implements it (the AXI spec explicitly permits a
processor to treat an OKAY response, as opposed to EXOKAY, as an error -
but it doesn't mandate it). I am not aware of any ARM processors that do
this. Otherwise that would certainly be the best solution.

Of course this means that if we want to "detect" an impossible situation
in order to generate an abort, we need to resort to counters, and
determining an arbitrary "highest possible" number of valid sequential
failures...

/
    Leif
