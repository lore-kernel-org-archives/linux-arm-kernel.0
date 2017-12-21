From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 21 Dec 2017 16:48:52 +0000
Subject: [PATCH 03/10] arm64: handle 52-bit addresses in TTBR
In-Reply-To: <e887ef9f-8d68-8f1f-8bc5-ea5ad4cb2b51@arm.com>
References: <1513184845-8711-1-git-send-email-kristina.martsenko@arm.com>
 <1513184845-8711-4-git-send-email-kristina.martsenko@arm.com>
 <e887ef9f-8d68-8f1f-8bc5-ea5ad4cb2b51@arm.com>
Message-ID: <20171221164851.edxq536yobjuagwe@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 14, 2017 at 06:50:05PM +0000, Marc Zyngier wrote:
> On 13/12/17 17:07, Kristina Martsenko wrote:
> > diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> > index eb0c2bd90de9..2b3104af79d0 100644
> > --- a/arch/arm64/include/asm/pgtable-hwdef.h
> > +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> > @@ -16,6 +16,8 @@
> >  #ifndef __ASM_PGTABLE_HWDEF_H
> >  #define __ASM_PGTABLE_HWDEF_H
> >  
> > +#include <asm/memory.h>
> > +
> >  /*
> >   * Number of page-table levels required to address 'va_bits' wide
> >   * address, without section mapping. We resolve the top (va_bits - PAGE_SHIFT)
> > @@ -277,4 +279,11 @@
> >  #define TCR_HA			(UL(1) << 39)
> >  #define TCR_HD			(UL(1) << 40)
> >  
> > +/*
> > + * TTBR
> > + */
> > +#ifdef CONFIG_ARM64_PA_BITS_52
> > +#define TTBR_BADDR_MASK_52	(((UL(1) << 46) - 1) << 2)
> 
> This really hurts by brain. How about
> 
> #define TTBR_BADDR_MASK_52	GENMASK_UL(47, 2)

This file is included in assembly code and GENMASK_ULL has a C-only
version (include/linux/bitops.h). I'll leave Kristina's original code in
place.

> instead, together with a comment saying that TTBR[1] is RES0.

I can add the comment.

-- 
Catalin
