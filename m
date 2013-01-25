From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 25 Jan 2013 09:55:29 +0000
Subject: [V5 PATCH 26/26] usb: ehci: ehci-mv: add device tree support
In-Reply-To: <CAK9wHMQF6UYpc-TVxh1ot9hgmErFfvhFGuPLNQn1CfaMcsnD-A@mail.gmail.com>
References: <1359009530-28182-1-git-send-email-chao.xie@marvell.com>
 <1359009530-28182-27-git-send-email-chao.xie@marvell.com>
 <20130124111603.GM32237@e106331-lin.cambridge.arm.com>
 <CAK9wHMQF6UYpc-TVxh1ot9hgmErFfvhFGuPLNQn1CfaMcsnD-A@mail.gmail.com>
Message-ID: <20130125095528.GH3075@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> >> @@ -170,19 +202,36 @@ static int mv_ehci_probe(struct platform_device *pdev)
> >>       }
> >>
> >>       platform_set_drvdata(pdev, ehci_mv);
> >> -     ehci_mv->pdata = pdata;
> >>       ehci_mv->hcd = hcd;
> >>
> >> -     ehci_mv->clknum = pdata->clknum;
> >> -     for (clk_i = 0; clk_i < ehci_mv->clknum; clk_i++) {
> >> -             ehci_mv->clk[clk_i] =
> >> -                 devm_clk_get(&pdev->dev, pdata->clkname[clk_i]);
> >> -             if (IS_ERR(ehci_mv->clk[clk_i])) {
> >> -                     dev_err(&pdev->dev, "error get clck \"%s\"\n",
> >> -                             pdata->clkname[clk_i]);
> >> -                     retval = PTR_ERR(ehci_mv->clk[clk_i]);
> >> -                     goto err_clear_drvdata;
> >> +     retval = mv_ehci_parse_dt(pdev, ehci_mv);
> >> +     if (retval > 0) {
> >
> > Is this why you returned 1 from mv_ehci_parse_dt? So you only do this if you
> > don't have a dt node?
> >
> > If so, why not rip the check (and positive error code) out of mv_ehci_parse_dt,
> > and then here:
> >
> > if (pdev->dev.of_node) {
> >         retval = mv_ehci_parse_dt(pdev, ehci_mv);
> > } else
> >         fall back to mv_usb_platform_data ...
> > }
> >
> > That makes it obvious that one side depends on dt and the other's a fallback,
> > and doesn't rely on nonstandard return code behaviour.
> >
> 
> I will change it.
> 
> > Also, why not return immediately if mv_ehci_parse_dt fails?
> >
> I do not understand. if mv_ehci_parse_dt returns negative value, the
> probe will be finished immediately.

Yes, you're right. I got myself confused about the logic.

Thanks,
Mark.
