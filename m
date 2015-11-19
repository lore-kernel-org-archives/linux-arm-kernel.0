From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 19 Nov 2015 18:32:01 +0000
Subject: [PATCH] arm64: efi: correctly align vaddr for runtime maps
In-Reply-To: <CAKv+Gu_KK_0DE668jz7gaJHwr3RFz0kAX=sokCG91+xWy6T-+A@mail.gmail.com>
References: <1447954656-10435-1-git-send-email-mark.rutland@arm.com>
 <CAKv+Gu9OoRmV5hDsN9MrnKEVV85EFPpN_tW7S1WoFMxNxoY73Q@mail.gmail.com>
 <20151119181724.GC15231@leverpostej>
 <CAKv+Gu_KK_0DE668jz7gaJHwr3RFz0kAX=sokCG91+xWy6T-+A@mail.gmail.com>
Message-ID: <20151119183201.GD15231@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 07:29:18PM +0100, Ard Biesheuvel wrote:
> On 19 November 2015 at 19:17, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Nov 19, 2015 at 07:08:53PM +0100, Ard Biesheuvel wrote:
> >> On 19 November 2015 at 18:37, Mark Rutland <mark.rutland@arm.com> wrote:
> >> > The kernel may use a page granularity of 4K, 16K, or 64K depending on
> >> > configuration.
> >> >
> >> > When mapping EFI runtime regions, we use memrange_efi_to_native to round
> >> > the physical base address of a region down to a granule-aligned
> >> > boundary, and round the size up to a granule-aligned boundary. However,
> >> > we fail to similarly round the virtual base address down to a
> >> > granule-aligned boundary.
> >> >
> >>
> >> Actually, __create_mapping() (which is called by create_pgd_mapping())
> >> does the following
> >>
> >> """
> >> static void  __create_mapping(struct mm_struct *mm, pgd_t *pgd,
> >>                                     phys_addr_t phys, unsigned long virt,
> >>                                     phys_addr_t size, pgprot_t prot,
> >>                                     void *(*alloc)(unsigned long size))
> >> {
> >>         unsigned long addr, length, end, next;
> >>
> >>         addr = virt & PAGE_MASK;
> >>         length = PAGE_ALIGN(size + (virt & ~PAGE_MASK));
> >> """
> >>
> >> so it does the rounding of the virtual address for us, but we are
> >> rounding up the length twice.
> >> I'd rather simply get rid of memrange_efi_to_native() instead, as it
> >> is obviously redundant.
> >
> > We'd have to have our own conversion from EFI page size to kernel page
> > size, but otherwise that would be fine, yes.
> >
> > I'll spin a v2 to that effect.
> >
> 
> The size is simply 'md->num_pages << EFI_PAGE_SHIFT'

Indeed, I figured this out immediately after sending the last mail.

It looks much nicer now. I'll post it once I've given it a spin.

Thanks,
Mark.
