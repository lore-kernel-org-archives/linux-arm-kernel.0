From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 25 Nov 2014 12:03:39 +0100
Subject: [PATCH v4 17/19] arm64: KVM: add SGI generation register emulation
In-Reply-To: <54735EE6.70904@arm.com>
References: <1415959683-26027-1-git-send-email-andre.przywara@arm.com>
 <1415959683-26027-18-git-send-email-andre.przywara@arm.com>
 <20141123150852.GD3401@cbox> <54735EE6.70904@arm.com>
Message-ID: <20141125110339.GD31297@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On Mon, Nov 24, 2014 at 04:37:58PM +0000, Andre Przywara wrote:
> Hi,
> 
> On 23/11/14 15:08, Christoffer Dall wrote:
> > On Fri, Nov 14, 2014 at 10:08:01AM +0000, Andre Przywara wrote:
> >> While the generation of a (virtual) inter-processor interrupt (SGI)
> >> on a GICv2 works by writing to a MMIO register, GICv3 uses the system
> >> register ICC_SGI1R_EL1 to trigger them.
> >> Trap that register on ARM64 hosts and handle it in a new handler
> >> function in the GICv3 emulation code.
> > 
> > Did you reorder something or does my previous comment still apply that
> > you're not enabling trapping yet, you're just adding the handler - those
> > are two different things.
> 
> Yes, I can fix the wording.
> 
> > You sort of left my question about access_gic_sgi() not checking if the
> > gicv3 is presetn hanging from the last thread, but I think I'm
> > understanding properly now, that as long as you're not setting the
> > ICC_SRE_EL2.Enable = 1, then we'll never get here, right?
> 
> Right, that is the idea. Just to make sure that I got this right from
> the discussion the other day: We will not trap to EL2 as long as
> ICC_SRE_EL2.Enable is 0 - which it should still be at this point, right?

No, when ICC_SRE_EL2.Enable is 0, then Non-secure EL1 access to
ICC_SRE_EL1 trap to EL2 (See Section 5.7.39 in the spec), which means
that accesses to the ICC_SGIx registers will cause an undefined
exception in the guest because we set ICC_SRE_EL1.SRE to 0 for the
guest and the guest cannot change this.

Now, when we set ICC_SRE_EL2.Enable to 1, then the guest can set
ICC_SRE_EL1.SRE to 1 (and we also happen to reset it to 1), and we will
indeed trap on guest access to the ICC_SGIx registers, because all
virtual accesses to these registers trap.

(Going back and checking where 'virtual accesses' is defined in the spec
left me somewhere without any results, but I am guessing that because we
set the ICH_HCR_EL2.En to 1, all accesses will be deemed virtual
accesses, maybe the spec should be clarfied on this matter?).

Anyhow, to get back to my original question, getting here requires
a situation where the guest copy of the ICC_SRE_EL1.SRE is 1, which we
only allow when we have properly initialized the GICv3 data structures.

> (I am asking because I struggle to find this in the spec).
> 
> So actually your ICC_SRE_EL1 trap patch solved that problem ;-)
> 

So I think this is a different thing, not related that closely to my
question above.

That patch was about when ICC_SRE_EL2.Enable is 0, then we would trap
guest accesses to ICC_SRE_EL1 which did not have any sysreg handler
installed, and ended up with an undefined exception in the guest instead
of handling the trap as RAZ/WI.

