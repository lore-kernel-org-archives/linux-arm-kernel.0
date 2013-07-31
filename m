From: htejun@gmail.com (Tejun Heo)
Date: Wed, 31 Jul 2013 06:41:25 -0400
Subject: [PATCH 2/2] chipidea: Use devm_request_irq()
In-Reply-To: <20130731102853.GD1754@pengutronix.de>
References: <1375232669-27846-1-git-send-email-festevam@gmail.com>
 <1375232669-27846-2-git-send-email-festevam@gmail.com>
 <20130731073306.GZ1754@pengutronix.de>
 <20130731082054.GF8540@nchen-desktop>
 <20130731084645.GB1754@pengutronix.de>
 <20130731090512.GD9858@sirena.org.uk>
 <20130731094434.GC1754@pengutronix.de>
 <20130731095411.GA2810@htj.dyndns.org>
 <20130731102853.GD1754@pengutronix.de>
Message-ID: <20130731104125.GF2810@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 12:28:53PM +0200, Uwe Kleine-K?nig wrote:
> Well, you cannot avoid assuming that the irq is still active when your
> driver's remove callback is called. But I agree about crappyness at the
> end of the destruction path. The problem is that crap is as easy as:
> 
> 	probe(..)
> 	{
> 		clk = devm_get_clk(...);
> 		clk_prepare_enable(clk);
> 		writel(1, base + IRQENABLE);
> 		devm_request_irq(...);
> 	}
> 
> 	remove(..)
> 	{
> 		writel(0, base + IRQENABLE);
> 		clk_disable_unprepare(clk);
> 	}
> 
> and I think there are more and more drivers doing that.

Oh, so, the problem is that the driver is mixing devm and non-devm
resource management and ending up messing the order of shutdown?
Well, the obvious solution is using devm for clk too.  devm does
provide constructs to build custom destruction sequence so that such
calls can be mixed but it's a bit of hassle and mostly meant for
driver midlayers (libata, firewire, usb and so on) so that they can
provide nicely wrapped init/exit helpers for low level drivers.

In general, partial devm conversion can easily lead to subtle shutdown
order problems and it's best to go all the way.

Thanks.

-- 
tejun
