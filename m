From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 26 Feb 2016 17:26:19 +0100
Subject: [RFC PATCH 1/6] arm64: vmemmap: use virtual projection of linear
 region
In-Reply-To: <20160226162415.GG29125@arm.com>
References: <1456330893-19228-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456330893-19228-2-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu9M6QukGqLWYgDqAp6xaa7RPVW36E591LOPf6xP_TH48w@mail.gmail.com>
 <20160226151557.GD29125@arm.com>
 <CAKv+Gu9Os3ZOepFDYTCQxfkWkhQUMbWyc_N=c5DNFgzmkAx0ZQ@mail.gmail.com>
 <20160226162415.GG29125@arm.com>
Message-ID: <CAKv+Gu8+E-xMHtfRucUyhXffFS8Yn8HmTcDwKeL-D_34XyP_Xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 February 2016 at 17:24, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Feb 26, 2016 at 04:39:55PM +0100, Ard Biesheuvel wrote:
>> On 26 February 2016 at 16:15, Will Deacon <will.deacon@arm.com> wrote:
>> > On Thu, Feb 25, 2016 at 08:02:00AM +0100, Ard Biesheuvel wrote:
>> >> On 24 February 2016 at 17:21, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> >> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> >> > index a440f5a85d08..8e6baea0ff61 100644
>> >> > --- a/arch/arm64/include/asm/pgtable.h
>> >> > +++ b/arch/arm64/include/asm/pgtable.h
>> >> > @@ -34,18 +34,19 @@
>> >> >  /*
>> >> >   * VMALLOC and SPARSEMEM_VMEMMAP ranges.
>> >> >   *
>> >> > - * VMEMAP_SIZE: allows the whole VA space to be covered by a struct page array
>> >> > + * VMEMAP_SIZE: allows the whole linear region to be covered by a struct page array
>> >> >   *     (rounded up to PUD_SIZE).
>> >> >   * VMALLOC_START: beginning of the kernel vmalloc space
>> >> >   * VMALLOC_END: extends to the available space below vmmemmap, PCI I/O space,
>> >> >   *     fixed mappings and modules
>> >> >   */
>> >> > -#define VMEMMAP_SIZE           ALIGN((1UL << (VA_BITS - PAGE_SHIFT)) * sizeof(struct page), PUD_SIZE)
>> >> > +#define VMEMMAP_SIZE           ALIGN((1UL << (VA_BITS - PAGE_SHIFT - 1)) * sizeof(struct page), PUD_SIZE)
>> >> >
>> >> >  #define VMALLOC_START          (MODULES_END)
>> >> >  #define VMALLOC_END            (PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - SZ_64K)
>> >> >
>> >> > -#define vmemmap                        ((struct page *)(VMALLOC_END + SZ_64K))
>> >> > +#define VMEMMAP_START          (VMALLOC_END + SZ_64K)
>> >> > +#define vmemmap                        ((struct page *)(VMEMMAP_START - memstart_addr / sizeof(struct page)))
>> >> >
>> >>
>> >> Note that with the linear region randomization which is now in -next,
>> >> this division needs to be signed (since memstart_addr can wrap).
>> >>
>> >> So I should either update the definition of memstart_addr to s64 in
>> >> this patch, or cast to (s64) in the expression above
>> >
>> > Can you avoid the division altogether by doing something like:
>> >
>> > (struct page *)(VMEMMAP_START - (PHYS_PFN(memstart_addr) * sizeof(struct page)))
>> >
>> > or have I misunderstood how this works?
>> >
>>
>> It needs to be a signed shift, since the RHS of the subtraction must
>> remain negative if memstart_addr is 'negative'
>>
>> This works as well:
>> (struct page *)VMEMMAP_START - ((s64)memstart_addr >> PAGE_SHIFT)
>
> Ah yeah, even better.
>
>> It may be appropriate to change the definition of memstart_addr to
>> s64, to reflect that, under randomization of the linear region, the
>> start of physical memory may be 'below zero' so that the actual
>> populated RAM region is high up in the linear region.
>> That way, we can lose the case here.
>
> That sounds like a good idea.
>

OK, I will respin the first patch. As far as the remaining patches are
concerned, I wonder if you have any suggestions as to how to measure
the performance impact of making virt_to_page() disregard PHYS_OFFSET
(as I did in 6/6) before respinning/resending the remaining patches
