From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Sep 2009 22:58:46 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <20090921201043.GA14700@shareable.org>
References: <20090919224022.GA738@n2100.arm.linux.org.uk>	<1253435940.498.15.camel@pc1117.cambridge.arm.com>	<20090920093139.GA1704@n2100.arm.linux.org.uk>	<20090920190227.GB5413@n2100.arm.linux.org.uk>	<4AB6B0AB.8040307@arm.com>
	<20090921083109.GC20006@shareable.org>	<1253522944.1541.3.camel@pc1117.cambridge.arm.com>	<20090921085425.GC27357@n2100.arm.linux.org.uk>	<1253526263.1541.32.camel@pc1117.cambridge.arm.com>	<20090921100751.GF27357@n2100.arm.linux.org.uk>
	<20090921201043.GA14700@shareable.org>
Message-ID: <4AB7F716.2070206@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jamie Lokier wrote:
> Russell King - ARM Linux wrote:
>> On Mon, Sep 21, 2009 at 10:44:23AM +0100, Catalin Marinas wrote:
>>> I would still call this I-D cache coherency issue since the two caches
>>> have a different view of the RAM but I agree that the D-cache is the one
>>> holding the data (with a slight chance for the I-cache not to be in sync
>>> with main RAM, though we could treat it separately).
>>>
>>> We can sort out the D-cache issue with your approach for cleaning it in
>>> the copy_user_highpage() function, but, as I said, we affect the
>>> standard CoW mechanism for data pages quite a lot.
>> Let me restate my approach more clearly:
>>
>> 1. Remember that a VMA has been executable.
>> 2. Only do the additional handing if the VMA has been executable.
> 
> Sorry, I'm a little confused, and I'm trying to understand what I can
> safely assume is reliable when using mprotect.

With the current kernel, using mprotect(RX) requires sys_cacheflush.

The patch I proposed handles the mprotect(RX) case and as a side-effect 
deals with the linker way of writing the relocations.

> If the problem is data in the D-cache not being flushed to be read as
> data from a text page (i.e. nothing to do with I-cache, it's all about
> the D-cache between different mappings), why is the previous
> executableness of the VMA relevant to the solution?

Well, it's a workaround to the dynamic linker issue we are having. The 
linker usually maps a file with RX rights and then checks for 
relocations. If these are needed, it calls mprotect(RW). Now we just 
assume that if the area was once executable, it is only temporarily 
marked RW.

> And here's a little something:
> 
> http://www.mail-archive.com/aufs-users at lists.sourceforge.net/msg02093.html
> 
> It's about MIPS, but has an awful lot of things in common with the bug
> being discussed in this thread: dynamic linker, constants embedded in
> the code, using mprotect rx->rw->rx, missing I-cache flush, only
> affects COW, copy_user_highpage(), is worked around by switching the
> cache from write-back to write-through...
> 
> Useful?

Very useful, thanks. It looks similar to the approach I proposed but the 
difference I think is that MIPS was already flushing the D-cache in 
flush_cache_range and they just added the I-cache invalidation. In our 
case (VIPT non-aliasing caches) we don't flush the D-cache at all in 
flush_cache_range().

> I found that while searching to see if mprotect rw->rx implies I-cache
> flush.  On IRIX it's explicitly documented to, in fact it has
> PROT_EXEC_NOFLUSH in case you want to optimise that away :-) Haven't
> found anything to confirm or deny it for Linux or anything else,
> though.

Maybe we should raise this on linux-arch and get some consistent 
approach between other Harvard architectures.

If we go this route, I can try to do a few more optimisations to my 
patch. But for the RWX case, we need to handle it via copy_user_highpage 
(though pretty simple check of the vm_flags).

> Hopefully it's clear that munmap of the region, followed by mmap
> PROT_READ|PROTE_EXEC to restore the mapping with different permissions
> (when it has a backing file) - hopefully it's clear that _that_ will
> do the needed I-cache flush.

It will indeed do the I-cache invalidation via update_mmu_cache() during 
fault processing after mmap but not necessarily D-cache cleaning. So if 
you write any instructions, make sure you call sys_cacheflush(). For 
shared mappings (no CoW), writing only data to text pages should be fine.

A possible scenario (though more code analysis is needed to be entirely 
sure) with writing instructions and not calling sys_cacheflush():

- application mmap's a file (shared mapping, otherwise the data written 
to private mappings is lost when unmapping)
- app writes some instructions to text pages. We don't get CoW because 
of the shared mapping but we don't get D-cache cleaning either
- app unmap's the page but the kernel keeps the physical page in its 
page cache. The flush_cache_page() on non-aliasing VIPT doesn't do 
anything on ARM
- app mmap's the page with PROT_READ|PROT_EXEC
- app executes from the page generating a prefetch abort. The kernel 
finds the page in its page cache and maps it into user space, calling 
update_mmu_cache(). However, the dirty bit isn't set (since the kernel 
hasn't touched the page) and the lazy D-cache flushing in 
update_mmu_cache isn't triggered, leaving the I-cache with old entries 
directly from RAM.

-- 
Catalin
