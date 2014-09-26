From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 25 Sep 2014 17:25:44 -0700
Subject: [PATCH 0/7] clk: sun6i: Unify AHB1 clock and fix rate calculation
In-Reply-To: <20140911203623.GJ31276@lukather>
References: <1410000448-9999-1-git-send-email-wens@csie.org>
 <20140911203623.GJ31276@lukather>
Message-ID: <20140926002544.19023.39287@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Maxime Ripard (2014-09-11 13:36:23)
> Hi Chen-Yu,
> 
> On Sat, Sep 06, 2014 at 06:47:21PM +0800, Chen-Yu Tsai wrote:
> > Hi everyone,
> > 
> > This series unifies the mux and divider parts of the AHB1 clock found
> > on sun6i and sun8i, while also adding support for the pre-divider on
> > the PLL6 input.
> > 
> > The rate calculation logic must factor in which parent it is using to
> > calculate the rate, to decide whether to use the pre-divider or not.
> > This is beyond the original factors clk design in sunxi. To avoid
> > feature bloat, this is implemented as a seperate composite clk.
> > 
> > The new clock driver is registered with a separate OF_CLK_DECLARE.
> > This is done so that assigned-clocks* properties on the clk provider
> > node can actually work. The clock framework arranges the clock setup
> > order by checking whether all clock parents are available, by checking
> > the node matching OF_CLK_DECLARE.
> > 
> > However, the sunxi clk driver is based on the root node compatible,
> > has no defined dependencies (parents), and is setup before the fixed-rate
> > clocks. Thus when the ahb1 clock is added, all parents have rate = 0.
> > There is no way to calculate the required clock factors to set a default
> > clock rate under these circumstances. This happens when we set the
> > defaults in the clock node (provider), rather than a clock consumer.
> >
> > I can think of 2 ways to solve the dependency issue, but neither is
> > pretty. One would be to move the root fixed-rate clocks into the sunxi
> > clk driver. The other would be separating all the clocks into individual
> > OF_CLK_DECLARE statements, which adds a lot of boilerplate code.
> 
> I don't know what Mike thinks of this, but I'd prefer the second.

I do not fully understand the problem. Ideally the clock driver should
have some way to fail with EPROBE_DEFER until the fixed-rate clocks are
registered. Those fixed-rate parents are enumerated in your dts, right?
Why isn't this enough?

Thanks,
Mike

> 
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
