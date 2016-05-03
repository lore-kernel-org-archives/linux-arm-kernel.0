From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 3 May 2016 20:40:49 +0900
Subject: [PATCH 3/7] reset: lpc18xx: use devm_reset_controller_register()
In-Reply-To: <1462273690.3617.56.camel@pengutronix.de>
References: <1462099023-11819-1-git-send-email-yamada.masahiro@socionext.com>
 <1462099023-11819-4-git-send-email-yamada.masahiro@socionext.com>
 <1462177581.3933.7.camel@pengutronix.de>
 <CAK7LNAQ5LztGBbHCQxfLyWT7c_kWL=zpdKfkC9vsOKw95XL_Yw@mail.gmail.com>
 <1462266344.3617.12.camel@pengutronix.de>
 <CAK7LNAQga-dCmAWevKMQx2DBzGim8DmNyeCxj4n5q-SjEapd+Q@mail.gmail.com>
 <1462273690.3617.56.camel@pengutronix.de>
Message-ID: <CAK7LNAR13Ox1pbRFmxKJfhNNRKJo+4XcQfvuCNZF6oyUF75Jkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-05-03 20:08 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
> Am Dienstag, den 03.05.2016, 19:25 +0900 schrieb Masahiro Yamada:
>> Hi Philipp,
>>
>> 2016-05-03 18:05 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
>> > Am Dienstag, den 03.05.2016, 00:52 +0900 schrieb Masahiro Yamada:
>> >> 2016-05-02 17:26 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
>> >> > Am Sonntag, den 01.05.2016, 19:36 +0900 schrieb Masahiro Yamada:
>> >> >> Use devm_reset_controller_register() for the reset controller
>> >> >> registration and remove the unregister call from the .remove callback.
>> >> >>
>> >> >> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> >> >> ---
>> >> >>
>> >> >>  drivers/reset/reset-lpc18xx.c | 4 +---
>> >> >>  1 file changed, 1 insertion(+), 3 deletions(-)
>> >> >>
>> >> >> diff --git a/drivers/reset/reset-lpc18xx.c b/drivers/reset/reset-lpc18xx.c
>> >> >> index 3b8a4f5..dd4f27e 100644
>> >> >> --- a/drivers/reset/reset-lpc18xx.c
>> >> >> +++ b/drivers/reset/reset-lpc18xx.c
>> >> >> @@ -199,7 +199,7 @@ static int lpc18xx_rgu_probe(struct platform_device *pdev)
>> >> >>
>> >> >>       platform_set_drvdata(pdev, rc);
>> >> >>
>> >> >> -     ret = reset_controller_register(&rc->rcdev);
>> >> >> +     ret = devm_reset_controller_register(&pdev->dev, &rc->rcdev);
>> >> >>       if (ret) {
>> >> >>               dev_err(&pdev->dev, "unable to register device\n");
>> >> >>               goto dis_clks;
>> >> >> @@ -229,8 +229,6 @@ static int lpc18xx_rgu_remove(struct platform_device *pdev)
>> >> >>       if (ret)
>> >> >>               dev_warn(&pdev->dev, "failed to unregister restart handler\n");
>> >> >>
>> >> >> -     reset_controller_unregister(&rc->rcdev);
>> >> >> -
>> >> >>       clk_disable_unprepare(rc->clk_delay);
>> >> >>       clk_disable_unprepare(rc->clk_reg);
>> >> >>
>> >> >
>> >> > Hmm, would this patch theoretically allow a window between the calls to
>> >> > clk_disable_unprepare(clk_reg) and devm_reset_controller_release() where
>> >> > reset_control_get() + reset_control_(de)assert() would access unclocked
>> >> > registers?
>> >>
>> >> This is not clear to me.
>> >>
>> >> Why reset_control_get() + reset_control_(de)assert() would happen here?
>> >
>> > I suppose on a non-SMP device, without parallel probing this can't
>> > really happen in practice.
>> > It still seems weird that suddenly we disable the clocks before
>> > unregistering the reset controller instead of afterwards.
>> >
>>
>> I still do not understand what you mean.
>>
>> This patch moves the reset_controller_unregister() call
>> after clk_disable_unprepare().
>
> And so the register access is made impossible before the reset
> controller device actually vanishes from the publicly visible list.
>
>> But, reset_controller_unregister() is just a manipulation of a liked list.
>> It does not trigger any hardware access.
>>
>> Am I wrong?
>
> No, you are perfectly right. I don't see how this can be a real problem
> unless at the same time another driver could try to request the still
> available reset control.


Ah, now I understood.
Thanks!



-- 
Best Regards
Masahiro Yamada
