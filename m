From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 27 Aug 2014 11:47:41 +0100
Subject: [RFC PATCH] Arm64: introduce __hyp_func_call
In-Reply-To: <1409135314-27266-1-git-send-email-achandran@mvista.com> (Arun
 Chandran's message of "Wed, 27 Aug 2014 11:28:34 +0100")
References: <1409135314-27266-1-git-send-email-achandran@mvista.com>
Message-ID: <87tx4yp5te.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27 2014 at 11:28:34 am BST, Arun Chandran <achandran@mvista.com> wrote:
> This adds a mechanism to __hyp_stub_vectors to allow a hypercall to
> call a function at EL2. It is needed for users who want to
> run a part of code with EL2 permissions. The current usecase is for
> KVM and kexec.
>
> For kexec we need to move the final CPU up to the mode it started
> in before we branch to the new kernel. If we don't do that
>
> * We loose EL2 in the next boot
> * Arm64 bootwrapper may not be able to put CPUs at the spin-table
>   code. It expects the final jump from kernel to cpu-return-addr to be
>   done in EL2.
>
> KVM can use this to set/get VBAR_EL2

So you've now broken KVM on arm64, since this patch doesn't address the
callers. But if you do so, you also break KVM on 32bit ARM, as we share
the calling code.

So you'll have to work a bit more before this can be an acceptable
solution.

Thanks,

	M.

> Signed-off-by: Arun Chandran <achandran@mvista.com>
> ---
> Idea is from "Mark Rutland <mark.rutland@arm.com>"
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/280026.html
> ---
>  arch/arm64/include/asm/virt.h |   15 +++++++++++++++
>  arch/arm64/kernel/hyp-stub.S  |   33 +++++++++++++++++++++------------
>  2 files changed, 36 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
> index 7a5df52..910a163 100644
> --- a/arch/arm64/include/asm/virt.h
> +++ b/arch/arm64/include/asm/virt.h
> @@ -34,9 +34,24 @@
>   */
>  extern u32 __boot_cpu_mode[2];
>  
> +void *__hyp_func_call(u64 __tmp, phys_addr_t func, ...);
>  void __hyp_set_vectors(phys_addr_t phys_vector_base);
>  phys_addr_t __hyp_get_vectors(void);
>  
> +#define __hyp_set_vectors(__vbase)					    \
> +({									    \
> +	u64 __tmp = 0;							    \
> +	__hyp_func_call(__tmp, virt_to_phys(__hyp_set_vectors), __vbase);   \
> +})
> +
> +#define __hyp_get_vectors()						    \
> +({									    \
> +	u64 __tmp = 0;							    \
> +	phys_addr_t ret = (phys_addr_t) __hyp_func_call(__tmp,		    \
> +					virt_to_phys(__hyp_get_vectors));   \
> +	ret;								    \
> +})
> +
>  /* Reports the availability of HYP mode */
>  static inline bool is_hyp_mode_available(void)
>  {
> diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> index a272f33..2144a3f 100644
> --- a/arch/arm64/kernel/hyp-stub.S
> +++ b/arch/arm64/kernel/hyp-stub.S
> @@ -53,15 +53,14 @@ ENDPROC(__hyp_stub_vectors)
>  	.align 11
>  
>  el1_sync:
> -	mrs	x1, esr_el2
> -	lsr	x1, x1, #26
> -	cmp	x1, #0x16
> +	mrs	x0, esr_el2
> +	lsr	x0, x0, #26
> +	cmp	x0, #0x16
>  	b.ne	2f				// Not an HVC trap
> -	cbz	x0, 1f
> -	msr	vbar_el2, x0			// Set vbar_el2
> -	b	2f
> -1:	mrs	x0, vbar_el2			// Return vbar_el2
> -2:	eret
> +
> +1:	blr	x1 				// Jump to the function
> +2:	mov	x0, xzr				// esr_el2 not readable <= el2
> +	eret
>  ENDPROC(el1_sync)
>  
>  .macro invalid_vector	label
> @@ -101,10 +100,20 @@ ENDPROC(\label)
>   */
>  
>  ENTRY(__hyp_get_vectors)
> -	mov	x0, xzr
> -	// fall through
> -ENTRY(__hyp_set_vectors)
> -	hvc	#0
> +	mrs	x0, vbar_el2			// Return vbar_el2
>  	ret
>  ENDPROC(__hyp_get_vectors)
> +
> +ENTRY(__hyp_set_vectors)
> +	msr	vbar_el2, x2
> +	ret
>  ENDPROC(__hyp_set_vectors)
> +
> +/* Call a function @x1 */
> +ENTRY(__hyp_func_call)
> +	/* Save lr here */
> +	msr	elr_el1, x30
> +	hvc	#0
> +	mrs	x30, elr_el1
> +	ret
> +ENDPROC(__hyp_func_call)

-- 
Jazz is not dead. It just smells funny.
