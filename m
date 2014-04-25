From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 25 Apr 2014 15:20:49 +0100
Subject: [PATCH v2 02/18] usb: host: xhci-plat: Add clocks support
In-Reply-To: <1398434836-18908-3-git-send-email-gregory.clement@free-electrons.com>
References: <1398434836-18908-1-git-send-email-gregory.clement@free-electrons.com>
 <1398434836-18908-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140425142049.GR26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 04:07:00PM +0200, Gregory CLEMENT wrote:
> +#if defined(CONFIG_HAVE_CLK)
> +static int try_enable_clk(struct platform_device *pdev)
> +{
> +	struct clk *clk = devm_clk_get(&pdev->dev, NULL);
> +
> +	/* Not all platforms have a clk so it is not an error if the clock
> +	   does not exists. */
> +	if (!IS_ERR(clk))
> +		if (clk_prepare_enable(clk))
> +			return  -ENODEV;
> +	return 0;
> +}
> +
> +static int try_disable_clk(struct platform_device *pdev)
> +{
> +	struct clk *clk = devm_clk_get(&pdev->dev, NULL);
> +
> +	/* Not all platforms have a clk so it is not an error if the clock
> +	   does not exists. */
> +	if (!IS_ERR(clk))
> +		clk_disable_unprepare(clk);
> +
> +	return 0;
> +}

OMG.

You do realise that clk_get() ref-counts against the module which
provided the clock, so this is akin to an explicit leaking module
ref-counts.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
