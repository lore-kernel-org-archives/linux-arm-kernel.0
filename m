From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 24 May 2016 16:12:35 +0100
Subject: [PATCH 1/1] arm64: fix flush_cache_range
In-Reply-To: <574446B9.8040105@huawei.com>
References: <1464088597-8820-1-git-send-email-thunder.leizhen@huawei.com>
 <20160524113727.GD25374@leverpostej> <574446B9.8040105@huawei.com>
Message-ID: <20160524151235.GA11605@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2016 at 08:19:05PM +0800, Leizhen (ThunderTown) wrote:
> 
> 
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
> But I see some other platforms have D-cache maintenance, like: arch/nios2/mm/cacheflush.c
> And according to the name of flush_cache_range, it should do this, I judged. Otherwise,
> mprotect04 will be failed on more platforms, it's easy to discover.

>From my experience with the LTP, it's likely that the test was written
and tested on very few architectures and kernel configurations, and has
seen very little testing on others.

> Only PPC have specific cache synchronization, maybe it meets some
> hardware limitation. 

Per [1] that "hardware limitation" is  simply the presence of a Harvard
cache architecture, similar to that of ARM.

> It's impossible a programmer fixed a common bug on only one platform
> but leave others unchanged.

The common problem here is I-cache coherency, but that must be managed
in an architecture-specific way. The patch for PPC [1] added
PPC-specific assembly to achieve that, and hence doesn't apply to other
platforms.

Jumping back to the problem at hand:

It looks like we inherited this from ARM, which has done this for all
executable mappings since commit  6060e8df517847bf ("ARM: I-cache: flush
executable mappings in flush_cache_range()"). The commit message refers
to a4db94d, which doesn't seem to exist, and I assume is
115b22474eb1905d ("ARM: 5794/1: Flush the D-cache during
copy_user_highpage()") which happened to get rebased at some point.

That all implies that the icache maintenance is only intended to ensure
that CoW does not result in unexpected incoherency. Which in turn
implies that flipping permissions with mprotect is not expected to
synchronise the D and I caches.

Russell, does that analysis make sense to you?

Ben, Paul, Michael, I take it that the LTP commit for PPC [1] is as
expected? i.e. you similarly do not expect flipping execute permission
with mprotect to imply that the kernel must synchronise the D & I
caches?

Thanks,
Mark.

> > It looks like the test may be missing I-cache maintenance regardless of
> > the semantics of mprotect in this case.
> > 
> > I have not yet devled into flush_cache_range and how it is called.
> 
> SYSCALL_DEFINE3(mprotect ---> mprotect_fixup ---> change_protection ---> change_protection_range --> flush_cache_range
> 
> > 
> > Thanks,
> > Mark.
> > 
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> ---
> >>  arch/arm64/mm/flush.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
> >> index dbd12ea..eda4124 100644
> >> --- a/arch/arm64/mm/flush.c
> >> +++ b/arch/arm64/mm/flush.c
> >> @@ -31,7 +31,7 @@ void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
> >>  		       unsigned long end)
> >>  {
> >>  	if (vma->vm_flags & VM_EXEC)
> >> -		__flush_icache_all();
> >> +		flush_icache_range(start, end);
> >>  }
> >>
> >>  static void sync_icache_aliases(void *kaddr, unsigned long len)
> >> --
> >> 2.5.0
> >>
> >>
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel at lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >>
> > 
> > .
> > 
> 

[1] https://github.com/linux-test-project/ltp/commit/cf9a0800cd0d71c8c471adc5631216f995ab7e02
