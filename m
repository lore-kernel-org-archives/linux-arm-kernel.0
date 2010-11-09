From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Tue, 9 Nov 2010 19:22:12 +0100
Subject: Cache clean of page table entries
In-Reply-To: <1289324189.11461.64.camel@e102109-lin.cambridge.arm.com>
References: <AANLkTinB8=fF7XiMvhEfPoBHh9A9qeHM-ZDP1UxxEyqY@mail.gmail.com>
	<1289240048.3541.153.camel@e102109-lin.cambridge.arm.com>
	<AANLkTimwhczn7nP1ys+iq-hv3Dh0pto+GsWc2fX=-WMg@mail.gmail.com>
	<1289324189.11461.64.camel@e102109-lin.cambridge.arm.com>
Message-ID: <AANLkTimh1jtcGMJJu2AJnxcVqfgmOgbOToeHzL8WsJtR@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 9, 2010 at 6:36 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, 2010-11-08 at 18:33 +0000, Christoffer Dall wrote:
>> On Mon, Nov 8, 2010 at 7:14 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> > On Fri, 2010-11-05 at 19:30 +0000, Christoffer Dall wrote:
>> >> What happens is this:
>> >> ?- The guest kernel allocates memory and writes a guest page table entry.
>> >
>> > Which address does it use to write the page table entry?
>>
>> It uses "it's own" virtual address. The guest has no knowledge of a
>> host or qemu and acts as if it runs natively. Therefore, if a standard
>> kernel maps its page tables at 0xc0002000, then the guest will write
>> the entries using 0xc0002000. It's up to KVM to create a mapping from
>> 0xc0002000 to a physical address. There will also be a mapping from
>> the Qemu process' address space to that same physical address and
>> possibly in the host kernel address space as well.
>
> OK, so it may be more efficient on ARMv7 (or ARMv6 with non-aliasing
> VIPT caches) to avoid extra flushing for aliases.

ah yes, PIPT caches will make my life easier...

>
>> > I assume at
>> > this stage is the one that Qemu uses in the host OS. Does the OS make
>> > any assumptions that the caches are disabled (Linux does this when
>> > setting up the initial page tables)? But the memory accesses are
>> > probably cacheable from the Qemu space.
>>
>> Yes, the entries are always marked as cacheable. The assumptions that
>> the MMU is turned off is only in the inital assembly code in head.S
>> right? Once we're in start_kernel(...) and subsequently
>> paging_init(...) the MMU is on and the kernel must clean the caches
>> right?
>
> Does KVM trap the cache maintenance operations that the guest kernel
> does and emulate them? There is even a full D-cache flushing before the
> MMU is enabled in the guest OS.

yes, they're caught and emulated in kvm. When testing I usually
clean+invalidate completely at all these emulation to be sure.
>
>> >> ?- Later, the guest tries to access the virtual address mapped through
>> >> the above entry
>> >> ?- The driver (KVM) will have to create a corresponding mapping in
>> >> it's shadow page tables (which are the ones used by the MMU). To do
>> >> so, it must read the guest page table.
>> >> ?- Before reading the data, the user space address (which is passed to
>> >> copy_from_user) is invalidated on the cache.
>> >> ?- From time to time, however the read returns incorrect
>> >> (uninitialized or stale) data.
>> >
>> > This happens usually because you may have invalidated a valid cache line
>> > which didn't make to RAM. You either use a flush (clean+invalidate) or
>> > make sure that the corresponding cache line has been flushed by whoever
>> > wrote that address. I think the former is safer.
>>
>> Yes, I learned that recently by spending a lot of time debugging
>> seemingly spurious bugs on the host. However, do you know how much of
>> a performance difference there is between flushing and invalidating a
>> clean line?
>
> Flushing is more expensive if there are dirty cache lines since they
> need to be written back and that depends on the bus and RAM speeds. But
> flushing and invalidating are operations to be used in different
> situations.
>
> If cache maintenance in the guest OS for page tables is done properly
> (i.e. cleaning or flushing is handled by KVM and emulated), in general
> you can only do an invalidation in the host kernel before reading. If
> you have non-aliasing VIPT caches, you don't even need to do this
> invalidation.
>
> But on the cache maintenance emulation part, is KVM switching the TTBR
> to the host OS when emulating the operations? If yes, the original
> virtual address is no longer present so you need to create the same
> alias before flushing (need to look at the KVM patches at some point).

well, there are two ways to handle this I guess. Either just
clean+invalidate the entire cache or perform the operation using
set/way where you loop over all the ways in the corresponding set, for
instance if the guest issues a clean by MVA. I have implemented the
latter, but there is no noticeable performance benefit from just
cleaning the entire cache so far.

>
>> > As long as you use copy_from_user which gets the same user virtual
>> > address, there is no need for any cache maintenance, you read it via the
>> > same alias so you hit the same cache lines anyway.
>>
>> I hope I explained this reasonably above. To clarify, the only time
>> Qemu writes to guest memory (ignoring i/o) is before initial boot when
>> it writes the bootloader and the kernel image to memory.
>
> That's clear now.
>
> Can you not force the ARMv6 to run in non-aliasing mode? I think there
> is a bit in some CP15 register (depending on the implementation) but it
> would limit the amount of cache to 16K (or 4K be way). Overall, it may
> be cheaper than all the cache maintenance that you have to do.

That's a really good suggestion. I should also also get my act
together and make stuff run on ARMv7 soon.
>
>> > In general, yes. But a guest OS may assume that the D-cache is disabled
>> > (especially during booting) and not do any cache maintenance.
>> >
>> > There is another situation where a page is allocated by Qemu and zero'ed
>> > by the kernel while the guest kernel tries to write it via a different
>> > mapping created by KVM. It only flushes the latter while the former may
>> > have some dirty cache lines being evicted (only if there is D-cache
>> > aliasing on ARMv6).
>>
>> I'm not sure what you mean here. Can you clarify a little?
>
> It may not be clear enough to me how kvm works. So Qemu has a virtual
> address space in the host OS. The guest OS has yet another virtual
> address space inside the virtual space of Qemu.

The guest OS has a virtual address space, which is completely
disconnected from that of the host (actually it has one per guest
process). However, it maps to "guest physical addresses" which are of
course not physical addresses, but merely an offset into the virtual
address range allocated by QEMU.

So, for example you have the following mappings:

Qemu maps 32MB of memory using standard malloc(...) and gets
addresses: 0x12000000 - 0x14000000
The guest maps the page at virtual address 0xffff0000 to guest
physical address 0x2000
Now, 0x2000 corresponds to the physical address backing the virtual
address (0x12000000 + 0x2000) = 0x12002000, let's call this X
KVM maps (in the shadow page table) from 0xffff0000 to X

Iow. you have 4 address spaces, guest virtual, guest physical, host
virtual and machine addresses (actual physical addresses)

>
> The Qemu virtual space is allocated by the host kernel. The anonymous
> pages are zero'ed or copied-on-write by the kernel before being mapped
> into user space. But cache flushing takes place already (at least in
> newer kernels), so that's not an issue.
>
> When creating a virtual mapping, does KVM pin the Qemu pages in memory
> using something like get_user_pages or does KVM allocates the pages
> itself?

KVM uses get_user_pages, and for other things, like the pages for the
shadow page tables them selves, uses simply __get_free_pages(...)
since these are unrelated to the guest memory.

-Christoffer
