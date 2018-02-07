From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 7 Feb 2018 15:55:24 +0000
Subject: [RFC v4 13/26] watchdog: renesas_wdt: Add restart handler
In-Reply-To: <CAMuHMdVZi0Vyz9+Z6TFeX3yh=rzRHBuNbgy1Nt4LhoLU8qK5KQ@mail.gmail.com>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517423070-24236-14-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdVZi0Vyz9+Z6TFeX3yh=rzRHBuNbgy1Nt4LhoLU8qK5KQ@mail.gmail.com>
Message-ID: <TY1PR06MB0895BDC61E7C226E29AC6D11C0FC0@TY1PR06MB0895.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Geert,

> Subject: Re: [RFC v4 13/26] watchdog: renesas_wdt: Add restart handler
>
> Hi Fabrizio,

Thank you for your feedback!

>
> On Wed, Jan 31, 2018 at 7:24 PM, Fabrizio Castro
> <fabrizio.castro@bp.renesas.com> wrote:
> > On iWave's boards iwg20d and iwg22d the only way to reboot the system is
> > by means of the watchdog.
> > This patch adds a restart handler to rwdt_ops, and also makes sure we
> > keep its priority to a medium level, in order to not override other more
> > effective handlers.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
>
> > --- a/drivers/watchdog/renesas_wdt.c
> > +++ b/drivers/watchdog/renesas_wdt.c
> > @@ -118,6 +136,7 @@ static const struct watchdog_ops rwdt_ops = {
> >         .stop = rwdt_stop,
> >         .ping = rwdt_init_timeout,
> >         .get_timeleft = rwdt_get_timeleft,
> > +       .restart = rwdt_restart,
> >  };
> >
> >  static int rwdt_probe(struct platform_device *pdev)
> > @@ -176,6 +195,7 @@ static int rwdt_probe(struct platform_device *pdev)
> >         platform_set_drvdata(pdev, priv);
> >         watchdog_set_drvdata(&priv->wdev, priv);
> >         watchdog_set_nowayout(&priv->wdev, nowayout);
> > +       watchdog_set_restart_priority(&priv->wdev, 128);
>
> Given we want to reboot R-Car Gen2 boards equipped with a suitable PMIC
> (e.g. DA9063) using that PMIC, I think the priority should be lower (0?),
> cfr.

Yes, can do, I have no strong opinion about this.
I'll use priority 0 for the next submission.

Thanks,
Fab

>
>  *   0:   use watchdog's restart function as last resort, has limited restart
>  *        capabilies
>  *   128: default restart handler, use if no other handler is expected to be
>  *        available and/or if restart is sufficient to restart the entire system
>  *   255: preempt all other handlers
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
