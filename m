From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 31 Aug 2010 13:22:05 +0100
Subject: [PATCH] MMC: move regulator handling closer to core
In-Reply-To: <1283102159-25804-1-git-send-email-linus.walleij@stericsson.com>
References: <1283102159-25804-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20100831122205.GI20849@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 29, 2010 at 07:15:59PM +0200, Linus Walleij wrote:
> After discovering a problem in regulator reference counting I
> took Mark Brown's advice to move the reference count into the
> MMC core by making the regulator status a member of
> struct mmc_host.
> 
> I took this opportunity to also implement NULL versions of
> the regulator functions so as to rid the driver code from
> some ugly #ifdef CONFIG_REGULATOR clauses.

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

A few small comments below.

> +		if (host->vcc) {
> +			ret = mmc_regulator_set_ocr(mmc, host->vcc, ios->vdd);
> +			if (ret)
> +				dev_err(mmc_dev(mmc),
> +					"could not set regulator OCR\n");
> +		}

It'd be nice to display the error code as well.  I do tend to agree with
Adrian that it might be nice to have the noop functions in the header to
allow the optimiser to play with them as well but it's unlikely to be a
big deal.
