From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 03 May 2016 11:05:44 +0200
Subject: [PATCH 3/7] reset: lpc18xx: use devm_reset_controller_register()
In-Reply-To: <CAK7LNAQ5LztGBbHCQxfLyWT7c_kWL=zpdKfkC9vsOKw95XL_Yw@mail.gmail.com>
References: <1462099023-11819-1-git-send-email-yamada.masahiro@socionext.com>
 <1462099023-11819-4-git-send-email-yamada.masahiro@socionext.com>
 <1462177581.3933.7.camel@pengutronix.de>
 <CAK7LNAQ5LztGBbHCQxfLyWT7c_kWL=zpdKfkC9vsOKw95XL_Yw@mail.gmail.com>
Message-ID: <1462266344.3617.12.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 03.05.2016, 00:52 +0900 schrieb Masahiro Yamada:
> 2016-05-02 17:26 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
> > Am Sonntag, den 01.05.2016, 19:36 +0900 schrieb Masahiro Yamada:
> >> Use devm_reset_controller_register() for the reset controller
> >> registration and remove the unregister call from the .remove callback.
> >>
> >> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >> ---
> >>
> >>  drivers/reset/reset-lpc18xx.c | 4 +---
> >>  1 file changed, 1 insertion(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/reset/reset-lpc18xx.c b/drivers/reset/reset-lpc18xx.c
> >> index 3b8a4f5..dd4f27e 100644
> >> --- a/drivers/reset/reset-lpc18xx.c
> >> +++ b/drivers/reset/reset-lpc18xx.c
> >> @@ -199,7 +199,7 @@ static int lpc18xx_rgu_probe(struct platform_device *pdev)
> >>
> >>       platform_set_drvdata(pdev, rc);
> >>
> >> -     ret = reset_controller_register(&rc->rcdev);
> >> +     ret = devm_reset_controller_register(&pdev->dev, &rc->rcdev);
> >>       if (ret) {
> >>               dev_err(&pdev->dev, "unable to register device\n");
> >>               goto dis_clks;
> >> @@ -229,8 +229,6 @@ static int lpc18xx_rgu_remove(struct platform_device *pdev)
> >>       if (ret)
> >>               dev_warn(&pdev->dev, "failed to unregister restart handler\n");
> >>
> >> -     reset_controller_unregister(&rc->rcdev);
> >> -
> >>       clk_disable_unprepare(rc->clk_delay);
> >>       clk_disable_unprepare(rc->clk_reg);
> >>
> >
> > Hmm, would this patch theoretically allow a window between the calls to
> > clk_disable_unprepare(clk_reg) and devm_reset_controller_release() where
> > reset_control_get() + reset_control_(de)assert() would access unclocked
> > registers?
> 
> This is not clear to me.
> 
> Why reset_control_get() + reset_control_(de)assert() would happen here?

I suppose on a non-SMP device, without parallel probing this can't
really happen in practice.
It still seems weird that suddenly we disable the clocks before
unregistering the reset controller instead of afterwards.

regards
Philipp
