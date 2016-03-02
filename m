From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 2 Mar 2016 11:48:34 +0000
Subject: [PATCHv2] arm64: kasan: clear stale stack poison
In-Reply-To: <20160302105620.GB25547@red-moon>
References: <1456862465-31505-1-git-send-email-mark.rutland@arm.com>
 <20160302105620.GB25547@red-moon>
Message-ID: <20160302114833.GA11670@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2016 at 10:56:20AM +0000, Lorenzo Pieralisi wrote:
> On Tue, Mar 01, 2016 at 08:01:05PM +0000, Mark Rutland wrote:
> 
> [...]
> 
> > diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
> > index 2774fa3..6f00b76 100644
> > --- a/arch/arm64/include/asm/kasan.h
> > +++ b/arch/arm64/include/asm/kasan.h
> > @@ -1,10 +1,30 @@
> >  #ifndef __ASM_KASAN_H
> >  #define __ASM_KASAN_H
> >  
> > -#ifndef __ASSEMBLY__
> > -
> > +#ifndef LINKER_SCRIPT
> >  #ifdef CONFIG_KASAN
> >  
> > +#ifdef __ASSEMBLY__
> > +
> > +#include <asm/asm-offsets.h>
> > +#include <asm/thread_info.h>
> > +
> > +	/*
> > +	 * Remove stale shadow posion for the stack left over from a prior
> > +	 * hot-unplug or idle exit, from the lowest stack address in the
> > +	 * thread_union up to the covering up to the current stack pointer.
> > +	 * Shadow poison above this is preserved.
> > +	 */
> > +	.macro kasan_unpoison_stack
> > +	mov	x1, sp
> > +	and	x0, x1, #~(THREAD_SIZE - 1)
> 
> I suspect you did not use sp_el0 on purpose here (that contains a
> pointer to thread_info), just asking.

I worked on the assumption that the arithmetic was likely to be faster
than a system register access, but I do not have numbers to back that
up.

I'm happy to use sp_el0 if that's preferrable.

> > +	add	x0, x0, #(THREAD_INFO_SIZE)
> > +	sub	x1, x1, x0
> > +	bl	kasan_unpoison_shadow
> 
> I wonder whether a wrapper function eg kasan_unpoison_stack(addr) is
> better, where the thread info/stack address computation can be done in C
> we just pass it the precise bottom of the stack location watermark, which
> is the only reason why we want to call it from assembly.

True; I'll have a go.

> Other than that:
> 
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Cheers!

Mark.
