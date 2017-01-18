From: will.deacon@arm.com (Will Deacon)
Date: Wed, 18 Jan 2017 15:24:24 +0000
Subject: [RFC PATCH v2 03/10] arm64: KVM: Save/restore the host SPE state
 when entering/leaving a VM
In-Reply-To: <61308f80-3bcd-6bff-2c87-dccb58a0a84c@arm.com>
References: <1484323429-15231-1-git-send-email-will.deacon@arm.com>
 <1484323429-15231-4-git-send-email-will.deacon@arm.com>
 <61308f80-3bcd-6bff-2c87-dccb58a0a84c@arm.com>
Message-ID: <20170118152423.GI28063@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Thanks for having a look.

On Mon, Jan 16, 2017 at 11:25:37AM +0000, Marc Zyngier wrote:
> On 13/01/17 16:03, Will Deacon wrote:
> > The SPE buffer is virtually addressed, using the page tables of the CPU
> > MMU. Unusually, this means that the EL0/1 page table may be live whilst
> > we're executing at EL2 on non-VHE configurations. When VHE is in use,
> > we can use the same property to profile the guest behind its back.
> > 
> > This patch adds the relevant disabling and flushing code to KVM so that
> > the host can make use of SPE without corrupting guest memory, and any
> > attempts by a guest to use SPE will result in a trap.
> > 
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Alex Benn?e <alex.bennee@linaro.org>
> > Cc: Christoffer Dall <christoffer.dall@linaro.org>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/include/asm/kvm_arm.h  |  3 ++
> >  arch/arm64/include/asm/kvm_host.h |  7 ++++-
> >  arch/arm64/kvm/debug.c            |  6 ++++
> >  arch/arm64/kvm/hyp/debug-sr.c     | 66 +++++++++++++++++++++++++++++++++++++--
> >  arch/arm64/kvm/hyp/switch.c       | 13 +++++++-
> >  5 files changed, 91 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> > index 2a2752b5b6aa..6e99978e83bd 100644
> > --- a/arch/arm64/include/asm/kvm_arm.h
> > +++ b/arch/arm64/include/asm/kvm_arm.h
> > @@ -188,6 +188,9 @@
> >  #define CPTR_EL2_DEFAULT	0x000033ff
> >  
> >  /* Hyp Debug Configuration Register bits */
> > +#define MDCR_EL2_TPMS		(1 << 14)
> > +#define MDCR_EL2_E2PB_MASK	(UL(0x3))
> > +#define MDCR_EL2_E2PB_SHIFT	(UL(12))
> >  #define MDCR_EL2_TDRA		(1 << 11)
> >  #define MDCR_EL2_TDOSA		(1 << 10)
> >  #define MDCR_EL2_TDA		(1 << 9)
> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > index e5050388e062..443b387021f2 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -229,7 +229,12 @@ struct kvm_vcpu_arch {
> >  
> >  	/* Pointer to host CPU context */
> >  	kvm_cpu_context_t *host_cpu_context;
> > -	struct kvm_guest_debug_arch host_debug_state;
> > +	struct {
> > +		/* {Break,watch}point registers */
> > +		struct kvm_guest_debug_arch regs;
> > +		/* Statistical profiling extension */
> > +		u64 pmscr_el1;
> > +	} host_debug_state;
> >  
> >  	/* VGIC state */
> >  	struct vgic_cpu vgic_cpu;
> > diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> > index 47e5f0feaee8..dbadfaf850a7 100644
> > --- a/arch/arm64/kvm/debug.c
> > +++ b/arch/arm64/kvm/debug.c
> > @@ -95,6 +95,7 @@ void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu)
> >   *  - Performance monitors (MDCR_EL2_TPM/MDCR_EL2_TPMCR)
> >   *  - Debug ROM Address (MDCR_EL2_TDRA)
> >   *  - OS related registers (MDCR_EL2_TDOSA)
> > + *  - Statistical profiler (MDCR_EL2_TPMS/MDCR_EL2_E2PB)
> >   *
> >   * Additionally, KVM only traps guest accesses to the debug registers if
> >   * the guest is not actively using them (see the KVM_ARM64_DEBUG_DIRTY
> > @@ -110,8 +111,13 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu)
> >  
> >  	trace_kvm_arm_setup_debug(vcpu, vcpu->guest_debug);
> >  
> > +	/*
> > +	 * This also clears MDCR_EL2_E2PB_MASK to disable guest access
> > +	 * to the profiling buffer.
> > +	 */
> >  	vcpu->arch.mdcr_el2 = __this_cpu_read(mdcr_el2) & MDCR_EL2_HPMN_MASK;
> >  	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM |
> > +				MDCR_EL2_TPMS |
> 
> This is RES0 on CPUs that do not implement SPE. Can we make this
> conditional on SPE being available?

