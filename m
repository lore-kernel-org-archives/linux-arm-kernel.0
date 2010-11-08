From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 08 Nov 2010 18:14:08 +0000
Subject: Cache clean of page table entries
In-Reply-To: <AANLkTinB8=fF7XiMvhEfPoBHh9A9qeHM-ZDP1UxxEyqY@mail.gmail.com>
References: <AANLkTinB8=fF7XiMvhEfPoBHh9A9qeHM-ZDP1UxxEyqY@mail.gmail.com>
Message-ID: <1289240048.3541.153.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-11-05 at 19:30 +0000, Christoffer Dall wrote:
> What happens is this:
>  - The guest kernel allocates memory and writes a guest page table entry.

Which address does it use to write the page table entry? I assume at
this stage is the one that Qemu uses in the host OS. Does the OS make
any assumptions that the caches are disabled (Linux does this when
setting up the initial page tables)? But the memory accesses are
probably cacheable from the Qemu space.

Does the guest kernel later try to write the page table entry via the
virtual address set up by KVM? In this case, you may have yet another
alias.

>  - Later, the guest tries to access the virtual address mapped through
> the above entry
>  - The driver (KVM) will have to create a corresponding mapping in
> it's shadow page tables (which are the ones used by the MMU). To do
> so, it must read the guest page table.
>  - Before reading the data, the user space address (which is passed to
> copy_from_user) is invalidated on the cache.
>  - From time to time, however the read returns incorrect
> (uninitialized or stale) data.

This happens usually because you may have invalidated a valid cache line
which didn't make to RAM. You either use a flush (clean+invalidate) or
make sure that the corresponding cache line has been flushed by whoever
wrote that address. I think the former is safer.

As long as you use copy_from_user which gets the same user virtual
address, there is no need for any cache maintenance, you read it via the
same alias so you hit the same cache lines anyway.
> 
> I understand that since the data is read from a different virtual
> address than it is written to, there may be aliasing issues. However,
> I would think it was sufficient to invalidate the cache by
> MVA on the read side. 

On some ARMv6 cores you may have cache aliasing issues. You can use
invalidating only if you are sure the writer cleaned the cache,
otherwise you miss some data.

> The reason is that, as far as I understand, the
> guest kernel must generally clean cache entries and drain the write
> buffer for shadow page table entry writes, since the MMU doesn't read
> from L1 caches on TLB misses.

In general, yes. But a guest OS may assume that the D-cache is disabled
(especially during booting) and not do any cache maintenance.

There is another situation where a page is allocated by Qemu and zero'ed
by the kernel while the guest kernel tries to write it via a different
mapping created by KVM. It only flushes the latter while the former may
have some dirty cache lines being evicted (only if there is D-cache
aliasing on ARMv6).

> But, for instance, I see that in arch/arm/mm/mmu.c the
> create_36bit_mapping function writes a pmd entry without calling
> flush_pmd_entry(...).

It looks like it's missing. But maybe this was done for one of the
xscale hardware which was fully coherent. I think we should do this.

Catalin
