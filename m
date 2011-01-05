From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Jan 2011 18:35:09 +0000
Subject: [PATCH v3 08/10] ARM: mxs: add ocotp read function
In-Reply-To: <20110105175617.GD12222@shareable.org>
References: <1294236457-17476-1-git-send-email-shawn.guo@freescale.com>
	<1294236457-17476-9-git-send-email-shawn.guo@freescale.com>
	<20110105161235.GA2112@gallagher>
	<20110105164409.GV25121@pengutronix.de>
	<20110105172501.GB2112@gallagher>
	<20110105175617.GD12222@shareable.org>
Message-ID: <20110105183509.GH8638@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 05, 2011 at 05:56:17PM +0000, Jamie Lokier wrote:
> cpu_relax() is a hint to the CPU to, for example, save power or be
> less aggressive on the memory bus (to save power or be fairer).
> 
> Currently these architectures do more than just a barrier in cpu_relax():
> x86, IA64, PowerPC, Tile and S390.
> 
> Although it's just a hint on ARM at the moment, it might change in
> future - especially with power mattering on so many ARM systems.
> (Even now, just changing it to a very short udelay might save power
> on existing ARMs without breaking drivers.)

I think that's a matter for what the loop is doing.  If it's polling
a memory location then it probably has no effect what so ever.  If
the loop is spinning on a device, then the CPU will have to wait for
the read to complete which will slow it down.

It's something that would need very careful evaluation, and is probably
something that's very platform and loop specific.

> By the way, I see ARM defines cpu_relax as smp_mb() on arch >= 6.  Is
> that correct and useful?  On other architectures*, barrier() is enough
> of a barrier, but it's conceivable that smp_mb() would have some
> ARM-specific fairness or bus activity benefit - in which case it
> should probably be mb().

See a discussion last year with Linus.  It's there to ensure that one CPU
spinning on a variable can see a write by another CPU to that same
variable.  Without the barrier, the visibility effects are unbounded on
ARMv6 - and it's only like that for ARMv6, not >= ARMv6.
