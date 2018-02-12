From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 12 Feb 2018 10:33:47 +0000
Subject: [RFC v4 13/26] watchdog: renesas_wdt: Add restart handler
In-Reply-To: <20180207230309.goxig2irkpxrw5el@katana>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517423070-24236-14-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180207230309.goxig2irkpxrw5el@katana>
Message-ID: <TY1PR06MB089578618AA33335D90D16CEC0F70@TY1PR06MB0895.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wolfram,

thank you for your feedback!

> Subject: Re: [RFC v4 13/26] watchdog: renesas_wdt: Add restart handler
>
>
> > +static int rwdt_restart(struct watchdog_device *wdev, unsigned long action,
> > +void *data)
> > +{
> > +struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
> > +
> > +pm_runtime_get_sync(wdev->parent);
> > +
> > +rwdt_write(priv, 0x00, RWTCSRB);
> > +rwdt_write(priv, 0x00, RWTCSRA);
> > +rwdt_write(priv, 0xffff, RWTCNT);
> > +
> > +while (readb_relaxed(priv->base + RWTCSRA) & RWTCSRA_WRFLG)
> > +cpu_relax();
> > +
> > +rwdt_write(priv, 0x80, RWTCSRA);
> > +return 0;
> > +}
>
> I used to have this simpler version (back then for the UP case):
>
> +rwdt_start(wdev);
> +rwdt_write(priv, 0xffff, RWTCNT);
> +return 0;
>
> It should still work probably...

It should still work, but it would be slower, I would stick with the version I have submitted if you don't mind.

Thanks,
Fabrizio





Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
