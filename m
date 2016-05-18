From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 18 May 2016 21:53:47 +0200
Subject: [PATCH] kvm: arm64: Fix EC field in inject_abt64
In-Reply-To: <5739C320.6010602@arm.com>
References: <5739C320.6010602@arm.com>
Message-ID: <20160518195347.GA26840@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2016 at 01:54:56PM +0100, Matt Evans wrote:
> The EC field of the constructed ESR is conditionally modified by ORing in
> ESR_ELx_EC_DABT_LOW for a data abort.  However, ESR_ELx_EC_SHIFT is missing
> from this condition.
> 
> Signed-off-by: Matt Evans <matt.evans@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Cc: <stable@vger.kernel.org>
> ---
>  arch/arm64/kvm/inject_fault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
> index 4d1ac81..e9e0e6d 100644
> --- a/arch/arm64/kvm/inject_fault.c
> +++ b/arch/arm64/kvm/inject_fault.c
> @@ -162,7 +162,7 @@ static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr
>  		esr |= (ESR_ELx_EC_IABT_CUR << ESR_ELx_EC_SHIFT);
>  
>  	if (!is_iabt)
> -		esr |= ESR_ELx_EC_DABT_LOW;
> +		esr |= ESR_ELx_EC_DABT_LOW << ESR_ELx_EC_SHIFT;
>  
>  	vcpu_sys_reg(vcpu, ESR_EL1) = esr | ESR_ELx_FSC_EXTABT;
>  }
> -- 
> 1.9.1
> 

Applied to queue.

Thanks!
-Christoffer
