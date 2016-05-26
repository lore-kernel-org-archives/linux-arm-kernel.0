From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 26 May 2016 17:36:05 +0100
Subject: [PATCH 1/1] arm64: fix flush_cache_range
In-Reply-To: <5746E203.4000906@huawei.com>
References: <1464088597-8820-1-git-send-email-thunder.leizhen@huawei.com>
 <20160524113727.GD25374@leverpostej> <574446B9.8040105@huawei.com>
 <20160524130255.GU4892@e104818-lin.cambridge.arm.com>
 <5744FDD0.8060504@huawei.com> <57451DC6.7080106@huawei.com>
 <20160525105022.GC5996@e104818-lin.cambridge.arm.com>
 <5746E203.4000906@huawei.com>
Message-ID: <20160526163604.GD7456@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2016 at 07:46:11PM +0800, Leizhen (ThunderTown) wrote:
> On 2016/5/25 18:50, Catalin Marinas wrote:
> > What happens is that __sync_icache_dcache() only takes care of the first
> > time a page is mapped in user space and flushes the caches, marking it
> > as "clean" (PG_dcache_clean) afterwards. Subsequent changes to this
> 
> As my tracing, it is returned by "if (!page_mapping(page))", because
> "mmap" are anonymous pages. I commented below code lines, it works
> well.
> 	
> 	/* no flushing needed for anonymous pages */
> 	if (!page_mapping(page))
> 		return;

I think it only works by luck. As I said above, even with your
modification for anonymous pages, the first time set_pte_at() is called,
__sync_icache_dcache() would set the PG_dcache_clean bit. Subsequent
set_pte_at() calls for changing the attributes would ignore the D-cache
invalidation as the page seems clean (unless there is a call to
flush_dcache_page() but this shouldn't be done on this path). What
probably happens is that memcpy() for copying the code triggers some
write streaming mode in the CPU and the information makes its way to the
PoU. The I-cache invalidation only removes the stale instructions.

-- 
Catalin
