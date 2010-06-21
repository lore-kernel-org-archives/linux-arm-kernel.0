From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Jun 2010 10:42:35 +0100
Subject: [PATCH v3 2/4] ARM: Use lazy cache flushing on ARMv7 SMPsystems
In-Reply-To: <20100621093856.GF7702@n2100.arm.linux.org.uk>
References: <20100621091745.23136.67979.stgit@e102109-lin.cambridge.arm.com>
	<20100621092029.23136.39916.stgit@e102109-lin.cambridge.arm.com>
	<20100621093856.GF7702@n2100.arm.linux.org.uk>
Message-ID: <1277113355.20758.11.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-06-21 at 10:38 +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 21, 2010 at 10:20:29AM +0100, Catalin Marinas wrote:
> > ARMv7 processors like Cortex-A9 broadcast the cache maintenance
> > operations in hardware. This patch allows the
> > flush_dcache_page/update_mmu_cache pair to work in lazy flushing mode
> > similar to the UP case.
> 
> No.  We know that this trick can't be used on SMP, because update_mmu_cache
> is called after the PTE has been established and the page has become
> visible to other CPUs in the system.
> 
> So this optimization must remain disabled on SMP for correctness.

Even the current code isn't correct because the I-cache is invalidated
via update_mmu_cache() but set_pte_at() gets called before.

So this is handled by patch 4/4 in the series. I can reorder them but I
couldn't see any reason since the current non-lazy behaviour isn't
correct either.

-- 
Catalin
