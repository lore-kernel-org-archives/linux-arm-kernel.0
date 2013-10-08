From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 8 Oct 2013 10:53:56 +0300
Subject: [PATCH 1/2] clk: tegra114: Rename gr_2d/gr_3d to gr2d/gr3d
In-Reply-To: <20131007145343.GA19045@ulmo.nvidia.com>
References: <1380748361-32459-1-git-send-email-treding@nvidia.com>
 <524EF436.4000704@wwwdotorg.org> <20131007001433.7445.7915@quantum>
 <20131007142839.GC3973@tbergstrom-lnx.Nvidia.com>
 <20131007145343.GA19045@ulmo.nvidia.com>
Message-ID: <20131008075356.GD3973@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 04:53:44PM +0200, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Mon, Oct 07, 2013 at 05:28:39PM +0300, Peter De Schrijver wrote:
> > On Mon, Oct 07, 2013 at 02:14:33AM +0200, Mike Turquette wrote:
> > > Quoting Stephen Warren (2013-10-04 10:00:38)
> > > > On 10/02/2013 03:12 PM, Thierry Reding wrote:
> > > > > These clocks were named gr2d and gr3d on Tegra20 and Tegra30, so use the
> > > > > same names on Tegra114 for consistency.
> > > > 
> > > > The series,
> > > > Acked-by: Stephen Warren <swarren@nvidia.com>
> > > > 
> > > > Although I wonder if there will be merge conflicts with Peter's "clk:
> > > > tegra: replace enum tegra114_clk by binding header"?
> > > 
> > > There are merge conflicts in other places too. The latest clk-next
> > > branch is based on -rc3 with only a few patches (publicly) applied so
> > > far. As of the time of this writing the top-most commit is
> > > 96a7ed9079a3483c5681b17f4713c37c1cf2b1c9.
> > > 
> > > Can the Tegra folks send me a pull request with the following
> > > patches applied? (likely in this order):
> > > 
> > > ARM: tegra114: add missing clocks to binding
> > > clk: tegra: replace enum tegra114_clk by binding header
> > > [PATCH v2] clk: tegra: Correct sbc mux width & parent
> > > clk: tegra: Fix vde/2d/3d clock src offset
> > > clk: tegra: Set the clock parent of gr2d/gr3d to pll_c2
> > > clk: tegra: Set the clk parent of host1x to pll_p
> > > clk: tegra114: Rename gr_2d/gr_3d to gr2d/gr3d
> > > clk: tegra114: Initialize gr2d clock
> > 
> > This conflicts with 'clk: tegra: Set the clock parent of gr2d/gr3d to pll_c2'
> > I suggest we drop 'clk: tegra114: Initialize gr2d clock' and use pll_c2 to clock gr2d.
> 
> What's wrong with pll_c? We've used it for Tegra20 and Tegra30 and I
> have at least tested that gr2d works properly with it. It will also
> cause both host1x and gr2d to run off the same clock, which I guess may
> not matter at all.
> 

Using pll_c2 is consistent with our policy in downstream. It allows more
freedom in scaling gr2d independently from host1x.

> Furthermore we've usually only added clock initialization when a driver
> became available to use it. There is currently no driver for gr3d in the
> upstream kernel, so perhaps we should leave the gr3d clock unconfigured
> for now?
> 

I don't have a strong opinion if we want the gr3d clock in or not. Mark?

> > > The set of patches above (with their functional dependencies) were
> > > giving me some conflict resolution issues (e.g. large data tables that
> > > needed to be updated in clk-tegra-114.c) against the latest clk-next.
> > > 
> > > Additionally I've looked at the following patches on the list which can
> > > be added to the pull request if you want (these patches all look fine
> > > but I haven't yet Acked each individually):
> > > 
> > > clk: tegra30: Don't wait for PLL_U lock bit
> > 
> > This is already part of next-20130927.
> > 
> > > clk: tegra114: Initialize host1x and related clocks
> > 
> > This conflicts with 'clk: tegra: Set the clk parent of host1x to pll_p'. I
> > suggest we drop 'clk: tegra: Set the clk parent of host1x to pll_p' and run
> > host1x from pll_c. Mark, Thierry, is this ok?
> 
> Sounds good to me. We use pll_c for host1x on earlier SoC generations as
> well.

Ok.

Cheers,

Peter.
