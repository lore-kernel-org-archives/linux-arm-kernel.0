From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 17 Sep 2010 12:30:50 +0100
Subject: [PATCH] regulator: Add support samsung power domain
In-Reply-To: <1284717532-9992-1-git-send-email-kgene.kim@samsung.com>
References: <1284717532-9992-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100917113050.GA4322@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 17, 2010 at 06:58:52PM +0900, Kukjin Kim wrote:

> This patch adds common regulator driver for samsung power domain.
> A consumer of controlling power domain uses regulator framework API,
> So new samsung pd driver is inserted into regulator directory.

This looks conceptually OK for the regulator API - there's no operating
points, it's just straight enable/disable stuff - but I do have a few
concerns about this approach.

> +config REGULATOR_SAMSUNG_POWER_DOMAIN
> +	tristate "Samsung power domain support"
> +	help
> +	  This driver provides support for samsung power domain.
> +

This really ought to have a dependency on PLAT_SAMSUNG or something.
However, see below.

> +static struct regulator_ops samsung_pd_ops = {
> +	.is_enabled	= samsung_pd_is_enabled,
> +	.enable		= samsung_pd_enable,
> +	.disable	= samsung_pd_disable,
> +	.enable_time	= samsung_pd_enable_time,
> +};

You've got a microvolts in the platform data but no voltage stuff here.
Equally well given that this is for processor internal stuff probably
the change you need is to remove the voltage from the config.

> +	dev_dbg(&pdev->dev, "%s registerd\n", drvdata->desc.name);

Spelling mistake here.  The regulator API is fairly chatty so I'd have
thought this was a bit redundant?

> +struct samsung_pd_config {
> +	const char *supply_name;
> +	int microvolts;
> +	unsigned startup_delay;
> +	unsigned enabled_at_boot:1;
> +	struct regulator_init_data *init_data;
> +	int (*enable)(void);
> +	int (*disable)(void);
> +};

So, this driver is essentially just a mapping of this ops structure into
the regulator API.  This is not at all Samsung specific so if it did get
included it shouldn't have any Samsung references (other than the author
and copyright ones) but I'm not convinced that this is the best approach.

What I'd have expected to see is either a regulator driver that at least
knows something about updating registers in the CPU (or whatever else is
needed to configure the power domains) or something more generic (along
the lines of the existing fixed voltage regulator, possibly just some
new features for it).  I'm tending more towards the former approach
since if you're having to provide enable and disable operations you're
getting very close to just implementing a subset regulator API.

Another option to consider here is using runtime PM - other platforms
seem to be going down that route, and are using it to also factor clock
management for the IP blocks out (so that the block's clocks get enabled
and disabled automatically when the block is active without needing any
code in the driver).
