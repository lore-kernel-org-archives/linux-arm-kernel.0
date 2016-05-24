From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 24 May 2016 14:02:56 +0100
Subject: [PATCH 1/1] arm64: fix flush_cache_range
In-Reply-To: <574446B9.8040105@huawei.com>
References: <1464088597-8820-1-git-send-email-thunder.leizhen@huawei.com>
 <20160524113727.GD25374@leverpostej> <574446B9.8040105@huawei.com>
Message-ID: <20160524130255.GU4892@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2016 at 08:19:05PM +0800, Leizhen (ThunderTown) wrote:
> On 2016/5/24 19:37, Mark Rutland wrote:
> > On Tue, May 24, 2016 at 07:16:37PM +0800, Zhen Lei wrote:
> >> When we ran mprotect04(a test case in LTP) infinitely, it would always
> >> failed after a few seconds. The case can be described briefly that: copy
> >> a empty function from code area into a new memory area(created by mmap),
> >> then call mprotect to change the protection to PROT_EXEC. The syscall
> >> sys_mprotect will finally invoke flush_cache_range, but this function
> >> currently only invalid icache, the operation of flush dcache is missed.
> > 
> > In the LTP code I see powerpc-specific D-cache / I-cache synchronisation
> > (i.e. d-cache cleaning followed by I-cache invalidation), so there
> > appears to be some expectation of userspace maintenance. Hoever, there
> > is no such ARM-specific I-cache maintenance.
> 
> But I see some other platforms have D-cache maintenance, like: arch/nios2/mm/cacheflush.c
> And according to the name of flush_cache_range, it should do this, I judged. Otherwise,
> mprotect04 will be failed on more platforms, it's easy to discover. Only PPC have specific
> cache synchronization, maybe it meets some hardware limitation. It's impossible a programmer
> fixed a common bug on only one platform but leave others unchanged.

flush_cache_range() is primarily used on VIVT caches before changing the
mapping and should not really be implemented on arm64. I don't recall
why we still have the I-cache invalidation, possibly for the ASID-tagged
VIVT I-cache case, though we should have a specific check for this.

There are some other cases where flush_cache_range() is called and no
D-cache maintenance is necessary on arm64, so I don't want to penalise
them by implementing flush_cache_range().

> > It looks like the test may be missing I-cache maintenance regardless of
> > the semantics of mprotect in this case.
> > 
> > I have not yet devled into flush_cache_range and how it is called.
> 
> SYSCALL_DEFINE3(mprotect ---> mprotect_fixup ---> change_protection ---> change_protection_range --> flush_cache_range

The change_protection() shouldn't need to flush the caches in
flush_cache_range(). The change_pte_range() function eventually ends up
calling set_pte_at() which calls __sync_icache_dcache() if the mapping
is executable.

Can you be more specific about the kernel version you are using, its
configuration?

-- 
Catalin
