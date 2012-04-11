From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Apr 2012 23:56:51 +0100
Subject: [PATCH 1/3] integrator: fix the IRQ masks on the Integrator/CP
In-Reply-To: <1334184223-18864-1-git-send-email-linus.walleij@linaro.org>
References: <1334184223-18864-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20120411225651.GD24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2012 at 12:43:43AM +0200, Linus Walleij wrote:
> diff --git a/arch/arm/mach-integrator/include/mach/irqs.h b/arch/arm/mach-integrator/include/mach/irqs.h
> index a19a1a2..283931e 100644
> --- a/arch/arm/mach-integrator/include/mach/irqs.h
> +++ b/arch/arm/mach-integrator/include/mach/irqs.h
> @@ -52,7 +52,7 @@
>  #define IRQ_CP_CPPLDINT			26
>  #define IRQ_CP_ETHINT			27
>  #define IRQ_CP_TSPENINT			28
> -#define IRQ_PIC_END			31
> +#define IRQ_PIC_END			28
>  
>  #define IRQ_CIC_START			32
>  #define IRQ_CM_SOFTINT			32
> diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
> index 48a115a..2172f4c 100644
> --- a/arch/arm/mach-integrator/integrator_cp.c
> +++ b/arch/arm/mach-integrator/integrator_cp.c
> @@ -163,10 +163,10 @@ static struct fpga_irq_data sic_irq_data = {
>  
>  static void __init intcp_init_irq(void)
>  {
> -	u32 pic_mask, sic_mask;
> +	u32 pic_mask, cic_mask, sic_mask;
>  
> -	pic_mask = ~((~0u) << (11 - IRQ_PIC_START));
> -	pic_mask |= (~((~0u) << (29 - 22))) << 22;
> +	pic_mask = ~((~0u) << (1 + IRQ_PIC_END - IRQ_PIC_START));

Err no, the original is correct.

Integrator/CP only has IRQs 29-22 and IRQs 11-0.  IRQs 21-12 are
reserved.  Integrator/AP on the other hand has IRQs 21-0.
