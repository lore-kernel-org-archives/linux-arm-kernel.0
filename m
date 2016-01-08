From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 8 Jan 2016 09:45:22 +0100 (CET)
Subject: [PATCH v3 1/3] gpio: xgene: Enable X-Gene standby GPIO as
 interrupt controller
In-Reply-To: <1452162428-26839-2-git-send-email-qnguyen@apm.com>
References: <1452162428-26839-1-git-send-email-qnguyen@apm.com>
 <1452162428-26839-2-git-send-email-qnguyen@apm.com>
Message-ID: <alpine.DEB.2.11.1601080942270.3575@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Jan 2016, Quan Nguyen wrote:
> -static int apm_gpio_sb_to_irq(struct gpio_chip *gc, u32 gpio)
> +static void xgene_gpio_sb_irq_ack(struct irq_data *d)
> +{
> +	struct irq_data *irqdata;
> +	struct xgene_gpio_sb *priv = irq_data_get_irq_chip_data(d);
> +
> +	irqdata = irq_get_irq_data(priv->gic_virq[d->hwirq]);
> +	if (!irqdata || !irqdata->chip)
> +		return;

What the heck is this? Why are you looking up some random other irq and fiddle
with its irq chip?

This is a 1:1 mapping from your gpio irq to a gic irq. We have hierarchical
interrupt domains for this.

Thanks,

	tglx
