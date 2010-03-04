From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 05 Mar 2010 08:37:40 +1100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267726049.6526.543.camel@e102109-lin.cambridge.arm.com>
References: <20100226210030.GC23933@n2100.arm.linux.org.uk>
	<1267316072.23523.1842.camel@pasglop>
	<1267333263.2762.11.camel@mulgrave.site>
	<20100302211049V.fujita.tomonori@lab.ntt.co.jp>
	<1267549527.15401.78.camel@e102109-lin.cambridge.arm.com>
	<20100303215437.GF2579@ucw.cz>
	<1267709756.6526.380.camel@e102109-lin.cambridge.arm.com>
	<20100304135128.GA12191@atrey.karlin.mff.cuni.cz>
	<1267712512.31654.176.camel@mulgrave.site>
	<1267716578.6526.483.camel@e102109-lin.cambridge.arm.com>
	<20100304154103.GA9384@linux-sh.org>
	<1267726049.6526.543.camel@e102109-lin.cambridge.arm.com>
Message-ID: <1267738660.22204.77.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-03-04 at 18:07 +0000, Catalin Marinas wrote:
> 
> Are you more in favour if a PIO kmap API than inverting the meaning of
> PG_arch_1? 

My main worry with this approach is the sheer amount of drivers that
need fixing. I believe inverting PG_arch_1 is a better solution and I
somewhat fail to see how we end up doing too much flushing if we have
per-page execute permission (but maybe SH doesn't ?)

> I'm not familiar with SH but for PIO devices the flushing shouldn't be
> more aggressive. For the DMA devices, Russell suggested that we mark
> the
> page as clean (set PG_dcache_clean) in the DMA API to avoid the
> default
> flushing.

I really like that idea, as I said earlier, but I'm worried about the I$
side of things. IE. What I'm trying to say is that I can't see how to do
that optimisation without ending up with missing I$ invalidations or
doing way too many of them, unless we have a separate bit to track I$
state.

> > Note that the PG_dcache_dirty semantics are also outlined in
> > Documentation/cachetlb.txt for PG_arch_1 usage, so it's hardly
> esoteric.
> 
> Yes, but the flush_dcache_page() semantics outlined in the same file
> aren't followed by all the PIO drivers in the kernel.
> 

Cheers,
Ben.
