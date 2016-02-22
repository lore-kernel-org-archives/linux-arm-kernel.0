From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Feb 2016 18:55:53 +0100
Subject: [PATCH v3 4/4] arm64: prevent __va() translations before
 memstart_addr is assigned
In-Reply-To: <20160222174124.GB5018@localhost.localdomain>
References: <1455289046-21321-1-git-send-email-ard.biesheuvel@linaro.org>
 <1455289046-21321-5-git-send-email-ard.biesheuvel@linaro.org>
 <20160222165209.GK31168@arm.com>
 <CAKv+Gu_BFK0cpSP1N7NC3brmfuHeXqTBxr-MGAkefLPfFSw6Gg@mail.gmail.com>
 <20160222174124.GB5018@localhost.localdomain>
Message-ID: <CAKv+Gu__aTAud736rqHdRk7=aObnZr8yjVXMBBmmv_TR=mqm-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 February 2016 at 18:41, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Feb 22, 2016 at 06:17:40PM +0100, Ard Biesheuvel wrote:
>> On 22 February 2016 at 17:52, Will Deacon <will.deacon@arm.com> wrote:
>> > On Fri, Feb 12, 2016 at 03:57:26PM +0100, Ard Biesheuvel wrote:
>> >> Since memstart_addr is assigned relatively late in the boot code,
>> >> after generic code like DT parsing and memblock manipulation has
>> >> already occurred, we need to ensure that no __va() translation occur
>> >> until memstart_addr has been set to a meaningful value.
>> >>
>> >> So initialize memstart_addr to a value that cannot represent a valid
>> >> physical address, and BUG() if memstart_addr is referenced while it
>> >> still holds this value. Note that the > comparison against LLONG_MAX
>> >> (not ULLONG_MAX) resolves to a single tbnz instruction that performs
>> >> a conditional jump to a brk instruction that is emitted out of line.
>> >
>> > Even so, I'd imagine that having a measurable impact on system
>> > performance. Did you have a go at benchmarking this?
>>
>> So in what kind of workload would the __pa() translation be on a hot
>> path? If you're dealing with DMA or other things that involve physical
>> addresses, surely, the single predicted non-taken branch instruction
>> shouldn't hurt?
>
> I recall we looked at this in the early arm64 days and found a lot of
> memory accesses to memstart_addr but we decided to keep it as the
> alternatives would have been: (a) no more single Image or (b) always
> 4-levels page tables.
>
> You could try perf to get some statistics but, for example, most of the
> code that works on pages (e.g. block I/O) and needs to access a page
> ends up doing a kmap(page) which in turns does a __va(). You also have
> lots of virt_to_page() calls in sl*b, so we need to see what impact this
> change has.
>

I guess virt_to_page() is only valid on linear addresses, so we could
reimplement it not to use the comparison with PAGE_OFFSET that I added
to __pa() for the kernmap stuff
