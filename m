From: Jean-Philippe.Brucker@arm.com (Jean-Philippe Brucker)
Date: Wed, 10 Feb 2016 20:42:21 +0000
Subject: [PATCH] ARM: virt: enable GICv3 system registers
In-Reply-To: <1453721639-24733-1-git-send-email-jean-philippe.brucker@arm.com>
References: <1453721639-24733-1-git-send-email-jean-philippe.brucker@arm.com>
Message-ID: <20160210204221.GA2749@e106794-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 11:33:59AM +0000, Jean-Philippe Brucker wrote:
> ARMv8 introduces system registers for the Generic Interrupt Controller's
> CPU and virtual interfaces.
> When GICv3 is implemented, EL2 needs to allow the kernel to use those
> registers, by changing the value of ICC_HSRE.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Russell, does this look OK for your tree?

Thanks,
Jean-Philippe

> ---
>  arch/arm/kernel/hyp-stub.S |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
> index 2a55373..0b1e4a9 100644
> --- a/arch/arm/kernel/hyp-stub.S
> +++ b/arch/arm/kernel/hyp-stub.S
> @@ -17,6 +17,7 @@
>   */
>  
>  #include <linux/init.h>
> +#include <linux/irqchip/arm-gic-v3.h>
>  #include <linux/linkage.h>
>  #include <asm/assembler.h>
>  #include <asm/virt.h>
> @@ -161,6 +162,29 @@ ARM_BE8(orr	r7, r7, #(1 << 25))     @ HSCTLR.EE
>  1:
>  #endif
>  
> +#ifdef CONFIG_ARM_GIC_V3
> +	@ Check whether GICv3 system registers are available
> +	mrc	p15, 0, r7, c0, c1, 1	@ ID_PFR1
> +	ubfx	r7, r7, #28, #4
> +	cmp	r7, #1
> +	bne	2f
> +
> +	@ Enable system register accesses
> +	mrc	p15, 4, r7, c12, c9, 5	@ ICC_HSRE
> +	orr	r7, r7, #(ICC_SRE_EL2_ENABLE | ICC_SRE_EL2_SRE)
> +	mcr	p15, 4, r7, c12, c9, 5	@ ICC_HSRE
> +	isb
> +
> +	@ SRE bit could be forced to 0 by firmware.
> +	@ Check whether it sticks before accessing any other sysreg
> +	mrc	p15, 4, r7, c12, c9, 5	@ ICC_HSRE
> +	tst	r7, #ICC_SRE_EL2_SRE
> +	beq	2f
> +	mov	r7, #0
> +	mcr	p15, 4, r7, c12, c11, 0	@ ICH_HCR
> +2:
> +#endif
> +
>  	bx	lr			@ The boot CPU mode is left in r4.
>  ENDPROC(__hyp_stub_install_secondary)
>  
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
