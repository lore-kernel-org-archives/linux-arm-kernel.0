From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Oct 2010 15:25:08 +0200
Subject: [RFC PATCH 06/18] ARM: LPAE: Introduce the 3-level page table
	format definitions
In-Reply-To: <1288007977.14756.41.camel@e102109-lin.cambridge.arm.com>
References: <20101025085812.25275.55757.stgit@e102109-lin.cambridge.arm.com>
	<201010251315.53304.arnd@arndb.de>
	<1288007977.14756.41.camel@e102109-lin.cambridge.arm.com>
Message-ID: <201010251525.09002.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 October 2010, Catalin Marinas wrote:
> On Mon, 2010-10-25 at 12:15 +0100, Arnd Bergmann wrote:
> > On Monday 25 October 2010, Catalin Marinas wrote:
> > 
> > Since the PGD is so extremely small, would it be possible to fold it
> > into the mm_context_t in order to save an allocation?
> > Or does the PGD still require page alignment?
> 
> There are alignment restrictions, though not to a page size. Given the
> TTBR0 access range of the full 4GB (TTBCR.T0SZ = 0), the alignment
> required is 64 (2^6). We get this for the slab allocator anyway when the
> L1_CACHE_SHIFT is 6 but I could make this requirement explicit by
> creating a kmem_cache with the required alignment.

I think you only need to set ARCH_MIN_TASKALIGN for that, which
also defaults to L1_CACHE_SHIFT.
 
> > Do you also have patches to allow 40-bit virtual space? I suppose we
> > will need that for KVM support in the future.
> 
> I'm not sure how these would look like since the architecture is 32-bit
> (and I'm not familiar with KVM). With the MMU disabled, you can't access
> beyond the 4GB space anyway. KVM could use something like the pfn but in
> the virtual space.
> 
> Cortex-A15 comes with both LPAE and Virtualisation Extensions, so the
> latter could be used for something like KVM. There is another stage of
> page table translations, so the one set up by Linux actually generates
> an intermediate physical address (IPA) which gets translated to the real
> PA in the second stage. The IPA is 40-bit wide.

I was only talking about the Virtualization Extensions, my impression from
the information that is publically available was that you'd only need
to set some mode bits differently in order to make the virtual address
space (I suppose that's what you call IPA) up to 40 bits instead of 32,
and you'd be able to have the guest use a 40 bit physical address space
from that.

Are there any significant differences to Linux between setting up page
tables for a 32 bit VA space or a 40 bit IPA space, other than the
size of the PGD?

	Arnd
