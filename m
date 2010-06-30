From: tony@atomide.com (Tony Lindgren)
Date: Wed, 30 Jun 2010 14:08:29 +0300
Subject: [PATCH 1/2] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and
	check for it on V6
In-Reply-To: <alpine.LFD.2.00.1006291355520.24097@xanadu.home>
References: <20100621133749.24299.36154.stgit@baageli.muru.com>
	<20100621135120.24299.98499.stgit@baageli.muru.com>
	<20100622170020.GF4371@shareable.org>
	<20100623073912.GA12255@atomide.com>
	<20100623133636.GC7058@shareable.org>
	<20100629141836.GM2822@atomide.com>
	<alpine.LFD.2.00.1006291355520.24097@xanadu.home>
Message-ID: <20100630110828.GZ2822@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [100629 22:14]:
> On Tue, 29 Jun 2010, Tony Lindgren wrote:
> 
> > Also, can we detect somehow the hardware that uses CONFIG_TLS_REG_EMUL?
> > Might be possible to remove that Kconfig option too later on..
> 
> Well... I don't think we _should_ try to detect it as it is not widely 
> available if at all.

OK
 
> And there is actually a "bug" with __kuser_get_tls because if ever 
> CONFIG_TLS_REG_EMUL is selected then a call to __kuser_get_tls is 
> currently doing nothing while it should actually use the mrc 
> instruction.

I've changed it to initialize to mrc if (tls_emu || has_tls).

> Could this be a tristate instead?  There are actually 3 cases:
> 
> 1) We know the TLS reg is _always_ available i.e. ARMv6K, ARMV7 and 
>    above.  In that case the test on elf_hwcap is redundant and wasteful.
> 
> 2) We know the TLS reg is _never_ available i.e. pre-ARMv6.  The test on 
>    elf_hwcap is again redundant and wasteful.
> 
> 3) We're unsure as the actual CPU is known only at run time.
> 
> Case #1 will become the common case in the future.  Case #2 is still 
> widely relevant for deployed systems in the field, and some popular 
> ARMv5TE based SOCs are still produced right now.  So instead of 
> replacing #1 and #2 with #3, I think you should add #3 to the other 
> cases instead.

OK. I've implemented this logic in new file tls.h.

> >  #ifdef CONFIG_MMU
> >  	mcr	p15, 0, r6, c3, c0, 0		@ Set domain register
> > @@ -1009,16 +1011,13 @@ kuser_cmpxchg_fixup:
> >   */
> >  
> >  __kuser_get_tls:				@ 0xffff0fe0
> > -
> > -#if !defined(CONFIG_HAS_TLS_REG) && !defined(CONFIG_TLS_REG_EMUL)
> > -	ldr	r0, [pc, #(16 - 8)]		@ TLS stored at 0xffff0ff0
> > -#else
> > -	mrc	p15, 0, r0, c13, c0, 3		@ read TLS register
> > -#endif
> > +	nop				@ read TLS, set in kuser_get_tls_init
> >  	usr_ret	lr
> > -
> > -	.rep	5
> > -	.word	0			@ pad up to __kuser_helper_version
> > +	mrc	p15, 0, r0, c13, c0, 3	@ 0xffff0fe8 hardware TLS code
> > +	ldr	r0, [pc, #(16 - 8)]	@ 0xffff0fec software TLS code
> > +	.word	0			@ 0xffff0ff0 software TLS value
> > +	nop				@ pad up to __kuser_helper_version
> > +	nop
> >  	.endr
> 
> This looks obscur.  The idea of patching the appropriate instruction at 
> runtime here is a good one.  However I'd simply keep the ldr version in 
> place otherwise the pc displacement doesn't match anymore when 
> disassembling.  And simply overwrite it with the mrc version when 
> necessary.

OK, changed to use the ldr by default.
 
> BTW you left a stray .endr here.

Oops. I've put back the .rep .endrep instead of the nops now.
 
> > +	if ((((id >> 4) & 0xfff) == 0xb36) && (((id >> 20) & 3) == 0))
> > +		elf_hwcap &= ~HWCAP_TLS;
> 
> You should probably test for the vendor ID as well (ARM in this case).

OK, added.
 
> > +}
> > +#else
> > +static inline void feat_v6_fixup(void)
> > +{
> > +}
> > +#endif
> 
> I think the #ifdef is unnecessary here.  This is __init code anyway, so 
> this could as well be always compiled in.

Removed.
 
> > diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> > index 1621e53..85dd001 100644
> > --- a/arch/arm/kernel/traps.c
> > +++ b/arch/arm/kernel/traps.c
> > @@ -518,16 +518,19 @@ asmlinkage int arm_syscall(int no, struct pt_regs *regs)
> >  
> >  	case NR(set_tls):
> >  		thread->tp_value = regs->ARM_r0;
> > -#if defined(CONFIG_HAS_TLS_REG)
> > -		asm ("mcr p15, 0, %0, c13, c0, 3" : : "r" (regs->ARM_r0) );
> > -#elif !defined(CONFIG_TLS_REG_EMUL)
> > -		/*
> > -		 * User space must never try to access this directly.
> > -		 * Expect your app to break eventually if you do so.
> > -		 * The user helper at 0xffff0fe0 must be used instead.
> > -		 * (see entry-armv.S for details)
> > -		 */
> > -		*((unsigned int *)0xffff0ff0) = regs->ARM_r0;
> > +#if !defined(CONFIG_TLS_REG_EMUL)
> > +		if (elf_hwcap & HWCAP_TLS) {
> > +			asm ("mcr p15, 0, %0, c13, c0, 3"
> > +				: : "r" (regs->ARM_r0));
> > +		} else {
> > +			/*
> > +			 * User space must never try to access this directly.
> > +			 * Expect your app to break eventually if you do so.
> > +			 * The user helper at 0xffff0fe0 must be used instead.
> > +			 * (see entry-armv.S for details)
> > +			 */
> > +			*((unsigned int *)0xffff0ff0) = regs->ARM_r0;
> > +		}
> >  #endif
> 
> The same comment as for __kuser_get_tls would apply here.  However, 
> instead of duplicating the code block, you could define a macro, such as 
> has_tls_reg(), that would be either 0, 1, or ((elf_hwcap & HWCAP_TLS).

Now using tls_emu and has_tls defines.
 
> >  		return 0;
> >  
> > @@ -743,6 +746,21 @@ void __init trap_init(void)
> >  	return;
> >  }
> >  
> > +#if defined(CONFIG_TLS_REG_EMUL)
> > +static void __init kuser_get_tls_init(unsigned long vectors)
> > +{
> > +	memcpy((void *)vectors + 0xfe0, (void *)vectors + 0xfe8, 4);
> > +}
> > +#else
> > +static void __init kuser_get_tls_init(unsigned long vectors)
> > +{
> > +	if (elf_hwcap & HWCAP_TLS)
> > +		memcpy((void *)vectors + 0xfe0, (void *)vectors + 0xfe8, 4);
> > +	else
> > +		memcpy((void *)vectors + 0xfe0, (void *)vectors + 0xfec, 4);
> > +}
> > +#endif
> 
> Please move the #ifdef within the function body.  Also it would be nice 
> to add comments about what those magic offsets are.

This is now cleaner too with if (tls_emu || has_tls).

Updated patch below.

Regards,

Tony
-------------- next part --------------
A non-text attachment was scrubbed...
Name: arm-tls-v4.patch
Type: text/x-diff
Size: 8804 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100630/5ef872de/attachment.bin>
