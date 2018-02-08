From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 8 Feb 2018 12:08:10 +0000
Subject: [PATCH] KVM: arm64: Enable the EL1 physical timer for AArch32
 guests
In-Reply-To: <1518091039-17356-1-git-send-email-j.fanguede@virtualopensystems.com>
References: <1518091039-17356-1-git-send-email-j.fanguede@virtualopensystems.com>
Message-ID: <51fa6f87-4d4d-0c14-9fb0-6ce0d2808ce3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/18 11:57, J?r?my Fangu?de wrote:
> Some 32bits guest OS can use the CNTP timer, however KVM does not
> handle the accesses, injecting a fault instead.
> 
> Use the proper handlers to emulate the EL1 Physical Timer (CNTP)
> register accesses of AArch32 guests.
> 
> Signed-off-by: J?r?my Fangu?de <j.fanguede@virtualopensystems.com>
> Signed-off-by: Alvise Rigo <a.rigo@virtualopensystems.com>
> ---
>  arch/arm64/kvm/sys_regs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 50a43c7..c0ab4f7 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1545,6 +1545,11 @@ static const struct sys_reg_desc cp15_regs[] = {
>  
>  	{ Op1( 0), CRn(13), CRm( 0), Op2( 1), access_vm_reg, NULL, c13_CID },
>  
> +	/* CNTP_TVAL */
> +	{ Op1( 0), CRn(14), CRm( 2), Op2( 0), access_cntp_tval },
> +	/* CNTP_CTL */
> +	{ Op1( 0), CRn(14), CRm( 2), Op2( 1), access_cntp_ctl },
> +
>  	/* PMEVCNTRn */
>  	PMU_PMEVCNTR(0),
>  	PMU_PMEVCNTR(1),
> @@ -1618,6 +1623,7 @@ static const struct sys_reg_desc cp15_64_regs[] = {
>  	{ Op1( 0), CRn( 0), CRm( 9), Op2( 0), access_pmu_evcntr },
>  	{ Op1( 0), CRn( 0), CRm(12), Op2( 0), access_gic_sgi },
>  	{ Op1( 1), CRn( 0), CRm( 2), Op2( 0), access_vm_reg, NULL, c2_TTBR1 },
> +	{ Op1( 2), CRn( 0), CRm(14), Op2( 0), access_cntp_cval },
>  };
>  
>  /* Target specific emulation tables */
> 

Seems OK to me. Can you please update the corresponding 32bit code while
you're at it?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
