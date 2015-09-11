From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 11 Sep 2015 11:16:07 +0100
Subject: [PATCH v2 05/22] KVM: ARM64: Add a helper for CP15 registers
 reset to UNKNOWN
In-Reply-To: <1441961715-11688-6-git-send-email-zhaoshenglong@huawei.com>
References: <1441961715-11688-1-git-send-email-zhaoshenglong@huawei.com>
 <1441961715-11688-6-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <55F2A9E7.7000100@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/15 09:54, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  arch/arm64/kvm/sys_regs.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
> index d411e25..a0b3811 100644
> --- a/arch/arm64/kvm/sys_regs.h
> +++ b/arch/arm64/kvm/sys_regs.h
> @@ -104,6 +104,14 @@ static inline void reset_unknown(struct kvm_vcpu *vcpu,
>  	vcpu_sys_reg(vcpu, r->reg) = 0x1de7ec7edbadc0deULL;
>  }
>  
> +static inline void reset_unknown_cp15(struct kvm_vcpu *vcpu,
> +				      const struct sys_reg_desc *r)
> +{
> +	BUG_ON(!r->reg);
> +	BUG_ON(r->reg >= NR_COPRO_REGS);
> +	vcpu_cp15(vcpu, r->reg) = 0xdecafbad;

Given how many times we use this constant, maybe we should consider
having a #define for it?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
