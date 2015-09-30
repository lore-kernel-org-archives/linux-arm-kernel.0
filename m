From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 30 Sep 2015 08:13:49 +0200
Subject: [PATCH 2/3] thermal: Add Mediatek thermal controller support
In-Reply-To: <20150929230438.GB22673@localhost.localdomain>
References: <1443015463-23639-1-git-send-email-s.hauer@pengutronix.de>
 <1443015463-23639-3-git-send-email-s.hauer@pengutronix.de>
 <20150929230438.GB22673@localhost.localdomain>
Message-ID: <20150930061349.GV7858@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eduardo,

On Tue, Sep 29, 2015 at 04:04:40PM -0700, Eduardo Valentin wrote:
> On Wed, Sep 23, 2015 at 03:37:42PM +0200, Sascha Hauer wrote:
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> 
> You dont seam to be using this header. Can you please clean up to have
> only the headers you need?

Ok, did that.

> > +	struct mtk_thermal *mt = bank->mt;
> > +	int temp, i, max;
> > +	u32 raw;
> > +
> > +	temp = max = INT_MIN;
> > +
> > +	for (i = 0; i < bank_data[bank->id].num_sensors; i++) {
> > +		raw = readl(mt->thermal_base + sensing_points[i].msr);
> > +
> > +		temp = raw_to_mcelsius(mt, raw);
> > +
> > +		/*
> > +		 * The first read of a sensor often contains very high bogus
> > +		 * temperature value. Filter these out so that the system does
> > +		 * not immediately shut down.
> > +		 */
> > +		if (temp > 200000)
> 
> Ok... How about after the first read?  is > 200000 a valid (supported) value range?

No, temperatures over 200?C are not supported for this SoC.

> > +
> > +	mt->dev = &pdev->dev;
> > +
> > +	auxadc = of_parse_phandle(np, "mediatek,auxadc", 0);
> of_put?

added

> > +	if (!auxadc) {
> > +		dev_err(&pdev->dev, "missing auxadc node\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	auxadc_phys_base = of_get_phys_base(auxadc);
> > +	if (auxadc_phys_base == OF_BAD_ADDR) {
> > +		dev_err(&pdev->dev, "Can't get auxadc phys address\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	apmixedsys = of_parse_phandle(np, "mediatek,apmixedsys", 0);
> > +	if (!apmixedsys) {
> > +		dev_err(&pdev->dev, "missing apmixedsys node\n");
> > +		return -ENODEV;
> > +	}

For this one aswell.

> > +	/*
> > +	 * These calibration values should finally be provided by the
> > +	 * firmware or fuses. For now use default values.
> > +	 */
> > +	mt->calib_slope = -123;
> > +	mt->calib_offset = 465124;
> 
> I would still prefer that this driver would not have these hardcoded
> values. Specially considering the fact that we could map it in DT for
> instance. What is the impact of using this? Does it work across all chip
> distribution?

I think yes, but not that accurate.

> 
> Should we wait until you have the code to read the fuses before merging
> this?

I'd say we should merge this. It makes the life easier for the guys
writing the cpufreq driver. Adding a dependency on a not yet written
driver IMO only adds unnecessary delays.

> 
> > +
> > +	for (i = 0; i < MT8173_NUM_ZONES; i++)
> > +		mtk_thermal_init_bank(mt, i, apmixed_phys_base, auxadc_phys_base);
> > +
> > +	platform_set_drvdata(pdev, mt);
> > +
> > +	for (i = 0; i < MT8173_NUM_ZONES; i++) {
> > +		struct mtk_thermal_bank *bank = &mt->banks[i];
> > +
> > +		bank->tzd = thermal_zone_of_sensor_register(&pdev->dev, i, bank,
> > +				&mtk_thermal_ops);
> 
> You need to error handle this.

Errors here are pretty much expected. This is due to the behaviour of
thermal_zone_of_sensor_register which errors out when no user for a
sensor is found. Normally I would expect that I can register a sensor
regardless if it is used or not, but that's not how
thermal_zone_of_sensor_register is written.

I could catch -EPROBE_DEFER here, but currently I see no case where this
can actually be returned from thermal_zone_of_sensor_register.

What I can and should do though is to call
thermal_zone_of_sensor_unregister only for sensors that are successfully
registered.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
