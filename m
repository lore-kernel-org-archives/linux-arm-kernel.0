From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 23 Mar 2017 11:57:12 +0000
Subject: [PATCH v4 02/28] arm64: KVM: Move lr save/restore to do_el2_call
In-Reply-To: <20170321192058.9300-3-marc.zyngier@arm.com>
References: <20170321192058.9300-1-marc.zyngier@arm.com>
 <20170321192058.9300-3-marc.zyngier@arm.com>
Message-ID: <d2dc3301-b3d4-44e7-2a47-b4d9c1f48444@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/03/17 19:20, Marc Zyngier wrote:
> At the moment, we only save/restore lr if on VHE, as we rely only
> the EL1 code to have preserved it in the non-VHE case.
> 
> As we're about to get rid of the latter, let's move the save/restore
> code to the do_el2_call macro, unifying both code paths.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/kvm/hyp/hyp-entry.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
> index 5e9052f087f2..d8ef788646c6 100644
> --- a/arch/arm64/kvm/hyp/hyp-entry.S
> +++ b/arch/arm64/kvm/hyp/hyp-entry.S
> @@ -32,17 +32,17 @@
>  	 * Shuffle the parameters before calling the function
>  	 * pointed to in x0. Assumes parameters in x[1,2,3].
>  	 */
> +	str	lr, [sp, #-16]!
>  	mov	lr, x0
>  	mov	x0, x1
>  	mov	x1, x2
>  	mov	x2, x3
>  	blr	lr
> +	ldr	lr, [sp], #16
>  .endm
>  
>  ENTRY(__vhe_hyp_call)
> -	str	lr, [sp, #-16]!
>  	do_el2_call
> -	ldr	lr, [sp], #16
>  	/*
>  	 * We used to rely on having an exception return to get
>  	 * an implicit isb. In the E2H case, we don't have it anymore.
> 

As a follow-up on this patch, here's a nit I missed where we were still 
saving lr in the EL2 entry code. Doesn't affect functionality, but 
might as well clean that one up (and kill an obscure comment):

diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index 09391cf0c93c..952f6cb9cf72 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -38,13 +38,10 @@
  * A function pointer with a value less than 0xfff has a special meaning,
  * and is used to implement hyp stubs in the same way as in
  * arch/arm64/kernel/hyp_stub.S.
- * HVC behaves as a 'bl' call and will clobber lr.
  */
 ENTRY(__kvm_call_hyp)
 alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
-	str     lr, [sp, #-16]!
 	hvc	#0
-	ldr     lr, [sp], #16
 	ret
 alternative_else_nop_endif
 	b	__vhe_hyp_call

I'll squash it locally.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
