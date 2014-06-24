From: msalter@redhat.com (Mark Salter)
Date: Tue, 24 Jun 2014 10:38:34 -0400
Subject: [PATCH] arm64: make CONFIG_ZONE_DMA user settable
In-Reply-To: <20140624141455.GE4489@arm.com>
References: <1403499924-11214-1-git-send-email-msalter@redhat.com>
 <20140623110937.GB15907@arm.com> <1403529423.755.49.camel@deneb.redhat.com>
 <20140624141455.GE4489@arm.com>
Message-ID: <1403620714.755.69.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-06-24 at 15:14 +0100, Catalin Marinas wrote:
> On Mon, Jun 23, 2014 at 02:17:03PM +0100, Mark Salter wrote:
> > On Mon, 2014-06-23 at 12:09 +0100, Catalin Marinas wrote:
> > > My proposal (in the absence of any kind of description) is to still
> > > create a ZONE_DMA if we have DMA memory below 32-bit, otherwise just add
> > > everything (>32-bit) to ZONE_DMA. Basically an extension from your CMA
> > > patch, make dma_phys_limit static in that file and set it to
> > > memblock_end_of_DRAM() if no 32-bit DMA. Re-use it in the
> > > zone_sizes_init() function for ZONE_DMA (maybe with a pr_info for no
> > > 32-bit only DMA zone).
> > 
> > There's a performance issue with all memory being in ZONE_DMA. It means
> > all normal allocations will fail on ZONE_NORMAL and then have to fall
> > back to ZONE_DMA. It would be better to put some percentage of memory
> > in ZONE_DMA.
> 
> Is the performance penalty real or just theoretical? I haven't run any
> benchmarks myself.
> 
It is real insofar as you must eat cycles eliminating ZONE_NORMAL from
consideration in the page allocation hot path. How much that really
costs, I don't know. But it seems like it could be easily avoided by
limiting ZONE_DMA size. Is there any reason it needs to be larger than
4GiB?
