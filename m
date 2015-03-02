From: robh@kernel.org (Rob Herring)
Date: Mon, 2 Mar 2015 16:57:23 -0600
Subject: EDAC on arm64
In-Reply-To: <20150302222704.GB13277@MBP.local>
References: <54F11133.70909@redhat.com> <20150302105919.GA4434@arm.com>
 <20150302145840.GQ22541@e104818-lin.cambridge.arm.com>
 <CAL_Jsq+ycHnjtFbmkHTn58vWNvvF81ON-nQBJ0CC5XZCLRnh-g@mail.gmail.com>
 <20150302222704.GB13277@MBP.local>
Message-ID: <CAL_Jsq+dx3kYAhiGV+NKXaeZZLCk55pDs26J-yaNQtCKqCHZVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 2, 2015 at 4:27 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Mar 02, 2015 at 10:34:16AM -0600, Rob Herring wrote:
>> On Mon, Mar 2, 2015 at 8:58 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> > On Mon, Mar 02, 2015 at 10:59:32AM +0000, Will Deacon wrote:
>> >> On Sat, Feb 28, 2015 at 12:52:03AM +0000, Jon Masters wrote:
>> >> > Have you considered reviving the patch you posted previously for EDAC
>> >> > support (the atomic_scrub read/write test piece dependency)?
>> >> >
>> >> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/249039.html
>> >>
>> >> Well, we'd need a way to handle the non-coherent DMA case and it's really
>> >> not clear how to fix that.
>> >
>> > I agree, that's where the discussions stopped. Basically the EDAC memory
>> > writing is racy with any non-cacheable memory accesses (by CPU or
>> > device). The only way we could safely use this is only if all the
>> > devices are coherent *and* KVM is disabled. With KVM, guests may access
>> > the memory uncached, so we hit the same problem.
>>
>> Scrubbing only prevents repeated error reporting of correctable errors
>> which only repeat on a cache miss. Perhaps we should just add an empty
>> version that is a nop.
>
> Can the error be cleared by a cache clean&invalidate by VA?

Yes, but only if the line is in fact dirty. If the line is clean, it
will just make the error repeat on every access. You can't make the
line dirty for the same reasons you've mentioned.

Rob
