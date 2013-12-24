From: dongas86@gmail.com (Dong Aisheng)
Date: Tue, 24 Dec 2013 11:29:29 +0800
Subject: [PATCH 2/2] mmc: sdhci-esdhc-imx: fix warning during module
 remove function
In-Reply-To: <20131224032925.GA4166@S2101-09.ap.freescale.net>
References: <1387796544-18209-1-git-send-email-b29396@freescale.com>
 <1387796544-18209-2-git-send-email-b29396@freescale.com>
 <20131223140613.GL26070@S2101-09.ap.freescale.net>
 <20131224023412.GC23230@shlinux2.ap.freescale.net>
 <20131224031607.GB3872@S2101-09.ap.freescale.net>
 <20131224032925.GA4166@S2101-09.ap.freescale.net>
Message-ID: <CAA+hA=QoVSPW3msrhBUvJVg6JFQqPFn8UuZNLdr7AYg0Akiy+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 24, 2013 at 11:29 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Dec 24, 2013 at 11:16:09AM +0800, Shawn Guo wrote:
>> On Tue, Dec 24, 2013 at 10:34:13AM +0800, Dong Aisheng wrote:
>> > > > @@ -1169,10 +1167,6 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
>> > > >         pm_runtime_dont_use_autosuspend(&pdev->dev);
>> > > >         pm_runtime_disable(&pdev->dev);
>> > > >
>> > > > -       clk_disable_unprepare(imx_data->clk_per);
>> > > > -       clk_disable_unprepare(imx_data->clk_ipg);
>> > > > -       clk_disable_unprepare(imx_data->clk_ahb);
>> > >
>> > > It's obviously a bad change to me.  We should definitely have these
>> > > clk_disable_unprepare() calls in sdhci_esdhc_imx_remove() to match the
>> > > clk_prepare_enable() calls in sdhci_esdhc_imx_probe().  Otherwise, at
>> > > least for !CONFIG_PM_RUNTIME build, it's broken.
>> > >
>> >
>> > How about add the !CONFIG_RUMTIME_PM precondition for these code to avoid
>> > break non runtime pm case?
>> >
>> > #ifndef CONFIG_PM_RUNTIME
>> >     clk_disable_unprepare(imx_data->clk_per);
>> >     clk_disable_unprepare(imx_data->clk_ipg);
>> >     clk_disable_unprepare(imx_data->clk_ahb);
>> > #endif
>>
>> It's quite ugly.  But well, if we do not have anything better, we have
>> to live with it.
>
> To make it look less ugly, we may want to use something like the
> following.
>
>         if (!IS_ENABLED(CONFIG_PM_RUNTIME)
>

I'm ok with it.

Regards
Dong Aisheng

> Shawn
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
