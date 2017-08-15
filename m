From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Aug 2017 17:37:55 +0100
Subject: [PATCH 23/27] arm64/sve: KVM: Hide SVE from CPU features exposed
 to guests
In-Reply-To: <1502280338-23002-24-git-send-email-Dave.Martin@arm.com>
References: <1502280338-23002-1-git-send-email-Dave.Martin@arm.com>
 <1502280338-23002-24-git-send-email-Dave.Martin@arm.com>
Message-ID: <39b6ee07-1258-e733-3495-38b0d31ab800@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/17 13:05, Dave Martin wrote:
> KVM guests cannot currently use SVE, because SVE is always
> configured to trap to EL2.
> 
> However, a guest that sees SVE reported as present in
> ID_AA64PFR0_EL1 may legitimately expect that SVE works and try to
> use it.  Instead of working, the guest will receive an injected
> undef exception, which may cause the guest to oops or go into a
> spin.
> 
> To avoid misleading the guest into believing that SVE will work,
> this patch masks out the SVE field from ID_AA64PFR0_EL1 when a
> guest attempts to read this register.  No support is explicitly
> added for ID_AA64ZFR0_EL1 either, so that is still emulated as
> reading as zero, which is consistent with SVE not being
> implemented.
> 
> This is a temporary measure, and will be removed in a later series
> when full KVM support for SVE is implemented.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm64/kvm/sys_regs.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 6583dd7..9e8c54e 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -897,8 +897,20 @@ static u64 read_id_reg(struct sys_reg_desc const *r, bool raz)
>  {
>  	u32 id = sys_reg((u32)r->Op0, (u32)r->Op1,
>  			 (u32)r->CRn, (u32)r->CRm, (u32)r->Op2);
> +	u64 val = raz ? 0 : read_sanitised_ftr_reg(id);
>  
> -	return raz ? 0 : read_sanitised_ftr_reg(id);
> +	if (id == SYS_ID_AA64PFR0_EL1) {
> +		static bool printed;
> +
> +		if ((val & (0xfUL << ID_AA64PFR0_SVE_SHIFT)) && !printed) {
> +			kvm_info("SVE unsupported for guests, suppressing\n");
> +			printed = true;
> +		}

Ideally, this should be a vcpu_unimpl_once(). But:
- it doesn't exist
- vcpu_unimpl looks hopelessly x86 specific

How about turning it into a pr_err_once() instead?

> +
> +		val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
> +	}
> +
> +	return val;
>  }
>  
>  /* cpufeature ID register access trap handlers */
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
