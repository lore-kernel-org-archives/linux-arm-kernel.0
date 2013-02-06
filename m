From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 6 Feb 2013 11:44:31 +0800
Subject: [PATCH v5 1/3] cpufreq: kirkwood: Add a cpufreq driver for
 Marvell Kirkwood SoCs
In-Reply-To: <1360094115-14999-2-git-send-email-andrew@lunn.ch>
References: <1360094115-14999-1-git-send-email-andrew@lunn.ch>
 <1360094115-14999-2-git-send-email-andrew@lunn.ch>
Message-ID: <20130206034427.GE16787@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 08:55:13PM +0100, Andrew Lunn wrote:
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>

Again, why do you need this header?  It's supposed to only be included
by clock drivers who provide clocks.

> +#include <linux/cpufreq.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <asm/proc-fns.h>

...

> +static int kirkwood_cpufreq_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np;
> +	struct resource *res;
> +	int err;
> +
> +	priv.dev = &pdev->dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Cannot get memory resource\n");
> +		return -ENODEV;
> +	}
> +	priv.base = devm_request_and_ioremap(&pdev->dev, res);
> +	if (!priv.base) {
> +		dev_err(&pdev->dev, "Cannot ioremap\n");
> +		return -EADDRNOTAVAIL;
> +	}
> +
> +	np = of_find_node_by_path("/cpus/cpu at 0");
> +	if (!np)
> +		return -ENODEV;

	pdev->dev.of_node = np;

> +
> +	priv.cpu_clk = of_clk_get_by_name(np, "cpu_clk");

Then, devm_clk_get(pdev->dev, "cpu_clk") should just work for you.
You are really hating to use devm_clk_get()?

Shawn

> +	if (IS_ERR(priv.cpu_clk)) {
> +		dev_err(priv.dev, "Unable to get cpuclk");
> +		return PTR_ERR(priv.cpu_clk);
> +	}
