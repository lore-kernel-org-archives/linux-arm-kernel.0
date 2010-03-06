From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 06 Mar 2010 10:00:22 +0000
Subject: [RFC PATCH] ARM: Assume new page cache pages have dirty D-cache
In-Reply-To: <20100305211629.GF4885@n2100.arm.linux.org.uk>
References: <20100304214435.GJ13417@n2100.arm.linux.org.uk>
	<1267807960.2581.5.camel@e102109-lin.cambridge.arm.com>
	<20100305211629.GF4885@n2100.arm.linux.org.uk>
Message-ID: <1267869622.4280.5.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-03-05 at 21:16 +0000, Russell King - ARM Linux wrote:
> On Fri, Mar 05, 2010 at 04:52:40PM +0000, Catalin Marinas wrote:
> > As Ben said, I think we can set PG_dcache_clean in the
> > clear/copy_user_page() functions. My doubt with these functions is the
> > highmem cases where kunmap_atomic() only flushes the D-cache in one
> > situation, the other just calling kunmap_high() which doesn't seem to do
> > anything to the caches.
> 
> In which case you're totally missing the point with these functions.
> The copy_user_page and clear_user_page functions specifically do tricks
> to ensure that they can avoid additional cache maintainence - or any
> cache maintainence at all.
> 
> For instance, on aliasing VIPT, they will map the user page in using
> the same colour as the ultimate userspace address, ensuring that any
> cache lines created will be visible to the userspace application.

I was more thinking for the non-aliasing VIPT case where we could defer
the flushing until update_mmu_cache(). But I'm fine with just setting
PG_dcache_clean in these functions to avoid checks on non-aliasing vs.
aliasing VIPT.

> So what kunmap_atomic() does with caches is not really relevant to the
> coherency issue.

The relevant part is that if highmem is enabled, copy_user_page() does
not flush the D-cache, leaving it to kunmap_atomic(). Does this latter
function flush the D-cache in all the relevant situations?

-- 
Catalin
