From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 21 Aug 2017 10:45:18 +0200
Subject: [PATCH v3 2/5] reset: socfpga: use the reset-simple driver
In-Reply-To: <900b3dad-7340-6ad9-d996-d2f0e389bd58@adaptrum.com>
References: <20170816094701.30678-1-p.zabel@pengutronix.de>
 <20170816094701.30678-3-p.zabel@pengutronix.de>
 <900b3dad-7340-6ad9-d996-d2f0e389bd58@adaptrum.com>
Message-ID: <1503305118.8125.8.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-08-16 at 13:46 -0700, Alexandru Gagniuc wrote:
> Hi Phillip,
> 
> On 08/16/2017 02:46 AM, Philipp Zabel wrote:
> [snip]
> > @@ -118,8 +151,23 @@ static int reset_simple_probe(struct
> > platform_device *pdev)
> > ?	data->rcdev.ops = &reset_simple_ops;
> > ?	data->rcdev.of_node = dev->of_node;
> > 
> > -	if (devdata)
> > +	if (devdata) {
> > +		u32 reg_offset = devdata->reg_offset;
> > +
> > +		if (reg_offset &&
> > +		????of_property_read_u32(dev->of_node,
> > "altr,modrst-offset",
> > +					?&reg_offset)) {
> > +			dev_warn(dev,
> > +				?"missing altr,modrst-offset
> > property, assuming 0x%x!\n",
> > +				?reg_offset);
> > +		}
> 
> I would not make reading dt properties dependent on the presence of?
> devdata. That breaks being able to configure the reset controller from?
> dt. I would either just read the "altr,modrst-offset" property, or read?
> it when
> 
> 	of_device_is_compatible(dev->of_node, "altr,rst-mgr"));

Checking the compatible again is unnecessary, we already have obtained
devdata depending on the compatible value. I had effectively the same
check in v2:

	if (devdata == &reset_simple_socfpga)

I can change back to that, if you prefer. Note that the

	if (devdata)
		reg_offset = devdata->reg_offset;

part has to stay now that reg_offset is stored in devdata.

> Ideally, we could have a more generic "reg-offset" binding for new reset?
> controllers, but that is beyond the scope of this patch.

Agreed.

regards
Philipp
