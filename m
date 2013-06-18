From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Jun 2013 17:52:47 +0100
Subject: [PATCH 1/2] ARM: mmu: fix the hang when we steal a section
 unaligned size memory
In-Reply-To: <20130618152905.GB8534@mudshark.cambridge.arm.com>
References: <1371113826-1231-1-git-send-email-b32955@freescale.com>
 <20130618152905.GB8534@mudshark.cambridge.arm.com>
Message-ID: <20130618165246.GC2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 04:29:05PM +0100, Will Deacon wrote:
> Wouldn't this be better achieved with a parameter, rather than a global
> state variable? That said, I don't completely follow why memblock_alloc is
> giving you back an unmapped physical address. It sounds like we're freeing
> too much as part of the stealing (or simply that stealing has to be section
> aligned), but memblock only deals with physical addresses.
> 
> Could you elaborate please?

It's a catch-22 situation.  memblock allocates from the top of usable
memory.

While setting up the page tables for the second time, we insert section
mappings.  If the last mapping is not section sized, we will try to set
it up using page mappings.  For this, we need to allocate L2 page
tables from memblock.

memblock returns a 4K page in the last non-section sized mapping - which
we're trying to setup, and hence is not yet mapped.

This is why I've always said - if you steal memory from memblock, it
_must_ be aligned to 1MB (the section size) to avoid this.  Not only
that, but we didn't _used_ to allow page-sized mappings for MT_MEMORY -
that got added for OMAP's SRAM support.
