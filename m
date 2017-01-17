From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 17 Jan 2017 04:00:13 +0100
Subject: [PATCH 08/22] power: supply: add AC power supply driver for
 AXP20X and AXP22X PMICs
In-Reply-To: <20170102163723.7939-9-quentin.schulz@free-electrons.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-9-quentin.schulz@free-electrons.com>
Message-ID: <20170117030013.g5xhlmrxpthyfewa@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Quentin,

The driver looks mostly fine. I do have a two comments, though.

On Mon, Jan 02, 2017 at 05:37:08PM +0100, Quentin Schulz wrote:
> [...]
>
> +static int axp20x_ac_power_probe(struct platform_device *pdev)
> +{
> +	static const char * const axp20x_irq_names[] = { "ACIN_PLUGIN",
> +		"ACIN_REMOVAL", NULL };
>
> +	static const char * const *irq_names;
> +	const struct power_supply_desc *ac_power_desc;
> +	int i, irq, ret;
> +
> +	if (!of_device_is_available(pdev->dev.of_node))
> +		return -ENODEV;
> +
> +	if (!axp20x) {
> +		dev_err(&pdev->dev, "Parent drvdata not set\n");
> +		return -EINVAL;
> +	}

axp20x will no longer be needed after implementing below
comments.

> [...]
> +	irq_names = axp20x_irq_names;

Just rename axp20x_irq_names into irq_names, since its only used
here.

> [...]
>
> +	power->np = pdev->dev.of_node;

This can be dropped, it's not used at all.

> +	power->regmap = axp20x->regmap;

power->regmap = dev_get_regmap(pdev->dev.parent, NULL);

> [...]
> +	/* Request irqs after registering, as irqs may trigger immediately */
> +	for (i = 0; irq_names[i]; i++) {
> +		irq = platform_get_irq_byname(pdev, irq_names[i]);
> +		if (irq < 0) {
> +			dev_warn(&pdev->dev, "No IRQ for %s: %d\n",
> +				 irq_names[i], irq);
> +			continue;
> +		}
> +		irq = regmap_irq_get_virq(axp20x->regmap_irqc, irq);

The mapping should actually happen in the mfd driver, so that
the platform resource contains a valid irq.

> +		ret = devm_request_any_context_irq(&pdev->dev, irq,
> +						   axp20x_ac_power_irq, 0,
> +						   DRVNAME, power);
> +		if (ret < 0)
> +			dev_warn(&pdev->dev, "Error requesting %s IRQ: %d\n",
> +				 irq_names[i], ret);
> +	}

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170117/37a1e7d4/attachment.sig>
