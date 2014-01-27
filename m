From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Jan 2014 17:36:24 +0000
Subject: [PATCH v5 14/20] watchdog: orion: Add support for Armada 370
 and Armada XP SoC
In-Reply-To: <1390836440-12744-15-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390836440-12744-15-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140127173624.GT15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 12:27:14PM -0300, Ezequiel Garcia wrote:
> +static int armada370_wdt_clock_init(struct platform_device *pdev,
> +				    struct orion_watchdog *dev)
> +{
> +	int ret;
> +
> +	dev->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(dev->clk))
> +		return PTR_ERR(dev->clk);
> +	ret = clk_prepare_enable(dev->clk);
> +	if (ret)
> +		return ret;
> +
> +	/* Setup watchdog input clock */
> +	atomic_io_modify(dev->reg + TIMER_CTRL,
> +			WDT_A370_RATIO_MASK(WDT_A370_RATIO_SHIFT),
> +			WDT_A370_RATIO_MASK(WDT_A370_RATIO_SHIFT));
> +
> +	dev->clk_rate = clk_get_rate(dev->clk) / WDT_A370_RATIO;
> +	return 0;
> +}
> +
> +static int armadaxp_wdt_clock_init(struct platform_device *pdev,
> +				   struct orion_watchdog *dev)
> +{
> +	int ret;
> +
> +	dev->clk = of_clk_get_by_name(pdev->dev.of_node, "fixed");
> +	if (IS_ERR(dev->clk))
> +		return PTR_ERR(dev->clk);
> +	ret = clk_prepare_enable(dev->clk);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable the fixed watchdog clock input */
> +	atomic_io_modify(dev->reg + TIMER_CTRL,
> +			 WDT_AXP_FIXED_ENABLE_BIT,
> +			 WDT_AXP_FIXED_ENABLE_BIT);
> +
> +	dev->clk_rate = clk_get_rate(dev->clk);
> +	return 0;
> +}

Doesn't this result in dev->clk being leaked?  Or at least a difference
in the way dev->clk needs to be cleaned up between these two functions?

I think it would be better in this case to use the standard clk_get() in
the first function and always use clk_put()... until there is a devm_*
version of the of_clk_get* functions.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
