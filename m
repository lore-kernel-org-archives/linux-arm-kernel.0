From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 30 Sep 2014 14:25:59 +0200
Subject: [PATCH 1/3] irqchip: dw-apb-ictl: always use use
 {readl|writel}_relaxed
In-Reply-To: <1411454100-6814-2-git-send-email-jszhang@marvell.com>
References: <1411454100-6814-1-git-send-email-jszhang@marvell.com>
 <1411454100-6814-2-git-send-email-jszhang@marvell.com>
Message-ID: <542AA157.8080908@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/2014 08:34 AM, Jisheng Zhang wrote:
> relaxed version and non-relaxed version are mixed, this patch always
> use the relaxed version to unify the memory access usage.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

While I don't agree with the above reason (unification) for this
change, I agree with the patch because it _can_ be changed, so

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> ---
>   drivers/irqchip/irq-dw-apb-ictl.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
> index 31e231e..fcc3385 100644
> --- a/drivers/irqchip/irq-dw-apb-ictl.c
> +++ b/drivers/irqchip/irq-dw-apb-ictl.c
> @@ -94,16 +94,16 @@ static int __init dw_apb_ictl_init(struct device_node *np,
>   	 */
>
>   	/* mask and enable all interrupts */
> -	writel(~0, iobase + APB_INT_MASK_L);
> -	writel(~0, iobase + APB_INT_MASK_H);
> -	writel(~0, iobase + APB_INT_ENABLE_L);
> -	writel(~0, iobase + APB_INT_ENABLE_H);
> +	writel_relaxed(~0, iobase + APB_INT_MASK_L);
> +	writel_relaxed(~0, iobase + APB_INT_MASK_H);
> +	writel_relaxed(~0, iobase + APB_INT_ENABLE_L);
> +	writel_relaxed(~0, iobase + APB_INT_ENABLE_H);
>
> -	reg = readl(iobase + APB_INT_ENABLE_H);
> +	reg = readl_relaxed(iobase + APB_INT_ENABLE_H);
>   	if (reg)
>   		nrirqs = 32 + fls(reg);
>   	else
> -		nrirqs = fls(readl(iobase + APB_INT_ENABLE_L));
> +		nrirqs = fls(readl_relaxed(iobase + APB_INT_ENABLE_L));
>
>   	domain = irq_domain_add_linear(np, nrirqs,
>   				       &irq_generic_chip_ops, NULL);
>
