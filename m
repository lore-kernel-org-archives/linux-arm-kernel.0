From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Dec 2015 22:50:02 +0100
Subject: [PATCH] ARM: Runtime patch udiv/sdiv instructions into
 __aeabi_{u}idiv()
In-Reply-To: <alpine.LFD.2.20.1512111125330.26920@knanqh.ubzr>
References: <alpine.LFD.2.20.1512110105450.26920@knanqh.ubzr>
 <6991913.FSOzozNbSC@wuerfel>
 <alpine.LFD.2.20.1512111125330.26920@knanqh.ubzr>
Message-ID: <1887582.W42jA1d2lP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 December 2015 12:10:29 Nicolas Pitre wrote:
> On Fri, 11 Dec 2015, Arnd Bergmann wrote:
> > On Friday 11 December 2015 01:26:25 Nicolas Pitre wrote:
> > > Of course the ultimate performance will come from having gcc emit those 
> > > div instructions directly, but that would make the kernel binary 
> > > incompatible with some systems in a multi-arch config. Hence it has to 
> > > be a separate config option.
> > 
> > Well, what we found is that we already have the same problem today
> > when enabling LPAE makes the kernel incompatible with platforms that
> > can be enabled. The affected platforms are basically the same, except
> > for the earlier PJ4 and Krait variants that have some idiv support
> > but no LPAE.
> 
> Still, making native div support depend on CONFIG_LPAE would be strange. 
> A separate config symbol would mmake it self explanatory.

Based on the discussion we had, I'd use CONFIG_CPU_V7VE or some variation
of that:

* Almost all early ARMv7 cpu cores (Cortex-A8/A9/A5, Scorpion, PJ4, PJ4B) are not
  V7VE, and they support neither LPAE nor IDIV

* All V7VE cores (Cortex-A7/A12/A15/A17, B15) by definition support both LPAE
  and IDIV. Krait400 and PJ4B-MP/PJ4C are not V7VE because they don't support
  virtualization, but for our purposes they are close enough that we want to
  build them with -march=armv7ve on toolchains that allow this.

* Most Krait (pre-Krait400) don't support LPAE but do support IDIV. However,
  with the latest change to mach-qcom/Kconfig we no longer care because we
  don't have separate Kconfig symbols per SoC any more and we can build a
  kernel for QCOM/MSM with either V7 or V7VE and with either LPAE or not, and
  we get what the user asked for.

* PJ4/PJ4B can be treated special when building a thumb2 kernel, we already
  have a Kconfig option for it that we could extend, but I'd just use your
  solution for this, it's good enough and it handles the special opcodes
  for ARM mode transparently (at least when you do a follow-up patch).

We haven't solved the question how the new Kconfig option fits in, but
I still think we should try to get this right, especially because the LPAE
handling is currently suboptimal in the way that you can enable LPAE on
any ARMv7 platform, whether that supports LPAE or not.

> > #ifdef CONFIG_CPU_PJ4B
> >         .type   __v7_pj4b_proc_info, #object
> > __v7_pj4b_proc_info:
> >         .long   0x560f5800
> >         .long   0xff0fff00
> >         __v7_proc __v7_pj4b_proc_info, __v7_pj4b_setup, proc_fns = pj4b_processor_functions
> >         .size   __v7_pj4b_proc_info, . - __v7_pj4b_proc_info
> > #endif
> > 
> > 
> > Can someone have a look and tell me that I'm wrong when I read this
> > as matching both PJ4 and PJ4B (and PJ4B-MP)?
> > 
> > Either I'm misreading this, or we do the wrong thing in configurations
> > that include both PJ4B (berlin, mvebu) and PJ4 (MMP2/dove).
> 
> I don't have the relevant documentation to validate it.  And I'd prefer 
> if this was sorted out in a separate patch.  Maybe I should just drop 
> the PJ4 variants from this patch for now.

To clarify: that point had nothing to do with your patch, I just think
I found an existing kernel bug that will cause pj4b_processor_functions
to be used on PJ4 (Dove, MMP2) in a kernel that includes both PJ4 and
PJ4B (Armada 370/XP, Berlin).

> > > +#ifdef CONFIG_ARM_PATCH_IDIV
> > > +
> > > +/* "sdiv r0, r0, r1" or "mrc p6, 1, r0, CR0, CR1, 4" if we're on pj4 w/o MP */
> > > +static inline u32 __attribute_const__ sdiv_instruction(void)
> > > +{
> > > +	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
> > > +		u32 insn = __opcode_thumb32_compose(0xfb90, 0xf0f1);
> > > +		if (cpu_is_pj4_nomp())
> > > +			insn = __opcode_thumb32_compose(0xee30, 0x0691);
> > > +		return __opcode_to_mem_thumb32(insn);
> > > +	}
> > 
> > Strictly speaking, we can ignore the thumb instruction for pj4, as all
> > variants also support the normal T2 opcode for udiv/sdiv.
> 
> OK it is gone.
> 
> Now... The code bails out if ARM mode and HWCAP_IDIVA is not set so 
> effectively the ARM mode on PJ4 is currently not used either. So I'm 
> leaning towards having aving another patch to sort PJ4 out.

Sounds good.

> > > diff --git a/arch/arm/lib/lib1funcs.S b/arch/arm/lib/lib1funcs.S
> > > index af2267f6a5..9397b2e532 100644
> > > --- a/arch/arm/lib/lib1funcs.S
> > > +++ b/arch/arm/lib/lib1funcs.S
> > > @@ -205,6 +205,10 @@ Boston, MA 02111-1307, USA.  */
> > >  .endm
> > >  
> > >  
> > > +#ifdef CONFIG_ARM_PATCH_IDIV
> > > +	.align	3
> > > +#endif
> > > +
> > >  ENTRY(__udivsi3)
> > >  ENTRY(__aeabi_uidiv)
> > >  UNWIND(.fnstart)
> > 
> > I'd probably just leave out the #ifdef and always align this, but it's not
> > important.
> 
> This serves as "documentation". The alignment is important when 
> CONFIG_ARM_PATCH_IDIV is selected and not otherwise.

Fair enough.

	Arnd
