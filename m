From: toddpoynor@google.com (Todd Poynor)
Date: Wed, 13 Jul 2011 22:56:08 -0700
Subject: [PATCH v4 13/20] gpio/omap: cleanup omap_gpio_mod_init function
In-Reply-To: <1310565259-31267-14-git-send-email-tarun.kanti@ti.com>
References: <1310565259-31267-1-git-send-email-tarun.kanti@ti.com>
	<1310565259-31267-14-git-send-email-tarun.kanti@ti.com>
Message-ID: <20110714055608.GA22467@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2011 at 07:24:12PM +0530, Tarun Kanti DebBarma wrote:
> With register offsets now defined for respective OMAP versions we can get rid
> of cpu_class_* checks. This function now has common initialization code for
> all OMAP versions. Initialization specific to OMAP16xx has been moved within
> omap16xx_gpio_init().
> 
...
> -	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++)
> +	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++) {
> +		pdev = omap16xx_gpio_dev[i];
> +		pdata = pdev->dev.platform_data;
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		base = ioremap(res->start, resource_size(res));


Should check platform_get_resource and ioremap error returns.

> +
> +		__raw_writel(0x0014, base + OMAP1610_GPIO_SYSCONFIG);


Todd
