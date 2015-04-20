From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 20 Apr 2015 20:42:50 +0200
Subject: [PATCH] arm64: kill flush_cache_all()
In-Reply-To: <20150420180255.GB17767@leverpostej>
References: <1429521875-16893-1-git-send-email-mark.rutland@arm.com>
 <CAKv+Gu-VVA+wruJgfWksFdL5eXrp5nZV-b9q7eYspfi=KoqvEg@mail.gmail.com>
 <20150420180255.GB17767@leverpostej>
Message-ID: <CAKv+Gu_6u6wZrd=3z94Wqrab=G=bxm30=zWK0Rry3w+F92Wn9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 April 2015 at 20:02, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Apr 20, 2015 at 06:23:00PM +0100, Ard Biesheuvel wrote:
>> On 20 April 2015 at 11:24, Mark Rutland <mark.rutland@arm.com> wrote:
>> > The documented semantics of flush_cache_all are not possible to provide
>> > for arm64 (short of flushing the entire physical address space by VA),
>> > and there are currently no users; KVM uses VA maintenance exclusively,
>> > cpu_reset is never called, and the only two users outside of arch code
>> > cannot be built for arm64.
>> >
>> > While cpu_soft_reset and related functions (which call flush_cache_all)
>> > were thought to be useful for kexec, their current implementations only
>> > serve to mask bugs. For correctness kexec will need to perform
>> > maintenance by VA anyway to account for system caches, line migration,
>> > and other subtleties of the cache architecture. As the extent of this
>> > cache maintenance will be kexec-specific, it should probably live in the
>> > kexec code.
>> >
>> > This patch removes flush_cache_all, and related unused components,
>> > preventing further abuse.
>> >
>>
>> While I agree fully with the general purpose of this patch, i.e., to
>> prevent set/way operations to be abused for managing coherency,
>> perhaps it would make sense to retain/repurpose some of this code as
>> the 'supported' way of putting the CPU in the mode that is mandated by
>> the boot protocol, so that it can be shared between the EFI stub and
>> kexec.
>>
>> I think the former is not entirely safe at the moment, since the only
>> region we clean/invalidate [by VA] is the memory region containing the
>> copied kernel image, and the remainder of the efi-entry.S code itself.
>> I may be wrong, but I think that means that any cached software state
>> owned by the runtime services [including virtual remappings] could
>> potentially get lost when we disable the dcache without cleaning it by
>> set/way first.
>
> Regarding the boot protocol, note that this was relaxed a while back
> w.r.t. cache requirements, only mandating that certain regions of memory
> are clean to the PoC.
>
> Clearing SCTLR.C prevents accesses from being given cacheable
> attributes, but doesn't disable any caches as such. The CPU caches
> remain active and coherent (unless some IMPLEMENTATION DEFINED mechanism
> is used to exit coherency), so the data will remain there unless
> naturally evicted, taken by another cache, or explicitly
> cleaned/invalidated.
>
> With SCTLR.C clear, memory accesses should not result in the allocation
> of new lines into the caches (though if data for a given address is
> present, an access may hit said data). Clearing SCTLR.M is necessary to
> prevent allocation by the page table walkers, unless these are not using
> cacheable attributes to begin with.
>
> Set/Way maintenance races with the usual operation of the caches while
> cacheable accesses may be made into them, so do not make sense to use
> while SCTLR.C or SCTLR.M are set. They can only drain the CPU-local
> caches when nothing may allocate into them, and do not affect system
> caches, so portable software must use maintenance by VA for correctness.
>
> Does that address your concerns? Or pose new questions? ;)
>

Crystal clear. Lately I have been dealing with some dodgy Tianocore
code that 'promoted' VA operations to set/way operations if the VA
range exceeded a certain size threshold (and nuked the whole cache
instead), so by now I am well aware of the differences. I was just
vaguely under the impression that clearing the C bit could result in
the caches to lose state, but apparently not.

So that means the EFI stub entry code is sound, and I have no
objections whatsoever to removing flush_cache_all() et al

-- 
Ard.
