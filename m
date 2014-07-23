From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 23 Jul 2014 15:59:20 +0200
Subject: [PATCH v2 14/16] cpufreq: Add cpufreq driver for Tegra124
In-Reply-To: <53CFAC22.40106@nvidia.com>
References: <1405957142-19416-1-git-send-email-ttynkkynen@nvidia.com>
 <1405957142-19416-15-git-send-email-ttynkkynen@nvidia.com>
 <20140723070949.GB15759@ulmo.nvidia.com>
 <53CFAC22.40106@nvidia.com>
Message-ID: <20140723135918.GC14263@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 23, 2014 at 03:35:46PM +0300, Tuomas Tynkkynen wrote:
> On 23/07/14 10:09, Thierry Reding wrote:
> > On Mon, Jul 21, 2014 at 06:39:00PM +0300, Tuomas Tynkkynen wrote:
[...]
> >> diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
[...]
> >> +	cpu_clk = of_clk_get_by_name(cpu_dev->of_node, "cpu_g");
> >> +	if (IS_ERR(cpu_clk))
> >> +		return PTR_ERR(cpu_clk);
[...]
> >> +	pllp_clk = of_clk_get_by_name(cpu_dev->of_node, "pll_p");
> >> +	if (IS_ERR(pllp_clk)) {
> >> +		ret = PTR_ERR(pllp_clk);
> >> +		goto out_put_pllx_clk;
> >> +	}
> > 
> > Can the above not be devm_clk_get(cpu_dev, "...") so that you can remove
> > all the clk_put() calls in the cleanup code below?
> 
> That would allocate the clks under the cpu_dev's devres list, i.e. all the
> clk_puts wouldn't happen when the cpufreq driver goes away, but only when
> cpu_dev itself goes away.

I don't think so. devres_release_all() is called on driver detach as
well.

> > But is there even a reason why we need that? Couldn't we make the
> > driver's .remove() undo what .probe() did so that the driver can be
> > unloaded?
> 
> I guess that could be done, though to fully undo everything the regulator
> voltage would also need to be saved/restored.

That would certainly be my prefered approach. that way the driver can
simply be unloaded, leaving the CPU in the same state as it was after
boot.

> > Otherwise it probably makes more sense not to use a driver (and dummy
> > device) at all as Viresh already mentioned.
> > 
> 
> The dummy platform device is only required for probe deferral, if that
> could be solved in a different way then yes.

I don't think it can. Probe deferral is pretty closely tied to devices
so it's unlikely to ever get implemented for regular initcalls. And in
this case I really think making the driver removable is a good thing.

> >> +};
> >> +
> >> +static const struct of_device_id soc_of_matches[] = {
> >> +	{ .compatible = "nvidia,tegra124", },
> >> +	{}
> >> +};
> >> +
> >> +static int __init tegra_cpufreq_init(void)
> >> +{
> >> +	int ret;
> >> +	struct platform_device *pdev;
> >> +
> >> +	if (!of_find_matching_node(NULL, soc_of_matches))
> >> +		return -ENODEV;
> > 
> > I think this could be of_machine_is_compatible() since there's only a
> > single entry in the match table. If there's a good chance that we may
> > end up with more entries, perhaps now would be a good time to add an
> > of_match_machine() function?
> 
> I think this driver should work on Tegra132 without modifications.
> of_match_machine() does sound useful for some of the other cpufreq
> drivers as well and likely for your soc_is_tegra() from the PMC
> series as well.

Yes, indeed. I'll give it a shot if you don't beat me to it with this
series.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140723/6f120a3c/attachment.sig>
