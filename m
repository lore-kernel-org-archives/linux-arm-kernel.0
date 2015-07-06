From: tony@atomide.com (Tony Lindgren)
Date: Sun, 5 Jul 2015 23:35:32 -0700
Subject: [RFC PATCH] pinctrl-single: Use of pinctrl-single for external
 device over I2C
In-Reply-To: <1435855992-10312-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1435855992-10312-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <20150706063532.GB10705@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vaibhav Hiremath <vaibhav.hiremath@linaro.org> [150702 09:58]:
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
>  
> -static unsigned __maybe_unused pcs_readb(void __iomem *reg)
> +static unsigned pcs_read(struct regmap *map, unsigned int reg)
>  {
> -	return readb(reg);
> -}
> +	unsigned int val;
>  
> -static unsigned __maybe_unused pcs_readw(void __iomem *reg)
> -{
> -	return readw(reg);
> -}
> -
> -static unsigned __maybe_unused pcs_readl(void __iomem *reg)
> -{
> -	return readl(reg);
> -}
> -
> -static void __maybe_unused pcs_writeb(unsigned val, void __iomem *reg)
> -{
> -	writeb(val, reg);
> -}
> +	regmap_read(map, reg, &val);

Sorry this won't work. Most platforms don't need regmap here, and I
certainly don't want to use regmap for toggling pins for runtime
PM because of the extra overhead.

It seems you need to stash the regmap pointer to struct pcs_device
and just the function pointers. As this driver is ioremapping the
region, we certainly want to keep things using void __iomem * too.
You can cast that to whatever regmap needs in the wrapper functions
for regmap. Note that the extra overhead there won't matter as we
are using regmap mostly for devices over I2C and so on.

Regards,

Tony
