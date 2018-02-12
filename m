From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 12 Feb 2018 10:31:06 +0000
Subject: [RFC v4 12/26] watchdog: renesas_wdt: Add R-Car Gen2 support
In-Reply-To: <20180207225356.pgirh2ohdsv7xdne@katana>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517423070-24236-13-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180207225356.pgirh2ohdsv7xdne@katana>
Message-ID: <TY1PR06MB0895E25D31BA11A42F24DF80C0F70@TY1PR06MB0895.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wolfram,

thank you for your feedback!

> Subject: Re: [RFC v4 12/26] watchdog: renesas_wdt: Add R-Car Gen2 support
>
>
> > +#ifdef CONFIG_PM
> > +static int rwdt_suspend(struct device *dev)
> > +{
> > +struct platform_device *pdev;
> > +struct rwdt_priv *priv;
> > +
> > +pdev = to_platform_device(dev);
> > +priv = platform_get_drvdata(pdev);
>
> struct rwdt_priv *priv = dev_get_drvdata(dev);
>
> ?

will change

>
>
> > +if (watchdog_active(&priv->wdev)) {
> > +rwdt_write(priv, priv->cks, RWTCSRA);
> > +}
> > +return 0;
> > +}
> > +
> > +static int rwdt_resume(struct device *dev)
> > +{
> > +struct platform_device *pdev;
> > +struct rwdt_priv *priv;
> > +
> > +pdev = to_platform_device(dev);
> > +priv = platform_get_drvdata(pdev);
>
> ditto

will change

>
> > +if (watchdog_active(&priv->wdev)) {
> > +rwdt_write(priv, priv->cks | RWTCSRA_TME, RWTCSRA);
> > +}
> > +return 0;
> > +}
> > +
> > +static const struct dev_pm_ops rwdt_pm = {
> > +.suspend = rwdt_suspend,
> > +.resume = rwdt_resume,
> > +};
>
> Use SIMPLE_DEV_PM_OPS macro (see stmp3xxx_rtc_wdt.c for an example) for
> more compact code and...
>
> > +#ifdef CONFIG_PM
> > +.pm = &rwdt_pm,
> > +#endif
>
> ... removing this ifdeffery?

will take out the ifdeffery


Thanks,
Fabrizio



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
