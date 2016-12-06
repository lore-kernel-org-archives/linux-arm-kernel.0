From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Dec 2016 16:37:07 +0000
Subject: [PATCH v2] arm64: KVM: pmu: Reset PMSELR_EL0.SEL to a sane value
 before entering the guest
In-Reply-To: <20161206162918.GE4816@cbox>
References: <1481036210-31816-1-git-send-email-marc.zyngier@arm.com>
 <20161206162918.GE4816@cbox>
Message-ID: <20161206163706.GR2498@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 05:29:18PM +0100, Christoffer Dall wrote:
> On Tue, Dec 06, 2016 at 02:56:50PM +0000, Marc Zyngier wrote:
> > diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> > index 83037cd..3b7cfbd 100644
> > --- a/arch/arm64/kvm/hyp/switch.c
> > +++ b/arch/arm64/kvm/hyp/switch.c
> > @@ -85,7 +85,13 @@ static void __hyp_text __activate_traps(struct kvm_vcpu *vcpu)
> >  	write_sysreg(val, hcr_el2);
> >  	/* Trap on AArch32 cp15 c15 accesses (EL1 or EL0) */
> >  	write_sysreg(1 << 15, hstr_el2);
> > -	/* Make sure we trap PMU access from EL0 to EL2 */
> > +	/*
> > +	 * Make sure we trap PMU access from EL0 to EL2. Also sanitize
> > +	 * PMSELR_EL0 to make sure it never contains the cycle
> > +	 * counter, which could make a PMXEVCNTR_EL0 access UNDEF.
> > +	 */
> > +	if (vcpu->arch.mdcr_el2 & MDCR_EL2_HPMN_MASK)
> > +		write_sysreg(0, pmselr_el0);
> 
> I'm a bit confused about how we use the HPMN field.  This value is
> always set to the full number of counters available on the system and
> never modified by the guest, right?  So this is in essence a check that
> says 'do you have any performance counters, then make sure accesses
> don't undef to el1 instead of trapping to el2', but then my question is,
> why not just set pmselr_el0 to zero unconditionally, because in the case
> where (vcpu->arch.mdcr_el2 & MDCR_EL2_HPMN_MASK) == 0, it means we have
> no counters, which we'll have exposed to the guest anyhow, and we should
> undef at el1 in the guest, or did I get this completely wrong (like
> everything else today)?

I think Marc and I came to the same conclusion a few minutes ago. The check
you might want is "Have I instantiated a virtual PMU for this device?",
but that's probably a micro-optimisation.

Will