I could, but it would introduce a runtime ID register check for the physical
CPU on the fastpath, because big/little systems are not required to be
symmetric in this regard. We already have code that writes to bits that
might be RES0 but have been defined by later versions of the architecture.
In fact, setting the TPM bit here is RES0 if the PMU is not implemented.

Furthermore, the architecture does state that writing a value to a RES0
field "must have no effect on the operation of the PE". The purpose of
the fields is for future architecture extension, which in this case has
been defined by SPE.

> > +static void __hyp_text __debug_save_spe_nvhe(u64 *pmscr_el1)
> > +{
> > +	u64 reg;
> > +
> > +	/* SPE present on this CPU? */
> > +	if (!cpuid_feature_extract_unsigned_field(read_sysreg(id_aa64dfr0_el1),
> > +						  ID_AA64DFR0_PMSVER_SHIFT))
> > +		return;
> > +
> > +	/* Yes; is it owned by EL3? */
> > +	reg = read_sysreg_s(PMBIDR_EL1);
> > +	if (reg & PMBIDR_EL1_P)
> > +		return;
> > +
> > +	/* No; is the host actually using the thing? */
> > +	reg = read_sysreg_s(PMBLIMITR_EL1);
> > +	if (!(reg & PMBLIMITR_EL1_E))
> > +		return;
> > +
> > +	/* Yes; save the control register and disable data generation */
> > +	*pmscr_el1 = read_sysreg_s(PMSCR_EL1);
> > +	write_sysreg_s(0, PMSCR_EL1);
> > +	isb();
> > +
> > +	/* Now drain all buffered data to memory */
> > +	psb_csync();
> > +	dsb(nsh);
> 
> So let's hope that nobody will build a non-VHE, SPE capable system.
> Because this feels like hitting the brakes each time we enter the guest
> (if SPE is in use, that is...).

Yup, not much we can do about that :(

> > +static hyp_alternate_select(__debug_save_spe,
> > +			    __debug_save_spe_nvhe, __debug_save_spe_vhe,
> > +			    ARM64_HAS_VIRT_HOST_EXTN);
> > +
> > +static void __hyp_text __debug_restore_spe(u64 pmscr_el1)
> > +{
> > +	if (!pmscr_el1)
> > +		return;
> > +
> > +	/* The host page table is installed, but not yet synchronised */
> > +	isb();
> 
> I believe you can avoid that on VHE (host page tables haven't changed).

It should already be skipped because pmscr_el1 is never set for VHE
(__debug_save_spe_vhe is a NOP).

> Also, if you now depend on the debug restore being run after the rest of
> the sysregs, please add a comment in switch.c::__kvm_vcpu_run so that we
> remember about that dependency.

Sure.

> > +
> > +	/* Re-enable data generation */
> > +	write_sysreg_s(pmscr_el1, PMSCR_EL1);
> 
> Same thing here, as we never disabled SPE the first place on VHE (and
> we're probably only writing zeroes there).

Yup, check the conditional :)

Will
