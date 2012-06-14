From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 14 Jun 2012 19:32:32 +0100
Subject: [PATCH 08/14] mfd: Add IRQ domain support for the AB8500
In-Reply-To: <1339428307-3850-9-git-send-email-lee.jones@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-9-git-send-email-lee.jones@linaro.org>
Message-ID: <20120614183231.GA30185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 04:25:01PM +0100, Lee Jones wrote:

> +	if (np) {
> +		ab8500->domain = irq_domain_add_linear(
> +			np, num_irqs, &ab8500_irq_ops, ab8500);
> +	}
> +	else {
> +		ab8500->domain = irq_domain_add_legacy(
> +			NULL, num_irqs, ab8500->irq_base,
> +			0, &ab8500_irq_ops, ab8500);
> +	}

This is odd, why are you forcing non-DT systems to use a legacy mapping?
The more usual approach is to use a legacy mapping if and only if a base
for the legacy range has been provided, otherwise the system will
needlessly fail to initialise the device...

> +	if (!(ab8500->irq_base || np)) {
> +		dev_info(&pdev->dev, "couldn't find irq-base and not doing DT boot\n");

...like this.  See regmap_irq for an example.
