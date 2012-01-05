From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 5 Jan 2012 08:23:06 +0100
Subject: [PATCH 5/6] gpio: tegra: Dynamically allocate IRQ base, and
 support DT
In-Reply-To: <1325702378-20863-5-git-send-email-swarren@nvidia.com>
References: <1325702378-20863-1-git-send-email-swarren@nvidia.com>
 <1325702378-20863-5-git-send-email-swarren@nvidia.com>
Message-ID: <20120105072306.GA3980@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
> @@ -343,6 +344,16 @@ static int __devinit tegra_gpio_probe(struct platform_device *pdev)
>  	int i;
>  	int j;
>  
> +	irq_domain.irq_base = irq_alloc_descs(-1, 0, TEGRA_NR_GPIOS, 0);
> +	if (irq_domain.irq_base < 0) {
> +		dev_err(&pdev->dev, "Couldn't allocate IRQ numbers\n");
> +		return -ENODEV;
> +	}
> +	irq_domain.nr_irq = TEGRA_NR_GPIOS;
> +	irq_domain.ops = &irq_domain_simple_ops;
> +	irq_domain.of_node = pdev->dev.of_node;
> +	irq_domain_add(&irq_domain);

I was wondering: except for setting the nr_irq field this is pretty much what
irq_domain_add_simple() does. While I get that you need access to the domain
later on and cannot use the helper, I'm still wondering why the nr_irq field
is not initialized by irq_domain_add_simple().

I have a driver for a GPIO/IRQ expander that does exactly the same and was
always wondering why the irq_data.hwirq field isn't properly setup, and
irq_domain.nr_irq being 0 seems to be exactly the reason. So am I supposed to
not use irq_domain_add_simple() in this case or should we rather update the
helper to take a nr_irq parameter that can be used to initialize the nr_irq
field?

Thierry

P.S.: sorry for hijacking
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120105/9b493e95/attachment-0001.sig>
