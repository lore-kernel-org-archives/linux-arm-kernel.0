From: rabin@rab.in (Rabin Vincent)
Date: Mon, 28 Jun 2010 20:17:43 +0530
Subject: [PATCH 4/8] ARM: S5PV310: Add IRQ support
In-Reply-To: <1277476037-8806-5-git-send-email-kgene.kim@samsung.com>
References: <1277476037-8806-1-git-send-email-kgene.kim@samsung.com>
	<1277476037-8806-5-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100628144743.GB3287@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 25, 2010 at 11:27:13PM +0900, Kukjin Kim wrote:
> +static DEFINE_SPINLOCK(irq_controller_lock);

Hmm, why is this lock needed?  The uses below don't seem like they need
locking:

> +static void combiner_mask_irq(unsigned int irq)
> +{
> +	u32 mask = 1 << (irq % 32);
> +
> +	spin_lock(&irq_controller_lock);
> +	__raw_writel(mask, combiner_base(irq) + COMBINER_ENABLE_CLEAR);
> +	spin_unlock(&irq_controller_lock);
> +}
> +
> +static void combiner_unmask_irq(unsigned int irq)
> +{
> +	u32 mask = 1 << (irq % 32);
> +
> +	spin_lock(&irq_controller_lock);
> +	__raw_writel(mask, combiner_base(irq) + COMBINER_ENABLE_SET);
> +	spin_unlock(&irq_controller_lock);
> +}
> +
> +static void combiner_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
> +{
...
> +	spin_lock(&irq_controller_lock);
> +	status = __raw_readl(chip_data->base + COMBINER_INT_STATUS);
> +	spin_unlock(&irq_controller_lock);
