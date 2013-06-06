From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 6 Jun 2013 15:25:31 +0100
Subject: [PATCH v4 5/6] arm64/xen: introduce CONFIG_XEN on ARM64
In-Reply-To: <1370451727-26826-5-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1306051605030.4589@kaball.uk.xensource.com>
 <1370451727-26826-5-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20130606142530.GJ28479@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 06:02:06PM +0100, Stefano Stabellini wrote:
> diff --git a/arch/arm/xen/hypercall.S b/arch/arm/xen/hypercall.S
> index 199cb2d..114b356 100644
> --- a/arch/arm/xen/hypercall.S
> +++ b/arch/arm/xen/hypercall.S
> @@ -31,51 +31,93 @@
>   */
>  
>  /*
> - * The Xen hypercall calling convention is very similar to the ARM
> - * procedure calling convention: the first paramter is passed in r0, the
> - * second in r1, the third in r2 and the fourth in r3. Considering that
> - * Xen hypercalls have 5 arguments at most, the fifth paramter is passed
> - * in r4, differently from the procedure calling convention of using the
> - * stack for that case.
> + * The Xen hypercall calling convention is very similar to the ARM/ARM64
> + * procedure calling convention: the first paramter is passed in r0/x0,
> + * the second in r1/x1, the third in r2/x2 and the fourth in r3/x3.
> + * Considering that Xen hypercalls have 5 arguments at most, the fifth
> + * paramter is always passed in r4/x4, differently from the ARM
> + * procedure calling convention of using the stack for that case.
>   *
> - * The hypercall number is passed in r12.
> + * The hypercall number is passed in r12/x16.
>   *
> - * The return value is in r0.
> + * The return value is in r0/x0.
>   *
> - * The hvc ISS is required to be 0xEA1, that is the Xen specific ARM
> - * hypercall tag.
> + * The hvc ISS is required to be 0xEA1, that is the Xen specific
> + * ARM/ARM64 hypercall tag.
>   */
>  
>  #include <linux/linkage.h>
>  #include <asm/assembler.h>
> -#include <asm/opcodes-virt.h>
>  #include <xen/interface/xen.h>
>  
>  
>  #define XEN_IMM 0xEA1
>  
> +
> +#ifdef CONFIG_ARM
> +
> +#include <asm/opcodes-virt.h>
> +
> +ENTRY(privcmd_call)
> +	stmdb sp!, {r4}
> +	mov r12, r0
> +	mov r0, r1
> +	mov r1, r2
> +	mov r2, r3
> +	ldr r3, [sp, #8]
> +	ldr r4, [sp, #4]
> +	__HVC(XEN_IMM)
> +	ldm sp!, {r4}
> +	mov pc, lr
> +ENDPROC(privcmd_call);
> +
>  #define HYPERCALL_SIMPLE(hypercall)		\
>  ENTRY(HYPERVISOR_##hypercall)			\
>  	mov r12, #__HYPERVISOR_##hypercall;	\
> -	__HVC(XEN_IMM);						\
> -	mov pc, lr;							\
> +	__HVC(XEN_IMM);				\
> +	mov pc, lr;				\
> +ENDPROC(HYPERVISOR_##hypercall)
> +
> +#define HYPERCALL5(hypercall)			\
> +ENTRY(HYPERVISOR_##hypercall)			\
> +	stmdb sp!, {r4}				\
> +	ldr r4, [sp, #4]			\
> +	mov r12, #__HYPERVISOR_##hypercall;	\
> +	__HVC(XEN_IMM);				\
> +	ldm sp!, {r4}				\
> +	mov pc, lr				\
>  ENDPROC(HYPERVISOR_##hypercall)
>  
> +#else /* ARM64 specific code below */
> +
> +ENTRY(privcmd_call)
> +	mov x16, x0
> +	mov x0, x1
> +	mov x1, x2
> +	mov x2, x3
> +	mov x3, x4
> +	mov x4, x5
> +	hvc XEN_IMM
> +	ret
> +ENDPROC(privcmd_call);

Ah, thanks to Ian for pointing out, I missed the fact that you merged
the hypercall.S files. Please don't. It's a different assembly syntax.

-- 
Catalin
