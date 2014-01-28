From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 28 Jan 2014 07:27:50 -0300
Subject: [PATCH v5 14/20] watchdog: orion: Add support for Armada 370 and
 Armada XP SoC
In-Reply-To: <20140127173624.GT15937@n2100.arm.linux.org.uk>
References: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390836440-12744-15-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140127173624.GT15937@n2100.arm.linux.org.uk>
Message-ID: <20140128102750.GA13052@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 05:36:24PM +0000, Russell King - ARM Linux wrote:
[..]
> > +static int armadaxp_wdt_clock_init(struct platform_device *pdev,
> > +				   struct orion_watchdog *dev)
> > +{
> > +	int ret;
> > +
> > +	dev->clk = of_clk_get_by_name(pdev->dev.of_node, "fixed");
> > +	if (IS_ERR(dev->clk))
> > +		return PTR_ERR(dev->clk);
> > +	ret = clk_prepare_enable(dev->clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Enable the fixed watchdog clock input */
> > +	atomic_io_modify(dev->reg + TIMER_CTRL,
> > +			 WDT_AXP_FIXED_ENABLE_BIT,
> > +			 WDT_AXP_FIXED_ENABLE_BIT);
> > +
> > +	dev->clk_rate = clk_get_rate(dev->clk);
> > +	return 0;
> > +}
> 
> Doesn't this result in dev->clk being leaked?  Or at least a difference
> in the way dev->clk needs to be cleaned up between these two functions?
> 

Yes, indeed.

> I think it would be better in this case to use the standard clk_get() in
> the first function and always use clk_put()... until there is a devm_*
> version of the of_clk_get* functions.
> 

Sound good.

Thanks,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
