From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Dec 2016 11:49:54 +0000
Subject: [PATCH 1/2] ARM: hyp-stub: improve ABI
In-Reply-To: <E1cH74w-0003ke-Qp@rmk-PC.armlinux.org.uk>
References: <20161213113044.GC19985@leverpostej>
 <E1cH74w-0003ke-Qp@rmk-PC.armlinux.org.uk>
Message-ID: <20161214114954.GF17982@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2016 at 10:46:30AM +0000, Russell King wrote:
> Improve the hyp-stub ABI to allow it to do more than just get/set the
> vectors.  We follow the example in ARM64, where r0 is used as an opcode
> with the other registers as an argument.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

This looks good to me, though I'd suggest s/ABI/calling convention/, as
this isn't strictly speaking an ABI. So FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  arch/arm/kernel/hyp-stub.S | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
> index 15d073ae5da2..f3e9ba5fb642 100644
> --- a/arch/arm/kernel/hyp-stub.S
> +++ b/arch/arm/kernel/hyp-stub.S
> @@ -22,6 +22,9 @@
>  #include <asm/assembler.h>
>  #include <asm/virt.h>
>  
> +#define HVC_GET_VECTORS 0
> +#define HVC_SET_VECTORS 1
> +
>  #ifndef ZIMAGE
>  /*
>   * For the kernel proper, we need to find out the CPU boot mode long after
> @@ -202,9 +205,19 @@ ARM_BE8(orr	r7, r7, #(1 << 25))     @ HSCTLR.EE
>  ENDPROC(__hyp_stub_install_secondary)
>  
>  __hyp_stub_do_trap:
> -	cmp	r0, #-1
> -	mrceq	p15, 4, r0, c12, c0, 0	@ get HVBAR
> -	mcrne	p15, 4, r0, c12, c0, 0	@ set HVBAR
> +	teq	r0, #HVC_GET_VECTORS
> +	bne	1f
> +	mrc	p15, 4, r0, c12, c0, 0	@ get HVBAR
> +	b	__hyp_stub_exit
> +
> +1:	teq	r0, #HVC_SET_VECTORS
> +	bne	1f
> +	mcr	p15, 4, r1, c12, c0, 0	@ set HVBAR
> +	b	__hyp_stub_exit
> +
> +1:	mov	r0, #-1
> +
> +__hyp_stub_exit:
>  	__ERET
>  ENDPROC(__hyp_stub_do_trap)
>  
> @@ -231,10 +244,14 @@ ENDPROC(__hyp_stub_do_trap)
>   * initialisation entry point.
>   */
>  ENTRY(__hyp_get_vectors)
> -	mov	r0, #-1
> +	mov	r0, #HVC_GET_VECTORS
> +	__HVC(0)
> +	ret	lr
>  ENDPROC(__hyp_get_vectors)
> -	@ fall through
> +
>  ENTRY(__hyp_set_vectors)
> +	mov	r1, r0
> +	mov	r0, #HVC_SET_VECTORS
>  	__HVC(0)
>  	ret	lr
>  ENDPROC(__hyp_set_vectors)
> -- 
> 2.7.4
> 
