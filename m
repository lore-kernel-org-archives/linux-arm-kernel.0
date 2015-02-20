From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 20 Feb 2015 11:42:27 -0800
Subject: [PATCH RFC v9 01/20] clk: divider: Correct parent clk round rate
 if no bestdiv is normally found
In-Reply-To: <20150220192043.GM8656@n2100.arm.linux.org.uk>
References: <1423720903-24806-2-git-send-email-Ying.Liu@freescale.com>
 <20150212103944.GA1290@victor> <20150212122405.GW12209@pengutronix.de>
 <20150212125646.GT8656@n2100.arm.linux.org.uk>
 <20150212134131.GX12209@pengutronix.de> <54DE0BB8.7070004@ti.com>
 <20150213185713.GA12209@pengutronix.de>
 <20150216112724.GN8656@n2100.arm.linux.org.uk>
 <20150220191306.421.58746@quantum>
 <20150220192043.GM8656@n2100.arm.linux.org.uk>
Message-ID: <20150220194227.421.44526@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Russell King - ARM Linux (2015-02-20 11:20:43)
> On Fri, Feb 20, 2015 at 11:13:06AM -0800, Mike Turquette wrote:
> > Quoting Russell King - ARM Linux (2015-02-16 03:27:24)
> > > On Fri, Feb 13, 2015 at 07:57:13PM +0100, Sascha Hauer wrote:
> > > > I agree that it's a bit odd, but I think it has to be like this.
> > > > Consider that you request a rate of 100Hz, but the clock can only
> > > > produce 99.5Hz, so due to rounding clk_round_rate() returns 99Hz.
> > > > Now when you request 99Hz from clk_set_rate() the 99.5Hz value
> > > > can't be used because it's too high.
> > > 
> > > Math rounding rules normally state that anything of .5 and greater
> > > should be rounded up, not rounded down.  So, for 99.5Hz, you really
> > > ought to be returning 100Hz, not 99Hz.
> > > 
> > > However, you do have a point for 99.4Hz, which would be returned as
> > > 99Hz, and when set, it would result in something which isn't 99.4Hz.
> > 
> > More practically, this again raises the issue of whether or not unsigned
> > long rate should be in millihertz or something other than hertz.
> 
> You still get the same issue if it's millihertz.  Take 10 2/3rds Hz.
> Is 10.666 Hz less than 10 2/3rds Hz?

Millihertz won't solve rounding problems, I agree. But we currently do
not support any fractional rates and we should.

Regards,
Mike

> 
> -- 
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.
