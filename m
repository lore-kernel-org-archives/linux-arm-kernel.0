From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Aug 2017 11:05:42 +0100
Subject: [PATCH] arm64: kaslr: ignore modulo offset when validating
 virtual displacement
In-Reply-To: <CAKv+Gu84Y-LWvhnzqK5KbjSGa75MpQPcwX6LiC0kpuyFXrP+9w@mail.gmail.com>
References: <20170818174230.30435-1-ard.biesheuvel@linaro.org>
 <20170820122653.vicqcqqdgqai6ywz@armageddon.cambridge.arm.com>
 <CAKv+Gu84Y-LWvhnzqK5KbjSGa75MpQPcwX6LiC0kpuyFXrP+9w@mail.gmail.com>
Message-ID: <20170821100541.4wiztipdu2ccofn4@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 20, 2017 at 07:43:05PM +0100, Ard Biesheuvel wrote:
> On 20 August 2017 at 13:26, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
> > index 1d95c204186b..b5fceb7efff5 100644
> > --- a/arch/arm64/kernel/kaslr.c
> > +++ b/arch/arm64/kernel/kaslr.c
> > @@ -131,8 +131,8 @@ u64 __init kaslr_early_init(u64 dt_phys)
> >         /*
> >          * The kernel Image should not extend across a 1GB/32MB/512MB alignment
> >          * boundary (for 4KB/16KB/64KB granule kernels, respectively). If this
> > -        * happens, increase the KASLR offset by the size of the kernel image
> > -        * rounded up by SWAPPER_BLOCK_SIZE.
> > +        * happens, decrease the KASLR offset by the boundary overflow rounded
> > +        * up to SWAPPER_BLOCK_SIZE.
> >          *
> >          * NOTE: The references to _text and _end below will already take the
> >          *       modulo offset (the physical displacement modulo 2 MB) into
> > @@ -142,8 +142,9 @@ u64 __init kaslr_early_init(u64 dt_phys)
> >          */
> >         if ((((u64)_text + offset) >> SWAPPER_TABLE_SHIFT) !=
> >             (((u64)_end + offset) >> SWAPPER_TABLE_SHIFT)) {
> > -               u64 kimg_sz = _end - _text;
> > -               offset = (offset + round_up(kimg_sz, SWAPPER_BLOCK_SIZE))
> > +               u64 adjust = ((u64)_end + offset) &
> > +                       ((1 << SWAPPER_TABLE_SHIFT) - 1);
> > +               offset = (offset - round_up(adjust, SWAPPER_BLOCK_SIZE))
> >                                 & mask;
> >         }
> >
> 
> At this point, _text is in the range [PAGE_OFFSET .. PAGE_OFFSET +
> 2MB), so we can simply round up offset instead, I think.
> 
> offset = round_up(offset, 1 << SWAPPER_TABLE_SHIFT);
> 
> That way we add rather than subtract but this should not be a problem
> (we don't randomize over the entire VMALLOC region anyway)

This would work as well, with a similar loss of randomness (I don't
think it matters whether _text or _end is more aligned with
1 << SWAPPER_TABLE_SHIFT).

-- 
Catalin
