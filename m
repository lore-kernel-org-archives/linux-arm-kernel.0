From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 May 2011 18:39:56 +0200
Subject: Updated mach-types update
In-Reply-To: <20110523153326.GB15153@n2100.arm.linux.org.uk>
References: <201105231652.28497.arnd@arndb.de>
	<20110523151051.GB6489@sirena.org.uk>
	<20110523153326.GB15153@n2100.arm.linux.org.uk>
Message-ID: <201105231839.57083.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 May 2011, Russell King - ARM Linux wrote:
> Let me turn this around.  Given that Linus has complained about the 60k LOC
> growth of ARM at every merge window, and at this window we've been able to
> achieve a net reduction of 15k LOC, what do you think the chances of adding
> another 60k LOC at the next merge window are?
> 
> Don't get me wrong - 15k LOC removal is a good start, but it's just that,
> a start.  It's well below what I was hoping for.

Agreed. The 15k LOC were also partially just the low-hanging fruit, so
we won't be able to do much larger reductions without doing more
groundwork first, like the stuff that is going in now (clkdev, irq,
clksource, device tree, ...).

We need to do more of those before we see significant reductions from
being able to remove a lot of the existing board files. At the same
time, a number of people obviously have new boards that they want to
see supported. The tactical answer that I'd give to them is that they
can still add board files, provided that they also help do the work
that is required to remove them later (depends the specific capabilities
of the people and the complexity of the code they want to add).

Only after we have dealt with board-level code and moved that over
to device tree probing within a given subarchitecture, we can really
start addressing the issue across SoCs inside of the same subarchitecture.
Similarly, I would not try to keep out new SoCs from getting merged
until then (as long as they don't try to add code that is worse than
the existing SoCs) but instead ask the people that are interested
in merging them to help the consolidation on that level. The reason
for doing cross-soc stuff after cross-board stuff is that it's
more work to do that in the device tree and that there is less
to gain.

Another area where I think we will see initial growth is the
device tree source files -- as we discussed, we want to put them
into the kernel at first, until the dust has settled down a bit and
they stop changing. At that point, we will start a new source code
repo that is OS independent and just contains all the device trees
so we can delete them again. My hope is that we get Linus to agree
to this because it's a useful step in the right direction and only
adds code that we are planning to remove later.

	Arnd
