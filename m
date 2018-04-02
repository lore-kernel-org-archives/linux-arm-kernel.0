From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 2 Apr 2018 09:53:33 +0200
Subject: [PATCH v5 1/5] mm: page_alloc: remain memblock_next_valid_pfn()
 on arm and arm64
In-Reply-To: <41445229-043c-976f-3961-13770163444f@gmail.com>
References: <1522636236-12625-1-git-send-email-hejianet@gmail.com>
 <1522636236-12625-2-git-send-email-hejianet@gmail.com>
 <CAKv+Gu96_sC1Q6-w4O-AXFZzNnH1WoGwJfqvSR+Q_k_bZbrUGg@mail.gmail.com>
 <41445229-043c-976f-3961-13770163444f@gmail.com>
Message-ID: <CAKv+Gu_CwWnW15jyTCY55akAikEjbgK4zRq_9=YuSDot3O3dQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 April 2018 at 09:49, Jia He <hejianet@gmail.com> wrote:
>
>
> On 4/2/2018 2:55 PM, Ard Biesheuvel Wrote:
>>
>> On 2 April 2018 at 04:30, Jia He <hejianet@gmail.com> wrote:
>>>
>>> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
>>> where possible") optimized the loop in memmap_init_zone(). But it causes
>>> possible panic bug. So Daniel Vacek reverted it later.
>>>
>>> But as suggested by Daniel Vacek, it is fine to using memblock to skip
>>> gaps and finding next valid frame with CONFIG_HAVE_ARCH_PFN_VALID.
>>>
>>> On arm and arm64, memblock is used by default. But generic version of
>>> pfn_valid() is based on mem sections and memblock_next_valid_pfn() does
>>> not always return the next valid one but skips more resulting in some
>>> valid frames to be skipped (as if they were invalid). And that's why
>>> kernel was eventually crashing on some !arm machines.
>>>
>>> And as verified by Eugeniu Rosca, arm can benifit from commit
>>> b92df1de5d28. So remain the memblock_next_valid_pfn on arm{,64} and move
>>> the related codes to arm64 arch directory.
>>>
>>> Suggested-by: Daniel Vacek <neelx@redhat.com>
>>> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
>>
>> Hello Jia,
>>
>> Apologies for chiming in late.
>
> no problem, thanks for your comments  ;-)
>>
>>
>> If we are going to rearchitect this, I'd rather we change the loop in
>> memmap_init_zone() so that we skip to the next valid PFN directly
>> rather than skipping to the last invalid PFN so that the pfn++ in the
>
> hmm... Maybe this macro name makes you confused
>
> pfn = skip_to_last_invalid_pfn(pfn);
>
> how about skip_to_next_valid_pfn?
>
>> for () results in the next value. Can we replace the pfn++ there with
>> a function calls that defaults to 'return pfn + 1', but does the skip
>> for architectures that implement it?
>
> I am not sure I understand your question here.
> With this patch, on !arm arches, skip_to_last_invalid_pfn is equal to (pfn),
> and will be increased
> when for{} loop continue. We only *skip* to the start pfn of next valid
> region when
> CONFIG_HAVE_MEMBLOCK and CONFIG_HAVE_ARCH_PFN_VALID(arm/arm64 supports
> both).
>

What I am saying is that the loop in memmap_init_zone

for (pfn = start_pfn; pfn < end_pfn; pfn++) { ... }

should be replaced by something like

for (pfn = start_pfn; pfn < end_pfn; pfn = next_valid_pfn(pfn))

where next_valid_pfn() is simply defined as

static ulong next_valid_pfn(ulong pfn)
{
  return pfn + 1;
}

by default, unless we do something special like you are proposing for
ARM and arm64, in which case you provide a different implementation.
That way, we no longer have to reason around the pfn++, and return an
invalid pfn so that the ++ will produce a valid pfn
