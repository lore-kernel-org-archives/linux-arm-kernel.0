From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Mar 2010 14:49:42 +0000
Subject: [PATCH 1/5] ARM: Use lazy cache flushing on ARMv7 SMP systems
In-Reply-To: <20100323213345.GH19572@n2100.arm.linux.org.uk>
References: <20100322151729.6353.79984.stgit@e102109-lin.cambridge.arm.com>
	<20100322151939.6353.7646.stgit@e102109-lin.cambridge.arm.com>
	<20100323213345.GH19572@n2100.arm.linux.org.uk>
Message-ID: <1269614982.807.80.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-03-23 at 21:33 +0000, Russell King - ARM Linux wrote:
> On Mon, Mar 22, 2010 at 03:19:39PM +0000, Catalin Marinas wrote:
> > ARMv7 processors like Cortex-A9 broadcast the cache maintenance
> > operations in hardware. This patch allows the
> > flush_dcache_page/update_mmu_cache pair to work in lazy flushing mode
> > similar to the UP case.
> 
> Didn't Ben point out that there's a race with the lazy dcache flushing
> on SMP platforms?

BTW, even with the current code we still have a similar race with the
I-cache. set_pte_at() creates the entry that another CPU may execute
from before we invalidate the I-cache in update_mmu_cache().

A solution would be that set_pte_at() sets the NX bit which is cleared
later in udpate_mmu_cache() after the I-cache invalidation. Some care
needs to be taken with possible prefetch aborts in the small window when
the page isn't executable.

Note that even if we flush the caches in set_pte_at(), we still have the
I-cache race unless we write the pte twice, first with NX and then
without. So I'm more in favour of the solution in the previous
paragraph.

-- 
Catalin
