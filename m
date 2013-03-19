From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Mar 2013 10:55:38 -0600
Subject: [PATCH V4 2/9] ARM: tegra: irq: add wake up handling
In-Reply-To: <1363594400-11663-3-git-send-email-josephl@nvidia.com>
References: <1363594400-11663-1-git-send-email-josephl@nvidia.com>
 <1363594400-11663-3-git-send-email-josephl@nvidia.com>
Message-ID: <5148988A.4020409@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2013 02:13 AM, Joseph Lo wrote:
> Add the wake up handling for legacy irq controller, and using
> IRQCHIP_MASK_ON_SUSPEND for wake irq handling.

> diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c

> +static int tegra_set_wake(struct irq_data *d, unsigned int enable)
> +{
> +	u32 irq = d->irq;
> +	u32 index, mask;
> +
> +	BUG_ON(irq < FIRST_LEGACY_IRQ ||
> +	       irq >= FIRST_LEGACY_IRQ + num_ictlrs * 32);

Perhaps that should be:

	if (irq < FIRST_LEGACY_IRQ ||
		irq >= FIRST_LEGACY_IRQ + num_ictlrs * 32)
	return -EINVAL;