> >>
> >> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> >> ---
> >> Changelog v3...v4:
> >> - moved addition of vgic_v3_dispatch_sgi() from earlier patch into here
> >> - move MPIDR comparison into extra function
> >> - use new ICC_SGI1R_ field names
> >> - improve readability of vgic_v3_dispatch_sgi()
> >> - add and refine comments
> >>
> >>  arch/arm64/kvm/sys_regs.c   |   26 ++++++++++
> >>  include/kvm/arm_vgic.h      |    1 +
> >>  virt/kvm/arm/vgic-v3-emul.c |  113 +++++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 140 insertions(+)
> >>
> >> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> >> index fd3ffc3..e59369a 100644
> >> --- a/arch/arm64/kvm/sys_regs.c
> >> +++ b/arch/arm64/kvm/sys_regs.c
> >> @@ -165,6 +165,27 @@ static bool access_sctlr(struct kvm_vcpu *vcpu,
> >>  	return true;
> >>  }
> >>  
> >> +/*
> >> + * Trap handler for the GICv3 SGI generation system register.
> >> + * Forward the request to the VGIC emulation.
> >> + * The cp15_64 code makes sure this automatically works
> >> + * for both AArch64 and AArch32 accesses.
> >> + */
> >> +static bool access_gic_sgi(struct kvm_vcpu *vcpu,
> >> +			   const struct sys_reg_params *p,
> >> +			   const struct sys_reg_desc *r)
> >> +{
> >> +	u64 val;
> >> +
> >> +	if (!p->is_write)
> >> +		return read_from_write_only(vcpu, p);
> >> +
> >> +	val = *vcpu_reg(vcpu, p->Rt);
> >> +	vgic_v3_dispatch_sgi(vcpu, val);
> >> +
> >> +	return true;
> >> +}
> >> +
> >>  static bool trap_raz_wi(struct kvm_vcpu *vcpu,
> >>  			const struct sys_reg_params *p,
> >>  			const struct sys_reg_desc *r)
> >> @@ -431,6 +452,9 @@ static const struct sys_reg_desc sys_reg_descs[] = {
> >>  	/* VBAR_EL1 */
> >>  	{ Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b0000), Op2(0b000),
> >>  	  NULL, reset_val, VBAR_EL1, 0 },
> >> +	/* ICC_SGI1R_EL1 */
> >> +	{ Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b1011), Op2(0b101),
> >> +	  access_gic_sgi },
> >>  	/* CONTEXTIDR_EL1 */
> >>  	{ Op0(0b11), Op1(0b000), CRn(0b1101), CRm(0b0000), Op2(0b001),
> >>  	  access_vm_reg, reset_val, CONTEXTIDR_EL1, 0 },
> >> @@ -659,6 +683,8 @@ static const struct sys_reg_desc cp14_64_regs[] = {
> >>   * register).
> >>   */
> >>  static const struct sys_reg_desc cp15_regs[] = {
> >> +	{ Op1( 0), CRn( 0), CRm(12), Op2( 0), access_gic_sgi },
> >> +
> >>  	{ Op1( 0), CRn( 1), CRm( 0), Op2( 0), access_sctlr, NULL, c1_SCTLR },
> >>  	{ Op1( 0), CRn( 2), CRm( 0), Op2( 0), access_vm_reg, NULL, c2_TTBR0 },
> >>  	{ Op1( 0), CRn( 2), CRm( 0), Op2( 1), access_vm_reg, NULL, c2_TTBR1 },
> >> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> >> index c1ef5a9..357a935 100644
> >> --- a/include/kvm/arm_vgic.h
> >> +++ b/include/kvm/arm_vgic.h
> >> @@ -305,6 +305,7 @@ void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu);
> >>  void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu);
> >>  int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
> >>  			bool level);
> >> +void vgic_v3_dispatch_sgi(struct kvm_vcpu *vcpu, u64 reg);
> >>  int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
> >>  bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
> >>  		      struct kvm_exit_mmio *mmio);
> >> diff --git a/virt/kvm/arm/vgic-v3-emul.c b/virt/kvm/arm/vgic-v3-emul.c
> >> index 97b5801..58d7457 100644
> >> --- a/virt/kvm/arm/vgic-v3-emul.c
> >> +++ b/virt/kvm/arm/vgic-v3-emul.c
> >> @@ -828,6 +828,119 @@ int vgic_v3_init_emulation(struct kvm *kvm)
> >>  	return 0;
> >>  }
> >>  
> >> +/*
> >> + * Compare a given affinity (level 1-3 and a level 0 mask, from the SGI
> >> + * generation register ICC_SGI1R_EL1) with a given VCPU.
> >> + * If the VCPU's MPIDR matches, return the level0 affinity, otherwise
> >> + * return -1.
> >> + */
> >> +static int match_mpidr(u64 sgi_aff, u16 sgi_cpu_mask, struct kvm_vcpu *vcpu)
> >> +{
> >> +	unsigned long affinity;
> >> +	int level0;
> >> +
> >> +	/*
> >> +	 * Split the current VCPU's MPIDR into affinity level 0 and the
> >> +	 * rest as this is what we have to compare against.
> >> +	 */
> >> +	affinity = kvm_vcpu_get_mpidr_aff(vcpu);
> >> +	level0 = MPIDR_AFFINITY_LEVEL(affinity, 0);
> >> +	affinity &= ~MPIDR_LEVEL_MASK;
> >> +
> >> +	/* bail out if the upper three levels don't match */
> >> +	if (sgi_aff != affinity)
> >> +		return -1;
> >> +
> >> +	/* Is this VCPU's bit set in the mask ? */
> >> +	if (!(sgi_cpu_mask & BIT(level0)))
> >> +		return -1;
> >> +
> >> +	return level0;
> >> +}
> >> +
> >> +#define SGI_AFFINITY_LEVEL(reg, level) \
> >> +	((((reg) & ICC_SGI1R_AFFINITY_## level ##_MASK) \
> >> +	>> ICC_SGI1R_AFFINITY_## level ##_SHIFT) << MPIDR_LEVEL_SHIFT(level))
> >> +
> >> +/**
> >> + * vgic_v3_dispatch_sgi - handle SGI requests from VCPUs
> >> + * @vcpu: The VCPU requesting a SGI
> >> + * @reg: The value written into the ICC_SGI1R_EL1 register by that VCPU
> >> + *
> >> + * With GICv3 (and ARE=1) CPUs trigger SGIs by writing to an architectural
> > 
> > what's a non-architectural system register?
> 
> architectural vs. implementation defined.
> Are you suggesting that I should drop "architectural" because it is a
> tautology?

when you write architectural here it lets the reader belive this is
something of importance as compared to any other system register write,
which I don't believe it is here, so I would drop the word, but it's up
to you.

Thanks,
-Christoffer
