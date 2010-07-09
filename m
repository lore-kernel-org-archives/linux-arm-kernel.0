From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 9 Jul 2010 16:19:14 +0300
Subject: [PATCH 2/3] Add s3c-adc-battery driver
In-Reply-To: <20100709125701.GA28316@oksana.dev.rtsoft.ru>
References: <1278674842-17583-1-git-send-email-anarsoul@gmail.com>
	<1278674842-17583-3-git-send-email-anarsoul@gmail.com>
	<20100709125701.GA28316@oksana.dev.rtsoft.ru>
Message-ID: <201007091619.20454.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 9 ???? 2010 15:57:01 ????? Anton Vorontsov ???????:
> Please Cc me on driver/power/* patches, it's pure luck that I
> noticed this patch.

Ok, I'll do :)

> > + * drivers/power/s3c_adc_battery.c
> 
> This line isn't needed. You'd better move the
> "iPAQ h1930/h1940/rx1950 battery controler driver" line here.

Ok

> #include <linux/init.h> for __init
> #include <linux/errno.h> for E-codes

init is not necessary, but errno is, I'm using some error codes (-EINVAL) in 
driver

> > +#include <linux/interrupt.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/power_supply.h>
> > +#include <linux/leds.h>
> > +#include <linux/gpio.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> 
> Do you really need io.h?

Will check.

> > +#include <linux/timer.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/s3c_adc_battery.h>
> > +
> > +#include <asm/irq.h>
> 
> Is this really needed?

asm/irq.h is not necessary

> > +#include <mach/regs-gpio.h>
> > +#include <mach/regs-gpioj.h>
> 
> Not linux/gpio.h?

Will remove it

> > +static int s3c_adc_ac_get_property(struct power_supply *psy,
> > +				enum power_supply_property psp,
> > +				union power_supply_propval *val);
> 
> Please avoid forward declarations where possible.

Ok
 
> > +static char *s3c_adc_supplied_to[] = {
> > +	"main-battery",
> > +};
> > +
> > +static enum power_supply_property s3c_adc_ac_props[] = {
> > +	POWER_SUPPLY_PROP_ONLINE,
> > +};
> > +
> > +static struct power_supply s3c_adc_ac = {
> > +	.name = "ac",
> > +	.type = POWER_SUPPLY_TYPE_MAINS,
> > +	.supplied_to = s3c_adc_supplied_to,
> > +	.num_supplicants = ARRAY_SIZE(s3c_adc_supplied_to),
> > +	.properties = s3c_adc_ac_props,
> > +	.num_properties = ARRAY_SIZE(s3c_adc_ac_props),
> > +	.get_property = s3c_adc_ac_get_property,
> > +};
> 
> You really shouldn't create yet another "ac" power supply
> instance. You can use drivers/power/pda_power.c for this.
> 
> Yep, it's duplication of pda_power.c functionality.
> 
> So, you probably want to register S3C ADC battery and pda-power
> platform devices. And S3C ADC battery driver would only do
> battery stuff, and pda-power would do the AC stuff.

Nope, I can't use pda_power here, as it can't control whether battery is 
already charged (it's separate gpio pin, and I need to disable charger in this 
case)

> > +	if (!bat) {
> > +		printk(KERN_ERR "%s: no battery infos ?!\n", __func__);
> 
> dev_err()

Ok

> > +	printk(KERN_INFO "Power cable %s\n",\
> > +			is_plugged ? "plugged" : "unplugged");
> 
> dev_info()

Ok

> ?
> 
> We have a generic charge triggers, see
> drivers/power/power_supply_leds.c, so you probably don't need this.

Ok

> > +static int s3c_adc_bat_get_property(struct power_supply *psy,
> > +				enum power_supply_property psp,
> > +				union power_supply_propval *val)
> > +{
> > +	struct s3c_adc_bat *bat = container_of(psy, struct s3c_adc_bat, psy);
> > +	static int volt_value = -1, cur_value = -1;
> 
> I don't think that using static variables here is safe. Why
> you need them? There must be a better way.

Need them to cache voltage and current values (to prevent spamming adc), 
however I should move them to s3c_adc_bat struct.

> > +	static unsigned int timestamp;
> > +	static int level = 1000000;
> > +
> 
> No need for this empty line.
>
Ok

> > +	int status = POWER_SUPPLY_STATUS_DISCHARGING, new_level, full_volt;
> 
> Each declaration on it own line please, e.g.
> 
> int status = ...;
> int new_level;
> int full_volt;

Ok

> > +			lut_volt1 = calc_full_volt(lut[0].volt, lut[0].cur);
> > +			lut_volt2 = calc_full_volt(lut[1].volt, lut[1].cur);
> > +			if (full_volt < lut_volt1 && full_volt >= lut_volt2) {
> > +				new_level = (lut[1].level +
> > +					(lut[0].level - lut[1].level) *
> > +					(full_volt - lut_volt2) /
> > +					(lut_volt1 - lut_volt2)) * 1000;
> > +				break;
> > +			}
> > +			new_level = lut[1].level * 1000;
> > +			lut++;
> > +		}
> > +	}
> 
> Cool!

Is it some kind of sarcasm? :)

> > +#if 0
> 
> Do you really need this dead code?

Nope, I'll remove it.

> 
> You probably don't need a timer for this.
> Use schedule_work() instead.

Timer's used to prevet jitter on gpio pins, and here it's used to check pins 
state on startup. I don't see any reason to replace it with delayed work.

Thanks for review!

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100709/34e2210c/attachment.sig>
