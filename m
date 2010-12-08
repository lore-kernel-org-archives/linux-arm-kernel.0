From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 08 Dec 2010 00:43:24 +0000
Subject: [PATCH] ARM: GIC irq desciptor bug fix
In-Reply-To: <1291270659-24903-1-git-send-email-cxie4@marvell.com>
References: <1291270659-24903-1-git-send-email-cxie4@marvell.com>
Message-ID: <4CFED4AC.3040304@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/10 06:17, Chao at marvell.com wrote:
> From: cxie4 <cxie4@marvell.com>

I think you should have your full name here.

> 
> gic_set_cpu will directly use irq_desc[]. If CONFIG_SPARSE_IRQ is enabled, there is no
> irq_desc[]. So we need use irq_to_desc(irq) to get the descriptor for irq.
> 
> Signed-off-by: cxie4 <cxie4@marvell.com>
> ---
>  arch/arm/common/gic.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> index 7dfa9a8..6599acb 100644
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c
> @@ -160,9 +160,15 @@ static int gic_set_cpu(unsigned int irq, const struct cpumask *mask_val)
>  	unsigned int shift = (irq % 4) * 8;
>  	unsigned int cpu = cpumask_first(mask_val);
>  	u32 val;
> +	struct irq_desc *desc;
>  
>  	spin_lock(&irq_controller_lock);
> -	irq_desc[irq].node = cpu;
> +	desc = irq_to_desc(irq);
> +	if (desc == NULL) {
> +		spin_unlock(&irq_controller_lock);
> +		return -EINVAL;
> +	}

Hmm, NULL would be quite a problem, should we BUG() on this
or maybe WARN on it?

> +	desc->node = cpu;
>  	val = readl(reg) & ~(0xff << shift);
>  	val |= 1 << (cpu + shift);
>  	writel(val, reg);
