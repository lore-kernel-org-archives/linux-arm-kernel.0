From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 19 Dec 2013 17:18:57 -0700
Subject: [PATCH 6/6] clk: tegra: add Tegra114 FCPU DFLL clocksource
 platform driver
In-Reply-To: <20131219124949.3226.94812.stgit@tamien>
References: <20131219122857.3226.42830.stgit@tamien>
 <20131219124949.3226.94812.stgit@tamien>
Message-ID: <52B38CF1.20508@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2013 05:49 AM, Paul Walmsley wrote:
> Add basic platform driver support for the fast CPU cluster DFLL
> clocksource found on Tegra114 SoCs.  This small driver selects the
> appropriate Tegra114-specific characterization data and integration
> code.  It relies on the DFLL common code to do most of the work.

> diff --git a/drivers/clk/tegra/Kconfig b/drivers/clk/tegra/Kconfig

> +config CLK_TEGRA114_DFLL_FCPU
> +	tristate "Clock driver for the Tegra T114 DFLL FCPU"

depends ARCH_TEGRA_114_SOC?

> +CFLAGS_clk-tegra114-dfll-fcpu.o		+= -Wall -Wextra -Wno-unused-parameter \
> +					   -Wno-missing-field-initializers \
> +					   -Wno-sign-compare

I'd drop this too.

> diff --git a/drivers/clk/tegra/clk-tegra114-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra114-dfll-fcpu.c

> + * clk-tegra114-dfll-fcpu.c - Tegra114 DFLL FCPU clock source driver

I'd drop the filename.

> + * Copyright (C) 2012-2013 NVIDIA Corporation.  All rights reserved.

This is 2012-2013 whereas the other files were only 2013?

> +#define DROOP_RATE_MIN			1000000
> +
> +

Double blank line.

> +static int tegra114_dfll_fcpu_probe(struct platform_device *pdev)
> +{
> +	struct tegra_dfll_soc_data soc;

Since most of the data in that struct is static, why not just make it a
static global, and initialize the constant fields. That would avoid the
need to copy it inside tegra_dfll_register(), and avoid the need to
assign the fields later in this function.

> +	int r, speedo_id, process_id;
> +
> +	speedo_id = tegra_get_cpu_speedo_id();
> +	process_id = tegra_get_cpu_process_id();
> +
> +	memset(&soc, 0, sizeof(soc));
> +	soc.driver_name = DRIVER_NAME;

Why is that needed? Shouldn't the library code be using
dev_name(&pdev->dev) or similar?

> +	r = tegra_dfll_register(pdev, &soc);
> +	if (!r)
> +		return r;
> +
> +	return 0;

if (!r) means if (r == 0) so this always returns 0. I assume that meant
if (r), but even simpler would be:

	return tegra_dfll_register(...);

> +static struct platform_driver tegra114_dfll_fcpu_driver = {
...
> +};
> +
> +module_platform_driver(tegra114_dfll_fcpu_driver);

The blank line before module_platform_driver() is customarily omitted.

> +MODULE_LICENSE("GPL");

"GPL v2"

> +MODULE_ALIAS("platform:" DRIVER_NAME);

That isn't needed since we only probe using DT now.
