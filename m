From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 18 Oct 2017 15:50:36 +0200
Subject: [PATCH v4 3/5] reset: socfpga: use the reset-simple driver
In-Reply-To: <ce77d20c-7d62-77c3-8c89-991eeb8d2405@arm.com>
References: <20171017130306.881-1-p.zabel@pengutronix.de>
 <20171017130306.881-4-p.zabel@pengutronix.de>
 <ce77d20c-7d62-77c3-8c89-991eeb8d2405@arm.com>
Message-ID: <1508334636.9874.4.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-10-18 at 14:00 +0100, Andre Przywara wrote:
> Hi,

Thank you for the review.

> On 17/10/17 14:03, Philipp Zabel wrote:
> > Add reset line status readback, inverted status support, and socfpga
> > device tree quirks to the simple reset driver, and use it to replace
> > the socfpga driver.
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> > Changes since v3:
> >  - Rebased onto reset/next
> >  - Only warn about missing altr,modrst-offset property on socfpga
> > ---
> >  drivers/reset/Kconfig         |  10 +--
> >  drivers/reset/Makefile        |   1 -
> >  drivers/reset/reset-simple.c  |  51 +++++++++++++-
> >  drivers/reset/reset-simple.h  |   4 ++
> >  drivers/reset/reset-socfpga.c | 157 ------------------------------------------
> >  5 files changed, 56 insertions(+), 167 deletions(-)
> >  delete mode 100644 drivers/reset/reset-socfpga.c
> > 
[...]
> > diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
> > index a5119457cec61..98ff0f924948e 100644
> > --- a/drivers/reset/reset-simple.c
> > +++ b/drivers/reset/reset-simple.c
> > @@ -68,25 +68,58 @@ static int reset_simple_deassert(struct reset_controller_dev *rcdev,
> >  	return reset_simple_update(rcdev, id, false);
> >  }
> >  
> > +static int reset_simple_status(struct reset_controller_dev *rcdev,
> > +			       unsigned long id)
> > +{
> > +	struct reset_simple_data *data = to_reset_simple_data(rcdev);
> > +	int reg_width = sizeof(u32);
> > +	int bank = id / (reg_width * BITS_PER_BYTE);
> > +	int offset = id % (reg_width * BITS_PER_BYTE);
> > +	u32 reg;
> > +
> > +	reg = readl(data->membase + (bank * reg_width));
> > +
> > +	return !(reg & BIT(offset)) ^ !data->status_active_low;
> > +}
> > +
> >  const struct reset_control_ops reset_simple_ops = {
> >  	.assert		= reset_simple_assert,
> >  	.deassert	= reset_simple_deassert,
> > +	.status		= reset_simple_status,
> >  };
> >  
> >  /**
> >   * struct reset_simple_devdata - simple reset controller properties
> > + * @reg_offset: offset between base address and first reset register.
> > + * @nr_resets: number of resets. If not set, default to resource size in bits.
> >   * @active_low: if true, bits are cleared to assert the reset. Otherwise, bits
> >   *              are set to assert the reset.
> > + * @status_active_low: if true, bits read back as cleared while the reset is
> > + *                     asserted. Otherwise, bits read back as set while the
> > + *                     reset is asserted.
> >   */
> >  struct reset_simple_devdata {
> > +	u32 reg_offset;
> > +	u32 nr_resets;
> >  	bool active_low;
> > +	bool status_active_low;
> > +};
> > +
> > +#define SOCFPGA_NR_BANKS	8
> > +
> > +static const struct reset_simple_devdata reset_simple_socfpga = {
> > +	.reg_offset = 0x10,

Here reset_simple_socfpga.reg_offset is set to the default of 0x10.

> > +	.nr_resets = SOCFPGA_NR_BANKS * 32,
> > +	.status_active_low = true,
> >  };
> >  
> >  static const struct reset_simple_devdata reset_simple_active_low = {
> >  	.active_low = true,
> > +	.status_active_low = true,
> >  };
> >  
> >  static const struct of_device_id reset_simple_dt_ids[] = {
> > +	{ .compatible = "altr,rst-mgr", .data = &reset_simple_socfpga },
> >  	{ .compatible = "allwinner,sun6i-a31-clock-reset",
> >  		.data = &reset_simple_active_low },
> >  	{ /* sentinel */ },
> > @@ -99,6 +132,7 @@ static int reset_simple_probe(struct platform_device *pdev)
> >  	struct reset_simple_data *data;
> >  	void __iomem *membase;
> >  	struct resource *res;
> > +	u32 reg_offset = 0;
> >  
> >  	devdata = of_device_get_match_data(dev);
> >  
> > @@ -118,8 +152,23 @@ static int reset_simple_probe(struct platform_device *pdev)
> >  	data->rcdev.ops = &reset_simple_ops;
> >  	data->rcdev.of_node = dev->of_node;
> >  
> > -	if (devdata)
> > +	if (devdata) {
> > +		reg_offset = devdata->reg_offset;

And here reg_offset is set to the default of 0x10 on socfpga.

> > +		if (devdata->nr_resets)
> > +			data->rcdev.nr_resets = devdata->nr_resets;
> >  		data->active_low = devdata->active_low;
> > +		data->status_active_low = devdata->status_active_low;
> > +	}
> > +
> > +	if (devdata == &reset_simple_socfpga &&
> 
> Mmh, this pointer comparison looks a bit dodgy. Isn't
> of_device_is_compatible() the right solution here?

My thinking was, the of_device_is_compatible is already called inside
of_device_get_match_data, so why call it again and not reuse the result?

> Also semantically, as?the property is tied to a certain compatible
> string (and not to our data structure)?

I agree with this, though. I'll change this line to say:

+	if (of_device_is_compatible(dev->of_node, "altr,rst-mgr") &&

instead.

> > +	    of_property_read_u32(dev->of_node, "altr,modrst-offset",
> > +		dev_warn(dev,
> > +			 "missing altr,modrst-offset property, assuming 0x%x!\n",
> > +			 reg_offset);
> 
> The existing driver falls back to 0x10 if no explicit property is found.
> Should we copy this here for compatibility reasons? We could simply use:
> "reg_offset = 0x10;" before the dev_warn().

See above.

regards
Philipp
