From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Mar 2016 13:55:36 +0000
Subject: [PATCHv2] arm64: kasan: clear stale stack poison
In-Reply-To: <20160302124723.GA11086@e104818-lin.cambridge.arm.com>
References: <1456862465-31505-1-git-send-email-mark.rutland@arm.com>
 <20160302105620.GB25547@red-moon>
 <20160302114833.GA11670@leverpostej>
 <20160302124723.GA11086@e104818-lin.cambridge.arm.com>
Message-ID: <20160302135535.GE7637@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2016 at 12:47:24PM +0000, Catalin Marinas wrote:
> On Wed, Mar 02, 2016 at 11:48:34AM +0000, Mark Rutland wrote:
> > On Wed, Mar 02, 2016 at 10:56:20AM +0000, Lorenzo Pieralisi wrote:
> > > On Tue, Mar 01, 2016 at 08:01:05PM +0000, Mark Rutland wrote:
> > > 
> > > [...]
> > > 
> > > > diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
> > > > index 2774fa3..6f00b76 100644
> > > > --- a/arch/arm64/include/asm/kasan.h
> > > > +++ b/arch/arm64/include/asm/kasan.h
> > > > @@ -1,10 +1,30 @@
> > > >  #ifndef __ASM_KASAN_H
> > > >  #define __ASM_KASAN_H
> > > >  
> > > > -#ifndef __ASSEMBLY__
> > > > -
> > > > +#ifndef LINKER_SCRIPT
> > > >  #ifdef CONFIG_KASAN
> > > >  
> > > > +#ifdef __ASSEMBLY__
> > > > +
> > > > +#include <asm/asm-offsets.h>
> > > > +#include <asm/thread_info.h>
> > > > +
> > > > +	/*
> > > > +	 * Remove stale shadow posion for the stack left over from a prior
> > > > +	 * hot-unplug or idle exit, from the lowest stack address in the
> > > > +	 * thread_union up to the covering up to the current stack pointer.
> > > > +	 * Shadow poison above this is preserved.
> > > > +	 */
> > > > +	.macro kasan_unpoison_stack
> > > > +	mov	x1, sp
> > > > +	and	x0, x1, #~(THREAD_SIZE - 1)
> > > 
> > > I suspect you did not use sp_el0 on purpose here (that contains a
> > > pointer to thread_info), just asking.
> > 
> > I worked on the assumption that the arithmetic was likely to be faster
> > than a system register access, but I do not have numbers to back that
> > up.
> > 
> > I'm happy to use sp_el0 if that's preferrable.
> 
> Since we need sp anyway, it is probably faster. But, I think the current
> patch is more to the point - clearing from the bottom of the current
> stack up to the current sp, we don't need any assumption about sp_el0 (I
> guess we never call cpu_suspend() on an IRQ stack, though I'm not 100%
> sure).
> 
> I don't think Will wants to send this as a fix for 4.5, probably not
> urgent but I'll let him decide. In any case:
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

I wasn't rushing to queue this, especially with the hotplug case
outstanding. Feel free to take it for 4.6.

Will
