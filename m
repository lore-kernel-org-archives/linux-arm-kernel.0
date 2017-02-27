From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 27 Feb 2017 19:47:48 +0000
Subject: [RFC PATCH] arm: Fix cache inconsistency when using fixmap
In-Reply-To: <1488221798.9100.10.camel@linaro.org>
References: <1487778678.18810.8.camel@linaro.org>
 <5497800b3271f13583e78710ac39a48e@agner.ch>
 <CAKv+Gu9YeJ+WN1TETjh5G73=tCOK9fDW21VOw0E1XYy=UJcBkg@mail.gmail.com>
 <1488206134.9100.7.camel@linaro.org>
 <4dfa7baf085fd16c4c2c3a88e1e49a27@agner.ch>
 <CAKv+Gu9EeykznTa8VgfB2oAW4fcYHqmeDSae72P78u+rLe8dsg@mail.gmail.com>
 <1488221798.9100.10.camel@linaro.org>
Message-ID: <CAKv+Gu9QAitgJgG+1=qcCovm3E4yCdRAsSo2+NCX0rAQenXByw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 February 2017 at 18:56, Jon Medhurst (Tixy) <tixy@linaro.org> wrote:
> On Mon, 2017-02-27 at 18:43 +0000, Ard Biesheuvel wrote:
>> On 27 February 2017 at 18:40, Stefan Agner <stefan@agner.ch> wrote:
>> > On 2017-02-27 06:35, Jon Medhurst (Tixy) wrote:
>> > > On Sun, 2017-02-26 at 14:35 +0000, Ard Biesheuvel wrote:
>> > >
>> > > > However, we could make this a bit more private to the fixmap code by
>> > > > using something like
>> > > >
>> > > >
>> > > > diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
>> > > > index 5c17d2dec777..6c375aea8f22 100644
>> > > > --- a/arch/arm/include/asm/fixmap.h
>> > > > +++ b/arch/arm/include/asm/fixmap.h
>> > > > @@ -41,11 +41,14 @@ static const enum fixed_addresses __end_of_fixed_addresses =
>> > > >
>> > > >  #define FIXMAP_PAGE_COMMON     (L_PTE_YOUNG | L_PTE_PRESENT |
>> > > > L_PTE_XN | L_PTE_DIRTY)
>> > > >
>> > > > -#define FIXMAP_PAGE_NORMAL     (FIXMAP_PAGE_COMMON | L_PTE_MT_WRITEBACK)
>> > > > -#define FIXMAP_PAGE_RO         (FIXMAP_PAGE_NORMAL | L_PTE_RDONLY)
>> > > > +#define __FIXMAP_MT_NORMAL     ((pgprot_val(pgprot_kernel) ?:
>> > >
>> > > The code above misses out setting L_PTE_XN when using pgprot_kernel
>> > >
>> > > > FIXMAP_PAGE_COMMON) | \
>> > > > +                                L_PTE_MT_WRITEBACK)
>> > > > +#define FIXMAP_PAGE_NORMAL     __pgprot(__FIXMAP_MT_NORMAL)
>> > > > +#define FIXMAP_PAGE_RO         __pgprot(__FIXMAP_MT_NORMAL | L_PTE_RDONLY)
>> > > >
>> > > >  /* Used by set_fixmap_(io|nocache), both meant for mapping a device */
>> > > > -#define FIXMAP_PAGE_IO         (FIXMAP_PAGE_COMMON |
>> > > > L_PTE_MT_DEV_SHARED | L_PTE_SHARED)
>> > > > +#define FIXMAP_PAGE_IO         __pgprot(FIXMAP_PAGE_COMMON |
>> > > > L_PTE_MT_DEV_SHARED | \
>> > > > +                                        L_PTE_SHARED)
>> > > >  #define FIXMAP_PAGE_NOCACHE    FIXMAP_PAGE_IO
>> > > >
>> > > >  #define __early_set_fixmap     __set_fixmap
>> > > >
>> > > > (and drop the change to mm/mmu.c), which boils down to the same for
>> > > > fixmap but does not affect other users of pgprot_kernel. Also, it
>> > > > appears these definitions are broken under STRICT_MM_TYPECHECKS so
>> > > > this is a good opportunity to get that fixed as well.
>> > >
>> > > I like this method better because as you say it keeps things private to
>> > > fixmap, and it doesn't risk affecting other things.
>> >
>> > Yes, I agree this is nicer than my proposal.
>> >
>> > >
>> > > As for getting STRICT_MM_TYPECHECKS working that looks good too, but
>> > > should be a separate cleanup patch, especially as a fix for the cache
>> > > problem possibly should go to stable kernels.
>> > >
>> > > I also think FIXMAP_PAGE_COMMON should be renamed (prefixed with '__')
>> > > as it's an implementation detail an not a memory type used with fixmap.
>> > >
>> > > So I was thinking, one patch as a bugfix:
>> > >
>> > > ----------------------------------------------------------------------
>> > > diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
>> > > index 5c17d2dec777..4e6784dc5668 100644
>> > > --- a/arch/arm/include/asm/fixmap.h
>> > > +++ b/arch/arm/include/asm/fixmap.h
>> > > @@ -41,7 +41,8 @@ static const enum fixed_addresses __end_of_fixed_addresses =
>> > >
>> > >  #define FIXMAP_PAGE_COMMON   (L_PTE_YOUNG | L_PTE_PRESENT | L_PTE_XN |
>> > > L_PTE_DIRTY)
>> > >
>> > > -#define FIXMAP_PAGE_NORMAL   (FIXMAP_PAGE_COMMON | L_PTE_MT_WRITEBACK)
>> > > +#define FIXMAP_PAGE_NORMAL   (pgprot_kernel ? pgprot_kernel | L_PTE_XN : \
>> > > +                                     FIXMAP_PAGE_COMMON | L_PTE_MT_WRITEBACK)
>> > >  #define FIXMAP_PAGE_RO               (FIXMAP_PAGE_NORMAL | L_PTE_RDONLY)
>> > >
>> > >  /* Used by set_fixmap_(io|nocache), both meant for mapping a device */
>> > > ----------------------------------------------------------------------
>> > >
>> > > Second patch as a cleanup. Note this is different to Ard's version as
>> > > it uses PAGE_KERNEL rather than open coding the same code from
>> > > pgtable.h to add XN permisions (Also, the default generic definition of
>> > > FIXMAP_PAGE_NORMAL is PAGE_KERNEL, and the only reason we want to change
>> > > it is to select an alternate value if that is not yet setup)
>> > >
>> > > ----------------------------------------------------------------------
>> > > diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
>> > > index 4e6784dc5668..ec689c6aa644 100644
>> > > --- a/arch/arm/include/asm/fixmap.h
>> > > +++ b/arch/arm/include/asm/fixmap.h
>> > > @@ -39,14 +39,15 @@ static const enum fixed_addresses __end_of_fixed_addresses =
>> > >       __end_of_fixmap_region > __end_of_early_ioremap_region ?
>> > >       __end_of_fixmap_region : __end_of_early_ioremap_region;
>> > >
>> > > -#define FIXMAP_PAGE_COMMON   (L_PTE_YOUNG | L_PTE_PRESENT | L_PTE_XN |
>> > > L_PTE_DIRTY)
>> > > +#define __FIXMAP_PAGE_COMMON (L_PTE_YOUNG | L_PTE_PRESENT | L_PTE_XN
>> > > > L_PTE_DIRTY)
>> > >
>> > > -#define FIXMAP_PAGE_NORMAL   (pgprot_kernel ? pgprot_kernel | L_PTE_XN : \
>> > > -                                     FIXMAP_PAGE_COMMON | L_PTE_MT_WRITEBACK)
>> > > -#define FIXMAP_PAGE_RO               (FIXMAP_PAGE_NORMAL | L_PTE_RDONLY)
>> > > +#define FIXMAP_PAGE_NORMAL   (pgprot_val(pgprot_kernel) ? PAGE_KERNEL : \
>> > > +                              __pgprot(__FIXMAP_PAGE_COMMON | L_PTE_MT_WRITEBACK))
>> > > +#define FIXMAP_PAGE_RO               _MOD_PROT(FIXMAP_PAGE_NORMAL, L_PTE_RDONLY)
>> > >
>> > >  /* Used by set_fixmap_(io|nocache), both meant for mapping a device */
>> > > -#define FIXMAP_PAGE_IO               (FIXMAP_PAGE_COMMON | L_PTE_MT_DEV_SHARED |
>> > > L_PTE_SHARED)
>> > > +#define FIXMAP_PAGE_IO         __pgprot(__FIXMAP_PAGE_COMMON |
>> > > L_PTE_MT_DEV_SHARED | \
>> > > +                                        L_PTE_SHARED)
>> > >  #define FIXMAP_PAGE_NOCACHE  FIXMAP_PAGE_IO
>> > >
>> > >  #define __early_set_fixmap   __set_fixmap
>> > > ----------------------------------------------------------------------
>> >
>> > Fix and cleanup looks good to me,
>> >
>> > Reviewed-by: Stefan Agner <stefan@agner.ch>
>> >
>>
>> Likewise,
>>
>> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Thanks both. I'll do some more testing then post proper patches with
> commit messages, and add something like
>
> Based on changes
> Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>

If you insist, but between Stefan, you and me, I am hardly the person
to have given the most substantial input into this discussion
