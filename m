From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 19 Mar 2014 18:10:44 -0700
Subject: [PATCH v2 2/7] ARM: KVM: fix vgic V7 assembler code to work in
 BE image
In-Reply-To: <1392183693-21238-3-git-send-email-victor.kamensky@linaro.org>
References: <1392183693-21238-1-git-send-email-victor.kamensky@linaro.org>
 <1392183693-21238-3-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140320011044.GH1297@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 09:41:28PM -0800, Victor Kamensky wrote:
> The vgic h/w registers are little endian; when asm code reads/writes

when BE asm code...

> from/to them, it needs to do byteswap after/before. Byteswap code
> uses ARM_BE8 wrapper to add swap only if CONFIG_CPU_BIG_ENDIAN is
> configured.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> ---
>  arch/arm/kvm/interrupts_head.S | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
> index 6f18695..1e9be2f 100644
> --- a/arch/arm/kvm/interrupts_head.S
> +++ b/arch/arm/kvm/interrupts_head.S
> @@ -1,4 +1,5 @@
>  #include <linux/irqchip/arm-gic.h>
> +#include <asm/assembler.h>
>  
>  #define VCPU_USR_REG(_reg_nr)	(VCPU_USR_REGS + (_reg_nr * 4))
>  #define VCPU_USR_SP		(VCPU_USR_REG(13))
> @@ -412,6 +413,14 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	ldr	r8, [r2, #GICH_ELRSR0]
>  	ldr	r9, [r2, #GICH_ELRSR1]
>  	ldr	r10, [r2, #GICH_APR]
> +ARM_BE8(rev	r3, r3	)
> +ARM_BE8(rev	r4, r4	)
> +ARM_BE8(rev	r5, r5	)
> +ARM_BE8(rev	r6, r6	)
> +ARM_BE8(rev	r7, r7	)
> +ARM_BE8(rev	r8, r8	)
> +ARM_BE8(rev	r9, r9	)
> +ARM_BE8(rev	r10, r10	)
>  
>  	str	r3, [r11, #VGIC_CPU_HCR]
>  	str	r4, [r11, #VGIC_CPU_VMCR]
> @@ -431,6 +440,7 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	add	r3, r11, #VGIC_CPU_LR
>  	ldr	r4, [r11, #VGIC_CPU_NR_LR]
>  1:	ldr	r6, [r2], #4
> +ARM_BE8(rev	r6, r6	)
>  	str	r6, [r3], #4
>  	subs	r4, r4, #1
>  	bne	1b
> @@ -458,6 +468,9 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	ldr	r3, [r11, #VGIC_CPU_HCR]
>  	ldr	r4, [r11, #VGIC_CPU_VMCR]
>  	ldr	r8, [r11, #VGIC_CPU_APR]
> +ARM_BE8(rev	r3, r3	)
> +ARM_BE8(rev	r4, r4	)
> +ARM_BE8(rev	r8, r8	)
>  
>  	str	r3, [r2, #GICH_HCR]
>  	str	r4, [r2, #GICH_VMCR]
> @@ -468,6 +481,7 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	add	r3, r11, #VGIC_CPU_LR
>  	ldr	r4, [r11, #VGIC_CPU_NR_LR]
>  1:	ldr	r6, [r3], #4
> +ARM_BE8(rev	r6, r6  )
>  	str	r6, [r2], #4
>  	subs	r4, r4, #1
>  	bne	1b
> -- 
> 1.8.1.4
> 

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
