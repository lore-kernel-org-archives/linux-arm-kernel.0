From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 23 Jan 2012 09:14:57 +0100
Subject: [RFC PATCH 03/11] ARM: protect usage of cr_alignment by #ifdef
 CONFIG_CPU_CP15
In-Reply-To: <20120123054346.GN25622@game.jcrosoft.org>
References: <20120122111230.GB14835@pengutronix.de>
 <1327230817-12855-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120123054346.GN25622@game.jcrosoft.org>
Message-ID: <20120123081457.GD14835@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Christophe,

On Mon, Jan 23, 2012 at 06:43:46AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 12:13 Sun 22 Jan     , Uwe Kleine-K?nig wrote:
> > diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
> > index caf14dc..119d178 100644
> > --- a/arch/arm/mm/alignment.c
> > +++ b/arch/arm/mm/alignment.c
> > @@ -89,7 +89,11 @@ core_param(alignment, ai_usermode, int, 0600);
> >  /* Return true if and only if the ARMv6 unaligned access model is in use. */
> >  static bool cpu_is_v6_unaligned(void)
> >  {
> > +#ifdef CONFIG_CPU_CP15
> >  	return cpu_architecture() >= CPU_ARCH_ARMv6 && (cr_alignment & CR_U);
> > +#else
> > +	return 0;
> > +#endif
> >  }
> >  
> >  static int safe_usermode(int new_usermode, bool warn)
> > @@ -961,12 +965,14 @@ static int __init alignment_init(void)
> >  		return -ENOMEM;
> >  #endif
> >  
> > +#ifdef CONFIG_CPU_CP15
> >  	if (cpu_is_v6_unaligned()) {
> >  		cr_alignment &= ~CR_A;
> >  		cr_no_alignment &= ~CR_A;
> >  		set_cr(cr_alignment);
> >  		ai_usermode = safe_usermode(ai_usermode, false);
> >  	}
> > +#endif
> why if CPU_CP15 is not supported cpu_is_v6_unaligned return 0
on v7M I could probably check the CCR register's UNALIGN_TRP flag which
has the semantic matching the CP15 U-flag. I don't know how a v7m
machine should be handled here. The only affected (and relevant) code
is in safe_usermode():

	/*
	 * ARMv6 and later CPUs can perform unaligned accesses for
	 * most single load and store instructions up to word size.
	 * LDM, STM, LDRD and STRD still need to be handled.
	 *
	 * Ignoring the alignment fault is not an option on these
	 * CPUs since we spin re-faulting the instruction without
	 * making any progress.
	 */
	if (cpu_is_v6_unaligned() && !(new_usermode & (UM_FIXUP | UM_SIGNAL))) {
		new_usermode |= UM_FIXUP;

		if (warn)
			printk(KERN_WARNING "alignment: ignoring faults is unsafe on this CPU.	Defaulting to fixup mode.\n");
	}

	return new_usermode;

Does this apply for v7m, too? If so, cpu_is_v6_unaligned needs fixing. Catalin?
Russell?

> >  	hook_fault_code(FAULT_CODE_ALIGNMENT, do_alignment, SIGBUS, BUS_ADRALN,
> >  			"alignment exception");
> > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > index 94c5a0c..f6dbe1a 100644
> > --- a/arch/arm/mm/mmu.c
> > +++ b/arch/arm/mm/mmu.c
> > @@ -109,8 +109,10 @@ static int __init early_cachepolicy(char *p)
> >  
> >  		if (memcmp(p, cache_policies[i].policy, len) == 0) {
> >  			cachepolicy = i;
> > +#ifdef CONFIG_CPU_CP15
> can you use if (IS_ENABLED(x)) instead
IS_ENABLED is defined as:

	#define IS_ENABLED(option) (__enabled_ ## option || __enabled_ ## option ## _MODULE)

CPU_CP15 isn't tristate, so I don't see the benefit.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
