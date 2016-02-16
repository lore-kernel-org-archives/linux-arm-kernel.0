From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 16 Feb 2016 13:11:41 +0100
Subject: [PATCH] arm64: mark kernel text segment as MEMBLOCK_NOMAP
In-Reply-To: <56C30441.1080003@arm.com>
References: <1455528512-32491-1-git-send-email-ard.biesheuvel@linaro.org>
 <56C2FF07.30205@arm.com>
 <CAKv+Gu_yTz-ohFPS0wMX42iCkDNaSwZoZ8Yi-zsZNNu1LNDkZQ@mail.gmail.com>
 <56C30441.1080003@arm.com>
Message-ID: <CAKv+Gu9=_qCirHeRJzNqbfgCCXrWb_q4GL0_fWJPHMy4Es8Efg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 February 2016 at 12:13, James Morse <james.morse@arm.com> wrote:
> On 16/02/16 10:57, Ard Biesheuvel wrote:
>> On 16 February 2016 at 11:50, James Morse <james.morse@arm.com> wrote:
>>> On 15/02/16 09:28, Ard Biesheuvel wrote:
>>>> This should hopefully address the issue reported by James, but I suppose
>>>> more work is required on the hibernate side to ensure the unmapped text
>>>> region is preserved, since it is no longer covered by the linear mapping.
>>>
>>> It does, now I have to work out how best to fix hibernate!
>>>
>>
>> Indeed. The alternative would be to map the [_stext, _etext] interval
>> into the linear region as a ro/nx alias of the actual mapping in the
>> vmalloc region. That would probably make your life easier, but I am
>> not convinced the overall result is better.
>
> I assumed you would NACK any approach that looked like that:
> It could be done temporarily while the memory snapshot is being taken, only
> swsusp_save() would see this mapping, it can be removed again afterwards. But
> pfn_valid() will still say those pages aren't there, and there is no
> memblock_clear_nomap() to change this.
>

Actually, we may have memblock_clear_nomap() at some point, since we
need it to simply relocate_initrd(), i.e., moving the initrd if its
memory is not covered by the linear mapping is much more complicated
than simply adding its memory to the linear mapping, and that requires
clearing the NOMAP flag as well if the region intersects with the UEFI
memory map (this is a corner case but one that does occur in practice)

But in this case, clearing the NOMAP flag only to appease pfn_valid()
is not the right approach, imo. Once the linear mapping is created, we
should not change the underlying memblock regions anymore. Also, what
pfn_valid() tells you should be in sync with what mappings are
actually present in the linear region (i.e., the issue you hit
originally)

> The current approach involves copying the kernel text into pages that are saved,
> and having two lists of pages that need restoring. (wheels within wheels!)
> Pretty unpleasant, and requires another patch in the core code, so likely won't
> be possible for v4.6. I should have the patches out for review later today.
>

I think a ro/nx alias in the linear region for [_stext, _etext] is
pretty harmless, and much preferred over having to add hacks on top of
generic layers like hibernate. The cost in terms of page tables and
TLB entries is zero, since the adjacent regions are mapped anyway, and
the region is never accessed during normal use.

So I will fold that in before sending out my v6.

-- 
Ard.
