From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 15 Dec 2016 11:18:48 +0000
Subject: [PATCH 1/2] ARM: hyp-stub: improve ABI
In-Reply-To: <E1cH74w-0003ke-Qp@rmk-PC.armlinux.org.uk>
References: <20161213113044.GC19985@leverpostej>
 <E1cH74w-0003ke-Qp@rmk-PC.armlinux.org.uk>
Message-ID: <72f93940-cf87-fd91-90f2-760b7ff050fb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/12/16 10:46, Russell King wrote:
> Improve the hyp-stub ABI to allow it to do more than just get/set the
> vectors.  We follow the example in ARM64, where r0 is used as an opcode
> with the other registers as an argument.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
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

This breaks the KVM implementation of __hyp_get_vectors, easily fixed
with the following patchlet:

diff --git a/arch/arm/include/asm/virt.h b/arch/arm/include/asm/virt.h
index a2e75b8..0fe637e 100644
--- a/arch/arm/include/asm/virt.h
+++ b/arch/arm/include/asm/virt.h
@@ -89,6 +89,14 @@ extern char __hyp_text_start[];
 extern char __hyp_text_end[];
 #endif
 
+#else
+
+/* Only assembly code should need those */
+
+#define HVC_GET_VECTORS 0
+#define HVC_SET_VECTORS 1
+#define HVC_SOFT_RESTART 2
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* ! VIRT_H */
diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index ebc26f8..1c6888f 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -22,10 +22,6 @@
 #include <asm/assembler.h>
 #include <asm/virt.h>
 
-#define HVC_GET_VECTORS 0
-#define HVC_SET_VECTORS 1
-#define HVC_SOFT_RESTART 2
-
 #ifndef ZIMAGE
 /*
  * For the kernel proper, we need to find out the CPU boot mode long after
diff --git a/arch/arm/kvm/hyp/hyp-entry.S b/arch/arm/kvm/hyp/hyp-entry.S
index 96beb53..1f8db7d 100644
--- a/arch/arm/kvm/hyp/hyp-entry.S
+++ b/arch/arm/kvm/hyp/hyp-entry.S
@@ -127,7 +127,7 @@ hyp_hvc:
 	pop	{r0, r1, r2}
 
 	/* Check for __hyp_get_vectors */
-	cmp	r0, #-1
+	cmp	r0, #HVC_GET_VECTORS
 	mrceq	p15, 4, r0, c12, c0, 0	@ get HVBAR
 	beq	1f
 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
