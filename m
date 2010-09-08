From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 8 Sep 2010 15:51:14 -0700
Subject: [PATCH] MMC: move regulator handling closer to core v3
In-Reply-To: <1283677538-31121-1-git-send-email-linus.walleij@stericsson.com>
References: <1283677538-31121-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20100908155114.880463fc.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun,  5 Sep 2010 11:05:38 +0200
Linus Walleij <linus.walleij@stericsson.com> wrote:

> After discovering a problem in regulator reference counting I
> took Mark Brown's advice to move the reference count into the
> MMC core by making the regulator status a member of
> struct mmc_host.
> 
>
> ...
>
> -static inline void pxamci_set_power(struct pxamci_host *host, unsigned int vdd)
> +static inline void pxamci_set_power(struct pxamci_host *host,
> +				    unsigned char power_mode,
> +				    unsigned int vdd)
>  {
>  	int on;
>  
> -#ifdef CONFIG_REGULATOR
> -	if (host->vcc)
> -		mmc_regulator_set_ocr(host->vcc, vdd);
> -#endif
> +	if (host->vcc) {
> +		int ret;
> +
> +		if (power_mode == MMC_POWER_UP)
> +			ret = mmc_regulator_set_ocr(host->mmc, host->vcc, vdd);
> +		else if (power_mode == MMC_POWER_OFF)
> +			ret = mmc_regulator_set_ocr(host->mmc, host->vcc, 0);
> +	}

There's no point in copying the return value into a local then ignoring
it.  mmc_regulator_set_ocr() can return a negative errno so we should
test for that, clean up and propagate the error.

If we really do deliberately ignore the error then there should be a
code comment which excuses this behaviour and perhaps a warning printk.

The same comments apply to mmci_set_ios().

omap_hsmmc_1_set_power() gets it right.

Why doesn't omap_hsmmc_23_set_sleep() run .before_set_reg() and
.after_set_reg()?

>
> ...
>
