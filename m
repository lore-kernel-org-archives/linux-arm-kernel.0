From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 29 Jan 2013 16:48:57 +0100
Subject: [PATCH 4/5] net: mvmdio: allow Device Tree and platform device
 to coexist
In-Reply-To: <1359473048-26551-5-git-send-email-florian@openwrt.org>
References: <1359473048-26551-1-git-send-email-florian@openwrt.org>
 <1359473048-26551-5-git-send-email-florian@openwrt.org>
Message-ID: <20130129164857.0ddcddf4@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Florian Fainelli,

On Tue, 29 Jan 2013 16:24:07 +0100, Florian Fainelli wrote:
> This patch changes the Marvell MDIO driver to be registered by using
> both Device Tree and platform device methods. The driver voluntarily
> does not use devm_ioremap() to share the same error path for Device Tree
> and non-Device Tree cases.

Not sure why you think devm_ioremap() can't be used here. Maybe I'm
missing something, but could you explain? If you use devm_ioremap(),
then basically you don't need to do anything in the error path
regarding to the I/O mapping... since it's the whole purpose of the
devm_*() stuff to automagically undo things in the error case, and in
the ->remove() code.

> -	dev->err_interrupt = irq_of_parse_and_map(pdev->dev.of_node, 0);
> +	if (pdev->dev.of_node) {
> +		dev->regs = of_iomap(pdev->dev.of_node, 0);
> +		if (!dev->regs) {
> +			dev_err(&pdev->dev, "No SMI register address given in DT\n");
> +			ret = -ENODEV;
> +			goto out_free;
> +		}
> +
> +		dev->err_interrupt = irq_of_parse_and_map(pdev->dev.of_node, 0);
> +	} else {
> +		r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +		dev->regs = ioremap(r->start, resource_size(r));
> +		if (!dev->regs) {
> +			dev_err(&pdev->dev, "No SMI register address given\n");
> +			ret = -ENODEV;
> +			goto out_free;
> +		}
> +
> +		dev->err_interrupt = platform_get_irq(pdev, 0);
> +	}

I think you can do a devm_ioremap() and a platform_get_irq() in both
cases here, and therefore keep the code common between the DT case and
the !DT case.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
