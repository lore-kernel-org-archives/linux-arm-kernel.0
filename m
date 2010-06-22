From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 22 Jun 2010 23:39:04 +0100
Subject: [PATCH v4 2/4] ARM: Assume new page cache pages have dirty D-cache
In-Reply-To: <20100622193638.GA9780@debian>
References: <20100621144409.26309.87173.stgit@e102109-lin.cambridge.arm.com>
	<20100621144632.26309.63314.stgit@e102109-lin.cambridge.arm.com>
	<20100622193638.GA9780@debian>
Message-ID: <1277246344.20311.30.camel@toshiba-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-06-22 at 20:36 +0100, Rabin Vincent wrote:
> On Mon, Jun 21, 2010 at 03:46:32PM +0100, Catalin Marinas wrote:
> > There are places in Linux where writes to newly allocated page cache
> > pages happen without a subsequent call to flush_dcache_page() (several
> > PIO drivers including USB HCD). This patch changes the meaning of
> > PG_arch_1 to be PG_dcache_clean and always flush the D-cache for a newly
> > mapped page in update_mmu_cache().
> 
> Correct me if I'm misreading the code, but don't this patch and the next
> one make the assumption that CONFIG_SMP == VIPT non-aliasing (or PIPT)
> caches?  

Yes.

> This patch does not add flushing on SMP systems, and the next
> one handles the I$-D$ coherency issues there (ignoring the set_pte race
> fix for a moment).   

The aim of this patch isn't to add any new flushing, just changes the
default assumptions on the D-cache status for new pages (from clean to
dirty).

The following patch (sync I-D caches) is aimed at sorting out a race.
This patch indeed adds a __flush_dcache_page() call if the page is dirty
but with well-behaved drivers (calling flush_dcache_page), the
PG_dcache_clean bit should always be set when reaching set_pte_at().

On ARM11MPCore, the cache operations are not broadcast in hardware, so
flush_dcache_page() must be called on the CPU that dirtied the cache. So
not having a correct driver could lead to errors in user space on this
processor (if running with more than 1).

Cortex-A9 broadcasts the cache ops in hardware, so even if you don't do
it via the driver and flush_dcache_page, you catch the dirty page later
in set_pte_at().

So the sync I-D cache patch fixes both the race and the handling of not
well written drivers (the latter only on Cortex-A9). With all this in
place, the final patch in my series allows Cortex-A9 to use lazy cache
flushing as on UP systems (flush_dcache_page/update_mmu_cache pair).

BTW, I have a patch for ARM11MPCore which allows lazy cache flushing as
well (by performing a read-for-ownership before flushing the D-cache).
However, I can't guarantee that it works on anything other than
ARM11MPcore as it is to specific to the hardware implementation.

> Won't the flushing added in this patch be
> unnecessary on non-SMP PIPT systems, since they too only need the
> exec-related flushing?

Yes, this can be optimised. We could extend the __sync_icache_dcache()
patch to all the ARMv7 (UP) and SMP configurations (just a matter of
#ifdef's) where we know for sure that the hardware is VIPT non-aliasing.

I'll have a look tomorrow and post an update to this patch.

Thanks.

-- 
Catalin
