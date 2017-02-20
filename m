From: james.morse@arm.com (James Morse)
Date: Mon, 20 Feb 2017 16:54:30 +0000
Subject: [PATCH 02/20] arm64: KVM: Implement HVC_RESET_VECTORS stub
 hypercall
In-Reply-To: <20170217154429.5000-3-marc.zyngier@arm.com>
References: <20170217154429.5000-1-marc.zyngier@arm.com>
 <20170217154429.5000-3-marc.zyngier@arm.com>
Message-ID: <58AB1F46.5000509@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 17/02/17 15:44, Marc Zyngier wrote:
> In order to restore HYP mode to its original condition, KVM currently
> implements __kvm_hyp_reset(). As we're moving towards a hyp-stub
> defined API, it becomes necessary to implement HVC_RESET_VECTORS.
> 
> This patch adds the HVC_RESET_VECTORS hypercall to the KVM init
> code, which so far lacked any form of hypercall support.

> diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
> index 6b29d3d9e1f2..948f331c7f32 100644
> --- a/arch/arm64/kvm/hyp-init.S
> +++ b/arch/arm64/kvm/hyp-init.S
> @@ -58,6 +59,9 @@ __invalid:
>  	 * x2: HYP vectors
>  	 */
>  __do_hyp_init:
> +	/* Check for a stub HVC call */
> +	cmp	x2, #HVC_STUB_HCALL_NR

Nit: x2 -> x0?


> +	b.lo	__kvm_handle_stub_hvc
>  
>  	msr	ttbr0_el2, x0
>  
> @@ -119,6 +123,9 @@ __do_hyp_init:
>  	eret
>  ENDPROC(__kvm_hyp_init)
>  
> +ENTRY(__kvm_handle_stub_hvc)
> +	cmp	x0, #HVC_RESET_VECTORS
> +	b.ne	1f
>  	/*
>  	 * Reset kvm back to the hyp stub.
>  	 */

Thanks,

James
