From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 20 May 2011 14:21:07 +0100
Subject: [PATCH v5 15/19] ARM: LPAE: Add support for
	cpu_v7_do_(suspend|resume)
In-Reply-To: <20110518072737.GC6815@atomide.com>
References: <1304859098-10760-1-git-send-email-catalin.marinas@arm.com>
	<1304859098-10760-16-git-send-email-catalin.marinas@arm.com>
	<20110518072737.GC6815@atomide.com>
Message-ID: <1305897667.2788.98.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

On Wed, 2011-05-18 at 08:27 +0100, Tony Lindgren wrote:
> * Catalin Marinas <catalin.marinas@arm.com> [110508 15:52]:
> > --- a/arch/arm/mm/proc-v7.S
> > +++ b/arch/arm/mm/proc-v7.S
> > @@ -260,19 +260,32 @@ cpu_v7_name:
> > 
> >  /* Suspend/resume support: derived from arch/arm/mach-s5pv210/sleep.S */
> >  .globl       cpu_v7_suspend_size
> > +#ifdef CONFIG_ARM_LPAE
> > +.equ cpu_v7_suspend_size, 4 * 10
> > +#else
> >  .equ cpu_v7_suspend_size, 4 * 8
> > +#endif
> >  #ifdef CONFIG_PM_SLEEP
> >  ENTRY(cpu_v7_do_suspend)
> >       stmfd   sp!, {r4 - r11, lr}
> >       mrc     p15, 0, r4, c13, c0, 0  @ FCSE/PID
> >       mrc     p15, 0, r5, c13, c0, 1  @ Context ID
> >       mrc     p15, 0, r6, c3, c0, 0   @ Domain ID
> > +#ifdef CONFIG_ARM_LPAE
> > +     mrrc    p15, 0, r7, r8, c2      @ TTB 0
> > +     mrrc    p15, 1, r2, r3, c2      @ TTB 1
> > +#else
> >       mrc     p15, 0, r7, c2, c0, 0   @ TTB 0
> >       mrc     p15, 0, r8, c2, c0, 1   @ TTB 1
> > +#endif
> >       mrc     p15, 0, r9, c1, c0, 0   @ Control register
> >       mrc     p15, 0, r10, c1, c0, 1  @ Auxiliary control register
> >       mrc     p15, 0, r11, c1, c0, 2  @ Co-processor access control
> > +#ifdef CONFIG_ARM_LPAE
> > +     stmia   r0, {r2 - r11}
> > +#else
> >       stmia   r0, {r4 - r11}
> > +#endif
> >       ldmfd   sp!, {r4 - r11, pc}
> >  ENDPROC(cpu_v7_do_suspend)
> > 
> > @@ -280,12 +293,21 @@ ENTRY(cpu_v7_do_resume)
> >       mov     ip, #0
> >       mcr     p15, 0, ip, c8, c7, 0   @ invalidate TLBs
> >       mcr     p15, 0, ip, c7, c5, 0   @ invalidate I cache
> > +#ifdef CONFIG_ARM_LPAE
> > +     ldmia   r0, {r2 - r11}
> > +#else
> >       ldmia   r0, {r4 - r11}
> > +#endif
> >       mcr     p15, 0, r4, c13, c0, 0  @ FCSE/PID
> >       mcr     p15, 0, r5, c13, c0, 1  @ Context ID
> >       mcr     p15, 0, r6, c3, c0, 0   @ Domain ID
> > +#ifdef CONFIG_ARM_LPAE
> > +     mcrr    p15, 0, r7, r8, c2      @ TTB 0
> > +     mcrr    p15, 1, r2, r3, c2      @ TTB 1
> > +#else
> >       mcr     p15, 0, r7, c2, c0, 0   @ TTB 0
> >       mcr     p15, 0, r8, c2, c0, 1   @ TTB 1
> > +#endif
> >       mcr     p15, 0, ip, c2, c0, 2   @ TTB control register
> >       mcr     p15, 0, r10, c1, c0, 1  @ Auxiliary control register
> >       mcr     p15, 0, r11, c1, c0, 2  @ Co-processor access control
> 
> Do we really need all this ifdef else throughout this series?
> 
> I think we already have things in place to do this dynamically
> like we already do for thumb, smp_on_up, v6 vs v7 and so on.

By dynamically, do you mean at run-time? We won't be able to compile
both classic and LPAE in the same kernel, there is just too much
difference between them (2 vs 3 levels of page tables - LPAE is an
entirely new format).

If you mean some simpler macros like what we have for ARM/THUMB to
reduce the number of lines, I'm fine with it though we don't always have
a 1:1 mapping between LPAE and non-LPAE instructions.

Alternatively, I'm happy to create a separate proc-v7lpae.S file.

-- 
Catalin
