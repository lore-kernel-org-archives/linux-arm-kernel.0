From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 4 Mar 2015 12:50:57 +0100
Subject: [RFC/RFT PATCH 0/3] arm64: KVM: work around incoherency with
 uncached guest mappings
In-Reply-To: <20150304113505.GS28951@e104818-lin.cambridge.arm.com>
References: <CAKv+Gu8Je3RRrgEFCZ7JUWtOgk3WqA_qdBEOPAMc3OqnKr1bwg@mail.gmail.com>
 <20150219175518.GB26965@hawk.usersys.redhat.com>
 <54E62404.9040702@redhat.com>
 <20150220142905.GA10942@hawk.usersys.redhat.com>
 <CAKv+Gu-YUzmnACZQi98OPRgKKL+gAGqwWYq2-_dwCdNqcktNUg@mail.gmail.com>
 <20150220153626.GB10942@hawk.usersys.redhat.com>
 <20150224145529.GA5498@hawk.usersys.redhat.com>
 <CAKv+Gu-Uk2wg1OkoWgQe4da_EiFoEz_u8VuD8Ees6qU1UYMDvQ@mail.gmail.com>
 <20150302163146.GB9686@lvm> <54F51A63.4060302@samsung.com>
 <20150304113505.GS28951@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu8OUtcpaQh5+gb6vNrdi+Q7eu_zKOujmyoRPrzrs+GJVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 March 2015 at 12:35, Catalin Marinas <catalin.marinas@arm.com> wrote:
> (please try to avoid top-posting)
>
> On Mon, Mar 02, 2015 at 06:20:19PM -0800, Mario Smarduch wrote:
>> On 03/02/2015 08:31 AM, Christoffer Dall wrote:
>> > However, my concern with these patches are on two points:
>> >
>> > 1. It's not a fix-all.  We still have the case where the guest expects
>> > the behavior of device memory (for strong ordering for example) on a RAM
>> > region, which we now break.  Similiarly this doesn't support the
>> > non-coherent DMA to RAM region case.
>> >
>> > 2. While the code is probably as nice as this kind of stuff gets, it
>> > is non-trivial and extremely difficult to debug.  The counter-point here
>> > is that we may end up handling other stuff at EL2 for performanc reasons
>> > in the future.
>> >
>> > Mainly because of point 1 above, I am leaning to thinking userspace
>> > should do the invalidation when it knows it needs to, either through KVM
>> > via a memslot flag or through some other syscall mechanism.
>
> I expressed my concerns as well, I'm definitely against merging this
> series.
>

Don't worry, that was never the intention, at least not as-is :-)

I think we have established that the performance hit is not the
problem but the correctness is.

I do have a remaining question, though: my original [non-working]
approach was to replace uncached mappings with write-through
read-allocate write-allocate, which I expected would keep the caches
in sync with main memory, but apparently I am misunderstanding
something here. (This is the reason for s/0xbb/0xff/ in patch #2 to
get it to work: it replaces WT/RA/WA with WB/RA/WA)

Is there no way to use write-through caching here?

>> I don't understand how can the CPU handle different cache attributes
>> used by QEMU and Guest won't you run into B2.9 checklist? Wouldn't
>> cache evictions or cleans wipe out guest updates to same cache
>> line(s)?
>
> "Clean+invalidate" is a safe operation even if the guest accesses the
> memory in a cacheable way. But if the guest can update the cache lines,
> Qemu should avoid cache maintenance from a performance perspective.
>
> The guest is either told that the DMA is coherent (via DT properties) or
> Qemu deals with (non-)coherency itself. The latter is fully in line with
> the B2.9 chapter in the ARM ARM, more precisely point 5:
>
>   If the mismatched attributes for a memory location all assign the same
>   shareability attribute to the location, any loss of uniprocessor
>   semantics or coherency within a shareability domain can be avoided by
>   use of software cache management.
>
> ... it continues with what kind of cache maintenance is required,
> together with:
>
>   A clean and invalidate instruction can be used instead of a clean
>   instruction, or instead of an invalidate instruction.
>
> --
> Catalin
