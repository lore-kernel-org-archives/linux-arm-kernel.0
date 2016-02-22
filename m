From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Feb 2016 18:17:40 +0100
Subject: [PATCH v3 4/4] arm64: prevent __va() translations before
 memstart_addr is assigned
In-Reply-To: <20160222165209.GK31168@arm.com>
References: <1455289046-21321-1-git-send-email-ard.biesheuvel@linaro.org>
 <1455289046-21321-5-git-send-email-ard.biesheuvel@linaro.org>
 <20160222165209.GK31168@arm.com>
Message-ID: <CAKv+Gu_BFK0cpSP1N7NC3brmfuHeXqTBxr-MGAkefLPfFSw6Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 February 2016 at 17:52, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Feb 12, 2016 at 03:57:26PM +0100, Ard Biesheuvel wrote:
>> Since memstart_addr is assigned relatively late in the boot code,
>> after generic code like DT parsing and memblock manipulation has
>> already occurred, we need to ensure that no __va() translation occur
>> until memstart_addr has been set to a meaningful value.
>>
>> So initialize memstart_addr to a value that cannot represent a valid
>> physical address, and BUG() if memstart_addr is referenced while it
>> still holds this value. Note that the > comparison against LLONG_MAX
>> (not ULLONG_MAX) resolves to a single tbnz instruction that performs
>> a conditional jump to a brk instruction that is emitted out of line.
>
> Even so, I'd imagine that having a measurable impact on system
> performance. Did you have a go at benchmarking this?
>

So in what kind of workload would the __pa() translation be on a hot
path? If you're dealing with DMA or other things that involve physical
addresses, surely, the single predicted non-taken branch instruction
shouldn't hurt?
