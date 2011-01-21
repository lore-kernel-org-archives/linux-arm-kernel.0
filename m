From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Jan 2011 19:28:54 +0000
Subject: [PATCH] mmc: msm: fix dma usage not to use internal APIs
In-Reply-To: <ff5d6c73aa50329b025bfe69297a92d9.squirrel@www.codeaurora.org>
References: <1295391805-15251-1-git-send-email-dwalker@codeaurora.org>
	<1295522421.4366.34.camel@m0nster>
	<20110120130246.GA23941@n2100.arm.linux.org.uk>
	<20110120131239.GB23941@n2100.arm.linux.org.uk>
	<1295536094.9236.11.camel@m0nster>
	<ff5d6c73aa50329b025bfe69297a92d9.squirrel@www.codeaurora.org>
Message-ID: <20110121192854.GB23151@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 08:13:59AM -0800, Brent DeGraaf wrote:
> Russell,
> 
> This code was not added simply for the dsb inside the dma_map_sg call.
> 
> This dma mapping call was introduced to deal with speculative dfetches:
> the scatter-gather area can be in normal memory, so we need to do a cache
> invalidate (which is taken care of by the mapping function) before reading
> data into the area using dma, or it's possible that a speculative dfetch
> could pull old data from the cache during the transfer.  (Maybe I should
> have beefed up the comment with more detail explaining  the role of the
> whole mapping call instead of using just the word "also" to signify that
> the non-cacheable box data was also put in-order from this command.)

Again, why don't you talk about these problems on the architecture list
rather than keeping it to your self.

This is one of the *biggest* problems I have with people setting up per-
platform mailing lists.  It hides information from the rest of the community
and causes idiotic practices and abuses such as has happened here.

In October 2009, the problem of speculative accesses causing DMA buffer
corruption was fixed.

> BTW, I have just looked at the new kernel mapping routines and they still
> do the proper thing for speculative cpus, but older cpus without
> speculative data fetches will do an unnecessary pre-invalidate.

Sigh.  Your comment is just soo wrong there it's untrue - do you have
any idea what would happen if we didn't invalidate before passing the
buffer to DMA for DMA-from-device?

Think about what would happen if during the DMA operation, the buffer
contained some dirty cache lines, and these happened to be evicted over
the top of the DMA'd data, corrupting it.

The invalidate on map is something that's been there since day one of
ARMs DMA API support.  It's not unnecessary, it's really very very
important.

> I'd like to talk about the additional barriers added to writel, however. 
> Our approach for such writes is to only add a barrier when ordering was
> important because barriering between each individual writel will interfere
> with our cpu's write-gathering capabilities, slowing things up a bit. 

That's one of the prices we pay for sharing the kernel with other
architectures.  Linus Torvalds refuses to tackle the problem of weakly
ordered IO - his position is that architectures with weakly ordered
memory models *must* behave in the same way that x86 does.  He has a
point, as many drivers only get written and tested on x86, so driver
writers have no idea whether their driver would work on a relaxed IO
CPU.

Many people from various different architectures have tried to influence
this position but have always been unsuccessful.  Architectures have
tried to get agreement on a way to allow relaxed IO, but it hasn't
happened.

The barrier in writel() has to stay to ensure correctness with existing
drivers.  Same for readl()'s memory barrier.  However, we do have a set
of relaxed operations - but the problem is that they can not be used in
any driver which is shared with other architectures as they aren't an
official part of the IO API.

So, if you're happy that your driver is limited to only ever running on
ARM, then you can use the relaxed IO operators.  Just append a _relaxed
suffix.  Bear in mind though that you will have to add an appropriate
mb() between writes to coherent DMA memory and the write which tells
the DMA hardware to start accessing that memory - or use writel()
instead (which is probably the preferred method).
