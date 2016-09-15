From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 16 Sep 2016 00:31:57 +0200
Subject: [PATCH] soc: rockchip: power-domain: Handle errors from
 of_genpd_add_provider_onecell
In-Reply-To: <14744126.0kYUlUJ0mc@diego>
References: <1473936221-9248-1-git-send-email-tomeu.vizoso@collabora.com>
 <14744126.0kYUlUJ0mc@diego>
Message-ID: <6250295.kzQYkblnJM@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 15. September 2016, 16:39:34 schrieb Heiko St?bner:
> Am Donnerstag, 15. September 2016, 12:43:41 schrieb Tomeu Vizoso:
> > It was a bit surprising that the device was reported to have probed just
> > fine, but the provider hadn't been registered.
> > 
> > So handle any errors when registering the provider and fail the probe
> > accordingly.
> > 
> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > Cc: Caesar Wang <wxt@rock-chips.com>
> > ---
> > 
> >  drivers/soc/rockchip/pm_domains.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/soc/rockchip/pm_domains.c
> > b/drivers/soc/rockchip/pm_domains.c index 7acd1517dd37..57e920128cb2
> > 100644
> > --- a/drivers/soc/rockchip/pm_domains.c
> > +++ b/drivers/soc/rockchip/pm_domains.c
> > @@ -627,7 +627,11 @@ static int rockchip_pm_domain_probe(struct
> > platform_device *pdev) goto err_out;
> > 
> >  	}
> > 
> > -	of_genpd_add_provider_onecell(np, &pmu->genpd_data);
> > +	error = of_genpd_add_provider_onecell(np, &pmu->genpd_data);
> > +	if (error) {
> > +		dev_err(dev, "failed to add provider: %d\n", error);
> > +		goto err_out;
> > +	}
> > 
> >  	return 0;
> 
> Looks good in itself, but seems to trigger some issue in the genpd code
> when applied alone on top of linux-next-20160915. Looks like genpd
> is missing counter-initialization somewhere, as I'm seeing now:
> 
> [    1.664744] genpd_poweroff_unused disabling (null)
> [    1.669553] ------------[ cut here ]------------
> [    1.674169] WARNING: CPU: 0 PID: 1 at ../kernel/workqueue.c:1440
> __queue_work+0x2b8/0x3f8 [    1.682337] Modules linked in:
> [    1.685401] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 4.8.0-rc6-next-20160915-00001-g7432710-dirty #5 [    1.694608] Hardware
> name: Rockchip (Device Tree)
> [    1.699312] [<c0310388>] (unwind_backtrace) from [<c030ba04>]
> (show_stack+0x10/0x14) [    1.707050] [<c030ba04>] (show_stack) from
> [<c0599c90>] (dump_stack+0x90/0xa4) [    1.714267] [<c0599c90>]
> (dump_stack) from [<c0341bc0>] (__warn+0xe8/0x100) [    1.721221]
> [<c0341bc0>] (__warn) from [<c0341c88>] (warn_slowpath_null+0x20/0x28) [   
> 1.728785] [<c0341c88>] (warn_slowpath_null) from [<c0355b28>]
> (__queue_work+0x2b8/0x3f8) [    1.737041] [<c0355b28>] (__queue_work) from
> [<c0355ca8>] (queue_work_on+0x40/0x4c) [    1.744692] [<c0355ca8>]
> (queue_work_on) from [<c103e8b8>] (genpd_poweroff_unused+0x78/0x9c) [   
> 1.753123] [<c103e8b8>] (genpd_poweroff_unused) from [<c0301e78>]
> (do_one_initcall+0x40/0x170) [    1.761815] [<c0301e78>] (do_one_initcall)
> from [<c1000dc8>] (kernel_init_freeable+0x15c/0x1fc) [    1.770507]
> [<c1000dc8>] (kernel_init_freeable) from [<c0bb7ba0>]
> (kernel_init+0x8/0x114) [    1.778678] [<c0bb7ba0>] (kernel_init) from
> [<c0307df8>] (ret_from_fork+0x14/0x3c) [    1.786240] ---[ end trace
> b38c51ace1463add ]---
> [    1.790875] genpd_poweroff_unused disabling ??????
> [    1.795856] genpd_poweroff_unused disabling ??????
> [    1.800830] ------------[ cut here ]------------
> [    1.805443] WARNING: CPU: 0 PID: 1 at ../kernel/workqueue.c:1440
> __queue_work+0x2b8/0x3f8 [    1.813610] Modules linked in:
> [    1.816673] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W      
> 4.8.0-rc6-next-20160915-00001-g7432710-dirty #5 [    1.827094] Hardware
> name: Rockchip (Device Tree)
> [    1.831795] [<c0310388>] (unwind_backtrace) from [<c030ba04>]
> (show_stack+0x10/0x14) [    1.839532] [<c030ba04>] (show_stack) from
> [<c0599c90>] (dump_stack+0x90/0xa4) [    1.846747] [<c0599c90>]
> (dump_stack) from [<c0341bc0>] (__warn+0xe8/0x100) [    1.853700]
> [<c0341bc0>] (__warn) from [<c0341c88>] (warn_slowpath_null+0x20/0x28) [   
> 1.861264] [<c0341c88>] (warn_slowpath_null) from [<c0355b28>]
> (__queue_work+0x2b8/0x3f8) [    1.869521] [<c0355b28>] (__queue_work) from
> [<c0355ca8>] (queue_work_on+0x40/0x4c) [    1.877170] [<c0355ca8>]
> (queue_work_on) from [<c103e8b8>] (genpd_poweroff_unused+0x78/0x9c) [   
> 1.885600] [<c103e8b8>] (genpd_poweroff_unused) from [<c0301e78>]
> (do_one_initcall+0x40/0x170) [    1.894290] [<c0301e78>] (do_one_initcall)
> from [<c1000dc8>] (kernel_init_freeable+0x15c/0x1fc) [    1.902981]
> [<c1000dc8>] (kernel_init_freeable) from [<c0bb7ba0>]
> (kernel_init+0x8/0x114) [    1.911152] [<c0bb7ba0>] (kernel_init) from
> [<c0307df8>] (ret_from_fork+0x14/0x3c) [    1.918713] ---[ end trace
> b38c51ace1463ade ]---
> [    1.923338] genpd_poweroff_unused disabling ??????
> [    1.928325] genpd_poweroff_unused disabling ??????
> 
> [+ millions more of those]

just for completenes sake, I've included your patch in a series of my
own [0] which adds the necessary  pm_genpd_remove prequisite to prevent
the errors shown above.


Heiko

[0] "[PATCH 0/2] soc: rockchip: fix probe error path in power-domain driver"
