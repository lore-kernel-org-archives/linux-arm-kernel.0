From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Jul 2013 00:22:34 +0100
Subject: [PATCH V3] ARM: mm: restrict early_alloc to section-aligned memory
In-Reply-To: <51E5C541.4080800@wwwdotorg.org>
References: <1373481831-31459-1-git-send-email-swarren@wwwdotorg.org>
 <51E5C541.4080800@wwwdotorg.org>
Message-ID: <20130716232234.GI24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 04:12:17PM -0600, Stephen Warren wrote:
> On 07/10/2013 12:43 PM, Stephen Warren wrote:
> > From: Russell King <rmk@arm.linux.org.uk>
> > 
> > When map_lowmem() runs, and processes a memory bank whose start or end
> > is not section-aligned, memory must be allocated to store the 2nd-level
> > page tables. Those allocations are made by calling memblock_alloc().
> > 
> > At this point, the only memory that is free *and* mapped is memory which
> > has already been mapped by map_lowmem() itself. For this reason, we must
> > calculate the first point at which map_lowmem() will need to allocate
> > memory, and set the memblock allocation limit to a lower address, so that
> > memblock_alloc() is guaranteed to return memory that is already mapped.
> > 
> > This patch enhances sanity_check_meminfo() to calculate that memory
> > address, and pass it to memblock_set_current_limit(), rather than just
> > assuming the limit is arm_lowmem_limit.
> > 
> > The algorithm applied is:
> > 
> > * Default memblock_limit to arm_lowmem_limit in the absence of any other
> >   limit; arm_lowmem_limit is the highest memory that is mapped by
> >   map_lowmem().
> > 
> > * While walking the list of memblocks, if the start of a block is not
> >   aligned, 2nd-level page tables will need to be allocated to map the
> >   first few pages of the block. Hence, the memblock_limit must be before
> >   the start of the block.
> > 
> > * Similarly, if the end of any block is not aligned, 2nd-level page
> >   tables will need to be allocated to map the last few pages of the
> >   block. Hence, the memblock_limit must point at the end of the block,
> >   rounded down to section-alignment.
> > 
> > * The memory blocks are assumed to be sorted in address order, so the
> >   first unaligned block start or end is used to set the limit.
> > 
> > With this algorithm, the start or end of almost any bank can be non-
> > section-aligned. The only exception is that the start of bank 0 must
> > be section-aligned, since otherwise memory would need to be allocated
> > when mapping the start of bank 0, which occurs before any free memory
> > is mapped.
> > 
> > Not-yet-signed-off-by: Russell King <rmk@arm.linux.org.uk>
> > [swarren, wrote commit description, rewrote calculation of memblock_limit]
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > ---
> > V3: completely new implementation based on Russell's suggestion.
> > 
> > Russell, since this is strongly based on your patch, I set you as the
> > author in git. I assume that's OK. If not, let me know and I'll change
> > the patch to my authorship and add a note to the commit description
> > that it's based on your original.
> 
> Russell, should I assume that no comment implies this is OK and I should
> send it to the ARM patch tracker?

Sure, I think it's fine - it should result in no change for most people.
