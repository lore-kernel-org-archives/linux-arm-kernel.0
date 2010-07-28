From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Jul 2010 10:39:55 -0700
Subject: [PATCH 4/4] sdhci-s3c: add regulator support
In-Reply-To: <1280326797-15792-5-git-send-email-m.szyprowski@samsung.com>
References: <1280326797-15792-1-git-send-email-m.szyprowski@samsung.com>
	<1280326797-15792-5-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20100728173954.GD22544@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 28, 2010 at 04:19:57PM +0200, Marek Szyprowski wrote:

>  static int sdhci_s3c_suspend(struct platform_device *dev, pm_message_t pm)
>  {
> +	int ret = 0;
>  	struct sdhci_host *host = platform_get_drvdata(dev);
> +	struct sdhci_s3c *sc = sdhci_priv(host);
>  
>  	sdhci_suspend_host(host, pm);
> -	return 0;
> +
> +	if (sc->vmmc)
> +		ret = regulator_disable(sc->vmmc);
> +

So, on suspend you disable the regulator...

> +	struct sdhci_s3c *sc = sdhci_priv(host);
> +
> +	if (sc->vmmc) {
> +		int ret = regulator_disable(sc->vmmc);
> +		if (ret)
> +			return ret;

...and on resume you disable it again.  I'm surprised this works
properly after resume, at the very least the core is going to get
confused about the reference counts I'd expect.

I suspect this is for something we need to do better in the regulator
API - restoring the state of the regulators after a resume if the
hardware changes them.  A lot of regulators just do this in hardware so
we didn't need to worry about it previously.

> +		mdelay(2);

This could do with some sort of comment.
