From: jnair@caviumnetworks.com (Jayachandran C)
Date: Mon, 8 Jan 2018 09:40:17 -0800
Subject: [v2,03/11] arm64: Take into account ID_AA64PFR0_EL1.CSV3
In-Reply-To: <9bc1f137-d78c-e46e-e1bc-f49160d5f289@arm.com>
References: <1515157961-20963-4-git-send-email-will.deacon@arm.com>
 <20180108072253.GA178830@jc-sabre>
 <9bc1f137-d78c-e46e-e1bc-f49160d5f289@arm.com>
Message-ID: <20180108174016.GB180149@jc-sabre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 08, 2018 at 09:20:09AM +0000, Marc Zyngier wrote:
> On 08/01/18 07:24, Jayachandran C wrote:
> > On Fri, Jan 05, 2018 at 01:12:33PM +0000, Will Deacon wrote:
> >> For non-KASLR kernels where the KPTI behaviour has not been overridden
> >> on the command line we can use ID_AA64PFR0_EL1.CSV3 to determine whether
> >> or not we should unmap the kernel whilst running at EL0.
> >>
> >> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> Signed-off-by: Will Deacon <will.deacon@arm.com>
> >> ---
> >>  arch/arm64/include/asm/sysreg.h | 1 +
> >>  arch/arm64/kernel/cpufeature.c  | 8 +++++++-
> >>  2 files changed, 8 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> >> index 08cc88574659..ae519bbd3f9e 100644
> >> --- a/arch/arm64/include/asm/sysreg.h
> >> +++ b/arch/arm64/include/asm/sysreg.h
> >> @@ -437,6 +437,7 @@
> >>  #define ID_AA64ISAR1_DPB_SHIFT		0
> >>  
> >>  /* id_aa64pfr0 */
> >> +#define ID_AA64PFR0_CSV3_SHIFT		60
> >>  #define ID_AA64PFR0_SVE_SHIFT		32
> >>  #define ID_AA64PFR0_GIC_SHIFT		24
> >>  #define ID_AA64PFR0_ASIMD_SHIFT		20
> >> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> >> index 9f0545dfe497..d723fc071f39 100644
> >> --- a/arch/arm64/kernel/cpufeature.c
> >> +++ b/arch/arm64/kernel/cpufeature.c
> >> @@ -145,6 +145,7 @@ static const struct arm64_ftr_bits ftr_id_aa64isar1[] = {
> >>  };
> >>  
> >>  static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
> >> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_CSV3_SHIFT, 4, 0),
> >>  	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_SVE_SHIFT, 4, 0),
> >>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_GIC_SHIFT, 4, 0),
> >>  	S_ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_ASIMD_SHIFT, 4, ID_AA64PFR0_ASIMD_NI),
> >> @@ -851,6 +852,8 @@ static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
> >>  static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
> >>  				int __unused)
> >>  {
> >> +	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
> >> +
> >>  	/* Forced on command line? */
> >>  	if (__kpti_forced) {
> >>  		pr_info_once("kernel page table isolation forced %s by command line option\n",
> >> @@ -862,7 +865,9 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
> >>  	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> >>  		return true;
> >>  
> >> -	return false;
> >> +	/* Defer to CPU feature registers */
> >> +	return !cpuid_feature_extract_unsigned_field(pfr0,
> >> +						     ID_AA64PFR0_CSV3_SHIFT);
> > 
> > If I read this correctly, this enables KPTI on all processors without the CSV3
> > set (which seems to be a future capability).
> > 
> > Turning on KPTI has a small but significant overhead, so I think we should turn
> > it off on processors that are not vulnerable to CVE-2017-5754. Can we add something
> > like  this:
> > 
> > --->8
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index 19ed09b..202b037 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -862,6 +862,13 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
> >                 return __kpti_forced > 0;
> >         }
> >  
> > +       /* Don't force KPTI for CPUs that are not vulnerable */
> > +       switch (read_cpuid_id() & MIDR_CPU_MODEL_MASK) {
> > +               case MIDR_CAVIUM_THUNDERX2:
> > +               case MIDR_BRCM_VULCAN:
> > +                       return false;
> > +       }
> > +
> >         /* Useful for KASLR robustness */
> >         if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> >                 return true;
> > 
> 
> KPTI is also an improvement for KASLR. Why would you deprive a user of
> the choice to further secure their system?

The user has a choice with kpti= at the kernel command line, so we are
not depriving the user of a choice. KASLR is expected to be enabled by
distributions, and KPTI will be enabled by default as well.

On systems that are not vulnerable to variant 3, this is an unnecessary
overhead.

JC
