From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 8 Feb 2016 13:09:50 +0100
Subject: [PATCH v11 06/21] KVM: ARM64: Add access handler for PMCEID0 and
 PMCEID1 register
In-Reply-To: <1454656456-11640-7-git-send-email-zhaoshenglong@huawei.com>
References: <1454656456-11640-1-git-send-email-zhaoshenglong@huawei.com>
 <1454656456-11640-7-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <20160208120950.GC620@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 05, 2016 at 03:14:01PM +0800, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Add access handler which gets host value of PMCEID0 or PMCEID1 when
> guest access these registers. Writing action to PMCEID0 or PMCEID1 is
> UNDEFINED.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  arch/arm64/kvm/sys_regs.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index fc60041..06257e2 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -492,6 +492,27 @@ static bool access_pmselr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>  	return true;
>  }
>  
> +static bool access_pmceid(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
> +			  const struct sys_reg_desc *r)
> +{
> +	u64 pmceid;
> +
> +	if (!kvm_arm_pmu_v3_ready(vcpu))
> +		return trap_raz_wi(vcpu, p, r);
> +
> +	if (p->is_write)
> +		return false;

Isn't it really a BUG_ON(p->is_write) ?

Presumably a guest write to these registers will raise an undefined
exception in EL0/1 and we don't get here by any other path than the trap
handler, do we?

Otherwise looks good to me.

Thanks,
-Christoffer
