From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 May 2010 12:31:19 +0100
Subject: [PATCH 2/8] ARM: Implement read/write for ownership in
	theARMv6 DMA cache ops
In-Reply-To: <309002C0DA137042828828FC53D7A93492FA31384F@IL-MB01.marvell.com>
References: <20100516150117.GC23961@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A93492FA31362D@IL-MB01.marvell.com>
	<20100517065712.GA23118@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A93492FA3136B1@IL-MB01.marvell.com>
	<20100517074329.GB23118@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A93492FA313710@IL-MB01.marvell.com>
	<20100517085751.GD23118@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A93492FA3137A1@IL-MB01.marvell.com>
	<20100517100342.GA29422@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A93492FA31384F@IL-MB01.marvell.com>
Message-ID: <20100517113119.GC29422@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 17, 2010 at 02:26:38PM +0300, Ronen Shitrit wrote:
> > How can you say that the current line won't be evicted?
>
> [Ronen Shitrit] Since the only ldr I see around is the ldr to the next
> line and next line will go to different line on the cache...

I think you mean different index, and yes, you're right about that.

However, I still feel that your solution is unsafe as long as
speculative prefetch is enabled; the assumption with speculative
prefetch from an architectural point of view is to assume that
the CPU has infinite prefetching.

The fact that we have non-ARM ARMv6 CPUs which do prefetch in ways
we don't know about means that we can't assume that ARMv6 CPUs
aren't going to have aggressive prefetching.
