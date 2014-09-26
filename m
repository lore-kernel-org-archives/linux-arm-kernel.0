From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 26 Sep 2014 09:44:40 +0200
Subject: [PATCH v5 00/11] PM / Domains: Generic OF-based support
In-Reply-To: <20140926002757.GJ10233@codeaurora.org>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
 <20140925112122.GA22753@ulmo>
 <CAPDyKFp8oK6KAujU44NEwT2vL2_BBPSMuGPkyppHdonPfOmUrQ@mail.gmail.com>
 <20140925165625.GC30382@ulmo>
 <20140926002757.GJ10233@codeaurora.org>
Message-ID: <20140926074437.GC31106@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 05:27:57PM -0700, Stephen Boyd wrote:
> On 09/25, Thierry Reding wrote:
> > On Thu, Sep 25, 2014 at 05:29:10PM +0200, Ulf Hansson wrote:
> > > On 25 September 2014 13:21, Thierry Reding <thierry.reding@gmail.com> wrote:
> > > > I just noticed these patches because they conflicted with some of the
> > > > local patches I had to add a very similar framework. One of the reasons
> > > > why I hadn't posted these publicly yet is because the platform where I
> > > > want to use this (Tegra) is somewhat quirky when it comes to power
> > > > domains.
> > > 
> > > It's great that more things goes on in this area. :-)
> > > 
> > > >
> > > > On Tegra these domains are called power gates and they currently have
> > > > their own API. We've been looking at migrating things over to some
> > > > generic framework for some time and PM domains do seem like a good fit.
> > > > However one of the quirks regarding these domains on Tegra is that a
> > > > fixed sequence exists that needs to be respected when enabling or
> > > > disabling a power partition. The exact sequence can be found in the
> > > > drivers/soc/tegra/pmc.c driver's tegra_powergate_sequence_power_up()
> > > > function. Essentially we need to call into the clock and reset drivers
> > > > at very specific moments during the operations that the PMC does.
> > > 
> > > I am not sure I fully understand how the power gating actually
> > > happens. How is it triggered?
> > 
> > Drivers explicitly call the custom API. So all drivers that need to turn
> > on power partitions have a call to tegra_powergate_sequence_power_up()
> > in .probe() and tegra_powergate_power_off() in .remove().
> > 
> > > > One solution to this would be to make the needed clocks and resets
> > > > available to the power domain driver via DT, but then we have the
> > > > problem that two drivers would be controlling the same resources. For
> > > > example drivers could still want to disable the clock for more fine-
> > > > grained power management.
> > > 
> > > Sorry, but I think I need a better understanding to be able to comment.
> > > 
> > > But maybe, drivers could implement runtime PM support and define
> > > runtime PM callbacks. From the callbacks those will handle clocks and
> > > resets, is not that enough? What more is needed from a PM domain point
> > > of view?
> > 
> > Let me quote the actual power up sequence code:
> > 
> > 	int tegra_powergate_sequence_power_up(int id, struct clk *clk,
> > 					      struct reset_control *rst)
> > 	{
> > 		int ret;
> > 
> > 		reset_control_assert(rst);
> > 
> > 		ret = tegra_powergate_power_on(id);
> > 		if (ret)
> > 			goto err_power;
> > 
> > 		ret = clk_prepare_enable(clk);
> > 		if (ret)
> > 			goto err_clk;
> > 
> > 		usleep_range(10, 20);
> > 
> > 		ret = tegra_powergate_remove_clamping(id);
> > 		if (ret)
> > 			goto err_clamp;
> > 
> > 		usleep_range(10, 20);
> > 		reset_control_deassert(rst);
> > 
> > 		return 0;
> > 
> > 	err_clamp:
> > 		clk_disable_unprepare(clk);
> > 	err_clk:
> > 		tegra_powergate_power_off(id);
> > 	err_power:
> > 		return ret;
> > 	}
> > 	EXPORT_SYMBOL(tegra_powergate_sequence_power_up);
> > 
> > The critical part is that we need to enable the clock after the
> > partition has been powered, but before the clamps are removed.
> > Implementing this with runtime PM support in drivers won't work
> > because the power domain driver has to do both the powering up
> > and removing the clamps, so there's no place to inject the call
> > to enable the clock.
> 
> FWIW, Qualcomm platforms have pretty much the same design. Our
> power domain controls live in the same register space as the
> clocks and resets. Is Tegra the same way?

Unfortunately the powergates are in a completely different block.

>                                           To power on/off a
> domain we need to go and forcefully turn a clock on and assert a
> reset or perhaps we need the clock to be off and assert a reset.
> It depends on the domain.

It seems like we may even need to interact with the memory controller to
make sure there are no outstanding requests before gating a partition,
and similarly interact with the memory controller after ungating to make
sure the memory clients can resume transactions. We currently don't do
that and it seems to work, but most likely only because we only ungate
on driver probe and gate on driver removal.

> Historically we've supported this by requiring all drivers to
> disable their clocks and deassert any resets before calling into
> this code (we put this behind the regulator API). Then we're free
> to do whatever is necessary to power on/off, eventally leaving
> the clocks off if they were forced on and finally giving control
> to the drivers so they can manage their own clocks and resets. It
> would be better for us to take ownership of the clocks and resets
> in the domain so we don't have this prerequisite of clocks being
> off before calling into the domain code. I plan to do pretty much
> Kevin outlined and use runtime PM, power domains, and per-device
> pm QoS to figure out if we should gate clocks (clk_disable), or
> if we go to a lower power mode where we unprepare clocks
> (clk_unprepare), or if we go to the lowest power mode where we
> apply clamps, etc. (called power collapse for us). Then the
> drivers just interact with runtime PM and QoS and they aren't
> aware of all this SoC glue.

That sounds like a good plan and very similar to what I had in mind for
Tegra. I have a feeling that the road leading there could be rather
bumpy...

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140926/f49425a0/attachment.sig>
