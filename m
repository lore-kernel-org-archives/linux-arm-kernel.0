From: steve.capper@linaro.org (Steve Capper)
Date: Mon, 23 Nov 2015 12:16:52 +0000
Subject: [PATCH 1/2] arm64: mm: detect bad __create_mapping uses
In-Reply-To: <20151123112151.GA28293@leverpostej>
References: <1448033724-13846-1-git-send-email-mark.rutland@arm.com>
 <CAPvkgC2NqfYrcAzsF=UwE9n3BGz74bYcNSGOaaCiwHP_YcnRWA@mail.gmail.com>
 <20151120170534.GE5536@leverpostej>
 <CAPvkgC1LWj8aCwX8WnJbb7tsuwwiLt+0KxQsZRq6U4Ai1BnJxA@mail.gmail.com>
 <20151123112151.GA28293@leverpostej>
Message-ID: <CAPvkgC0-x=Vs=t__3GgN24ENJ2OYsLSsf9vwTzeiUsD6MC55FA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 November 2015 at 11:21, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Nov 23, 2015 at 11:01:51AM +0000, Steve Capper wrote:
>> On 20 November 2015 at 17:05, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Fri, Nov 20, 2015 at 04:13:28PM +0000, Steve Capper wrote:
>> >> On 20 November 2015 at 15:35, Mark Rutland <mark.rutland@arm.com> wrote:
>> >> > If a caller of __create_mapping provides a PA and VA which have
>> >> > different sub-page offsets, it is not clear which offset they expect to
>> >> > apply to the mapping, and is indicative of a bad caller.
>> >> >
>> >> > Disallow calls with differing sub-page offsets, and WARN when they are
>> >> > encountered, so that we can detect and fix such cases.
>> >> >
>> >> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>> >> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> >> > Cc: Catalin Marinas <caralin.marinas@arm.com>
>> >> > Cc: Laura Abbott <labbott@fedoraproject.org>
>> >> > Cc: Steve Capper <steve.capper@linaro.org>
>> >> > Cc: Will Deacon <will.deacon@arm.com>
>> >> > ---
>> >> >  arch/arm64/mm/mmu.c | 7 +++++++
>> >> >  1 file changed, 7 insertions(+)
>> >> >
>> >> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> >> > index e3f563c..3b06afa 100644
>> >> > --- a/arch/arm64/mm/mmu.c
>> >> > +++ b/arch/arm64/mm/mmu.c
>> >> > @@ -300,6 +300,13 @@ static void  __create_mapping(struct mm_struct *mm, pgd_t *pgd,
>> >> >  {
>> >> >         unsigned long addr, length, end, next;
>> >> >
>> >> > +       /*
>> >> > +        * If the virtual and physical address don't have the same offset
>> >> > +        * within a page, we cannot map the region as the caller expects.
>> >> > +        */
>> >> > +       if (WARN_ON((phys ^ virt) & ~PAGE_MASK))
>> >> > +               return;
>> >> > +
>> >>
>> >> Do we want any subpage offsets in our virt and phys?
>> >
>> > Yes.
>> >
>> > For instance, when mapping EFI regions (which exist at 4K granularity)
>> > on a 64K page kernel, per [1]. The spec requires that any regions in the
>> > same 64K page can be mapped using the same attributes, so it's fine to
>> > map at 64K granularity.
>>
>> Thanks Mark,
>> I didn't know that was allowed, now I do :-).
>> These two patches now make perfect sense.
>>
>> >
>> > We already try to cater for this in __create_mapping where we fix up the
>> > base and size:
>> >
>> >         addr = virt & PAGE_MASK;
>> >         length = PAGE_ALIGN(size + (virt & ~PAGE_MASK));
>> >
>> > I will add a middle paragraph to the commit message:
>> >
>> >         In some cases, the region we wish to map may validly have a
>> >         sub-page offset in the physical and virtual adddresses. For
>> >         example, EFI runtime regions have 4K granularity, yet may be
>> >         mapped by a 64K page kernel. So long as the physical and virtual
>> >         offsets are the same, the region will be mapped at the expected
>> >         VAs.
>> >
>> > Does that sound OK?
>>
>> s/adddresses/addresses/
>> Otherwise that looks great, thanks.
>
> Good spot. Fixed.
>
>> >> If we have sub page bits in phys won't that start flipping on bits in
>> >> the page table entries?
>> >
>> > In all cases where we use phys, we either shift phys right by PAGE_SHIFT
>> > (in __populate_init_pte vi __phys_to_pfn) which clears those bits, or we
>> > first check it is sufficiently aligned for that level of table (and
>> > hence the low bits are all zero). Patch 2 fixes a bug related to the
>> > latter case.
>> >
>> >> What about something like:
>> >> if (WARN_ON((phys | virt) & ~PAGE_MASK))
>> >
>> > Per the above, that would break the EFI code in [1].
>>
>> Agreed.
>>
>> I was toying with suggesting we warn for any phys/virt bit set below
>> bit #12 (i.e. anything smaller than 4K alignment), that would probably
>> just increase complexity with little appreciable gain though.
>
> I'm not sure either way, to be honest. We might want to use it in an
> ioremap-like manner to map small objects.
>
> For instance, we use create_mapping to map the DTB in fixmap_remap_fdt,
> and the DTB itself is only guaranteed to be 8-byte aligned. However,
> fixmap_remap_fdt has to handle the sub-page offset explicitly either
> way, either adding it to the fixmap slot's virtual address or
> subtracting it from the physical base when it makes the call.

Thanks I see. Yes, as you have it is best.

>
>> For both patches (with the extra paragraph above added to the commit log):
>> Reviewed-by: Steve Capper <steve.capper@linaro.org>
>
> I take it you mean with the paragraph added to this patch, not to both
> patches?

Yes please to this one, thanks.

Cheers,
-- 
Steve

>
> Thanks,
> Mark.
