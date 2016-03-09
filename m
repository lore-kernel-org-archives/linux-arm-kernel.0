From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 9 Mar 2016 12:03:10 +0700
Subject: [PATCH 0/3] arm64: simplify and optimize kernel mapping
In-Reply-To: <20160307014031.GA2158@svinekod>
References: <1457010581-4924-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160307014031.GA2158@svinekod>
Message-ID: <CAKv+Gu_RRtARFsgc516GjhceiT=i4iS6P4muG++ciB6eO-cH+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 March 2016 at 08:40, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> I like this series, though I have a few minor comments below.
>
> On Thu, Mar 03, 2016 at 02:09:38PM +0100, Ard Biesheuvel wrote:
>> This series makes a couple of minor changes that should result in the
>> kernel being mapped in a more efficient manner.
>>
>> First of all, it merges the .head.text with the .text section (patch #2)
>> after moving everything except the kernel and EFI header into the __init
>> section (patch #1)
>
> Face-to-face, you suggested it might be possible to move .init before .text, so
> we could place the EFI header in there too (and keep .text aligned while making
> it smaller). Is there some reason we missed that means we cannot do this?
>

Well, I tried implementing this, and it breaks the PIE linking. That
itself is probably a binutils problem, and I will try to follow up on
that with the toolchain group. But in the meantime, it means we cannot
reorder .text and .init.

>> Then, it standardizes the segment alignment to 64 KB for all page sizes.
>> (patch #3). In the example below (4 KB granule, with Jeremy's PTE_CONT
>> patch applied), we lose 80 KB in total to padding, but the resulting
>> mappings do look somewhat better.
>
> I suspect some people might want a minimal alignment option for tinification
> purposes, but this sounds fine to me as a default. I also think we can wait
> until someone asks.
>
> As a general think, currently we use "chunk" instead of "segment" in the mm
> code. We only used "chunk" so as to not overload "section". For consistency it
> would be nice to either keep with "chunk" or convert existing uses to
> "segment". I much prefer the latter!
>

OK

>> Before:
>>
>> 0xffff000008082000-0xffff000008090000    56K  ro x  SHD AF         UXN MEM
>> 0xffff000008090000-0xffff000008200000  1472K  ro x  SHD AF CON     UXN MEM
>> 0xffff000008200000-0xffff000008600000     4M  ro x  SHD AF     BLK UXN MEM
>> 0xffff000008600000-0xffff000008660000   384K  ro x  SHD AF CON     UXN MEM
>> 0xffff000008660000-0xffff00000866c000    48K  ro x  SHD AF         UXN MEM
>> 0xffff00000866c000-0xffff000008670000    16K  ro NX SHD AF         UXN MEM
>> 0xffff000008670000-0xffff000008900000  2624K  ro NX SHD AF CON     UXN MEM
>> 0xffff000008900000-0xffff000008909000    36K  ro NX SHD AF         UXN MEM
>> 0xffff000008c39000-0xffff000008c40000    28K  RW NX SHD AF         UXN MEM
>> 0xffff000008c40000-0xffff000008d50000  1088K  RW NX SHD AF CON     UXN MEM
>> 0xffff000008d50000-0xffff000008d57000    28K  RW NX SHD AF         UXN MEM
>>
>> After:
>>
>> 0xffff000008080000-0xffff000008200000  1536K  ro x  SHD AF CON     UXN MEM
>> 0xffff000008200000-0xffff000008600000     4M  ro x  SHD AF     BLK UXN MEM
>> 0xffff000008600000-0xffff000008670000   448K  ro x  SHD AF CON     UXN MEM
>> 0xffff000008670000-0xffff000008910000  2688K  ro NX SHD AF CON     UXN MEM
>> 0xffff000008c50000-0xffff000008d60000  1088K  RW NX SHD AF CON     UXN MEM
>> 0xffff000008d60000-0xffff000008d6b000    44K  RW NX SHD AF         UXN MEM
>>
>> I am aware that this clashes with Jeremy's patch to allow CONT_SIZE alignment
>> when CONFIG_DEBUG_ALIGN_RODATA=y, but the net effect of patch #3 is the same
>> (only the Kconfig change is not included here)
>
> Jeremy, do you have any thoughts on this series?
>
> Thanks,
> Mark.
>
>> Ard Biesheuvel (3):
>>   arm64: move early boot code to the .init segment
>>   arm64: cover the .head.text section in the .text segment mapping
>>   arm64: simplify kernel segment mapping granularity
>>
>>  arch/arm64/kernel/efi-entry.S   |  2 +-
>>  arch/arm64/kernel/head.S        | 32 +++++++++-----------
>>  arch/arm64/kernel/image.h       |  4 +++
>>  arch/arm64/kernel/vmlinux.lds.S | 26 +++++++++-------
>>  arch/arm64/mm/mmu.c             | 10 +++---
>>  5 files changed, 40 insertions(+), 34 deletions(-)
>>
>> --
>> 2.5.0
>>
