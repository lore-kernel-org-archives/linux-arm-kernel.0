From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 08 Dec 2015 17:03:56 +0000
Subject: [PATCH v6 15/21] KVM: ARM64: Add reset and access handlers for
 PMUSERENR register
In-Reply-To: <1449578860-15808-16-git-send-email-zhaoshenglong@huawei.com>
References: <1449578860-15808-1-git-send-email-zhaoshenglong@huawei.com>
 <1449578860-15808-16-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <56670D7C.9070902@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/15 12:47, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> The reset value of PMUSERENR_EL0 is UNKNOWN, use reset_unknown.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  arch/arm64/kvm/sys_regs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index c830fde..80b66c0 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -880,7 +880,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  	  access_pmu_pmxevcntr },
>  	/* PMUSERENR_EL0 */
>  	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1110), Op2(0b000),
> -	  trap_raz_wi },
> +	  access_pmu_regs, reset_unknown, PMUSERENR_EL0 },

So while the 64bit view of the register resets as unknown, a CPU
resetting in 32bit mode resets as 0. I suggest you reset it as zero, and
document that choice. You may have to revisit all the other registers
that do reset as unknown for 64bit as well.

>  	/* PMOVSSET_EL0 */
>  	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1110), Op2(0b011),
>  	  access_pmu_regs, reset_unknown, PMOVSSET_EL0 },
> @@ -1301,7 +1301,8 @@ static const struct sys_reg_desc cp15_regs[] = {
>  	  NULL, c9_PMCCNTR },
>  	{ Op1( 0), CRn( 9), CRm(13), Op2( 1), access_pmu_pmxevtyper },
>  	{ Op1( 0), CRn( 9), CRm(13), Op2( 2), access_pmu_pmxevcntr },
> -	{ Op1( 0), CRn( 9), CRm(14), Op2( 0), trap_raz_wi },
> +	{ Op1( 0), CRn( 9), CRm(14), Op2( 0), access_pmu_cp15_regs,
> +	  NULL,  c9_PMUSERENR, 0 },
>  	{ Op1( 0), CRn( 9), CRm(14), Op2( 1), access_pmu_cp15_regs,
>  	  NULL, c9_PMINTENSET },
>  	{ Op1( 0), CRn( 9), CRm(14), Op2( 2), access_pmu_cp15_regs,
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
