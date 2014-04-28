From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 28 Apr 2014 12:58:19 +0100
Subject: [PATCH v4 04/14] irq: gic: use mask field in GICC_IAR
In-Reply-To: <1398668032-8335-5-git-send-email-haojian.zhuang@linaro.org>
 (Haojian Zhuang's message of "Mon, 28 Apr 2014 07:53:42 +0100")
References: <1398668032-8335-1-git-send-email-haojian.zhuang@linaro.org>
 <1398668032-8335-5-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <87y4ypu0mc.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28 2014 at  7:53:42 am BST, Haojian Zhuang <haojian.zhuang@linaro.org> wrote:
> Bit[9:0] is interrupt ID field in GICC_IAR. Bit[12:10] is CPU ID field,
> and others are reserved.
>
> So we should use GICC_IAR_INTID to get interrupt ID. It's not a good way
> to use ~0x1c00 (CPU ID field) to get interrupt ID.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  drivers/irqchip/irq-gic.c       | 2 +-
>  include/linux/irqchip/arm-gic.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 4300b66..8fd27bf 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -287,7 +287,7 @@ static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
>  
>  	do {
>  		irqstat = readl_relaxed(cpu_base + GIC_CPU_INTACK);
> -		irqnr = irqstat & ~0x1c00;
> +		irqnr = irqstat & GICC_IAR_INTID;
>  
>  		if (likely(irqnr > 15 && irqnr < 1021)) {
>  			irqnr = irq_find_mapping(gic->domain, irqnr);
> diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
> index 7ed92d0..55933aa 100644
> --- a/include/linux/irqchip/arm-gic.h
> +++ b/include/linux/irqchip/arm-gic.h
> @@ -21,6 +21,8 @@
>  #define GIC_CPU_ACTIVEPRIO		0xd0
>  #define GIC_CPU_IDENT			0xfc
>  
> +#define GICC_IAR_INTID			0x3ff

This is actually a mask, so I'd suggest to reflect this in the name.
GICC_IAR_INT_ID_MASK?

> +
>  #define GIC_DIST_CTRL			0x000
>  #define GIC_DIST_CTR			0x004
>  #define GIC_DIST_IGROUP			0x080

	M.
-- 
Jazz is not dead. It just smells funny.
