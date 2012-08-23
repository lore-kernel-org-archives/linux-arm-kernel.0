From: b29396@freescale.com (Dong Aisheng)
Date: Thu, 23 Aug 2012 15:26:30 +0800
Subject: [PATCH 1/7] mfd: add imx syscon driver based on regmap
In-Reply-To: <20120822160241.GR7995@opensource.wolfsonmicro.com>
References: <1345619928-15446-1-git-send-email-b29396@freescale.com>
 <1345619928-15446-2-git-send-email-b29396@freescale.com>
 <20120822160241.GR7995@opensource.wolfsonmicro.com>
Message-ID: <20120823072629.GG10057@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2012 at 12:02:41AM +0800, Mark Brown wrote:
> On Wed, Aug 22, 2012 at 03:18:42PM +0800, Dong Aisheng wrote:
> 
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> > Add regmap based imx syscon driver.
> 
> Nice to see more regmap-mmio usage!
> 
> Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> from a regmap point of view.
> 
Thanks

> > +int imx_syscon_write(struct device_node *np, u32 reg, u32 val)
> > +{
> > +	struct device *dev;
> > +	struct imx_syscon *syscon;
> > +	int ret = 0;
> > +
> > +	dev = driver_find_device(&imx_syscon_driver.driver, NULL, np,
> > +				 imx_syscon_match);
> > +	if (!dev)
> > +		return -EPROBE_DEFER;
> > +
> > +	syscon = dev_get_drvdata(dev);
> > +	ret = regmap_write(syscon->regmap, reg, val);
> 
> It'd be good to provide a way of retrieving the regmap so that drivers
> for subsystems with generic regmap code could use the framework features
> (regulator is one example that I just mentioned in my other mail).

Do you mean something like:
regmap = syscon_regmap_dev_lookup(np, "fsl,anatop");
regmap_write(regmap, reg, val);

Then drivers can use generic regmap framework features rather than depend
on what imx-syscon implemented, is that correct?

Regards
Dong Aisheng
