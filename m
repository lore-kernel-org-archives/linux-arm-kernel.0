From: robh@kernel.org (Rob Herring)
Date: Mon, 2 Mar 2015 10:34:16 -0600
Subject: EDAC on arm64
In-Reply-To: <20150302145840.GQ22541@e104818-lin.cambridge.arm.com>
References: <54F11133.70909@redhat.com> <20150302105919.GA4434@arm.com>
 <20150302145840.GQ22541@e104818-lin.cambridge.arm.com>
Message-ID: <CAL_Jsq+ycHnjtFbmkHTn58vWNvvF81ON-nQBJ0CC5XZCLRnh-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 2, 2015 at 8:58 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Mar 02, 2015 at 10:59:32AM +0000, Will Deacon wrote:
>> On Sat, Feb 28, 2015 at 12:52:03AM +0000, Jon Masters wrote:
>> > Have you considered reviving the patch you posted previously for EDAC
>> > support (the atomic_scrub read/write test piece dependency)?
>> >
>> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/249039.html
>>
>> Well, we'd need a way to handle the non-coherent DMA case and it's really
>> not clear how to fix that.
>
> I agree, that's where the discussions stopped. Basically the EDAC memory
> writing is racy with any non-cacheable memory accesses (by CPU or
> device). The only way we could safely use this is only if all the
> devices are coherent *and* KVM is disabled. With KVM, guests may access
> the memory uncached, so we hit the same problem.

Scrubbing only prevents repeated error reporting of correctable errors
which only repeat on a cache miss. Perhaps we should just add an empty
version that is a nop. At least then we can enable EDAC and be able to
report errors. Otherwise, they may just be silently ignored (fine for
correctable, but not so good to do with uncorrectable errors).

Anyway, I'll leave it to someone who still has this itch to sort out.
My itch was cured.

Rob

>
> --
> Catalin
