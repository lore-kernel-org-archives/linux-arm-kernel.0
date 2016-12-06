From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Dec 2016 15:27:09 +0000
Subject: [PATCH v2] arm64: KVM: pmu: Reset PMSELR_EL0.SEL to a sane value
 before entering the guest
In-Reply-To: <1481036210-31816-1-git-send-email-marc.zyngier@arm.com>
References: <1481036210-31816-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20161206152708.GL2498@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 02:56:50PM +0000, Marc Zyngier wrote:
> The ARMv8 architecture allows the cycle counter to be configured
> by setting PMSELR_EL0.SEL==0x1f and then accessing PMXEVTYPER_EL0,
> hence accessing PMCCFILTR_EL0. But it disallows the use of
> PMSELR_EL0.SEL==0x1f to access the cycle counter itself through
> PMXEVCNTR_EL0.
> 
> Linux itself doesn't violate this rule, but we may end up with
> PMSELR_EL0.SEL being set to 0x1f when we enter a guest. If that
> guest accesses PMXEVCNTR_EL0, the access may UNDEF at EL1,
> despite the guest not having done anything wrong.
> 
> In order to avoid this unfortunate course of events (haha!), let's
> sanitize PMSELR_EL0 on guest entry. This ensures that the guest
> won't explode unexpectedly.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> This is another approach to fix this issue, this time nuking PMSELR_EL0
> on guest entry instead of relying on perf not to clobber the register.
> 
> Tested on v4.9-rc8 with a Rev A3 X-Gene.
> 
>  arch/arm64/kvm/hyp/switch.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index 83037cd..3b7cfbd 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -85,7 +85,13 @@ static void __hyp_text __activate_traps(struct kvm_vcpu *vcpu)
>  	write_sysreg(val, hcr_el2);
>  	/* Trap on AArch32 cp15 c15 accesses (EL1 or EL0) */
>  	write_sysreg(1 << 15, hstr_el2);
> -	/* Make sure we trap PMU access from EL0 to EL2 */
> +	/*
> +	 * Make sure we trap PMU access from EL0 to EL2. Also sanitize
> +	 * PMSELR_EL0 to make sure it never contains the cycle
> +	 * counter, which could make a PMXEVCNTR_EL0 access UNDEF.

"UNDEF at EL1, as opposed to trapping to EL2" might be clearer, but up to
you.

> +	 */
> +	if (vcpu->arch.mdcr_el2 & MDCR_EL2_HPMN_MASK)
> +		write_sysreg(0, pmselr_el0);
>  	write_sysreg(ARMV8_PMU_USERENR_MASK, pmuserenr_el0);

Curious, but why do you check MDCR.HPMN for PMSELR_EL0, but not for
PMUSERENR_EL0?

Anyway:

Acked-by: Will Deacon <will.deacon@arm.com>

Thanks,

Will
