From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Jun 2012 20:18:01 +0100
Subject: [PATCH] [RESEND] arm: limit memblock base address for
 early_pte_alloc
In-Reply-To: <025701cd457e$d5065410$7f12fc30$@lge.com>
References: <1338880312-17561-1-git-send-email-minchan@kernel.org>
 <025701cd457e$d5065410$7f12fc30$@lge.com>
Message-ID: <20120627191801.GD25319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 08, 2012 at 10:58:50PM +0900, Kim, Jong-Sung wrote:
> > From: Minchan Kim [mailto:minchan at kernel.org]
> > Sent: Tuesday, June 05, 2012 4:12 PM
> > 
> > If we do arm_memblock_steal with a page which is not aligned with section
> > size, panic can happen during boot by page fault in map_lowmem.
> > 
> > Detail:
> > 
> > 1) mdesc->reserve can steal a page which is allocated at 0x1ffff000 by
> > memblock
> >    which prefers tail pages of regions.
> > 2) map_lowmem maps 0x00000000 - 0x1fe00000
> > 3) map_lowmem try to map 0x1fe00000 but it's not aligned by section due to
> 1.
> > 4) calling alloc_init_pte allocates a new page for new pte by
> memblock_alloc
> > 5) allocated memory for pte is 0x1fffe000 -> it's not mapped yet.
> > 6) memset(ptr, 0, sz) in early_alloc_aligned got PANICed!
> 
> May I suggest another simple approach? The first continuous couples of
> sections are always safely section-mapped inside alloc_init_section funtion.
> So, by limiting memblock_alloc to the end of the first continuous couples of
> sections at the start of map_lowmem, map_lowmem can safely memblock_alloc &
> memset even if we have one or more section-unaligned memory regions. The
> limit can be extended back to arm_lowmem_limit after the map_lowmem is done.

No.  What if the first block of memory is not large enough to handle all
the allocations?

I think the real problem is folk trying to reserve small amounts.  I have
said all reservations must be aligned to 1MB.
