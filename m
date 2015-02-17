From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 17 Feb 2015 09:29:35 +0000
Subject: [PATCH v2 5/6] irqchip: gicv3-its: add support for power down
In-Reply-To: <1423992723-5028-6-git-send-email-wuyun.wu@huawei.com>
References: <1423992723-5028-1-git-send-email-wuyun.wu@huawei.com>
 <1423992723-5028-6-git-send-email-wuyun.wu@huawei.com>
Message-ID: <20150217092935.1fefcb24@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 15 Feb 2015 09:32:02 +0000
Yun Wu <wuyun.wu@huawei.com> wrote:

> It's unsafe to change the configurations of an activated ITS directly
> since this will lead to unpredictable results. This patch guarantees
> a safe quiescent status before initializing an ITS.

Please change the title of this patch to reflect what it actually
does. Nothing here is about powering down anything.

> Signed-off-by: Yun Wu <wuyun.wu@huawei.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 32
> ++++++++++++++++++++++++++++++++ 1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c
> b/drivers/irqchip/irq-gic-v3-its.c index 42c03b2..29eb665 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1321,6 +1321,31 @@ static const struct irq_domain_ops
> its_domain_ops = { .deactivate		=
> its_irq_domain_deactivate, };
> 
> +static int its_check_quiesced(void __iomem *base)
> +{
> +	u32 count = 1000000;	/* 1s */
> +	u32 val;
> +
> +	val = readl_relaxed(base + GITS_CTLR);
> +	if (val & GITS_CTLR_QUIESCENT)
> +		return 0;
> +
> +	/* Disable the generation of all interrupts to this ITS */
> +	val &= ~GITS_CTLR_ENABLE;
> +	writel_relaxed(val, base + GITS_CTLR);
> +
> +	/* Poll GITS_CTLR and wait until ITS becomes quiescent */
> +	while (count--) {
> +		val = readl_relaxed(base + GITS_CTLR);
> +		if (val & GITS_CTLR_QUIESCENT)
> +			return 0;
> +		cpu_relax();
> +		udelay(1);
> +	}

You're now introducing a third variant of a 1s timeout loop. Notice a
pattern?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
