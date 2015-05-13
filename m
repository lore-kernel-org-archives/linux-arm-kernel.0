From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 13 May 2015 08:47:45 +0200
Subject: Automatic clock disabling on clk_put()
In-Reply-To: <55528B84.5050700@codeaurora.org>
References: <20150511060129.GG6325@pengutronix.de>
 <55528B84.5050700@codeaurora.org>
Message-ID: <20150513064745.GY6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 04:23:48PM -0700, Stephen Boyd wrote:
> On 05/10/15 23:01, Sascha Hauer wrote:
> > Hi,
> >
> > Since we now have per-user clks we could automatically disable clks on
> > clk_put() to make the drivers errors paths easier. AFAIR that was one
> > of the motivations to switch to per user clks. Is this just not yet
> > implemented or are there problems implementing this?
> >
> >
> 
> I don't recall that as being a motivation for per-user clks. The
> documentation explicitly states:
> 
>  * Note: drivers must ensure that all clk_enable calls made on this
>  * clock source are balanced by clk_disable calls prior to calling
>  * this function.
> 
> so it seems that such a behavior would be an API change.

Hm, yes it would be an API change, but we are only loosening this
restriction. The only impact I see is that previously buggy drivers
get fixed. Hurray :)
Wait, I forgot about the currently 22 clk support implementations in
arch/* :(

> Is it really
> that hard to call clk_disable_unprepare() on a clock at the end of an
> error path?

There are more and more cases in which the clk disabling is the only
reason why an error path even exists. No it's not that hard, it would
just be convenient to not have to care about it.

> Maybe you could add a devm_clk_get_prepare_enable() that
> does what you want and then call clk_disable_unprepare on the exit path?

I never thought about that, that would work aswell. Maybe I'll have a
look into this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
