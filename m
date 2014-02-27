From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 27 Feb 2014 18:54:24 +0000
Subject: [PATCH V2] irqchip:gic: change access of gicc_ctrl register to
 read modify write.
In-Reply-To: <1393526095-31479-1-git-send-email-fkan@apm.com> (Feng Kan's
 message of "Thu, 27 Feb 2014 18:34:55 +0000")
References: <1393526095-31479-1-git-send-email-fkan@apm.com>
Message-ID: <87zjlc2xpb.fsf@sofa.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 27 2014 at  6:34:55 pm GMT, Feng Kan <fkan@apm.com> wrote:
> This change is made to preserve the GIC v2 releated bits in the
> GIC_CPU_CTRL register (also known as the GICC_CTLR register in spec).
> The original code only set the enable/disable group bit in this register.
> This code will preserve the bypass bits configured by the bootload except
> the enable/disable bit. The main reason for this change is to allow the
> bypass bits specified in the v2 spec to remain untouched by the current
> GIC code. In the X-Gene platform, the bypass functionality is not used
> and bypass must be disabled at all time.
>
> Signed-off-by: Vinayak Kale <vkale@apm.com>
> Acked-by: Anup Patel <apatel@apm.com>
> Signed-off-by: Feng Kan <fkan@apm.com>
> ---
> V2 Changes:
> 	- only mask off v2 bypass bits
>
>  drivers/irqchip/irq-gic.c |   22 +++++++++++++++++++---
>  1 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 341c601..757581b 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -418,6 +418,7 @@ static void gic_cpu_init(struct gic_chip_data *gic)
>  	void __iomem *dist_base = gic_data_dist_base(gic);
>  	void __iomem *base = gic_data_cpu_base(gic);
>  	unsigned int cpu_mask, cpu = smp_processor_id();
> +	unsigned int ctrl_mask;
>  	int i;
>  
>  	/*
> @@ -449,13 +450,24 @@ static void gic_cpu_init(struct gic_chip_data *gic)
>  		writel_relaxed(0xa0a0a0a0, dist_base + GIC_DIST_PRI + i * 4 / 4);
>  
>  	writel_relaxed(0xf0, base + GIC_CPU_PRIMASK);
> -	writel_relaxed(1, base + GIC_CPU_CTRL);
> +
> +	ctrl_mask = readl(base + GIC_CPU_CTRL);
> +	ctrl_mask |= 0x1;
> +	writel_relaxed(ctrl_mask, base + GIC_CPU_CTRL);

I think I'm quickly loosing the will to live, or at least to review this
patch any further.

	M.
-- 
AAAFNRAA
