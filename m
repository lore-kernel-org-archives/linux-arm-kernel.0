From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 27 Jan 2013 17:11:11 +0000
Subject: [PATCH v3 1/3] cpufreq: kirkwood: Add a cpufreq driver for
 Marvell Kirkwood SoCs
In-Reply-To: <1359281244-31455-2-git-send-email-andrew@lunn.ch>
References: <1359281244-31455-1-git-send-email-andrew@lunn.ch>
 <1359281244-31455-2-git-send-email-andrew@lunn.ch>
Message-ID: <20130127171111.GG23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 27, 2013 at 11:07:22AM +0100, Andrew Lunn wrote:
> +static struct priv
> +{
> +	struct clk *cpu_clk;
> +	struct clk *ddr_clk;
> +	struct clk *powersave_clk;
> +	struct device *dev;
> +	void __iomem *base;
> +} priv;

I guess you probably think that the compiler will do something special
with this, like reference these all through a base address and offset,
but you'd be wrong there.  This is no different from declaring each
as an individual static variable.

> +static unsigned int kirkwood_cpufreq_get_cpu_frequency(unsigned int cpu)
> +{
> +	if (__clk_is_enabled(priv.powersave_clk))

This looks to me to be a layering violation.

> +static int kirkwood_cpufreq_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = of_find_compatible_node(
> +		NULL, NULL, "marvell,kirkwood-core-clock");

What if np is NULL?

> +
> +	struct of_phandle_args clkspec;
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
> +		return -ENOMEM;

A number of people have been pointing out that the right return value for
this is -EADDRNOTAVAIL as documented against devm_request_and_ioremap().

> +	}
> +
> +	clkspec.np = np;
> +	clkspec.args_count = 1;
> +	clkspec.args[0] = 1;
> +
> +	priv.cpu_clk = of_clk_get_from_provider(&clkspec);

Oh, yet another way to get clocks...
