From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 11 Dec 2015 12:10:29 -0500 (EST)
Subject: [PATCH] ARM: Runtime patch udiv/sdiv instructions into
 __aeabi_{u}idiv()
In-Reply-To: <6991913.FSOzozNbSC@wuerfel>
References: <alpine.LFD.2.20.1512110105450.26920@knanqh.ubzr>
 <6991913.FSOzozNbSC@wuerfel>
Message-ID: <alpine.LFD.2.20.1512111125330.26920@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Dec 2015, Arnd Bergmann wrote:

> On Friday 11 December 2015 01:26:25 Nicolas Pitre wrote:
> 
> > This is my counter proposal to Stephen's version. Those patches and the 
> > discussion that followed are available here:
> > 
> >   http://news.gmane.org/group/gmane.linux.kbuild.devel/thread=14007
> > 
> > I think what I propose here is much simpler and less intrusive.  Going
> > to the full call site patching provides between moderate to no 
> > additional performance benefits depending on the CPU core.  That should 
> > probably be compared with this solution with benchmark results to 
> > determine if it is worth it.
> 
> Looks really nice, as it's much simpler than Stephen's approach
> 
> > Of course the ultimate performance will come from having gcc emit those 
> > div instructions directly, but that would make the kernel binary 
> > incompatible with some systems in a multi-arch config. Hence it has to 
> > be a separate config option.
> 
> Well, what we found is that we already have the same problem today
> when enabling LPAE makes the kernel incompatible with platforms that
> can be enabled. The affected platforms are basically the same, except
> for the earlier PJ4 and Krait variants that have some idiv support
> but no LPAE.

Still, making native div support depend on CONFIG_LPAE would be strange. 
A separate config symbol would mmake it self explanatory.

> > diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
> > index 85e374f873..48c77d422a 100644
> > --- a/arch/arm/include/asm/cputype.h
> > +++ b/arch/arm/include/asm/cputype.h
> > @@ -250,8 +250,14 @@ static inline int cpu_is_pj4(void)
> >  
> >  	return 0;
> >  }
> > +
> > +static inline bool __attribute_const__ cpu_is_pj4_nomp(void)
> > +{
> > +	return read_cpuid_part() == 0x56005810;
> > +}
> >  #else
> > -#define cpu_is_pj4()	0
> > +#define cpu_is_pj4()		0
> > +#define cpu_is_pj4_nomp()	0
> >  #endif
> 
> It would be nice to use a symbolic constant for the above, and maybe define
> all three known cpuid numbers for PJ4 variants.
> 
> I've looked at it some more and I now have doubts about this code:
> 
> #ifdef CONFIG_CPU_PJ4B
>         .type   __v7_pj4b_proc_info, #object
> __v7_pj4b_proc_info:
>         .long   0x560f5800
>         .long   0xff0fff00
>         __v7_proc __v7_pj4b_proc_info, __v7_pj4b_setup, proc_fns = pj4b_processor_functions
>         .size   __v7_pj4b_proc_info, . - __v7_pj4b_proc_info
> #endif
> 
> 
> Can someone have a look and tell me that I'm wrong when I read this
> as matching both PJ4 and PJ4B (and PJ4B-MP)?
> 
> Either I'm misreading this, or we do the wrong thing in configurations
> that include both PJ4B (berlin, mvebu) and PJ4 (MMP2/dove).

I don't have the relevant documentation to validate it.  And I'd prefer 
if this was sorted out in a separate patch.  Maybe I should just drop 
the PJ4 variants from this patch for now.

> > +#ifdef CONFIG_ARM_PATCH_IDIV
> > +
> > +/* "sdiv r0, r0, r1" or "mrc p6, 1, r0, CR0, CR1, 4" if we're on pj4 w/o MP */
> > +static inline u32 __attribute_const__ sdiv_instruction(void)
> > +{
> > +	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
> > +		u32 insn = __opcode_thumb32_compose(0xfb90, 0xf0f1);
> > +		if (cpu_is_pj4_nomp())
> > +			insn = __opcode_thumb32_compose(0xee30, 0x0691);
> > +		return __opcode_to_mem_thumb32(insn);
> > +	}
> 
> Strictly speaking, we can ignore the thumb instruction for pj4, as all
> variants also support the normal T2 opcode for udiv/sdiv.

OK it is gone.

Now... The code bails out if ARM mode and HWCAP_IDIVA is not set so 
effectively the ARM mode on PJ4 is currently not used either. So I'm 
leaning towards having aving another patch to sort PJ4 out.

> > diff --git a/arch/arm/lib/lib1funcs.S b/arch/arm/lib/lib1funcs.S
> > index af2267f6a5..9397b2e532 100644
> > --- a/arch/arm/lib/lib1funcs.S
> > +++ b/arch/arm/lib/lib1funcs.S
> > @@ -205,6 +205,10 @@ Boston, MA 02111-1307, USA.  */
> >  .endm
> >  
> >  
> > +#ifdef CONFIG_ARM_PATCH_IDIV
> > +	.align	3
> > +#endif
> > +
> >  ENTRY(__udivsi3)
> >  ENTRY(__aeabi_uidiv)
> >  UNWIND(.fnstart)
> 
> I'd probably just leave out the #ifdef and always align this, but it's not
> important.

This serves as "documentation". The alignment is important when 
CONFIG_ARM_PATCH_IDIV is selected and not otherwise.


Nicolas
