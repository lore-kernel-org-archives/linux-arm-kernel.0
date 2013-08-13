From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 13 Aug 2013 17:47:31 +0100
Subject: [PATCH 1/8] clk: keystone: add Keystone PLL clock driver
In-Reply-To: <520A5877.7050608@ti.com>
References: <1375719147-7578-1-git-send-email-santosh.shilimkar@ti.com>
 <1375719147-7578-2-git-send-email-santosh.shilimkar@ti.com>
 <20130813154842.GQ27165@e106331-lin.cambridge.arm.com>
 <520A5877.7050608@ti.com>
Message-ID: <20130813164730.GT27165@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 05:01:59PM +0100, Santosh Shilimkar wrote:
> On Tuesday 13 August 2013 11:48 AM, Mark Rutland wrote:
> > [Adding dt maintainers]
> > 
> > On Mon, Aug 05, 2013 at 05:12:20PM +0100, Santosh Shilimkar wrote:
> >> Add the driver for the PLL IPs found on Keystone 2 devices. The main PLL
> >> IP typically has a multiplier, and a divider. The addtional PLL IPs like
> >> ARMPLL, DDRPLL and PAPLL are controlled by the memory mapped register where
> >> as the Main PLL is controlled by a PLL controller and memory map registers.
> >> This difference is handle using 'has_pll_cntrl' property.
> >>
> >> Cc: Mike Turquette <mturquette@linaro.org>
> >>
> >> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >> ---
> 
> Thanks for review Mark.
> 
> >>  .../devicetree/bindings/clock/keystone-pll.txt     |   36 ++++
> >>  drivers/clk/keystone/pll.c                         |  197 ++++++++++++++++++++
> >>  include/linux/clk/keystone.h                       |   18 ++
> >>  3 files changed, 251 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/clock/keystone-pll.txt
> >>  create mode 100644 drivers/clk/keystone/pll.c
> >>  create mode 100644 include/linux/clk/keystone.h
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/keystone-pll.txt b/Documentation/devicetree/bindings/clock/keystone-pll.txt
> >> new file mode 100644
> >> index 0000000..58f6470
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/clock/keystone-pll.txt
> >> @@ -0,0 +1,36 @@
> >> +Binding for keystone PLLs. The main PLL IP typically has a multiplier,
> >> +a divider and a post divider. The additional PLL IPs like ARMPLL, DDRPLL
> >> +and PAPLL are controlled by the memory mapped register where as the Main
> >> +PLL is controlled by a PLL controller. This difference is handle using
> >> +'pll_has_pllctrl' property.
> >> +
> >> +This binding uses the common clock binding[1].
> >> +
> >> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> >> +
> >> +Required properties:
> >> +- compatible : shall be "keystone,pll-clk".
> > 
> > Keystone isn't a vendor, and generally, bindings have used "clock"
> > rather than "clk".
> > 
> > Perhaps "ti,keystone-pll-clock" ?
> > 
> Agree.
> 
> >> +- #clock-cells : from common clock binding; shall be set to 0.
> >> +- clocks : parent clock phandle
> >> +- reg - index 0 -  PLLCTRL PLLM register address
> >> +- 	index 1 -  MAINPLL_CTL0 register address
> > 
> > Perhaps a reg-names would be useful?
> > 
> >> +- pll_has_pllctrl - PLL is controlled by controller or memory mapped register
> > 
> > Huh? I don't understand what that description means. What does the
> > property tell you? Is having one of the registers optional? If so that
> > should be described by a reg-names property associated with the reg, and
> > should be noted in the binding.
> > 
> After re-reading it, yes I agree it not clear. The point is there
> are two different types of IPs and pogramming model changes quite
> a bit. Its not just 1 register optional.

If that's the case, then having different compatible strings would make
sense.

> 
> >> +- pllm_lower_mask - pllm lower bit mask
> >> +- pllm_upper_mask - pllm upper bit mask
> >> +- plld_mask - plld mask
> >> +- fixed_postdiv - fixed post divider value
> > 
> > Please use '-' rather than '_' in property names, it's a standard
> > convention for dt and going against it just makes things unnecessarily
> > complicated.
> > 
> > Why are these necessary? Are clocks sharing common registers, are there
> > some sets of "keystone,pll-clk"s that have the same masks, or does this
> > just vary wildly?
> > 
> This is mainly to take care of the programming model which varies between
> IPs. Will try to make that bit more clear.

Are there more than the two IPs mentioned above? If they had separate
compatible strings, would that give enough information implicitly,
without the precise masks needing to be in the dt?

> 
> > Also, what types are these (presumably a single cell/u32)?
> > 
> u32

Ok, please could you document that in the binding?

Cheers,
Mark.
