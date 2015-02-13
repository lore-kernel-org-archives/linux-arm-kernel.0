From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 13 Feb 2015 19:57:13 +0100
Subject: [PATCH RFC v9 01/20] clk: divider: Correct parent clk round rate
 if no bestdiv is normally found
In-Reply-To: <54DE0BB8.7070004@ti.com>
References: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
 <1423720903-24806-2-git-send-email-Ying.Liu@freescale.com>
 <20150212093356.GR12209@pengutronix.de>
 <20150212103944.GA1290@victor>
 <20150212122405.GW12209@pengutronix.de>
 <20150212125646.GT8656@n2100.arm.linux.org.uk>
 <20150212134131.GX12209@pengutronix.de> <54DE0BB8.7070004@ti.com>
Message-ID: <20150213185713.GA12209@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 13, 2015 at 04:35:36PM +0200, Tomi Valkeinen wrote:
> On 12/02/15 15:41, Sascha Hauer wrote:
> 
> > Tomis patch is based on the assumption that clk_set_rate(clk_round_rate(rate))
> > is equal to clk_round_rate(rate). So when this assumption is wrong then
> > it should simply be reverted.
> 
> When is it not equal?
> 
> I agree that doing clk_set_rate(clk, clk_round_rate(clk, rate)) is
> pointless, but shouldn't it still work?
> 
> And we can forget about clk_round_rate. Without my patch, this would
> behave oddly also:
> 
> rate = clk_get_rate(clk);
> clk_set_rate(clk, rate);
> 
> The end result could be something else than 'rate'.

I agree that it's a bit odd, but I think it has to be like this.
Consider that you request a rate of 100Hz, but the clock can only
produce 99.5Hz, so due to rounding clk_round_rate() returns 99Hz.
Now when you request 99Hz from clk_set_rate() the 99.5Hz value
can't be used because it's too high.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
