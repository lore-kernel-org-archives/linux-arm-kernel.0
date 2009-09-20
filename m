From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 20 Sep 2009 23:02:12 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <20090920093139.GA1704@n2100.arm.linux.org.uk>
References: <4A7AEEB6.5060903@googlemail.com>	<1250184014.14019.40.camel@pc1117.cambridge.arm.com>	<1250501311.9858.24.camel@pc1117.cambridge.arm.com>	<20090817140422.GA10764@n2100.arm.linux.org.uk>	<1250529916.11185.80.camel@pc1117.cambridge.arm.com>	<20090919224022.GA738@n2100.arm.linux.org.uk>	<1253435940.498.15.camel@pc1117.cambridge.arm.com>
	<20090920093139.GA1704@n2100.arm.linux.org.uk>
Message-ID: <4AB6A664.3010704@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Sun, Sep 20, 2009 at 09:39:00AM +0100, Catalin Marinas wrote:
>> On Sat, 2009-09-19 at 23:40 +0100, Russell King - ARM Linux wrote:
>>> On Mon, Aug 17, 2009 at 06:25:16PM +0100, Catalin Marinas wrote:
>>>> Assuming that the dynamic linker does instruction modifications as well
>>>> and expects the mprotect(RX) to flush the caches, the patch below
>>>> appears to fix the problem (not intensively tested). Note that I don't
>>>> say this is the right fix but it may work around the problem until
>>>> further investigation into the dynamic linker.
>>> Having now re-read the start of the thread, and put all the pieces
>>> together, the problem is not to do with SMP per-se, or Icache
>>> problems.
 >>
>> It's the I-D cache coherency.
> 
> You may be right, but the current evidence does not support that.
> If what you say is true, then all current ARMv6 and ARMv7 non-SMP
> systems would be affected.  So far, the bug report is only against
> SMP systems, where the cache is always forced to write allocate mode.

It is quite unlikely, though not impossible, for the I-cache to have 
stale entries. That's mainly because by the time a page cache page is 
reused for a different file, the corresponding I-cache entries are long 
gone. You could try on a software model to limit the amount of RAM and 
increase the I-cache size (I think AEM supports pseudo-infinite caches).

Data (instruction opcodes) not reaching the RAM because of 
write-allocate D-cache is the main issue, but it would be better to 
cover the I-cache coherency to avoid hard to reproduce bugs on some 
hardware configurations.

>>> I'd like to request that someone who can prove that the program works
>>> on ARMv6/v7 hardware does the following test:
>>>
>>> 1. boot the system with cachepolicy=writealloc
>>> 2. re-test the program
 >>
>> I don't think this would work. All the non-SMP v6/v7 processors I'm
>> aware of only support read-allocate caches, even if you try to force
>> write-allocate. On the SMP ones (Cortex-A9, ARM11MPCore), write-allocate
>> is the default.
> 
> Are you sure - I thought some of them did support write allocate.

I'm not entirely sure but that's what I recall. Anyway, you can run a UP 
kernel on ARM11MPCore.

>> I also recall that the cachepolicy argument was only affecting the
>> kernel mapping rather than the user one. Is this still the case?
> 
> Since changing the ptebits stuff, it affects everything.

Great.

>>> I think what we need to do is to ensure that the copy_user_highpage
>>> function is writing back data to the backing RAM, so it is visible
>>> to the I-cache when COWs of executable pages occur.  However, while
>>> we can pass this the vma, the vm_flags can't currently be used to
>>> detect COW of temporarily non-executable pages - which is what we
>>> want to detect to avoid having to clean the cache on every page
>>> copy.
 >>
>> copy_user_highpage() would work if we can detect the VM_EXEC flag but in
>> this case, the linker does mprotect(RW) before writing to the page (BTW,
>> this function could be fixed as well for RWX pages).
> 
> "can't currently be used" - yes, I'm aware of this.  

Sorry, I missed that line (too early in the morning).

> We could arrange
> to remember that the region had executable permission, and use that as
> a trigger for additional handling in copy_user_highpage().

Can the current dirty mechanism used for UP kernels be extended to cover 
this? The copy_user_highpage() could mark the page as dirty and later 
flush_cache_range() called via mprotect() could check this bit, similar 
to update_mmu_cache(). This would work on Cortex-A9 (where cache 
operations are detected by the snoop unit) but not on ARM11MPCore, where 
we can do it non-lazily.

We have the mechanism in place already, we could call 
flush_dcache_page(to) in copy_user_highpage() (which makes sense since 
the kernel is writing to a page visible to the user). Ideally, 
change_protection() should call update_mmu_cache() as well.

-- 
Catalin
