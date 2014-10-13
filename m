From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 13 Oct 2014 12:39:52 +0200
Subject: [PATCH 0/7] clk: sun6i: Unify AHB1 clock and fix rate calculation
In-Reply-To: <CAGb2v65KDOmwHAgFT6Gx8mtKTGEEYfbx6UVhz74V15J1O4odjg@mail.gmail.com>
References: <1410000448-9999-1-git-send-email-wens@csie.org>
 <20140911203623.GJ31276@lukather>
 <20140926002544.19023.39287@quantum>
 <CAGb2v67QkjfH2U9YGUVcwisNakNs_=zEEWghiGkaGkm-A8aK=w@mail.gmail.com>
 <20140926185334.19023.12876@quantum>
 <CAGb2v65KDOmwHAgFT6Gx8mtKTGEEYfbx6UVhz74V15J1O4odjg@mail.gmail.com>
Message-ID: <20141013103952.GW19438@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 09, 2014 at 11:16:50AM +0800, Chen-Yu Tsai wrote:
> On Sat, Sep 27, 2014 at 2:53 AM, Mike Turquette <mturquette@linaro.org> wrote:
> > Quoting Chen-Yu Tsai (2014-09-25 17:55:27)
> >> On Fri, Sep 26, 2014 at 8:25 AM, Mike Turquette <mturquette@linaro.org> wrote:
> >> > Quoting Maxime Ripard (2014-09-11 13:36:23)
> >> >> Hi Chen-Yu,
> >> >>
> >> >> On Sat, Sep 06, 2014 at 06:47:21PM +0800, Chen-Yu Tsai wrote:
> >> >> > Hi everyone,
> >> >> >
> >> >> > This series unifies the mux and divider parts of the AHB1 clock found
> >> >> > on sun6i and sun8i, while also adding support for the pre-divider on
> >> >> > the PLL6 input.
> >> >> >
> >> >> > The rate calculation logic must factor in which parent it is using to
> >> >> > calculate the rate, to decide whether to use the pre-divider or not.
> >> >> > This is beyond the original factors clk design in sunxi. To avoid
> >> >> > feature bloat, this is implemented as a seperate composite clk.
> >> >> >
> >> >> > The new clock driver is registered with a separate OF_CLK_DECLARE.
> >> >> > This is done so that assigned-clocks* properties on the clk provider
> >> >> > node can actually work. The clock framework arranges the clock setup
> >> >> > order by checking whether all clock parents are available, by checking
> >> >> > the node matching OF_CLK_DECLARE.
> >> >> >
> >> >> > However, the sunxi clk driver is based on the root node compatible,
> >> >> > has no defined dependencies (parents), and is setup before the fixed-rate
> >> >> > clocks. Thus when the ahb1 clock is added, all parents have rate = 0.
> >> >> > There is no way to calculate the required clock factors to set a default
> >> >> > clock rate under these circumstances. This happens when we set the
> >> >> > defaults in the clock node (provider), rather than a clock consumer.
> >> >> >
> >> >> > I can think of 2 ways to solve the dependency issue, but neither is
> >> >> > pretty. One would be to move the root fixed-rate clocks into the sunxi
> >> >> > clk driver. The other would be separating all the clocks into individual
> >> >> > OF_CLK_DECLARE statements, which adds a lot of boilerplate code.
> >> >>
> >> >> I don't know what Mike thinks of this, but I'd prefer the second.
> >> >
> >> > I do not fully understand the problem. Ideally the clock driver should
> >> > have some way to fail with EPROBE_DEFER until the fixed-rate clocks are
> >> > registered. Those fixed-rate parents are enumerated in your dts, right?
> >> > Why isn't this enough?
> >>
> >> This is due to the way the sunxi clock driver is setup. The clock driver's
> >> OF_CLK_DECLARE matches against the "soc" node, not the individual clock
> >> nodes. When the setup function is called, it just registers all the
> >> supported clocks. There are no dependencies listed.
> >>
> >> Unfortunately, the fixed-factor clock is in the middle of the whole clock
> >> tree. The sunxi clock driver provides its parents _and_ its children.
> >> Naturally the clock framework then probes the fixed-factor clock after
> >> the sunxi ones. Any attempts to change the state of clocks under the
> >> unavailable fixed-factor clock, such as done by of_clk_set_defaults(),
> >> would get an incomplete clock, likely with no parents and parent_rate = 0.
> >> That is until of_clk_init() finishes and all clocks are properly hooked
> >> up.
> >>
> >> Anyway, this problem only occurred when I added clk-assigned-* defaults
> >> to the clock provider node, which is not the case anymore.
> >
> > Makes sense. I guess you could ignore the problem until you need to use
> > the assigned defaults.
> 
> An update on this. Improper ordering of clock probing also affects
> sunxi's clock protection code.
> 
> Currently we have 2 mechanisms for protecting clocks.
> 
>   a) A list of clock names in sunxi/clk-sunxi.c, fetched and enabled
>      using clkdev.
>   b) Enabling clocks right after they are registered. Used for separated
>      clock drivers like sun5i-a13-mbus and sun8i-a23-mbus.
> 
> One issue I ran across was when most of the clock tree is registered using
> independent CLK_OF_DECLAREs, as I'm doing for the A80, if the protected
> clocks list is handled before the clock tree is complete, the prepare
> and enable calls are not correctly propagated to the parents that arrive
> later on.
> 
> This happens to the ahb*_sdram gates.

I guess that eventually, we should be able to remove a). For the time
being, maybe we can just move the clock protection code itself to a
later initcall?

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141013/1d84f837/attachment.sig>
