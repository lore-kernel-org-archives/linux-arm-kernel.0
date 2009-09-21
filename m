From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 21 Sep 2009 23:12:29 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <4AB7F716.2070206@arm.com>
References: <20090920093139.GA1704@n2100.arm.linux.org.uk>
	<20090920190227.GB5413@n2100.arm.linux.org.uk>
	<4AB6B0AB.8040307@arm.com> <20090921083109.GC20006@shareable.org>
	<1253522944.1541.3.camel@pc1117.cambridge.arm.com>
	<20090921085425.GC27357@n2100.arm.linux.org.uk>
	<1253526263.1541.32.camel@pc1117.cambridge.arm.com>
	<20090921100751.GF27357@n2100.arm.linux.org.uk>
	<20090921201043.GA14700@shareable.org> <4AB7F716.2070206@arm.com>
Message-ID: <20090921221229.GF14700@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> A possible scenario (though more code analysis is needed to be entirely 
> sure) with writing instructions and not calling sys_cacheflush():
> 
> - application mmap's a file (shared mapping, otherwise the data written 
> to private mappings is lost when unmapping)
> - app writes some instructions to text pages. We don't get CoW because 
> of the shared mapping but we don't get D-cache cleaning either
> - app unmap's the page but the kernel keeps the physical page in its 
> page cache. The flush_cache_page() on non-aliasing VIPT doesn't do 
> anything on ARM
> - app mmap's the page with PROT_READ|PROT_EXEC
> - app executes from the page generating a prefetch abort. The kernel 
> finds the page in its page cache and maps it into user space, calling 
> update_mmu_cache(). However, the dirty bit isn't set (since the kernel 
> hasn't touched the page) and the lazy D-cache flushing in 
> update_mmu_cache isn't triggered, leaving the I-cache with old entries 
> directly from RAM.

Why isn't the dirty bit set by the last step?

The dirty bit must be set by the writes in the second step, otherwise
how does the kernel know not to discard those writes under memory
pressure?

Btw, regarding "non-aliasing", it's pretty clear that it does alias
the I-cache ;-), in much the same way as different addresses alias in
the D-cache with an "aliasing" cache.  That may well be a clue as to
clean, systematic and sane way of ensuring all the cache ops are in
all the right places.

-- Jamie
