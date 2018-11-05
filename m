From: james.morse@arm.com (James Morse)
Date: Mon, 5 Nov 2018 18:34:35 +0000
Subject: [PATCH 4/4] arm64: KVM: Implement workaround for Cortex-A76
 erratum 1165522
In-Reply-To: <20181105143617.120602-5-marc.zyngier@arm.com>
References: <20181105143617.120602-1-marc.zyngier@arm.com>
 <20181105143617.120602-5-marc.zyngier@arm.com>
Message-ID: <a13dfb2d-df5b-7783-2e8b-8a8ffe50b436@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 05/11/2018 14:36, Marc Zyngier wrote:
> Early versions of Cortex-A76 can end-up with corrupt TLBs if they
> speculate an AT instruction in during a guest switch while the

                              (in during?)

> S1/S2 system registers are in an inconsistent state.
> 
> Work around it by:
> - Mandating VHE
> - Make sure that S1 and S2 system registers are consistent before
>    clearing HCR_EL2.TGE, which allows AT to target the EL1 translation
>    regime
> 
> These two things together ensure that we cannot hit this erratum.


> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index 51d5d966d9e5..322109183853 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -143,6 +143,13 @@ static void deactivate_traps_vhe(void)
>   {
>   	extern char vectors[];	/* kernel exception vectors */
>   	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
> +
> +	/*
> +	 * ARM erratum 1165522 requires the actual execution of the
> +	 * above before we can switch to the host translation regime.
> +	 */
> +	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_1165522));
> +

Host regime too ... does __tlb_switch_to_host_vhe() need the same 
treatment? It writes vttbr_el2 and hcr_el2 back to back.



Thanks,

James
