From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 11 Oct 2016 12:17:54 +0100
Subject: [PATCH] arm64: mmu: set the contiguous for kernel mappings when
 appropriate
In-Reply-To: <CAKv+Gu-e6HT2YNvXJV2AbAzLrEeV6OvM6-hfTsCH0oXqH8zbKQ@mail.gmail.com>
References: <1476123164-10532-1-git-send-email-ard.biesheuvel@linaro.org>
 <20161011074419.GA20213@remoulade>
 <CAPvkgC1p5yZLtENYMi6zd5-pPDOYUtMw0Lxvb592u975gc+Zvg@mail.gmail.com>
 <CAKv+Gu-e6HT2YNvXJV2AbAzLrEeV6OvM6-hfTsCH0oXqH8zbKQ@mail.gmail.com>
Message-ID: <CAKv+Gu9W69rP5o09t+d498nVE666Show1VK-Sm9LmchjeUsD_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 October 2016 at 10:09, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 11 October 2016 at 09:48, Steve Capper <steve.capper@linaro.org> wrote:
>>
>>
>> On 11 October 2016 at 08:44, Mark Rutland <mark.rutland@arm.com> wrote:
>>>
>>> Hi Ard,
>>>
>>> On Mon, Oct 10, 2016 at 07:12:44PM +0100, Ard Biesheuvel wrote:
>>> > Now that we no longer allow live kernel PMDs to be split, it is safe to
>>> > start using the contiguous bit for kernel mappings. So set the
>>> > contiguous
>>> > bit in the kernel page mappings for regions whose size and alignment are
>>> > suitable for this.
>>> >
>>> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>
>>> Given the splitting is now gone, using the contiguous bit makes sense to
>>> me.
>>>
>>> With 16K pages, we can have contiguous PMD entries. Should we handle
>>> those,
>>> too? e.g. have separate {PMD,PTE}_CONT{,_SIZE}?
>>>
>>> Otherwise, I have some comments below.
>>
>>
>> Hi,
>>
>> So in arch/arm64/include/asm/pgtable-hwdef.h, we have:
>> CONT_PTE_SHIFT
>> CONT_PMD_SHIFT
>> CONT_PTES
>> CONT_PMDS
>> CONT_PTE_SIZE
>> CONT_PTE_MASK
>> ...
>>
>> which are used by the contiguous hint HugeTLB code.
>> Can those be adopted instead of CONT_MASK and CONT_SIZE?
>>

Looking at the hugetlb code, it appears to support contiguous PMDs for
4k and 64k pages as well, while the ARM ARM only defines it for 16k
pages. I suppose the contiguous bit is simply ignored for level 2
entries when using 4k or 64k pages kernels, but I think it would be
better for the code to reflect this as well.
