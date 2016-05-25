From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 May 2016 16:22:55 +0100
Subject: [PATCH 1/1] arm64: fix flush_cache_range
In-Reply-To: <20160524151235.GA11605@leverpostej>
References: <1464088597-8820-1-git-send-email-thunder.leizhen@huawei.com>
 <20160524113727.GD25374@leverpostej> <574446B9.8040105@huawei.com>
 <20160524151235.GA11605@leverpostej>
Message-ID: <20160525152255.GH5996@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2016 at 04:12:35PM +0100, Mark Rutland wrote:
> On Tue, May 24, 2016 at 08:19:05PM +0800, Leizhen (ThunderTown) wrote:
> > On 2016/5/24 19:37, Mark Rutland wrote:
> > > On Tue, May 24, 2016 at 07:16:37PM +0800, Zhen Lei wrote:
> > >> When we ran mprotect04(a test case in LTP) infinitely, it would always
> > >> failed after a few seconds. The case can be described briefly that: copy
> > >> a empty function from code area into a new memory area(created by mmap),
> > >> then call mprotect to change the protection to PROT_EXEC. The syscall
> > >> sys_mprotect will finally invoke flush_cache_range, but this function
> > >> currently only invalid icache, the operation of flush dcache is missed.
[...]
> Jumping back to the problem at hand:
> 
> It looks like we inherited this from ARM, which has done this for all
> executable mappings since commit  6060e8df517847bf ("ARM: I-cache: flush
> executable mappings in flush_cache_range()"). The commit message refers
> to a4db94d, which doesn't seem to exist, and I assume is
> 115b22474eb1905d ("ARM: 5794/1: Flush the D-cache during
> copy_user_highpage()") which happened to get rebased at some point.
> 
> That all implies that the icache maintenance is only intended to ensure
> that CoW does not result in unexpected incoherency. Which in turn
> implies that flipping permissions with mprotect is not expected to
> synchronise the D and I caches.

Looking through the arm32 history:

2.6.33:
  115b22474eb1 ("ARM: 5794/1: Flush the D-cache during copy_user_highpage()")
  6060e8df5178 ("ARM: I-cache: flush executable mappings in flush_cache_range()")

These both take care of the CoW issue with executable pages.

2.6.37:
  6012191aa9c6 ("ARM: 6380/1: Introduce __sync_icache_dcache() for VIPT caches")

The above is a fix for SMP systems where update_mmu_cache() happens
after the PTE was actually written, so slight chance of race with
another CPU. We generalised it to all ARMv6+ systems (so VIPT caches).

3.1:
  c7e89b16eb90 ("ARM: 6995/2: mm: remove unnecessary cache flush on v6 copypage")

That's when we realised that the CoW problem no longer exists for
non-aliasing VIPT caches. However, the I-cache counterpart 6060e8df5178
has not been reverted.

So I think that for arm64 and arm32 with non-aliasing VIPT,
flush_cache_range() can safely be a no-op.

-- 
Catalin
