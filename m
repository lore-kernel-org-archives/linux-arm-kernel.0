From: mturquette@ti.com (Mike Turquette)
Date: Thu, 31 May 2012 12:09:46 -0700
Subject: [RFC PATCH] clk: add extension API
In-Reply-To: <4FC68304.9050208@codeaurora.org>
References: <1338285540-24407-1-git-send-email-pdeschrijver@nvidia.com>
 <4FC5DFCF.1020606@codeaurora.org>
 <20120530194059.GA13243@gmail.com>
 <4FC68304.9050208@codeaurora.org>
Message-ID: <20120531190946.GA16878@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120530-13:28, Stephen Boyd wrote:
> On 05/30/12 12:40, Mike Turquette wrote:
> > I also wonder if exposing some of these knobs should be done in the
> > basic clock types.  Meaning that instead of having additional calls in
> > the clk.h API those calls could be exposed by the basic clock types that
> > map to the actions.
> 
> What do you mean by basic clock types that map to actions? Perhaps an
> example?
> 

No exmaples to give, just tossing out ideas.

> >
> > The question that needs to be answered is this: do generic drivers need
> > access to these additional functions (clk.h) or just the platform code
> > which implements some of the clock logic (basic clock types &
> > platform-speciic clock types).
> 
> At least for tegra it looks like they need reset assertion and
> deassertion in generic drivers.
> 
> $ git grep tegra_periph_reset_assert
> arch/arm/mach-tegra/clock.c:void tegra_periph_reset_assert(struct clk *c)
> arch/arm/mach-tegra/clock.c:EXPORT_SYMBOL(tegra_periph_reset_assert);
> arch/arm/mach-tegra/include/mach/clk.h:void tegra_periph_reset_assert(struct clk *c);
> arch/arm/mach-tegra/pcie.c:     tegra_periph_reset_assert(tegra_pcie.pcie_xclk);
> arch/arm/mach-tegra/pcie.c:     tegra_periph_reset_assert(tegra_pcie.afi_clk);
> arch/arm/mach-tegra/pcie.c:     tegra_periph_reset_assert(tegra_pcie.pex_clk);
> arch/arm/mach-tegra/pcie.c:     tegra_periph_reset_assert(tegra_pcie.pcie_xclk);
> arch/arm/mach-tegra/pcie.c:     tegra_periph_reset_assert(tegra_pcie.afi_clk);
> arch/arm/mach-tegra/powergate.c:        tegra_periph_reset_assert(clk);
> drivers/i2c/busses/i2c-tegra.c: tegra_periph_reset_assert(i2c_dev->clk);
> drivers/input/keyboard/tegra-kbc.c:     tegra_periph_reset_assert(kbc->clk);
> drivers/staging/nvec/nvec.c:    tegra_periph_reset_assert(nvec->i2c_clk);
> 

Ok, this is good to know.  The same sort of thing is achieved via
runtime pm and the hwmod framework in OMAP code.  I had given similar
feedback to Andrew Lunn for using clk_prepare/clk_unprepare to power
down the PHY for some of his IP blocks.  I don't think that the clock
framework should be used for that and this clk_reset(...) stuff seems
similar.

Like Benoit, I am partial to associating these actions to module-level
APIs, not necessarily clock-level APIs.

A yardstick to determine whether or not the clock framework is the right
place for a _reset() function might be whether or not it will change the
values of struct clk's members.  If we had a clk_reset(...) call it
would clearly bang some bits in a register via clk->ops->reset ... but
what data would it change in struct clk?  Adjust the rate to 0?  Reset
prepare_count and enable_count to 0?

If it doesn't actually change any of the bookkeeping or accounting in
the clock framework then it might be a clue that the clock framework
isn't the best place for this API.

Thanks,
Mike
