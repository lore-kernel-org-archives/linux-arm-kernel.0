From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 6 Apr 2017 14:49:03 +0100
Subject: [PATCH v3] arm: Fix memory attribute inconsistencies when using
 fixmap
In-Reply-To: <1491486403.2950.3.camel@linaro.org>
References: <1491291087-17450-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170405224245.GA17774@n2100.armlinux.org.uk>
 <1491486403.2950.3.camel@linaro.org>
Message-ID: <CAKv+Gu_EVqqQGXauWmfhhmJZEyrPDEHDiN2T23XVPy_eR99Lsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 April 2017 at 14:46, Jon Medhurst (Tixy) <tixy@linaro.org> wrote:
> On Wed, 2017-04-05 at 23:42 +0100, Russell King - ARM Linux wrote:
>> On Tue, Apr 04, 2017 at 08:31:27AM +0100, Ard Biesheuvel wrote:
>> > diff --git a/arch/arm/include/asm/mmu.h b/arch/arm/include/asm/mmu.h
>> > index a5b47421059d..80dfeb8ce8f2 100644
>> > --- a/arch/arm/include/asm/mmu.h
>> > +++ b/arch/arm/include/asm/mmu.h
>> > @@ -1,6 +1,8 @@
>> >  #ifndef __ARM_MMU_H
>> >  #define __ARM_MMU_H
>> >
>> > +struct machine_desc;
>> > +
>> >  #ifdef CONFIG_MMU
>> >
>> >  typedef struct {
>> > @@ -24,6 +26,8 @@ typedef struct {
>> >  #define ASID(mm)   (0)
>> >  #endif
>> >
>> > +void early_mm_init(const struct machine_desc *mdesc);
>> > +
>> >  #else
>> >
>> >  /*
>> > @@ -35,6 +39,8 @@ typedef struct {
>> >     unsigned long   end_brk;
>> >  } mm_context_t;
>> >
>> > +static inline void early_mm_init(const struct machine_desc *mdesc) { }
>> > +
>>
>> Why are we stuffing this into mmu.h?  mmu.h is not the header file for
>> arch/arm/mm/mmu.c - although they have the same base filename, they are
>> not really related.
>>
>> asm/mmu.h is supposed to be a kernel-wide include file for the mm_context_t
>> thing, and should not be filled with arch-private stuff.
>>
>> Please find a better location for this.
>
> In arch/arm/mm/mm.h ?
>
> Or as early_mm_init() is replacing early_paging_init() in setup.c, and
> that is currently handled by a local extern statement, keeping doing the
> same? That keeps the diff neater which is a plus for a patch that should
> be backported to stable kernels.
>

Yes, the latter sounds like the least intrusive approach.
