From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Oct 2009 18:12:27 +0100
Subject: [PATCH] Use Normal uncached memory rather than Strongly
	Ordered on ARMv6+
In-Reply-To: <1256316861.6564.154.camel@pc1117.cambridge.arm.com>
References: <20091023094121.21605.39568.stgit@pc1117.cambridge.arm.com>
	<20091023100639.GA19437@n2100.arm.linux.org.uk>
	<1256293374.6564.27.camel@pc1117.cambridge.arm.com>
	<20091023103420.GC19437@n2100.arm.linux.org.uk>
	<1256295591.6564.42.camel@pc1117.cambridge.arm.com>
	<20091023113001.GA22853@n2100.arm.linux.org.uk>
	<1256299512.6564.74.camel@pc1117.cambridge.arm.com>
	<20091023123600.GB22853@n2100.arm.linux.org.uk>
	<1256316861.6564.154.camel@pc1117.cambridge.arm.com>
Message-ID: <20091023171227.GA29639@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2009 at 05:54:21PM +0100, Catalin Marinas wrote:
> On Fri, 2009-10-23 at 13:36 +0100, Russell King - ARM Linux wrote:
> > If you have a shared ownership ring buffer, you need the writes for
> > updating the DMA pointers to hit it before the write to change the
> > ownership of the descriptor to device.  Reverse those two writes and
> > you end up transmitting junk.
> 
> But if we have arch_is_coherent() enabled (possibly with hardware
> support like ARM's ACP), we need the drivers to have barriers anyway
> since we would use normal cached memory (and ordering isn't guaranteed).
> Of course, one has to go through the drivers used with a platform and
> check them but we already have a precedent.

Actually, we do not.  arch_is_coherent() is for one ARM platform
(Intel IXP) which has their own DMA coherent support for PCI devices -
devices which quite possibly already have the necessary barriers.

> BTW, there are two other architectures (x86 and PowerPC) with a similar
> restriction. Do they do anything about this in Linux?

PPC doesn't appear to - they seem to live with multiple mappings for
the same space with different attributes.

x86 is fully cache coherent, and so doesn't have the DMA issue to
worry about - there's no need for dma_alloc_coherent() to be anything
but a call to get_free_pages().

ARM is more complex because we don't have any coherency hardware,
and the only way to safely get the required semantics for this memory
is by returning "strongly ordered" on ARMv5 and below.

In summary, the concern is:
1. The ARM support is currently setup to return strongly ordered memory.
2. Drivers are _currently_ written with this expectation in mind no
   matter what CPU architecture is in use.
3. Relaxing the returned memory type will destabilise systems,
   especially on ARMv6 and above.

As far as I'm concerned, we've spent far too long discussing this issue -
there's nothing really to discuss.  We need dma_alloc_coherent() to use
its own page protection modifier, which causes it to behave the same as
dma_alloc_writecombine() on ARMv7, and with the existing behaviour (for
the time being) on ARMv6 and below.  We should leave pgprot_noncached()
well alone until we know that its other places need to be changed.
