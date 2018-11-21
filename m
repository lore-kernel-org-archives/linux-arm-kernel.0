From: sakari.ailus@linux.intel.com (Sakari Ailus)
Date: Thu, 22 Nov 2018 00:01:03 +0200
Subject: [PATCH 3/5] media: sunxi: Add A10 CSI driver
In-Reply-To: <20181115205106.thbkojnzdwmaeui3@flea>
References: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
 <c53e1cdc3b139382b00ee06bf3980d3fd1742ec0.1542097288.git-series.maxime.ripard@bootlin.com>
 <f34c79f5-66d6-2c2f-5616-020ad2b96400@xs4all.nl>
 <20181115205106.thbkojnzdwmaeui3@flea>
Message-ID: <20181121220102.6nn7uwu2c67zs6pz@mara.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 09:51:06PM +0100, Maxime Ripard wrote:
> Hi Hans,
> 
> Thanks for your review! I'll address the other comments you made.
> 
> On Tue, Nov 13, 2018 at 01:24:47PM +0100, Hans Verkuil wrote:
> > > +static int csi_probe(struct platform_device *pdev)
> > > +{
> > > +	struct sun4i_csi *csi;
> > > +	struct resource *res;
> > > +	int ret;
> > > +	int irq;
> > > +
> > > +	csi = devm_kzalloc(&pdev->dev, sizeof(*csi), GFP_KERNEL);
> > 
> > devm_kzalloc is not recommended: all devm_ memory is freed when the driver
> > is unbound, but a filehandle might still have a reference open.
> 
> How would a !devm variant with a kfree in the remove help? We would
> still fall in the same case, right?

Not quite. For video nodes this is handled: the release callback gets called
once there are no file handles open to the device. That may well be much
later than the device has been unbound from the driver.

-- 
Sakari Ailus
sakari.ailus at linux.intel.com
