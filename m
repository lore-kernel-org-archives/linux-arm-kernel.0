From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 29 Jun 2015 10:36:19 +0100
Subject: dma_sync_single_for_cpu takes a really long time
In-Reply-To: <20150629090804.GX7557@n2100.arm.linux.org.uk>
References: <CAF6-1L6sjGc1VySi=oQGzOEm-e5jauznh+jzmdDgmJQWLbA_pA@mail.gmail.com>
 <20150628223039.GV7557@n2100.arm.linux.org.uk>
 <CAF6-1L6Xhsk3CwTvu6rAvYGYX3XvcwbmP582tVPEuiVaDnFpRA@mail.gmail.com>
 <20150629090804.GX7557@n2100.arm.linux.org.uk>
Message-ID: <20150629093619.GB29907@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 29, 2015 at 10:08:04AM +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 29, 2015 at 08:07:52AM +0200, Sylvain Munaut wrote:
> > > However, if you're going to read the entire frame through a cacheable
> > > mapping, you're probably going to end up flushing your cache several
> > > times over through doing that
> > 
> > Isn't there some intermediary between coherent and cacheable, a bit like
> > write combine for read ?
> 
> Unfortunately not.  IIRC, some CPUs like PXA had a "read buffer" which
> would do that, but that was a PXA specific extension, and never became
> part of the ARM architecture itself.

I'm not familiar with the PXA implementation but on A9, in combination
with the ACP, you can get "cacheable read no-allocate, write
no-allocate" accesses from the device side. This allows the CPU to just
use cacheable accesses.

If you don't want read-allocate for PL310, you can configure the ACP
outer cacheability attributes as shareable, non-cacheable and leave bit
22 in the PL310 aux ctrl register cleared. However, the latter requires
that all DMA goes through the ACP.

> > The Zynq TRM mention something about having independent control on inner
> > and outer cacheability for instance. If only one was enabled, then at least
> > the other wouldn't have to be invalidated ?
> 
> We then start running into other problems: there are only 8 memory types,
> 7 of which are usable (one is "implementation specific").  All of these
> are already used by Linux...

With the ACP, it's just hardware configuration so we wouldn't need
additional memory types in the kernel.

(as for the memory types, some of them are never used at the same time:
writeback, writealloc, writethrough)

-- 
Catalin
