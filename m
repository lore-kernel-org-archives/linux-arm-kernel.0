From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 7 Feb 2018 23:53:56 +0100
Subject: [RFC v4 12/26] watchdog: renesas_wdt: Add R-Car Gen2 support
In-Reply-To: <1517423070-24236-13-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517423070-24236-13-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20180207225356.pgirh2ohdsv7xdne@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +#ifdef CONFIG_PM
> +static int rwdt_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev;
> +	struct rwdt_priv *priv;
> +
> +	pdev = to_platform_device(dev);
> +	priv = platform_get_drvdata(pdev);

struct rwdt_priv *priv = dev_get_drvdata(dev);

?


> +	if (watchdog_active(&priv->wdev)) {
> +		rwdt_write(priv, priv->cks, RWTCSRA);
> +	}
> +	return 0;
> +}
> +
> +static int rwdt_resume(struct device *dev)
> +{
> +	struct platform_device *pdev;
> +	struct rwdt_priv *priv;
> +
> +	pdev = to_platform_device(dev);
> +	priv = platform_get_drvdata(pdev);

ditto

> +	if (watchdog_active(&priv->wdev)) {
> +		rwdt_write(priv, priv->cks | RWTCSRA_TME, RWTCSRA);
> +	}
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops rwdt_pm = {
> +	.suspend = rwdt_suspend,
> +	.resume = rwdt_resume,
> +};

Use SIMPLE_DEV_PM_OPS macro (see stmp3xxx_rtc_wdt.c for an example) for
more compact code and...

> +#ifdef CONFIG_PM
> +		.pm = &rwdt_pm,
> +#endif

... removing this ifdeffery?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180207/edd05963/attachment.sig>
