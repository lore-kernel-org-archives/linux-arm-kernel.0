From: cdall@linaro.org (Christoffer Dall)
Date: Mon, 31 Jul 2017 14:59:20 +0200
Subject: [RFC PATCH v2 38/38] KVM: arm64: Respect the virtual
 CPTR_EL2.TCPAC setting
In-Reply-To: <1500397144-16232-39-git-send-email-jintack.lim@linaro.org>
References: <1500397144-16232-1-git-send-email-jintack.lim@linaro.org>
 <1500397144-16232-39-git-send-email-jintack.lim@linaro.org>
Message-ID: <20170731125920.GX5176@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 11:59:04AM -0500, Jintack Lim wrote:
> Forward CPACR_EL1 traps to the virtual EL2 if virtual CPTR_EL2 is
> configured to trap CPACR_EL1 accesses from EL1.
> 
> This is for recursive nested virtualization.
> 
> Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
> ---
>  arch/arm64/kvm/sys_regs.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 6f67666..ba2966d 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1091,6 +1091,11 @@ static bool access_cpacr(struct kvm_vcpu *vcpu,
>  	if (el12_reg(p) && forward_nv_traps(vcpu))
>  		return kvm_inject_nested_sync(vcpu, kvm_vcpu_get_hsr(vcpu));
>  
> +	/* Forward this trap to the virtual EL2 if CPTR_EL2.TCPAC is set*/
> +	if (!el12_reg(p) && !vcpu_mode_el2(vcpu) &&
> +	    (vcpu_sys_reg(vcpu, CPTR_EL2) & CPTR_EL2_TCPAC))
> +		return kvm_inject_nested_sync(vcpu, kvm_vcpu_get_hsr(vcpu));
> +

I'm trying to understand what should happen if the VM is in EL1 and
accesses CPACR_EL12, but the guest hypervisor did not set
CPTR_EL2.TCPAC, why would we get here, and if there's a good reason why
we god here, is the EL12 access not supposed to undef at EL1 as opposed
to actually work, like it seems your code does when it doesn't take the
branch?

>  	/*
>  	 * When the virtual HCR_EL2.E2H == 1, an access to CPACR_EL1
>  	 * in the virtual EL2 is to access CPTR_EL2.
> -- 
> 1.9.1
> 

Thanks,
-Christoffer
