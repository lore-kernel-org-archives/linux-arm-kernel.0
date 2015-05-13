From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 13 May 2015 08:45:50 +0200
Subject: Automatic clock disabling on clk_put()
In-Reply-To: <55528B84.5050700@codeaurora.org>
References: <20150511060129.GG6325@pengutronix.de>
 <55528B84.5050700@codeaurora.org>
Message-ID: <20150513064550.GE28888@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, May 12, 2015 at 04:23:48PM -0700, Stephen Boyd wrote:
> On 05/10/15 23:01, Sascha Hauer wrote:
> > Hi,
> >
> > Since we now have per-user clks we could automatically disable clks on
> > clk_put() to make the drivers errors paths easier. AFAIR that was one
> > of the motivations to switch to per user clks. Is this just not yet
> > implemented or are there problems implementing this?
> 
> I don't recall that as being a motivation for per-user clks. The
> documentation explicitly states:
> 
>  * Note: drivers must ensure that all clk_enable calls made on this
>  * clock source are balanced by clk_disable calls prior to calling
>  * this function.
> 
> so it seems that such a behavior would be an API change. Is it really
well, it's a compatible API change. So if you continue to use it as you
were obliged to do before, everything is fine. IMHO the introduction of
per-user clocks are a much bigger issue.

I'm not sure that auto disabling is a good idea[1], but at least giving a
warning should be possible.

> that hard to call clk_disable_unprepare() on a clock at the end of an
> error path? Maybe you could add a devm_clk_get_prepare_enable() that
> does what you want and then call clk_disable_unprepare on the exit path?
You mean clk_disable_unprepare is called in the same function that calls
clk_put I assume such that you don't have to do anything in the exit
path.

Best regards
Uwe

[1] mainly because I didn't think about it
-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
