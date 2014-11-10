From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 10 Nov 2014 11:47:11 -0300
Subject: [PATCH v3 2/3] watchdog: orion: Use the reference clock on Armada
 375 SoC
In-Reply-To: <5460CEB0.7080009@free-electrons.com>
References: <1415107293-19258-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1415107293-19258-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <5460CEB0.7080009@free-electrons.com>
Message-ID: <5460CFEF.1090400@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2014 11:41 AM, Gregory CLEMENT wrote:
> Hi Ezequiel,
> 
> [...]
> 
>> +static int armada375_wdt_clock_init(struct platform_device *pdev,
>> +				    struct orion_watchdog *dev)
>> +{
>> +	int ret;
>> +
>> +	dev->clk = of_clk_get_by_name(pdev->dev.of_node, "fixed");
>> +	if (!IS_ERR(dev->clk)) {
>> +		ret = clk_prepare_enable(dev->clk);
>> +		if (ret) {
>> +			clk_put(dev->clk);
>> +			return ret;
>> +		}
>> +
>> +		atomic_io_modify(dev->reg + TIMER_CTRL,
>> +				WDT_AXP_FIXED_ENABLE_BIT,
>> +				WDT_AXP_FIXED_ENABLE_BIT);
>> +		dev->clk_rate = clk_get_rate(dev->clk);
>> +
>> +		return 0;
>> +	}
>> +
>> +	/* Mandatory fallback for proper devicetree backward compatibility */
>> +	dev->clk = clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(dev->clk))
>> +		return PTR_ERR(dev->clk);
>> +
>> +	ret = clk_prepare_enable(dev->clk);
>> +	if (ret) {
>> +		clk_put(dev->clk);
>> +		return ret;
>> +	}
>> +
>> +	atomic_io_modify(dev->reg + TIMER_CTRL,
>> +			WDT_A370_RATIO_MASK(WDT_A370_RATIO_SHIFT),
>> +			WDT_A370_RATIO_MASK(WDT_A370_RATIO_SHIFT));
>> +	dev->clk_rate = clk_get_rate(dev->clk) / WDT_A370_RATIO;
>> +
>> +	return 0;
>> +}
> 
> Shouldn't be possible to do the following:
> 
> static int armada375_wdt_clock_init(struct platform_device *pdev,
> 				    struct orion_watchdog *dev)
> {
> 	if (armadaxp_wdt_clock_init(pdev, dev)) {
> 		/* Mandatory fallback for proper devicetree backward compatibility */
> 		return armadaxp_wdt_clock_init(pdev, dev));

I guess you meant armada370_wdt_clock_init for the fallback?

> 	}
> 	return 0;
> }
> 
> Actually reusing the armadaxp_wdt_clock_init() function  was also suggested by Thomas
> on your first version but I didn't find your answer about it.
> 

I replied here to the same objection on the clocksource driver:
http://www.spinics.net/lists/linux-watchdog/msg05318.html

I found that it's a fragile practice, just to save a few lines of code.
Someone can go and change the 370/xp clock init, in some way that's
incompatible with 375.

I guess I'm being paranoid, but it's a way to keep the code robust and
we are only duplicating a few lines.

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
