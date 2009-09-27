From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 27 Sep 2009 16:31:08 +0100
Subject: [PATCH] Make MMCI driver compile without gpiolib
In-Reply-To: <1251276988-27882-1-git-send-email-linus.walleij@stericsson.com>
References: <1251276988-27882-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20090927153108.GA20093@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2009 at 10:56:28AM +0200, Linus Walleij wrote:
> The recent addition of optional gpiolib support to check if a
> card was inserted or write protected was really not optional.
> It needs this ifdef to become optional so that U300 compiles,
> for example.

Looking back at this, I don't think this ifdef is required.

Why?

We're using linux/gpio.h, which provides dummy definitions for the
GPIO functions of GENERIC_GPIO is not set.  If GENERIC_GPIO is set,
then GPIOs are available, and can be used.

GPIOLIB is entirely a different matter, and doesn't really indicate
whether GPIO support is available or not.

The real problem is that U300 doesn't implement gpio_is_valid() -
which is part of the GPIO API and not specific to GPIOLIB.

Please implement this function, and let's revert this (wrong) patch.

> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 5eb86a8..a923ee2 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -619,6 +619,7 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
>  	writel(0, host->base + MMCIMASK1);
>  	writel(0xfff, host->base + MMCICLEAR);
>  
> +#ifdef CONFIG_GPIOLIB
>  	if (gpio_is_valid(plat->gpio_cd)) {
>  		ret = gpio_request(plat->gpio_cd, DRIVER_NAME " (cd)");
>  		if (ret == 0)
> @@ -637,6 +638,7 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
>  		else if (ret != -ENOSYS)
>  			goto err_gpio_wp;
>  	}
> +#endif
>  
>  	ret = request_irq(dev->irq[0], mmci_irq, IRQF_SHARED, DRIVER_NAME " (cmd)", host);
>  	if (ret)
