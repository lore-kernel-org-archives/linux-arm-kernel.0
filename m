From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 6 Mar 2017 07:08:08 -0800
Subject: [PATCH 2/2] arm64/kvm: survive unknown traps from guests
In-Reply-To: <1487593812-9174-3-git-send-email-mark.rutland@arm.com>
References: <1487593812-9174-1-git-send-email-mark.rutland@arm.com>
 <1487593812-9174-3-git-send-email-mark.rutland@arm.com>
Message-ID: <20170306150808.GC1502@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2017 at 12:30:12PM +0000, Mark Rutland wrote:
> Currently we BUG() if we see an ESR_EL2.EC value we don't recognise. As
> configurable disables/enables are added to the architecture (controlled
> by RES1/RES0 bits respectively), with associated synchronous exceptions,
> it may be possible for a guest to trigger exceptions with classes that
> we don't recognise.
> 
> While we can't service these exceptions in a manner useful to the guest,
> we can avoid bringing down the host. Per ARM DDI 0487A.k_iss10775, page
> D7-1937, EC values within the range 0x00 - 0x2c are reserved for future
> use with synchronous exceptions, and EC values within the range 0x2d -
> 0x3f may be used for either synchronous or asynchronous exceptions.
> 
> The patch makes KVM handle any unknown EC by injecting an UNDEFINED
> exception into the guest, with a corresponding (ratelimited) warning in
> the host dmesg. We could later improve on this with with a new (opt-in)
> exit to the host userspace.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Dave Martin <dave.martin@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/kvm/handle_exit.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index 1bfe30d..fa1b18e 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -135,7 +135,19 @@ static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  	return ret;
>  }
>  
> +static int kvm_handle_unknown_ec(struct kvm_vcpu *vcpu, struct kvm_run *run)
> +{
> +	u32 hsr = kvm_vcpu_get_hsr(vcpu);
> +
> +	kvm_pr_unimpl("Unknown exception class: hsr: %#08x -- %s\n",
> +		      hsr, esr_get_class_string(hsr));
> +
> +	kvm_inject_undefined(vcpu);
> +	return 1;
> +}
> +
>  static exit_handle_fn arm_exit_handlers[] = {
> +	[0 ... ESR_ELx_EC_MAX]	= kvm_handle_unknown_ec,
>  	[ESR_ELx_EC_WFx]	= kvm_handle_wfx,
>  	[ESR_ELx_EC_CP15_32]	= kvm_handle_cp15_32,
>  	[ESR_ELx_EC_CP15_64]	= kvm_handle_cp15_64,
> @@ -162,13 +174,6 @@ static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
>  	u32 hsr = kvm_vcpu_get_hsr(vcpu);
>  	u8 hsr_ec = ESR_ELx_EC(hsr);
>  
> -	if (hsr_ec >= ARRAY_SIZE(arm_exit_handlers) ||
> -	    !arm_exit_handlers[hsr_ec]) {
> -		kvm_err("Unknown exception class: hsr: %#08x -- %s\n",
> -			hsr, esr_get_class_string(hsr));
> -		BUG();
> -	}
> -
>  	return arm_exit_handlers[hsr_ec];
>  }
>  
> -- 

Reviewed-by: Christoffer Dall <cdall@linaro.org>
