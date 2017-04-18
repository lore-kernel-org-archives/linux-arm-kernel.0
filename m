From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 18 Apr 2017 19:48:59 +0100
Subject: [PATCH 4/5] Hot-remove implementation for arm64
In-Reply-To: <20170418182125.GL17866@leverpostej>
References: <cover.1491920513.git.ar@linux.vnet.ibm.com>
 <897973dd5d3fc91c70aba4b44350099a61c3a12c.1491920513.git.ar@linux.vnet.ibm.com>
 <20170411171210.GD32267@leverpostej> <20170414140158.GA17950@samekh>
 <20170418182125.GL17866@leverpostej>
Message-ID: <CAKv+Gu9YYoFmFwpVgrOvD+eMHAKPmG_zgTz5f7JMT6iGqgLHGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 April 2017 at 19:21, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Apr 14, 2017 at 03:01:58PM +0100, Andrea Reale wrote:
>> I guess it is likely that I might have made assumptions that are true
>> for x86_64 but do not hold for arm64. Whenever you feel this is the
>> case, I would be really grateful if you could help identify them.
>
> Sure thing.
>
>> On Tue, Apr 11, 2017 at 06:12:11PM +0100, Mark Rutland wrote:
>> > On Tue, Apr 11, 2017 at 03:55:42PM +0100, Andrea Reale wrote:
>
>> > > +static void  free_pagetable(struct page *page, int order, bool direct)
>> >
>> > This "direct" parameter needs a better name, and a description in a
>> > comment block above this function.
>>
>> The name direct is inherited directly from the x86_64 hot remove code.
>> It serves to distinguish if we are removing either a pagetable page that
>> is mapping to the direct mapping space (I think it is called also linear
>> mapping area somewhere else) or a pagetable page or a data page
>> from vmemmap.
>
> FWIW, I've largely heard the folk call that the "linear mapping", and
> x86 folk call that the "direct mapping". The two are interchangeable.
>
>> In this specific set of functions, the flag is needed because the various
>> alloc_init_p*d used for allocating entries for direct memory mapping
>> rely on pgd_pgtable_alloc, which in its turn calls  pgtable_page_ctor;
>> hence, we need to call the dtor.
>
> AFAICT, that's not true for the arm64 linear map, since that's created
> with our early_pgtable_alloc(), which doesn't call pgtable_page_ctor().
>
> Judging by commit:
>
>   1378dc3d4ba07ccd ("arm64: mm: run pgtable_page_ctor() on non-swapper
>                      translation table pages")
>
> ... we only do this for non-swapper page tables.
>
>> On the contrary, vmemmap entries are created using vmemmap_alloc_block
>> (from within vmemmap_populate), which does not call pgtable_page_ctor
>> when allocating pages.
>>
>> I am not sure I understand why the pgtable_page_ctor is not called when
>> allocating vmemmap page tables, but that's the current situation.
>
> From a quick scan, I see that it's necessary to use pgtable_page_ctor()
> for pages that will be used for userspace page tables, but it's not
> clear to me if it's ever necessary for pages used for kernel page
> tables.
>
> If it is, we appear to have a bug on arm64.
>
> Laura, Ard, thoughts?
>

The generic apply_to_page_range() will expect the PTE lock to be
initialized for page table pages that are not part of init_mm. For
arm64, that is precisely efi_mm as far as I am aware. For EFI, the
locking is unnecessary but does no harm (the permissions are set once
via apply_to_page_range() at boot), so I added this call when adding
support for strict permissions in EFI rt services mappings.

So I think it is appropriate for create_pgd_mapping() to be in charge
of calling the ctor(). We simply have no destroy_pgd_mapping()
counterpart that would be the place for the dtor() call, given that we
never take down EFI rt services mappings.

Whether it makes sense or not to lock/unlock in apply_to_page_range()
is something I did not spend any brain cycles on at the time.

-- 
Ard.
