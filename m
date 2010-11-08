From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Mon, 8 Nov 2010 19:33:31 +0100
Subject: Cache clean of page table entries
In-Reply-To: <1289240048.3541.153.camel@e102109-lin.cambridge.arm.com>
References: <AANLkTinB8=fF7XiMvhEfPoBHh9A9qeHM-ZDP1UxxEyqY@mail.gmail.com>
	<1289240048.3541.153.camel@e102109-lin.cambridge.arm.com>
Message-ID: <AANLkTimwhczn7nP1ys+iq-hv3Dh0pto+GsWc2fX=-WMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 8, 2010 at 7:14 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Fri, 2010-11-05 at 19:30 +0000, Christoffer Dall wrote:
>> What happens is this:
>> ?- The guest kernel allocates memory and writes a guest page table entry.
>
> Which address does it use to write the page table entry?
It uses "it's own" virtual address. The guest has no knowledge of a
host or qemu and acts as if it runs natively. Therefore, if a standard
kernel maps its page tables at 0xc0002000, then the guest will write
the entries using 0xc0002000. It's up to KVM to create a mapping from
0xc0002000 to a physical address. There will also be a mapping from
the Qemu process' address space to that same physical address and
possibly in the host kernel address space as well.

> I assume at
> this stage is the one that Qemu uses in the host OS. Does the OS make
> any assumptions that the caches are disabled (Linux does this when
> setting up the initial page tables)? But the memory accesses are
> probably cacheable from the Qemu space.
>
Yes, the entries are always marked as cacheable. The assumptions that
the MMU is turned off is only in the inital assembly code in head.S
right? Once we're in start_kernel(...) and subsequently
paging_init(...) the MMU is on and the kernel must clean the caches
right?

>
> Does the guest kernel later try to write the page table entry via the
> virtual address set up by KVM? In this case, you may have yet another
> alias.

Yes, lots of aliases :)
>
>> ?- Later, the guest tries to access the virtual address mapped through
>> the above entry
>> ?- The driver (KVM) will have to create a corresponding mapping in
>> it's shadow page tables (which are the ones used by the MMU). To do
>> so, it must read the guest page table.
>> ?- Before reading the data, the user space address (which is passed to
>> copy_from_user) is invalidated on the cache.
>> ?- From time to time, however the read returns incorrect
>> (uninitialized or stale) data.
>
> This happens usually because you may have invalidated a valid cache line
> which didn't make to RAM. You either use a flush (clean+invalidate) or
> make sure that the corresponding cache line has been flushed by whoever
> wrote that address. I think the former is safer.

Yes, I learned that recently by spending a lot of time debugging
seemingly spurious bugs on the host. However, do you know how much of
a performance difference there is between flushing and invalidating a
clean line?

>
> As long as you use copy_from_user which gets the same user virtual
> address, there is no need for any cache maintenance, you read it via the
> same alias so you hit the same cache lines anyway.

I hope I explained this reasonably above. To clarify, the only time
Qemu writes to guest memory (ignoring i/o) is before initial boot when
it writes the bootloader and the kernel image to memory.

[snip]
>
> In general, yes. But a guest OS may assume that the D-cache is disabled
> (especially during booting) and not do any cache maintenance.
>
> There is another situation where a page is allocated by Qemu and zero'ed
> by the kernel while the guest kernel tries to write it via a different
> mapping created by KVM. It only flushes the latter while the former may
> have some dirty cache lines being evicted (only if there is D-cache
> aliasing on ARMv6).

I'm not sure what you mean here. Can you clarify a little?
>
>> But, for instance, I see that in arch/arm/mm/mmu.c the
>> create_36bit_mapping function writes a pmd entry without calling
>> flush_pmd_entry(...).
>
> It looks like it's missing. But maybe this was done for one of the
> xscale hardware which was fully coherent. I think we should do this.
>
ok, thanks. It was just throwing me a little off.


Thanks,
Christoffer
