From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 25 Sep 2014 18:56:26 +0200
Subject: [PATCH v5 00/11] PM / Domains: Generic OF-based support
In-Reply-To: <CAPDyKFp8oK6KAujU44NEwT2vL2_BBPSMuGPkyppHdonPfOmUrQ@mail.gmail.com>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
 <20140925112122.GA22753@ulmo>
 <CAPDyKFp8oK6KAujU44NEwT2vL2_BBPSMuGPkyppHdonPfOmUrQ@mail.gmail.com>
Message-ID: <20140925165625.GC30382@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 05:29:10PM +0200, Ulf Hansson wrote:
> On 25 September 2014 13:21, Thierry Reding <thierry.reding@gmail.com> wrote:
> > I just noticed these patches because they conflicted with some of the
> > local patches I had to add a very similar framework. One of the reasons
> > why I hadn't posted these publicly yet is because the platform where I
> > want to use this (Tegra) is somewhat quirky when it comes to power
> > domains.
> 
> It's great that more things goes on in this area. :-)
> 
> >
> > On Tegra these domains are called power gates and they currently have
> > their own API. We've been looking at migrating things over to some
> > generic framework for some time and PM domains do seem like a good fit.
> > However one of the quirks regarding these domains on Tegra is that a
> > fixed sequence exists that needs to be respected when enabling or
> > disabling a power partition. The exact sequence can be found in the
> > drivers/soc/tegra/pmc.c driver's tegra_powergate_sequence_power_up()
> > function. Essentially we need to call into the clock and reset drivers
> > at very specific moments during the operations that the PMC does.
> 
> I am not sure I fully understand how the power gating actually
> happens. How is it triggered?

Drivers explicitly call the custom API. So all drivers that need to turn
on power partitions have a call to tegra_powergate_sequence_power_up()
in .probe() and tegra_powergate_power_off() in .remove().

> > One solution to this would be to make the needed clocks and resets
> > available to the power domain driver via DT, but then we have the
> > problem that two drivers would be controlling the same resources. For
> > example drivers could still want to disable the clock for more fine-
> > grained power management.
> 
> Sorry, but I think I need a better understanding to be able to comment.
> 
> But maybe, drivers could implement runtime PM support and define
> runtime PM callbacks. From the callbacks those will handle clocks and
> resets, is not that enough? What more is needed from a PM domain point
> of view?

Let me quote the actual power up sequence code:

	int tegra_powergate_sequence_power_up(int id, struct clk *clk,
					      struct reset_control *rst)
	{
		int ret;

		reset_control_assert(rst);

		ret = tegra_powergate_power_on(id);
		if (ret)
			goto err_power;

		ret = clk_prepare_enable(clk);
		if (ret)
			goto err_clk;

		usleep_range(10, 20);

		ret = tegra_powergate_remove_clamping(id);
		if (ret)
			goto err_clamp;

		usleep_range(10, 20);
		reset_control_deassert(rst);

		return 0;

	err_clamp:
		clk_disable_unprepare(clk);
	err_clk:
		tegra_powergate_power_off(id);
	err_power:
		return ret;
	}
	EXPORT_SYMBOL(tegra_powergate_sequence_power_up);

The critical part is that we need to enable the clock after the
partition has been powered, but before the clamps are removed.
Implementing this with runtime PM support in drivers won't work
because the power domain driver has to do both the powering up
and removing the clamps, so there's no place to inject the call
to enable the clock.

> > Furthermore for some devices it may turn out
> > that turning the domain off and on introduces too much latency to be
> > useful.
> 
> This should be handled by the generic PM domain governor. Through the
> per device QOS, you are able to set latencies constraints which could
> prevent a PM domain from being gated.

Okay, that sounds good.

> > Does anyone have any better ideas on how to make that work with this
> > generic PM domain framework? Or is Tegra just too special to be a good
> > fit?
> 
> I certainly think it's worth a try, I would be surprised if we
> shouldn't be able to address requirements from Tegra.
> 
> As you might have figured out, I am dedicated to improve the generic
> power domain such it could fit more SOCs than today, thus I am also
> hoping for more SOC to start to convert to it.

I do have code that seems to work in most cases without following the
above sequence, but there are no guarantees, so I'm reluctant to make
that change.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140925/6e9b09dc/attachment.sig>
