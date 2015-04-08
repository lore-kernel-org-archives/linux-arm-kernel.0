From: treding@nvidia.com (Thierry Reding)
Date: Wed, 8 Apr 2015 10:06:31 +0200
Subject: [PATCH v2 07/17] soc: tegra: pmc: Add generic PM domain support
In-Reply-To: <7h1tjwx4r2.fsf@deeprootsystems.com>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
 <1426162518-7405-8-git-send-email-vinceh@nvidia.com>
 <7h1tjwx4r2.fsf@deeprootsystems.com>
Message-ID: <20150408080629.GB26974@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 06, 2015 at 03:37:37PM -0700, Kevin Hilman wrote:
> Hi Vince,
> 
> Vince Hsu <vinceh@nvidia.com> writes:
[...]
> > +static int tegra_pmc_powergate_power_off(struct generic_pm_domain *domain)
> > +{
> > +	struct tegra_powergate *powergate = to_powergate(domain);
> > +	struct tegra_pmc *pmc = powergate->pmc;
> > +	int err;
> > +
> > +	dev_dbg(pmc->dev, "> %s(domain=%p)\n", __func__, domain);
> > +	dev_dbg(pmc->dev, "  name: %s\n", domain->name);
> > +
> > +	/* never turn off these partitions */
> > +	switch (powergate->id) {
> > +	case TEGRA_POWERGATE_CPU:
> > +	case TEGRA_POWERGATE_CPU1:
> > +	case TEGRA_POWERGATE_CPU2:
> > +	case TEGRA_POWERGATE_CPU3:
> > +	case TEGRA_POWERGATE_CPU0:
> > +	case TEGRA_POWERGATE_C0NC:
> > +	case TEGRA_POWERGATE_IRAM:
> > +		dev_dbg(pmc->dev, "not disabling always-on partition %s\n",
> > +			domain->name);
> > +		err = -EINVAL;
> > +		goto out;
> > +	}
> 
> You're re-inventing the per-device QoS flag: PM_QOS_FLAG_NO_POWER_OFF
> which could be used here to prevent ->power_off from ever being called.
> 
> Alternately, if this really a static configuraion, why even register the
> ->power_off hook for these domains in the first place?

This isn't really a static configuration. The problem here is that there
is code elsewhere to deal with these domains. The CPU power partitions
for example are dealt with in the cpuidle code (or PSCI firmware). What
complicates this even further is that we have an existing custom API for
enabling/disabling power partitions (cpuidle uses that API).

Although, thinking about it some more, it seems that for the purposes of
power domains perhaps we should just not consider these power partitions
at all (i.e. not even register them).

[...]
> > @@ -831,12 +1405,19 @@ static int tegra_pmc_probe(struct platform_device *pdev)
> >  
> >  	tegra_pmc_init_tsense_reset(pmc);
> >  
> > +	if (IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS)) {
> > +		err = tegra_powergate_init(pmc);
> > +		if (err < 0)
> > +			return err;
> > +	}
> 
> On many SoCs there's some special handling for the !CONFIG_PM case here
> such that all the PM domains are enabled by default in case they are not
> enabled by the bootloader.

Yeah, I think we'll need something like that for backwards-compatibility
with the old API. Converting to power domains should be done in the same
step as stubbing out the old API, and then to prevent devices using some
old DTBs to fail we'd need to enable all domains that are currently
controlled by existing drivers using the custom API.

So we don't only need this fallback for !PM_GENERIC_DOMAINS but also for
cases where we detect a DTB that's missing the nodes to describe the
domains.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150408/dc5841c0/attachment.sig>
