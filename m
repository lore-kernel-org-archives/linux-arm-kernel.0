From: bonbons@linux-vserver.org (Bruno =?UTF-8?B?UHLDqW1vbnQ=?=)
Date: Wed, 22 Oct 2014 08:30:13 +0200
Subject: [RFC Patch 2/4] mfd: AXP20x: Add power supply sub-driver
In-Reply-To: <20141021202715.GC7893@lukather>
References: <20141020221959.2f312906@neptune.home>
 <20141020223320.2b4ecba9@neptune.home>
 <20141021202715.GC7893@lukather>
Message-ID: <20141022083013.6b90be7e@pluto.restena.lu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Oct 2014 22:27:15 +0200 Maxime Ripard wrote:
> On Mon, Oct 20, 2014 at 10:33:20PM +0200, Bruno Pr?mont wrote:
> > Add driver for the power supply features of AXP20x PMIC.
> > 
> > Covered features:
> >  - backup / RTC battery
> >  - VBUS/OTG power input
> >  - AC power input
> >  - LIon battery charger
> 
> Missing Signed-off-by

Oops, forgot that when splitting the original patch
into multiple parts.

> > ---
> >  drivers/mfd/axp20x.c                             |  106 +-
> >  drivers/power/Kconfig                            |    9 +
> >  drivers/power/Makefile                           |    1 +
> >  drivers/power/axp20x_power.c                     | 1530 ++++++++++++++++++++++
> >  include/linux/mfd/axp20x.h                       |    5 +
> >  5 files changed, 1650 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/power/axp20x_power.c
> > 
> > diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> > index dee6539..1322489 100644
> > --- a/drivers/mfd/axp20x.c
> > +++ b/drivers/mfd/axp20x.c
> > @@ -31,10 +31,16 @@
> >  static const struct regmap_range axp20x_writeable_ranges[] = {
> >  	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
> >  	regmap_reg_range(AXP20X_DCDC_MODE, AXP20X_FG_RES),
> > +	regmap_reg_range(AXP20X_OCV(0), AXP20X_OCV(15)),
> >  };
> >  
> >  static const struct regmap_range axp20x_volatile_ranges[] = {
> > +	regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_USB_OTG_STATUS),
> > +	regmap_reg_range(AXP20X_CHRG_CTRL1, AXP20X_CHRG_CTRL2),
> >  	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
> > +	regmap_reg_range(AXP20X_ACIN_V_ADC_H, AXP20X_IPSOUT_V_HIGH_L),
> > +	regmap_reg_range(AXP20X_GPIO20_SS, AXP20X_GPIO3_CTRL),
> > +	regmap_reg_range(AXP20X_FG_RES, AXP20X_RDC_L),
> >  };
> >  
> >  static const struct regmap_access_table axp20x_writeable_table = {
> > @@ -61,12 +67,106 @@ static struct resource axp20x_pek_resources[] = {
> >  	},
> >  };
> >  
> > +static struct resource axp20x_power_resources[] = {
> > +	{
> > +		.name	= "ACIN_OVER_V",
> > +		.start	= AXP20X_IRQ_ACIN_OVER_V,
> > +		.end	= AXP20X_IRQ_ACIN_OVER_V,
> > +		.flags	= IORESOURCE_IRQ,
> > +	}, {
> > +		.name	= "ACIN_PLUGIN",
> > +		.start	= AXP20X_IRQ_ACIN_PLUGIN,
> > +		.end	= AXP20X_IRQ_ACIN_PLUGIN,
> > +		.flags	= IORESOURCE_IRQ,
> > +	}, {
> > +		.name	= "ACIN_REMOVAL",
> > +		.start	= AXP20X_IRQ_ACIN_REMOVAL,
> > +		.end	= AXP20X_IRQ_ACIN_REMOVAL,
> > +		.flags	= IORESOURCE_IRQ,
> > +	}, {
> > +		.name	= "VBUS_OVER_V",
> > +		.start	= AXP20X_IRQ_VBUS_OVER_V,
> > +		.end	= AXP20X_IRQ_VBUS_OVER_V,
> > +		.flags	= IORESOURCE_IRQ,
> > +	}, {
> > +		.name	= "VBUS_PLUGIN",
> > +		.start	= AXP20X_IRQ_VBUS_PLUGIN,
> > +		.end	= AXP20X_IRQ_VBUS_PLUGIN,
> > +		.flags	= IORESOURCE_IRQ,
> > +	}, {
> > +		.name	= "VBUS_REMOVAL",
> > +		.start	= AXP20X_IRQ_VBUS_REMOVAL,
> > +		.end	= AXP20X_IRQ_VBUS_REMOVAL,
> > +		.flags	= IORESOURCE_IRQ,
> > +	}, {
> > +		.name	= "VBUS_V_LOW",
> > +		.start	= AXP20X_IRQ_VBUS_V_LOW,
> > +		.end	= AXP20X_IRQ_VBUS_V_LOW,
> > +		.flags	= IORESOURCE_IRQ,
> > +	}, {
> > +		.name	= "BATT_PLUGIN",
> > +		.start	= AXP20X_IRQ_BATT_PLUGIN,
> > +		.end	= AXP20X_IRQ_BATT_PLUGIN,
> > +		.flags	= IORESOURCE_IRQ,
> > +	}, {
> > +		.name	= "BATT_REMOVAL",
> > +		.start	= AXP20X_IRQ_BATT_REMOVAL,
> > +		.end	= AXP20X_IRQ_BATT_REMOVAL,
> > +		.flags	= IORESOURCE_IRQ,
> > +	}, {
> > +		.name	= "BATT_ACTIVATE",
> > +		.start	= AXP20X_IRQ_BATT_ENT_ACT_MODE,
> > +		.end	= AXP20X_IRQ_BATT_ENT_ACT_MODE,
> > +		.flags	= IORESOURCE_IRQ,
> > +	}, {
> > +		.name	= "BATT_ACTIVATED",
> > +		.start	= AXP20X_IRQ_BATT_EXIT_ACT_MODE,
> > +		.end	= AXP20X_IRQ_BATT_EXIT_ACT_MODE,
> > +		.flags	= IORESOURCE_IRQ,
> > +	}, {
> > +		.name	= "BATT_CHARGING",
> > +		.start	= AXP20X_IRQ_CHARG,
> > +		.end	= AXP20X_IRQ_CHARG,
> > +		.flags	= IORESOURCE_IRQ,
> > +	}, {
> > +		.name	= "BATT_CHARGED",
> > +		.start	= AXP20X_IRQ_CHARG_DONE,
> > +		.end	= AXP20X_IRQ_CHARG_DONE,
> > +		.flags	= IORESOURCE_IRQ,
> > +	}, {
> > +		.name	= "BATT_HOT",
> > +		.start	= AXP20X_IRQ_BATT_TEMP_HIGH,
> > +		.end	= AXP20X_IRQ_BATT_TEMP_HIGH,
> > +		.flags	= IORESOURCE_IRQ,
> > +	}, {
> > +		.name	= "BATT_COLD",
> > +		.start	= AXP20X_IRQ_BATT_TEMP_LOW,
> > +		.end	= AXP20X_IRQ_BATT_TEMP_LOW,
> > +		.flags	= IORESOURCE_IRQ,
> > +	}, {
> > +		.name	= "BATT_CHG_CURR_LOW",
> > +		.start	= AXP20X_IRQ_CHARG_I_LOW,
> > +		.end	= AXP20X_IRQ_CHARG_I_LOW,
> > +		.flags	= IORESOURCE_IRQ,
> > +	}, {
> > +		.name	= "POWER_LOW_WARN",
> > +		.start	= AXP20X_IRQ_LOW_PWR_LVL1,
> > +		.end	= AXP20X_IRQ_LOW_PWR_LVL1,
> > +		.flags	= IORESOURCE_IRQ,
> > +	}, {
> > +		.name	= "POWER_LOW_CRIT",
> > +		.start	= AXP20X_IRQ_LOW_PWR_LVL2,
> > +		.end	= AXP20X_IRQ_LOW_PWR_LVL2,
> > +		.flags	= IORESOURCE_IRQ,
> > +	},
> > +};
> > +
> >  static const struct regmap_config axp20x_regmap_config = {
> >  	.reg_bits	= 8,
> >  	.val_bits	= 8,
> >  	.wr_table	= &axp20x_writeable_table,
> >  	.volatile_table	= &axp20x_volatile_table,
> > -	.max_register	= AXP20X_FG_RES,
> > +	.max_register	= AXP20X_OCV(15),
> >  	.cache_type	= REGCACHE_RBTREE,
> >  };
> >  
> > @@ -158,6 +258,10 @@ static struct mfd_cell axp20x_cells[] = {
> >  		.name			= "axp20x-regulator",
> >  		.parent_supplies	= axp20x_supplies,
> >  		.num_parent_supplies	= ARRAY_SIZE(axp20x_supplies),
> > +	}, {
> > +		.name			= "axp20x-power",
> > +		.num_resources		= ARRAY_SIZE(axp20x_power_resources),
> > +		.resources		= axp20x_power_resources,
> >  	},
> >  };
> >  
> > diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> > index 73cfcdf..209d677 100644
> > --- a/drivers/power/Kconfig
> > +++ b/drivers/power/Kconfig
> > @@ -396,6 +396,15 @@ config BATTERY_GOLDFISH
> >  	  Say Y to enable support for the battery and AC power in the
> >  	  Goldfish emulator.
> >  
> > +config AXP20X_POWER
> > +	tristate "AXP20x power supply driver"
> > +	depends on MFD_AXP20X
> > +	help
> > +	  This driver provides support for the power supply features of
> > +	  AXP20x PMIC.
> > +	  Included features are: AC-power, USB-power, Battery charger
> > +	  (RTC backup-battery and Lithium main bettery).
> > +
> >  source "drivers/power/reset/Kconfig"
> 
> This patch should be splitted in two, one to add the new resources,
> the other one to add the new driver.

Ok

> >  endif # POWER_SUPPLY
> > diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> > index dfa8942..ab2324f 100644
> > --- a/drivers/power/Makefile
> > +++ b/drivers/power/Makefile
> > @@ -9,6 +9,7 @@ obj-$(CONFIG_GENERIC_ADC_BATTERY)	+= generic-adc-battery.o
> >  
> >  obj-$(CONFIG_PDA_POWER)		+= pda_power.o
> >  obj-$(CONFIG_APM_POWER)		+= apm_power.o
> > +obj-$(CONFIG_AXP20X_POWER)	+= axp20x_power.o
> >  obj-$(CONFIG_MAX8925_POWER)	+= max8925_power.o
> >  obj-$(CONFIG_WM831X_BACKUP)	+= wm831x_backup.o
> >  obj-$(CONFIG_WM831X_POWER)	+= wm831x_power.o
> > diff --git a/drivers/power/axp20x_power.c b/drivers/power/axp20x_power.c
> > new file mode 100644
> > index 0000000..9d6b8bc
> > --- /dev/null
> > +++ b/drivers/power/axp20x_power.c
> > @@ -0,0 +1,1530 @@
> > +/*
> > + * AC power input driver for X-Powers AXP20x PMICs
> > + *
> > + * Copyright 2014 Bruno Pr?mont <bonbons@linux-vserver.org>
> > + *
> > + * This file is subject to the terms and conditions of the GNU General
> > + * Public License. See the file "COPYING" in the main directory of this
> > + * archive for more details.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/power_supply.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
> > +#include <linux/time.h>
> > +#include <linux/mfd/axp20x.h>
> > +
> > +struct axp20x_power {
> > +	struct axp20x_dev *axp20x;
> > +	/* RTC / Backup battery */
> > +	struct power_supply backup;
> > +	char backup_name[24];
> > +	/* ACIN power supply */
> > +	struct power_supply ac;
> > +	char ac_name[24];
> > +	/* VBUS/OTG power supply */
> > +	struct power_supply vbus;
> > +	char vbus_name[24];
> > +	/* Battery charger */
> > +	struct power_supply battery;
> > +	char battery_name[24];
> > +	char *battery_supplies[2];
> > +	/* AXP state tracking */
> > +	struct work_struct work;
> > +	spinlock_t lock;
> > +	struct timespec next_check;
> > +	uint8_t status1;
> > +	uint8_t status2;
> > +	uint8_t vbusmgt;
> > +	int vvbus;
> > +	int ivbus;
> > +	int vac;
> > +	int iac;
> > +	int vbatt;
> > +	int ibatt;
> > +	int pbatt;
> > +	int tbatt;
> > +	int tbatt_min;
> > +	int tbatt_max;
> > +	int batt_percent;
> > +	int batt_capacity;
> > +	int batt_health;
> > +	int batt_user_imax;
> > +};
> > +
> > +/* Fields of AXP20X_PWR_INPUT_STATUS */
> > +#define AXP20X_PWR_STATUS_AC_PRESENT     (1 << 7)
> > +#define AXP20X_PWR_STATUS_AC_AVAILABLE   (1 << 6)
> > +#define AXP20X_PWR_STATUS_VBUS_PRESENT   (1 << 5)
> > +#define AXP20X_PWR_STATUS_VBUS_AVAILABLE (1 << 4)
> > +#define AXP20X_PWR_STATUS_VBUS_VHOLD     (1 << 3)
> > +#define AXP20X_PWR_STATUS_BAT_CHARGING   (1 << 2)
> > +#define AXP20X_PWR_STATUS_AC_VBUS_SHORT  (1 << 1)
> > +#define AXP20X_PWR_STATUS_AC_VBUS_SEL    (1 << 0)
> > +
> > +/* Fields of AXP20X_PWR_OP_MODE */
> > +#define AXP20X_PWR_OP_OVERTEMP             (1 << 7)
> > +#define AXP20X_PWR_OP_CHARGING             (1 << 6)
> > +#define AXP20X_PWR_OP_BATT_PRESENT         (1 << 5)
> > +#define AXP20X_PWR_OP_BATT_ACTIVATED       (1 << 3)
> > +#define AXP20X_PWR_OP_BATT_CHG_CURRENT_LOW (1 << 2)
> > +
> > +/* Fields of AXP20X_ADC_EN1 */
> > +#define AXP20X_ADC_EN1_BATT_V (1 << 7)
> > +#define AXP20X_ADC_EN1_BATT_C (1 << 6)
> > +#define AXP20X_ADC_EN1_ACIN_V (1 << 5)
> > +#define AXP20X_ADC_EN1_ACIN_C (1 << 4)
> > +#define AXP20X_ADC_EN1_VBUS_V (1 << 3)
> > +#define AXP20X_ADC_EN1_VBUS_C (1 << 2)
> > +#define AXP20X_ADC_EN1_APS_V  (1 << 1)
> > +#define AXP20X_ADC_EN1_TEMP   (1 << 0)
> > +
> > +/* Fields of AXP20X_ADC_RATE */
> > +#define AXP20X_ADR_RATE_MASK    (3 << 6)
> > +#define AXP20X_ADR_RATE_25Hz    (0 << 6)
> > +#define AXP20X_ADR_RATE_50Hz    (1 << 6)
> > +#define AXP20X_ADR_RATE_100Hz   (2 << 6)
> > +#define AXP20X_ADR_RATE_200Hz   (3 << 6)
> > +#define AXP20X_ADR_TS_CURR_MASK (3 << 4)
> > +#define AXP20X_ADR_TS_CURR_20uA (0 << 4)
> > +#define AXP20X_ADR_TS_CURR_40uA (1 << 4)
> > +#define AXP20X_ADR_TS_CURR_60uA (2 << 4)
> > +#define AXP20X_ADR_TS_CURR_80uA (3 << 4)
> > +#define AXP20X_ADR_TS_UNRELATED (1 << 2)
> > +#define AXP20X_ADR_TS_WHEN_MASK (3 << 0)
> > +#define AXP20X_ADR_TS_WHEN_OFF  (0 << 0)
> > +#define AXP20X_ADR_TS_WHEN_CHG  (1 << 0)
> > +#define AXP20X_ADR_TS_WHEN_ADC  (2 << 0)
> > +#define AXP20X_ADR_TS_WHEN_ON   (3 << 0)
> > +
> > +/* Fields of AXP20X_VBUS_IPSOUT_MGMT */
> > +#define AXP20X_VBUS_VHOLD_MASK   (7 << 3)
> > +#define AXP20X_VBUS_VHOLD_mV(b)  (4000000 + (((b) >> 3) & 7) * 100000)
> > +#define AXP20X_VBUS_CLIMIT_MASK  (3)
> > +#define AXP20X_VBUC_CLIMIT_900mA (0)
> > +#define AXP20X_VBUC_CLIMIT_500mA (1)
> > +#define AXP20X_VBUC_CLIMIT_100mA (2)
> > +#define AXP20X_VBUC_CLIMIT_NONE  (3)
> > +
> > +/* Fields of AXP20X_OFF_CTRL */
> > +#define AXP20X_OFF_CTRL_BATT_MON    (1 << 6)
> > +#define AXP20X_OFF_CTRL_CHGLED_MASK (3 << 4)
> > +#define AXP20X_OFF_CTRL_CHGLED_HR   (0 << 4)
> > +#define AXP20X_OFF_CTRL_CHGLED_1Hz  (1 << 4)
> > +#define AXP20X_OFF_CTRL_CHGLED_4Hz  (2 << 4)
> > +#define AXP20X_OFF_CTRL_CHGLED_LOW  (3 << 4)
> > +#define AXP20X_OFF_CTRL_CHGLED_FIX  (1 << 3)
> > +/* Fields of AXP20X_CHRG_CTRL1 */
> > +#define AXP20X_CHRG_CTRL1_ENABLE    (1 << 7)
> > +#define AXP20X_CHRG_CTRL1_TGT_VOLT  (3 << 5)
> > +#define AXP20X_CHRG_CTRL1_TGT_4_1V  (0 << 5)
> > +#define AXP20X_CHRG_CTRL1_TGT_4_15V (1 << 5)
> > +#define AXP20X_CHRG_CTRL1_TGT_4_2V  (2 << 5)
> > +#define AXP20X_CHRG_CTRL1_TGT_4_36V (3 << 5)
> > +#define AXP20X_CHRG_CTRL1_END_CURR  (1 << 4)
> > +#define AXP20X_CHRG_CTRL1_TGT_CURR  0x0f
> > +/* Fields of AXP20X_CHRG_CTRL2 */
> > +#define AXP20X_CHRG_CTRL2_PRE_MASK  (3 << 6)
> > +#define AXP20X_CHRG_CTRL2_PRE_40MIN (0 << 6)
> > +#define AXP20X_CHRG_CTRL2_PRE_50MIN (1 << 6)
> > +#define AXP20X_CHRG_CTRL2_PRE_60MIN (2 << 6)
> > +#define AXP20X_CHRG_CTRL2_PRE_70MIN (3 << 6)
> > +#define AXP20X_CHRG_CTRL2_CHGLED_FL (1 << 4)
> > +#define AXP20X_CHRG_CTRL2_CHG_MASK  (0 << 6)
> > +#define AXP20X_CHRG_CTRL2_CHG_6H    (0 << 0)
> > +#define AXP20X_CHRG_CTRL2_CHG_8H    (1 << 0)
> > +#define AXP20X_CHRG_CTRL2_CHG_10H   (2 << 6)
> > +#define AXP20X_CHRG_CTRL2_CHG_12H   (3 << 0)
> > +/* Fields of AXP20X_FG_RES */
> > +#define AXP20X_FG_ENABLE   (1 << 7)
> > +#define AXP20X_FG_PERCENT  (0x7f)
> 
> I guess these should be defined together with the registers.

I can do. I included them here as Carlo did for the PEK input driver
from which series I referenced the bindings documentation patch.

> > +
> > +static int axp20x_power_poll(struct axp20x_power *devdata, int init)
> > +{
> > +	struct axp20x_dev *axp20x = devdata->axp20x;
> > +	struct timespec ts;
> > +	int ret, status1, status2, vbusmgt, adc_cfg, bpercent;
> > +	uint8_t adc[19];
> > +
> > +	getnstimeofday(&ts);
> > +	/* only query hardware if our data is stale */
> 
> Is it called that often?

Pretty often yes.
When accessing /sys/class/power_supply/*/uevent it's one call per
property, for the property specific sysfs files its one per file read.

Notifying power_supply subsystem about changes also triggers one access
per defined property.

Initially I tried without caching data and it caused quite severe
latencies (would have to redo the tests for proper quantifying).

I looked at regmap's caching feature but it seems not possible to tell
it to flush (part of) its cache.

> > +	spin_lock(&devdata->lock);
> > +	if (!init && !(ts.tv_sec > devdata->next_check.tv_sec ||
> > +	               ts.tv_nsec > devdata->next_check.tv_sec)) {
> > +		spin_unlock(&devdata->lock);
> > +		return 0;
> > +	}
> > +	spin_unlock(&devdata->lock);
> > +
> > +	ret = regmap_read(axp20x->regmap, AXP20X_PWR_INPUT_STATUS, &status1);
> > +	if (ret)
> > +		return ret;
> > +	ret = regmap_read(axp20x->regmap, AXP20X_PWR_OP_MODE, &status2);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_read(axp20x->regmap, AXP20X_ADC_RATE, &adc_cfg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (init == 2) {
> > +		int reg = AXP20X_ADC_EN1_VBUS_V | AXP20X_ADC_EN1_VBUS_C;
> > +
> > +		if (!(status1 & AXP20X_PWR_STATUS_AC_VBUS_SHORT))
> > +			reg |= AXP20X_ADC_EN1_ACIN_V | AXP20X_ADC_EN1_ACIN_C;
> > +		if (devdata->battery_name[0])
> > +			reg |= AXP20X_ADC_EN1_BATT_V | AXP20X_ADC_EN1_BATT_C;
> > +		if (devdata->battery_name[0] &&
> > +		    !(adc_cfg & AXP20X_ADR_TS_UNRELATED))
> > +			reg |= AXP20X_ADC_EN1_TEMP;
> > +
> > +		regmap_update_bits(axp20x->regmap, AXP20X_ADC_EN1,
> > +			AXP20X_ADC_EN1_ACIN_V | AXP20X_ADC_EN1_ACIN_C |
> > +			AXP20X_ADC_EN1_VBUS_V | AXP20X_ADC_EN1_VBUS_C |
> > +			AXP20X_ADC_EN1_BATT_V | AXP20X_ADC_EN1_BATT_C |
> > +			AXP20X_ADC_EN1_TEMP, reg);
> > +	}
> > +
> > +	ret = regmap_read(axp20x->regmap, AXP20X_VBUS_IPSOUT_MGMT, &vbusmgt);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_bulk_read(axp20x->regmap, AXP20X_ACIN_V_ADC_H, adc, 8);
> > +	if (ret)
> > +		return ret;
> > +	if (devdata->battery_name[0] && !(adc_cfg & AXP20X_ADR_TS_UNRELATED)) {
> > +		ret = regmap_bulk_read(axp20x->regmap, AXP20X_TS_IN_H, adc+8, 2);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +	if (devdata->battery_name[0]) {
> > +		ret = regmap_bulk_read(axp20x->regmap, AXP20X_PWR_BATT_H, adc+10, 3);
> > +		if (ret)
> > +			return ret;
> > +		ret = regmap_bulk_read(axp20x->regmap, AXP20X_BATT_V_H, adc+13, 6);
> > +		if (ret)
> > +			return ret;
> > +		ret = regmap_read(axp20x->regmap, AXP20X_FG_RES, &bpercent);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	switch (adc_cfg & AXP20X_ADR_RATE_MASK) {
> > +	case AXP20X_ADR_RATE_200Hz:
> > +		timespec_add_ns(&ts,  5000000); break;
> > +	case AXP20X_ADR_RATE_100Hz:
> > +		timespec_add_ns(&ts, 10000000); break;
> > +	case AXP20X_ADR_RATE_50Hz:
> > +		timespec_add_ns(&ts, 20000000); break;
> > +	case AXP20X_ADR_RATE_25Hz:
> > +	default:
> > +		timespec_add_ns(&ts, 40000000);
> > +	}
> > +
> > +	ret = devdata->status1 | (devdata->status2 << 8) |
> > +	      ((devdata->batt_percent & 0x7f) << 16);
> > +	if (init == 2)
> > +		timespec_add_ns(&ts, 200000000);
> > +	spin_lock(&devdata->lock);
> > +	devdata->vac        = ((adc[0] << 4) | (adc[1] & 0x0f)) * 1700;
> > +	devdata->iac        = ((adc[2] << 4) | (adc[3] & 0x0f)) * 625;
> > +	devdata->vvbus      = ((adc[4] << 4) | (adc[5] & 0x0f)) * 1700;
> > +	devdata->ivbus      = ((adc[6] << 4) | (adc[7] & 0x0f)) * 375;
> > +	devdata->next_check = ts;
> > +	devdata->vbusmgt    = vbusmgt;
> > +	devdata->status1    = status1;
> > +	devdata->status2    = status2;
> > +	if (devdata->battery_name[0] && !(adc_cfg & AXP20X_ADR_TS_UNRELATED))
> > +		devdata->tbatt = ((adc[8] << 4) | (adc[9] & 0x0f)) * 800;
> > +	if (devdata->battery_name[0]) {
> > +		devdata->vbatt = ((adc[13] << 4) | (adc[14] & 0x0f)) * 1100;
> > +		if (status1 & AXP20X_PWR_STATUS_BAT_CHARGING)
> > +			devdata->ibatt = ((adc[15] << 4) | (adc[16] & 0x0f));
> > +		else
> > +			devdata->ibatt = ((adc[17] << 4) | (adc[18] & 0x0f));
> > +		devdata->ibatt *= 500;
> > +		devdata->pbatt = ((adc[10] << 16) | (adc[11] << 8) | adc[12]) *
> > +				 55 / 100;
> > +		devdata->batt_percent = bpercent & 0x7f;
> > +	}
> > +	spin_unlock(&devdata->lock);
> > +
> > +	if (init == 2 || init == 0)
> > +		return 0;
> > +
> > +	if ((ret ^ status1) & (AXP20X_PWR_STATUS_VBUS_PRESENT |
> > +			       AXP20X_PWR_STATUS_VBUS_AVAILABLE))
> > +		power_supply_changed(&devdata->vbus);
> > +	if (devdata->ac_name[0]) {
> > +	} else if ((ret ^ status1) & (AXP20X_PWR_STATUS_AC_PRESENT |
> > +				     AXP20X_PWR_STATUS_AC_AVAILABLE))
> > +		power_supply_changed(&devdata->ac);
> > +	if (!devdata->battery_name[0]) {
> > +	} else if ((ret ^ status1) & AXP20X_PWR_STATUS_BAT_CHARGING) {
> > +		power_supply_changed(&devdata->battery);
> > +	} else if (((ret >> 8) ^ status2) & (AXP20X_PWR_OP_CHARGING |
> > +		   AXP20X_PWR_OP_BATT_PRESENT | AXP20X_PWR_OP_BATT_ACTIVATED |
> > +		   AXP20X_PWR_OP_BATT_CHG_CURRENT_LOW)) {
> > +		power_supply_changed(&devdata->battery);
> > +	} else if (((ret >> 16) & 0x7f) != (bpercent & 0x7f)) {
> > +		power_supply_changed(&devdata->battery);
> > +	}
> > +	return 0;
> > +}
> > +
> > +static void axp20x_power_monitor(struct work_struct *work)
> > +{
> > +	struct axp20x_power *devdata = container_of(work,
> > +					struct axp20x_power, work);
> > +
> > +	axp20x_power_poll(devdata, 1);
> > +
> > +	/* TODO: check status for consitency
> > +	 *       adjust battery charging parameters as needed
> > +	 */
> > +}
> > +
> > +/* ********************************************** *
> > + * ***  RTC / Backup battery charger          *** *
> > + * ********************************************** */
> > +
> > +/* Fields of AXP20X_CHRG_BAK_CTRL */
> > +#define AXP20X_BACKUP_ENABLE         (0x01 << 7)
> > +#define AXP20X_BACKUP_VOLTAGE_MASK   (0x03 << 5)
> > +#define AXP20X_BACKUP_VOLTAGE_3_1V   (0x00 << 5)
> > +#define AXP20X_BACKUP_VOLTAGE_3_0V   (0x01 << 5)
> > +#define AXP20X_BACKUP_VOLTAGE_3_6V   (0x02 << 5)
> > +#define AXP20X_BACKUP_VOLTAGE_2_5V   (0x03 << 5)
> > +#define AXP20X_BACKUP_CURRENT_MASK   0x03
> > +#define AXP20X_BACKUP_CURRENT_50uA   0x00
> > +#define AXP20X_BACKUP_CURRENT_100uA  0x01
> > +#define AXP20X_BACKUP_CURRENT_200uA  0x02
> > +#define AXP20X_BACKUP_CURRENT_400uA  0x03
> > +
> > +static int axp20x_backup_config(struct platform_device *pdev,
> > +				struct axp20x_dev *axp20x)
> > +{
> > +	struct device_node *np;
> > +	int ret = 0, reg, new_reg = 0;
> > +	u32 lim[2];
> > +
> > +	ret = regmap_read(axp20x->regmap, AXP20X_CHRG_BAK_CTRL, &reg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	np = of_node_get(axp20x->dev->of_node);
> > +	if (!np)
> > +		return -ENODEV;
> > +
> > +	ret = of_property_read_u32_array(np, "backup", lim, 2);
> > +	if (ret != 0)
> > +		goto err;
> > +
> > +	switch (lim[0]) {
> > +	case 2500000:
> > +		new_reg |= AXP20X_BACKUP_VOLTAGE_2_5V;
> > +		break;
> > +	case 3000000:
> > +		new_reg |= AXP20X_BACKUP_VOLTAGE_3_0V;
> > +		break;
> > +	case 3100000:
> > +		new_reg |= AXP20X_BACKUP_VOLTAGE_3_1V;
> > +		break;
> > +	case 3600000:
> > +		new_reg |= AXP20X_BACKUP_VOLTAGE_3_6V;
> > +		break;
> > +	default:
> > +		dev_warn(&pdev->dev, "Invalid backup DT voltage limit %u\n", lim[0]);
> > +		ret = -EINVAL;
> > +		goto err;
> > +	}
> > +	switch (lim[1]) {
> > +	case 50:
> > +		new_reg |= AXP20X_BACKUP_CURRENT_50uA;
> > +		break;
> > +	case 100:
> > +		new_reg |= AXP20X_BACKUP_CURRENT_100uA;
> > +		break;
> > +	case 200:
> > +		new_reg |= AXP20X_BACKUP_CURRENT_200uA;
> > +		break;
> > +	case 400:
> > +		new_reg |= AXP20X_BACKUP_CURRENT_400uA;
> > +		break;
> > +	default:
> > +		dev_warn(&pdev->dev, "Invalid backup DT current limit %u\n", lim[1]);
> > +		ret = -EINVAL;
> > +		goto err;
> > +	}
> > +	new_reg |= AXP20X_BACKUP_ENABLE;
> > +
> > +	ret = regmap_update_bits(axp20x->regmap, AXP20X_CHRG_BAK_CTRL,
> > +			AXP20X_BACKUP_ENABLE | AXP20X_BACKUP_VOLTAGE_MASK |
> > +			AXP20X_BACKUP_CURRENT_MASK, new_reg);
> > +	if (ret)
> > +		dev_warn(&pdev->dev, "Failed to adjust backup battery settings: %d\n", ret);
> > +
> > +err:
> > +	of_node_put(np);
> > +	return ret;
> > +}
> > +
> > +static int axp20x_backup_get_prop(struct power_supply *psy,
> > +				  enum power_supply_property psp,
> > +				  union power_supply_propval *val)
> > +{
> > +	struct axp20x_power *devdata = dev_get_drvdata(psy->dev->parent);
> > +	int ret = 0, reg;
> > +
> > +	ret = regmap_read(devdata->axp20x->regmap, AXP20X_CHRG_BAK_CTRL, &reg);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	switch (psp)  {
> > +	case POWER_SUPPLY_PROP_STATUS:
> > +		if ((reg & AXP20X_BACKUP_ENABLE))
> > +			val->intval = POWER_SUPPLY_STATUS_CHARGING;
> > +		else
> > +			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> > +		break;
> > +
> > +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> > +		switch ((reg & AXP20X_BACKUP_VOLTAGE_MASK)) {
> > +		case AXP20X_BACKUP_VOLTAGE_2_5V:
> > +			val->intval = 2500000; break;
> > +		case AXP20X_BACKUP_VOLTAGE_3_0V:
> > +			val->intval = 3000000; break;
> > +		case AXP20X_BACKUP_VOLTAGE_3_1V:
> > +			val->intval = 3100000; break;
> > +		case AXP20X_BACKUP_VOLTAGE_3_6V:
> > +			val->intval = 3600000; break;
> > +		default:
> > +			val->intval = 0;
> > +		}
> > +		break;
> > +
> > +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> > +		switch ((reg & AXP20X_BACKUP_CURRENT_MASK)) {
> > +		case AXP20X_BACKUP_CURRENT_50uA:
> > +			val->intval = 50; break;
> > +		case AXP20X_BACKUP_CURRENT_100uA:
> > +			val->intval = 100; break;
> > +		case AXP20X_BACKUP_CURRENT_200uA:
> > +			val->intval = 200; break;
> > +		case AXP20X_BACKUP_CURRENT_400uA:
> > +			val->intval = 400; break;
> > +		default:
> > +			val->intval = 0;
> > +		}
> > +		break;
> > +
> > +	default:
> > +		ret = -EINVAL;
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int axp20x_backup_set_prop(struct power_supply *psy,
> > +				  enum power_supply_property psp,
> > +				  const union power_supply_propval *val)
> > +{
> > +	struct axp20x_power *devdata = dev_get_drvdata(psy->dev->parent);
> > +	int ret;
> > +
> > +	switch (psp) {
> > +	case POWER_SUPPLY_PROP_STATUS:
> > +		if (val->intval == POWER_SUPPLY_STATUS_CHARGING)
> > +			ret = regmap_update_bits(devdata->axp20x->regmap,
> > +						 AXP20X_CHRG_BAK_CTRL,
> > +						 AXP20X_BACKUP_ENABLE,
> > +						 AXP20X_BACKUP_ENABLE);
> > +		else if (val->intval == POWER_SUPPLY_STATUS_NOT_CHARGING)
> > +			ret = regmap_update_bits(devdata->axp20x->regmap,
> > +						 AXP20X_CHRG_BAK_CTRL,
> > +						 AXP20X_BACKUP_ENABLE, 0);
> > +		else
> > +			ret = -EINVAL;
> > +		break;
> > +
> > +	default:
> > +		ret = -EINVAL;
> > +	}
> > +	return ret;
> > +}
> > +
> > +static int axp20x_backup_prop_writeable(struct power_supply *psy,
> > +					enum power_supply_property psp)
> > +{
> > +	return psp == POWER_SUPPLY_PROP_STATUS;
> > +}
> > +
> > +static enum power_supply_property axp20x_backup_props[] = {
> > +	POWER_SUPPLY_PROP_STATUS,
> > +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
> > +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> > +};
> > +
> > +/* ********************************************** *
> > + * ***  ACIN power supply                     *** *
> > + * ********************************************** */
> > +
> > +static int axp20x_ac_get_prop(struct power_supply *psy,
> > +			      enum power_supply_property psp,
> > +			      union power_supply_propval *val)
> > +{
> > +	struct axp20x_power *devdata = dev_get_drvdata(psy->dev->parent);
> > +	int ret;
> > +
> > +	ret = axp20x_power_poll(devdata, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	spin_lock(&devdata->lock);
> > +	switch (psp)  {
> > +	case POWER_SUPPLY_PROP_PRESENT:
> > +		val->intval = !!(devdata->status1 & AXP20X_PWR_STATUS_AC_PRESENT);
> > +		break;
> > +
> > +	case POWER_SUPPLY_PROP_ONLINE:
> > +		val->intval = !!(devdata->status1 & AXP20X_PWR_STATUS_AC_AVAILABLE);
> > +		break;
> > +
> > +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> > +		val->intval = devdata->vac;
> > +		break;
> > +
> > +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> > +		val->intval = devdata->iac;
> > +		break;
> > +
> > +	default:
> > +		ret = -EINVAL;
> > +	}
> > +	spin_unlock(&devdata->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static enum power_supply_property axp20x_ac_props[] = {
> > +	POWER_SUPPLY_PROP_PRESENT,
> > +	POWER_SUPPLY_PROP_ONLINE,
> > +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> > +	POWER_SUPPLY_PROP_CURRENT_NOW,
> > +};
> > +
> > +/* ********************************************** *
> > + * ***  VBUS power supply                     *** *
> > + * ********************************************** */
> > +
> > +static int axp20x_vbus_get_prop(struct power_supply *psy,
> > +				enum power_supply_property psp,
> > +				union power_supply_propval *val)
> > +{
> > +	struct axp20x_power *devdata = dev_get_drvdata(psy->dev->parent);
> > +	int ret;
> > +
> > +	ret = axp20x_power_poll(devdata, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	spin_lock(&devdata->lock);
> > +	switch (psp)  {
> > +	case POWER_SUPPLY_PROP_PRESENT:
> > +		val->intval = !!(devdata->status1 & AXP20X_PWR_STATUS_VBUS_PRESENT);
> > +		break;
> > +
> > +	case POWER_SUPPLY_PROP_ONLINE:
> > +		val->intval = !!(devdata->status1 & AXP20X_PWR_STATUS_VBUS_AVAILABLE);
> > +		break;
> > +
> > +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> > +		val->intval = devdata->vvbus;
> > +		break;
> > +
> > +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> > +		val->intval = devdata->ivbus;
> > +		break;
> > +
> > +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> > +		switch (devdata->vbusmgt & AXP20X_VBUS_CLIMIT_MASK) {
> > +		case AXP20X_VBUC_CLIMIT_100mA:
> > +			val->intval = 100000; break;
> > +		case AXP20X_VBUC_CLIMIT_500mA:
> > +			val->intval = 500000; break;
> > +		case AXP20X_VBUC_CLIMIT_900mA:
> > +			val->intval = 900000; break;
> > +		case AXP20X_VBUC_CLIMIT_NONE:
> > +		default:
> > +			val->intval = -1;
> > +		}
> > +		break;
> > +
> > +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> > +		val->intval = AXP20X_VBUS_VHOLD_mV(devdata->vbusmgt);
> > +		break;
> > +
> > +	default:
> > +		ret = -EINVAL;
> > +	}
> > +	spin_unlock(&devdata->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int axp20x_vbus_set_prop(struct power_supply *psy,
> > +				enum power_supply_property psp,
> > +				const union power_supply_propval *val)
> > +{
> > +	struct axp20x_power *devdata = dev_get_drvdata(psy->dev->parent);
> > +	int ret, reg;
> > +
> > +	switch (psp) {
> > +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> > +		if (val->intval == 100000)
> > +			reg = AXP20X_VBUC_CLIMIT_100mA;
> > +		else if (val->intval == 500000)
> > +			reg = AXP20X_VBUC_CLIMIT_500mA;
> > +		else if (val->intval == 900000)
> > +			reg = AXP20X_VBUC_CLIMIT_900mA;
> > +		else if (val->intval == -1)
> > +			reg = AXP20X_VBUC_CLIMIT_NONE;
> > +		else {
> > +			ret = -EINVAL;
> > +			break;
> > +		}
> > +		regmap_update_bits(devdata->axp20x->regmap,
> > +				   AXP20X_VBUS_IPSOUT_MGMT,
> > +				   AXP20X_VBUS_CLIMIT_MASK, reg);
> > +		spin_lock(&devdata->lock);
> > +		devdata->vbusmgt = (devdata->vbusmgt & ~AXP20X_VBUS_CLIMIT_MASK) |
> > +				   (reg & AXP20X_VBUS_CLIMIT_MASK);
> > +		spin_unlock(&devdata->lock);
> > +		ret = 0;
> > +		break;
> > +
> > +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> > +		if (val->intval < 4000000) {
> > +			ret = -EINVAL;
> > +			break;
> > +		} else
> > +			reg = val->intval / 100000;
> > +		if ((reg & 7) != reg) {
> > +			ret = -EINVAL;
> > +			break;
> > +		} else
> > +			reg = reg << 3;
> > +		regmap_update_bits(devdata->axp20x->regmap,
> > +				   AXP20X_VBUS_IPSOUT_MGMT,
> > +				   AXP20X_VBUS_VHOLD_MASK, reg);
> > +		spin_lock(&devdata->lock);
> > +		devdata->vbusmgt = (devdata->vbusmgt & ~AXP20X_VBUS_VHOLD_MASK) |
> > +				   (reg & AXP20X_VBUS_VHOLD_MASK);
> > +		spin_unlock(&devdata->lock);
> > +		ret = 0;
> > +		break;
> > +
> > +	default:
> > +		ret = -EINVAL;
> > +	}
> > +	return ret;
> > +}
> > +
> > +static enum power_supply_property axp20x_vbus_props[] = {
> > +	POWER_SUPPLY_PROP_PRESENT,
> > +	POWER_SUPPLY_PROP_ONLINE,
> > +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> > +	POWER_SUPPLY_PROP_CURRENT_NOW,
> > +	POWER_SUPPLY_PROP_VOLTAGE_MIN,
> > +	POWER_SUPPLY_PROP_CURRENT_MAX,
> > +};
> > +
> > +static int axp20x_vbus_prop_writeable(struct power_supply *psy,
> > +				      enum power_supply_property psp)
> > +{
> > +	return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
> > +	       psp == POWER_SUPPLY_PROP_CURRENT_MAX;
> > +}
> > +
> > +
> > +/* ********************************************** *
> > + * ***  main battery charger                  *** *
> > + * ********************************************** */
> > +
> > +static void axp20x_battery_chg_reconfig(struct power_supply *psy);
> > +
> > +static int axp20x_battery_config(struct platform_device *pdev,
> > +				 struct axp20x_power *devdata,
> > +				 struct axp20x_dev *axp20x)
> > +{
> > +	struct device_node *np;
> > +	int i, ret = 0, reg, new_reg = 0;
> > +	u32 ocv[16], temp[3], rdc, capa;
> > +
> > +	ret = regmap_read(axp20x->regmap, AXP20X_PWR_OP_MODE, &reg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	np = of_node_get(axp20x->dev->of_node);
> > +	if (!np)
> > +		return -ENODEV;
> > +
> > +	ret = of_property_read_u32_array(np, "battery.ocv", ocv, 16);
> > +	for (i = 0; ret == 0 && i < ARRAY_SIZE(ocv); i++)
> > +		if (ocv[i] > 100) {
> > +			dev_warn(&pdev->dev, "OCV[%d] %u > 100\n", i, ocv[i]);
> > +			ret = -EINVAL;
> > +			goto err;
> > +		}
> > +
> > +	ret = of_property_read_u32_array(np, "battery.resistance", &rdc, 1);
> > +	if (ret != 0)
> > +		rdc = 100;
> > +
> > +	ret = of_property_read_u32_array(np, "battery.capacity", &capa, 1);
> > +	if (ret != 0)
> > +		capa = 0;
> > +
> > +	ret = of_property_read_u32_array(np, "battery.temp_sensor", temp, 3);
> > +	if (ret != 0)
> > +		memset(temp, 0, sizeof(temp));
> > +	else if (temp[0] != 20 && temp[0] != 40 && temp[0] != 60 &&
> > +		 temp[0] != 80) {
> > +		dev_warn(&pdev->dev, "Invalid battery temperature sensor current setting\n");
> > +		ret = -EINVAL;
> > +		memset(temp, 0, sizeof(temp));
> > +	}
> > +
> > +	dev_info(&pdev->dev, "FDT settings: capacity=%d, resistance=%d, temp_sensor=<%d %d %d>\n", capa, rdc, temp[0], temp[1], temp[2]);
> > +	/* apply settings */
> > +	devdata->batt_health = POWER_SUPPLY_HEALTH_UNKNOWN;
> > +	regmap_update_bits(axp20x->regmap, AXP20X_FG_RES, AXP20X_FG_ENABLE, 0x00);
> > +	regmap_update_bits(axp20x->regmap, AXP20X_RDC_H, 0x80, 0x00);
> > +	regmap_update_bits(axp20x->regmap, AXP20X_RDC_L, 0xff, (rdc * 10000 + 5371) / 10742);
> > +	regmap_update_bits(axp20x->regmap, AXP20X_RDC_H, 0x1f, ((rdc * 10000 + 5371) / 10742) >> 8);
> > +	if (of_find_property(np, "battery.ocv", NULL))
> > +		for (i = 0; i < ARRAY_SIZE(ocv); i++) {
> > +			ret = regmap_update_bits(axp20x->regmap, AXP20X_OCV(i),
> > +						 0xff, ocv[i]);
> > +			if (ret)
> > +				dev_warn(&pdev->dev,
> > +					 "Failed to store OCV[%d] setting: %d\n",
> > +					 i, ret);
> > +		}
> > +	regmap_update_bits(axp20x->regmap, AXP20X_FG_RES, AXP20X_FG_ENABLE, AXP20X_FG_ENABLE);
> > +
> > +	if (capa == 0 && !(reg & AXP20X_PWR_OP_BATT_PRESENT)) {
> > +		/* No battery present or configured -> disable */
> > +		regmap_update_bits(axp20x->regmap, AXP20X_CHRG_CTRL1, AXP20X_CHRG_CTRL1_ENABLE, 0x00);
> > +		regmap_update_bits(axp20x->regmap, AXP20X_OFF_CTRL, AXP20X_OFF_CTRL_BATT_MON, 0x00);
> > +		dev_info(&pdev->dev, "No battery, disabling charger\n");
> > +		ret = -ENODEV;
> > +		goto err;
> > +	}
> > +
> > +	if (temp[0] == 0) {
> > +		regmap_update_bits(axp20x->regmap, AXP20X_ADC_RATE,
> > +				   AXP20X_ADR_TS_WHEN_MASK |
> > +				   AXP20X_ADR_TS_UNRELATED,
> > +				   AXP20X_ADR_TS_UNRELATED |
> > +				   AXP20X_ADR_TS_WHEN_OFF);
> > +	} else {
> > +		devdata->tbatt_min = temp[1];
> > +		devdata->tbatt_max = temp[2];
> > +		switch (temp[0]) {
> > +		case 20:
> > +			regmap_update_bits(axp20x->regmap, AXP20X_ADC_RATE,
> > +					   AXP20X_ADR_TS_CURR_MASK |
> > +					   AXP20X_ADR_TS_WHEN_MASK |
> > +					   AXP20X_ADR_TS_UNRELATED,
> > +					   AXP20X_ADR_TS_CURR_20uA |
> > +					   AXP20X_ADR_TS_WHEN_ADC);
> > +			break;
> > +		case 40:
> > +			regmap_update_bits(axp20x->regmap, AXP20X_ADC_RATE,
> > +					   AXP20X_ADR_TS_CURR_MASK |
> > +					   AXP20X_ADR_TS_WHEN_MASK |
> > +					   AXP20X_ADR_TS_UNRELATED,
> > +					   AXP20X_ADR_TS_CURR_40uA |
> > +					   AXP20X_ADR_TS_WHEN_ADC);
> > +			break;
> > +		case 60:
> > +			regmap_update_bits(axp20x->regmap, AXP20X_ADC_RATE,
> > +					   AXP20X_ADR_TS_CURR_MASK |
> > +					   AXP20X_ADR_TS_WHEN_MASK |
> > +					   AXP20X_ADR_TS_UNRELATED,
> > +					   AXP20X_ADR_TS_CURR_60uA |
> > +					   AXP20X_ADR_TS_WHEN_ADC);
> > +			break;
> > +		case 80:
> > +			regmap_update_bits(axp20x->regmap, AXP20X_ADC_RATE,
> > +					   AXP20X_ADR_TS_CURR_MASK |
> > +					   AXP20X_ADR_TS_WHEN_MASK |
> > +					   AXP20X_ADR_TS_UNRELATED,
> > +					   AXP20X_ADR_TS_CURR_80uA |
> > +					   AXP20X_ADR_TS_WHEN_ADC);
> > +			break;
> > +		}
> > +		new_reg = temp[1] / (0x10 * 800);
> > +		regmap_update_bits(axp20x->regmap, AXP20X_V_HTF_CHRG, 0xff,
> > +				   new_reg);
> > +		regmap_update_bits(axp20x->regmap, AXP20X_V_HTF_DISCHRG, 0xff,
> > +				   new_reg);
> > +		new_reg = temp[2] / (0x10 * 800);
> > +		regmap_update_bits(axp20x->regmap, AXP20X_V_LTF_CHRG, 0xff,
> > +				   new_reg);
> > +		regmap_update_bits(axp20x->regmap, AXP20X_V_LTF_DISCHRG, 0xff,
> > +				   new_reg);
> > +	}
> > +	devdata->batt_capacity  = capa * 1000;
> > +	devdata->batt_user_imax = (capa < 300 ? 300 : capa) * 1000;
> > +	/* Prefer longer battery life over longer runtime. */
> > +	regmap_update_bits(devdata->axp20x->regmap, AXP20X_CHRG_CTRL1,
> > +			   AXP20X_CHRG_CTRL1_TGT_VOLT,
> > +			   AXP20X_CHRG_CTRL1_TGT_4_15V);
> > +
> > +	/* TODO: configure CHGLED? */
> > +
> > +	/* Default to about 5% capacity, about 3.5V */
> > +	regmap_update_bits(axp20x->regmap, AXP20X_APS_WARN_L1, 0xff,
> > +			   (3500000 - 2867200) / 4 / 1400);
> > +	regmap_update_bits(axp20x->regmap, AXP20X_APS_WARN_L2, 0xff,
> > +			   (3304000 - 2867200) / 4 / 1400);
> > +	/* RDC - disable capacity monitor, reconfigure, re-enable */
> > +	regmap_update_bits(axp20x->regmap, AXP20X_FG_RES, 0x80, 0x80);
> > +	regmap_update_bits(axp20x->regmap, AXP20X_RDC_H, 0x80, 0x00);
> > +	regmap_update_bits(axp20x->regmap, AXP20X_RDC_H, 0x1f, ((rdc * 10000 + 5371) / 10742) >> 8);
> > +	regmap_update_bits(axp20x->regmap, AXP20X_RDC_L, 0xff, (rdc * 10000 + 5371) / 10742);
> > +	regmap_update_bits(axp20x->regmap, AXP20X_FG_RES, 0x80, 0x00);
> > +	regmap_update_bits(axp20x->regmap, AXP20X_OFF_CTRL, AXP20X_OFF_CTRL_BATT_MON, AXP20X_OFF_CTRL_BATT_MON);
> > +	axp20x_battery_chg_reconfig(&devdata->battery);
> > +	ret = 0;
> > +
> > +err:
> > +	of_node_put(np);
> > +	return ret;
> > +}
> > +
> > +static int axp20x_battery_uv_to_temp(struct axp20x_power *devdata, int uv)
> > +{
> > +	/* TODO: convert ?V to ?C */
> > +	return uv;
> > +}
> > +
> > +static int axp20x_battery_get_prop(struct power_supply *psy,
> > +				   enum power_supply_property psp,
> > +				   union power_supply_propval *val)
> > +{
> > +	struct axp20x_power *devdata = dev_get_drvdata(psy->dev->parent);
> > +	int ret, reg;
> > +
> > +	switch (psp) {
> > +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> > +		ret = regmap_read(devdata->axp20x->regmap, AXP20X_CHRG_CTRL1,
> > +				  &reg);
> > +		if (ret)
> > +			return ret;
> > +		val->intval = (reg & AXP20X_CHRG_CTRL1_TGT_CURR) * 100000 +
> > +			      300000;
> > +		return 0;
> > +
> > +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> > +		ret = regmap_read(devdata->axp20x->regmap, AXP20X_CHRG_CTRL1,
> > +				  &reg);
> > +		if (ret)
> > +			return ret;
> > +		switch (reg & AXP20X_CHRG_CTRL1_TGT_VOLT) {
> > +		case AXP20X_CHRG_CTRL1_TGT_4_1V:
> > +			val->intval = 4100000;
> > +			break;
> > +		case AXP20X_CHRG_CTRL1_TGT_4_15V:
> > +			val->intval = 4150000;
> > +			break;
> > +		case AXP20X_CHRG_CTRL1_TGT_4_2V:
> > +			val->intval = 4200000;
> > +			break;
> > +		case AXP20X_CHRG_CTRL1_TGT_4_36V:
> > +			val->intval = 4360000;
> > +			break;
> > +		default:
> > +			ret = -EINVAL;
> > +		}
> > +		return 0;
> > +
> > +	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> > +		ret = regmap_read(devdata->axp20x->regmap, AXP20X_APS_WARN_L2,
> > +				  &reg);
> > +		if (ret)
> > +			return ret;
> > +		val->intval = 2867200 + 1400 * reg * 4;
> > +		return 0;
> > +
> > +	case POWER_SUPPLY_PROP_TECHNOLOGY:
> > +		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
> > +		return 0;
> > +
> > +	default:
> > +		break;
> > +	}
> > +
> > +	ret = axp20x_power_poll(devdata, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	spin_lock(&devdata->lock);
> > +	switch (psp)  {
> > +	case POWER_SUPPLY_PROP_PRESENT:
> > +	case POWER_SUPPLY_PROP_ONLINE:
> > +		val->intval = !!(devdata->status2 & AXP20X_PWR_OP_BATT_PRESENT);
> > +		break;
> > +
> > +	case POWER_SUPPLY_PROP_STATUS:
> > +		if (devdata->status1 & AXP20X_PWR_STATUS_BAT_CHARGING)
> > +			val->intval = POWER_SUPPLY_STATUS_CHARGING;
> > +		else if (devdata->ibatt == 0 && devdata->batt_percent == 100)
> > +			val->intval = POWER_SUPPLY_STATUS_FULL;
> > +		else if (devdata->ibatt == 0)
> > +			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> > +		else
> > +			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> > +		break;
> > +
> > +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> > +		val->intval = devdata->ibatt;
> > +		break;
> > +
> > +	case POWER_SUPPLY_PROP_HEALTH:
> > +		val->intval = POWER_SUPPLY_HEALTH_UNKNOWN;
> > +		// POWER_SUPPLY_HEALTH_GOOD, POWER_SUPPLY_HEALTH_OVERHEAT, POWER_SUPPLY_HEALTH_DEAD, POWER_SUPPLY_HEALTH_OVERVOLTAGE, POWER_SUPPLY_HEALTH_UNSPEC_FAILURE, POWER_SUPPLY_HEALTH_COLD, POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE
> > +		break;
> > +
> > +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> > +		val->intval = devdata->vbatt;
> > +		break;
> > +
> > +	case POWER_SUPPLY_PROP_POWER_NOW:
> > +		val->intval = devdata->pbatt;
> > +		break;
> > +
> > +	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> > +		val->intval = devdata->batt_capacity;
> > +		break;
> > +
> > +	case POWER_SUPPLY_PROP_CHARGE_NOW:
> > +		/* TODO */
> > +		val->intval = 12345;
> > +		break;
> > +
> > +	case POWER_SUPPLY_PROP_CAPACITY:
> > +		val->intval = devdata->batt_percent;
> > +		break;
> > +
> > +	case POWER_SUPPLY_PROP_TEMP:
> > +		val->intval = axp20x_battery_uv_to_temp(devdata,
> > +							devdata->tbatt);
> > +		break;
> > +
> > +	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> > +		val->intval = axp20x_battery_uv_to_temp(devdata,
> > +							devdata->tbatt_min);
> > +		break;
> > +
> > +	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> > +		val->intval = axp20x_battery_uv_to_temp(devdata,
> > +							devdata->tbatt_max);
> > +		break;
> > +
> > +	default:
> > +		ret = -EINVAL;
> > +	}
> > +	spin_unlock(&devdata->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int axp20x_battery_max_chg_current(struct axp20x_power *devdata)
> > +{
> > +	if ((devdata->status1 & AXP20X_PWR_STATUS_AC_PRESENT) &&
> > +	    (devdata->status1 & AXP20X_PWR_STATUS_AC_AVAILABLE)) {
> > +		/* AC available - unrestricted power */
> > +		return devdata->batt_capacity / 2;
> > +	} else if ((devdata->status1 & AXP20X_PWR_STATUS_VBUS_PRESENT) &&
> > +		   (devdata->status1 & AXP20X_PWR_STATUS_VBUS_AVAILABLE)) {
> > +		/* VBUS available - limited power */
> > +		switch (devdata->vbusmgt & AXP20X_VBUS_CLIMIT_MASK) {
> > +		case AXP20X_VBUC_CLIMIT_100mA:
> > +			return 0;
> > +		case AXP20X_VBUC_CLIMIT_500mA:
> > +			return 300000;
> > +		case AXP20X_VBUC_CLIMIT_900mA:
> > +			return 600000;
> > +		case AXP20X_VBUC_CLIMIT_NONE:
> > +			return devdata->batt_capacity / 2;
> > +		default:
> > +			return 0;
> > +		}
> > +	} else {
> > +		/* on-battery */
> > +		return 0;
> > +	}
> > +}
> > +
> > +static int axp20x_battery_set_prop(struct power_supply *psy,
> > +				   enum power_supply_property psp,
> > +				   const union power_supply_propval *val)
> > +{
> > +	struct axp20x_power *devdata = dev_get_drvdata(psy->dev->parent);
> > +	int ret;
> > +
> > +	switch (psp) {
> > +	case POWER_SUPPLY_PROP_STATUS:
> > +		if (val->intval == POWER_SUPPLY_STATUS_CHARGING) {
> > +			ret = axp20x_battery_max_chg_current(devdata);
> > +			if (ret == 0) {
> > +				ret = -EBUSY;
> > +				break;
> > +			}
> > +			ret = regmap_update_bits(devdata->axp20x->regmap,
> > +						 AXP20X_PWR_OP_MODE,
> > +						 AXP20X_PWR_OP_CHARGING,
> > +						 AXP20X_PWR_OP_CHARGING);
> > +			if (ret == 0)
> > +				axp20x_battery_chg_reconfig(&devdata->battery);
> > +		} else if (val->intval == POWER_SUPPLY_STATUS_NOT_CHARGING) {
> > +			ret = regmap_update_bits(devdata->axp20x->regmap,
> > +						 AXP20X_PWR_OP_MODE,
> > +						 AXP20X_PWR_OP_CHARGING, 0);
> > +		} else
> > +			ret = -EINVAL;
> > +		break;
> > +
> > +	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> > +		/* TODO: adjust AXP20X_APS_WARN_L1 and AXP20X_APS_WARN_L2 accordingly */
> > +		ret = -EINVAL;
> > +		break;
> > +
> > +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> > +		switch (val->intval) {
> > +		case 4100000:
> > +			ret = regmap_update_bits(devdata->axp20x->regmap,
> > +						 AXP20X_CHRG_CTRL1,
> > +						 AXP20X_CHRG_CTRL1_TGT_VOLT,
> > +						 AXP20X_CHRG_CTRL1_TGT_4_1V);
> > +			break;
> > +		case 4150000:
> > +			ret = regmap_update_bits(devdata->axp20x->regmap,
> > +						 AXP20X_CHRG_CTRL1,
> > +						 AXP20X_CHRG_CTRL1_TGT_VOLT,
> > +						 AXP20X_CHRG_CTRL1_TGT_4_15V);
> > +			break;
> > +		case 4200000:
> > +			ret = regmap_update_bits(devdata->axp20x->regmap,
> > +						 AXP20X_CHRG_CTRL1,
> > +						 AXP20X_CHRG_CTRL1_TGT_VOLT,
> > +						 AXP20X_CHRG_CTRL1_TGT_4_2V);
> > +			break;
> > +		case 4360000:
> > +			/* refuse this as it's too much for Li-ion! */
> > +		default:
> > +			ret = -EINVAL;
> > +		}
> > +		break;
> > +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> > +		if (((val->intval - 300000) / 100000) > 0x0f)
> > +			ret = -EINVAL;
> > +		else if (val->intval < 300000)
> > +			ret = -EINVAL;
> > +		else {
> > +			devdata->batt_user_imax = val->intval;
> > +			axp20x_battery_chg_reconfig(&devdata->battery);
> > +			ret = 0;
> > +		}
> > +		break;
> > +
> > +	default:
> > +		ret = -EINVAL;
> > +	}
> > +	return ret;
> > +}
> > +
> > +static enum power_supply_property axp20x_battery_props[] = {
> > +	POWER_SUPPLY_PROP_PRESENT,
> > +	POWER_SUPPLY_PROP_ONLINE,
> > +	POWER_SUPPLY_PROP_STATUS,
> > +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> > +	POWER_SUPPLY_PROP_CURRENT_NOW,
> > +	POWER_SUPPLY_PROP_CURRENT_MAX,
> > +	POWER_SUPPLY_PROP_HEALTH,
> > +	POWER_SUPPLY_PROP_TECHNOLOGY,
> > +	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> > +	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> > +	POWER_SUPPLY_PROP_POWER_NOW,
> > +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> > +	/* POWER_SUPPLY_PROP_CHARGE_NOW, */
> > +	POWER_SUPPLY_PROP_CAPACITY,
> > +	POWER_SUPPLY_PROP_TEMP,
> > +	POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
> > +	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
> > +};
> > +
> > +static int axp20x_battery_prop_writeable(struct power_supply *psy,
> > +				      enum power_supply_property psp)
> > +{
> > +	return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN ||
> > +	       psp == POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN ||
> > +	       psp == POWER_SUPPLY_PROP_CURRENT_MAX ||
> > +	       psp == POWER_SUPPLY_PROP_STATUS;
> > +}
> > +
> > +static void axp20x_battery_chg_reconfig(struct power_supply *psy)
> > +{
> > +	struct axp20x_power *devdata = container_of(psy,
> > +				       struct axp20x_power, battery);
> > +	int charge_max, ret;
> > +
> > +	ret = axp20x_power_poll(devdata, 0);
> > +	if (ret)
> > +		return;
> > +
> > +	charge_max = axp20x_battery_max_chg_current(devdata);
> > +
> > +	if (charge_max == 0) {
> > +		ret = regmap_update_bits(devdata->axp20x->regmap,
> > +					 AXP20X_PWR_OP_MODE,
> > +					 AXP20X_PWR_OP_CHARGING, 0);
> > +	} else {
> > +		if (devdata->batt_user_imax < charge_max)
> > +			charge_max = devdata->batt_user_imax;
> > +		if (((charge_max - 300000) / 100000) > 0x0f)
> > +			charge_max = 300000 + 0x0f * 100000;
> > +		ret = regmap_update_bits(devdata->axp20x->regmap,
> > +					 AXP20X_CHRG_CTRL1,
> > +					 AXP20X_CHRG_CTRL1_TGT_CURR,
> > +					(charge_max - 300000) / 100000);
> > +		ret = regmap_update_bits(devdata->axp20x->regmap,
> > +					 AXP20X_PWR_OP_MODE,
> > +					 AXP20X_PWR_OP_CHARGING,
> > +					 AXP20X_PWR_OP_CHARGING);
> > +	}
> > +}
> > +
> > +
> > +
> > +/* ********************************************** *
> > + * ***  IRQ handlers                          *** *
> > + * ********************************************** */
> > +
> > +static irqreturn_t axp20x_irq_ac_over_v(int irq, void *pwr)
> > +{
> > +	struct platform_device *pdev = pwr;
> > +	struct axp20x_power *devdata = platform_get_drvdata(pdev);
> > +
> > +	dev_warn(&pdev->dev, "IRQ#%d AC over voltage\n", irq);
> > +	schedule_work(&devdata->work);
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t axp20x_irq_ac_plugin(int irq, void *pwr)
> > +{
> > +	struct platform_device *pdev = pwr;
> > +	struct axp20x_power *devdata = platform_get_drvdata(pdev);
> > +
> > +	dev_info(&pdev->dev, "IRQ#%d AC connected\n", irq);
> > +	schedule_work(&devdata->work);
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t axp20x_irq_ac_removal(int irq, void *pwr)
> > +{
> > +	struct platform_device *pdev = pwr;
> > +	struct axp20x_power *devdata = platform_get_drvdata(pdev);
> > +
> > +	dev_info(&pdev->dev, "IRQ#%d AC disconnected\n", irq);
> > +	schedule_work(&devdata->work);
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t axp20x_irq_vbus_over_v(int irq, void *pwr)
> > +{
> > +	struct platform_device *pdev = pwr;
> > +	struct axp20x_power *devdata = platform_get_drvdata(pdev);
> > +
> > +	dev_warn(&pdev->dev, "IRQ#%d VBUS over voltage\n", irq);
> > +	schedule_work(&devdata->work);
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t axp20x_irq_vbus_plugin(int irq, void *pwr)
> > +{
> > +	struct platform_device *pdev = pwr;
> > +	struct axp20x_power *devdata = platform_get_drvdata(pdev);
> > +
> > +	dev_info(&pdev->dev, "IRQ#%d VBUS connected\n", irq);
> > +	schedule_work(&devdata->work);
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t axp20x_irq_vbus_removal(int irq, void *pwr)
> > +{
> > +	struct platform_device *pdev = pwr;
> > +	struct axp20x_power *devdata = platform_get_drvdata(pdev);
> > +
> > +	dev_info(&pdev->dev, "IRQ#%d VBUS disconnected\n", irq);
> > +	schedule_work(&devdata->work);
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t axp20x_irq_vbus_v_low(int irq, void *pwr)
> > +{
> > +	struct platform_device *pdev = pwr;
> > +	struct axp20x_power *devdata = platform_get_drvdata(pdev);
> > +
> > +	dev_warn(&pdev->dev, "IRQ#%d VBUS low voltage\n", irq);
> > +	schedule_work(&devdata->work);
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t axp20x_irq_batt_plugin(int irq, void *pwr)
> > +{
> > +	struct platform_device *pdev = pwr;
> > +	struct axp20x_power *devdata = platform_get_drvdata(pdev);
> > +
> > +	dev_info(&pdev->dev, "IRQ#%d Battery connected\n", irq);
> > +	schedule_work(&devdata->work);
> > +	return IRQ_HANDLED;
> > +}
> > +static irqreturn_t axp20x_irq_batt_removal(int irq, void *pwr)
> > +{
> > +	struct platform_device *pdev = pwr;
> > +	struct axp20x_power *devdata = platform_get_drvdata(pdev);
> > +
> > +	dev_info(&pdev->dev, "IRQ#%d Battery disconnected\n", irq);
> > +	schedule_work(&devdata->work);
> > +	return IRQ_HANDLED;
> > +}
> > +static irqreturn_t axp20x_irq_batt_activation(int irq, void *pwr)
> > +{
> > +	struct platform_device *pdev = pwr;
> > +	struct axp20x_power *devdata = platform_get_drvdata(pdev);
> > +
> > +	dev_info(&pdev->dev, "IRQ#%d Battery activation started\n", irq);
> > +	schedule_work(&devdata->work);
> > +	return IRQ_HANDLED;
> > +}
> > +static irqreturn_t axp20x_irq_batt_activated(int irq, void *pwr)
> > +{
> > +	struct platform_device *pdev = pwr;
> > +	struct axp20x_power *devdata = platform_get_drvdata(pdev);
> > +
> > +	dev_info(&pdev->dev, "IRQ#%d Battery activation completed\n", irq);
> > +	schedule_work(&devdata->work);
> > +	return IRQ_HANDLED;
> > +}
> > +static irqreturn_t axp20x_irq_batt_charging(int irq, void *pwr)
> > +{
> > +	struct platform_device *pdev = pwr;
> > +	struct axp20x_power *devdata = platform_get_drvdata(pdev);
> > +
> > +	dev_info(&pdev->dev, "IRQ#%d Battery charging\n", irq);
> > +	schedule_work(&devdata->work);
> > +	return IRQ_HANDLED;
> > +}
> > +static irqreturn_t axp20x_irq_batt_charged(int irq, void *pwr)
> > +{
> > +	struct platform_device *pdev = pwr;
> > +	struct axp20x_power *devdata = platform_get_drvdata(pdev);
> > +
> > +	dev_info(&pdev->dev, "IRQ#%d Battery charged\n", irq);
> > +	schedule_work(&devdata->work);
> > +	return IRQ_HANDLED;
> > +}
> > +static irqreturn_t axp20x_irq_batt_high_temp(int irq, void *pwr)
> > +{
> > +	struct platform_device *pdev = pwr;
> > +	struct axp20x_power *devdata = platform_get_drvdata(pdev);
> > +
> > +	dev_warn(&pdev->dev, "IRQ#%d Battery temperature high\n", irq);
> > +	schedule_work(&devdata->work);
> > +	return IRQ_HANDLED;
> > +}
> > +static irqreturn_t axp20x_irq_batt_low_temp(int irq, void *pwr)
> > +{
> > +	struct platform_device *pdev = pwr;
> > +	struct axp20x_power *devdata = platform_get_drvdata(pdev);
> > +
> > +	dev_warn(&pdev->dev, "IRQ#%d Battery temperature low\n", irq);
> > +	schedule_work(&devdata->work);
> > +	return IRQ_HANDLED;
> > +}
> > +static irqreturn_t axp20x_irq_batt_chg_curr_low(int irq, void *pwr)
> > +{
> > +	struct platform_device *pdev = pwr;
> > +	struct axp20x_power *devdata = platform_get_drvdata(pdev);
> > +
> > +	dev_warn(&pdev->dev, "IRQ#%d External power too weak for target charging current!\n", irq);
> > +	schedule_work(&devdata->work);
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t axp20x_irq_power_low(int irq, void *pwr)
> > +{
> > +	struct platform_device *pdev = pwr;
> > +	struct axp20x_power *devdata = platform_get_drvdata(pdev);
> > +
> > +	dev_warn(&pdev->dev, "IRQ#%d System power running out soon\n", irq);
> > +	schedule_work(&devdata->work);
> > +	return IRQ_HANDLED;
> > +}
> > +static irqreturn_t axp20x_irq_power_low_crit(int irq, void *pwr)
> > +{
> > +	struct platform_device *pdev = pwr;
> > +	struct axp20x_power *devdata = platform_get_drvdata(pdev);
> > +
> > +	dev_crit(&pdev->dev, "IRQ#%d System power running out now!\n", irq);
> > +	schedule_work(&devdata->work);
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +/* ********************************************** *
> > + * ***  Platform driver code                  *** *
> > + * ********************************************** */
> > +
> > +static int axp20x_init_irq(struct platform_device *pdev,
> > +	struct axp20x_dev *axp20x, const char *irq_name,
> > +	const char *dev_name, irq_handler_t handler)
> > +{
> > +	int irq = platform_get_irq_byname(pdev, irq_name);
> > +	int ret;
> > +
> > +	if (irq < 0) {
> > +		dev_warn(&pdev->dev, "No IRQ for %s: %d\n", irq_name, irq);
> > +		return irq;
> > +	}
> > +	irq = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
> > +
> > +	ret = devm_request_any_context_irq(&pdev->dev, irq, handler, 0,
> > +					dev_name, pdev);
> > +	if (ret < 0)
> > +		dev_warn(&pdev->dev, "Failed to request %s IRQ#%d: %d\n", irq_name, irq, ret);
> > +	return ret;
> > +}
> > +
> > +static int axp20x_power_suspend(struct platform_device *pdev, pm_message_t state)
> > +{
> > +	struct axp20x_power *devdata = platform_get_drvdata(pdev);
> > +
> > +	cancel_work_sync(&devdata->work);
> > +	return 0;
> > +}
> > +
> > +static int axp20x_power_resume(struct platform_device *pdev)
> > +{
> > +	struct axp20x_power *devdata = platform_get_drvdata(pdev);
> > +
> > +	axp20x_power_poll(devdata, 1);
> > +	return 0;
> > +}
> > +
> > +static void axp20x_power_shutdown(struct platform_device *pdev)
> > +{
> > +	struct axp20x_power *devdata = platform_get_drvdata(pdev);
> > +
> > +	cancel_work_sync(&devdata->work);
> > +}
> > +
> > +static int axp20x_power_probe(struct platform_device *pdev)
> > +{
> > +	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
> > +	struct axp20x_power *devdata;
> > +	struct power_supply *ac, *vbus, *backup, *battery;
> > +	int ret;
> > +
> > +	devdata = devm_kzalloc(&pdev->dev, sizeof(struct axp20x_power),
> > +				GFP_KERNEL);
> > +	if (devdata == NULL)
> > +		return -ENOMEM;
> > +
> > +	spin_lock_init(&devdata->lock);
> > +	devdata->axp20x = axp20x;
> > +	platform_set_drvdata(pdev, devdata);
> > +
> > +	backup = &devdata->backup;
> > +	snprintf(devdata->backup_name, sizeof(devdata->backup_name), "axp20x-backup");
> > +	backup->name                  = devdata->backup_name;
> > +	backup->type                  = POWER_SUPPLY_TYPE_BATTERY;
> > +	backup->properties            = axp20x_backup_props;
> > +	backup->num_properties        = ARRAY_SIZE(axp20x_backup_props);
> > +	backup->property_is_writeable = axp20x_backup_prop_writeable;
> > +	backup->get_property          = axp20x_backup_get_prop;
> > +	backup->set_property          = axp20x_backup_set_prop;
> > +
> > +	ac = &devdata->ac;
> > +	snprintf(devdata->ac_name, sizeof(devdata->ac_name), "axp20x-ac");
> > +	ac->name           = devdata->ac_name;
> > +	ac->type           = POWER_SUPPLY_TYPE_MAINS;
> > +	ac->properties     = axp20x_ac_props;
> > +	ac->num_properties = ARRAY_SIZE(axp20x_ac_props);
> > +	ac->get_property   = axp20x_ac_get_prop;
> > +
> > +	vbus = &devdata->vbus;
> > +	snprintf(devdata->vbus_name, sizeof(devdata->vbus_name), "axp20x-usb");
> > +	vbus->name                  = devdata->vbus_name;
> > +	vbus->type                  = POWER_SUPPLY_TYPE_USB;
> > +	vbus->properties            = axp20x_vbus_props;
> > +	vbus->num_properties        = ARRAY_SIZE(axp20x_vbus_props);
> > +	vbus->property_is_writeable = axp20x_vbus_prop_writeable;
> > +	vbus->get_property          = axp20x_vbus_get_prop;
> > +	vbus->set_property          = axp20x_vbus_set_prop;
> > +
> > +	devdata->battery_supplies[0] = devdata->vbus_name;
> > +	devdata->battery_supplies[1] = devdata->ac_name;
> > +	battery = &devdata->battery;
> > +	snprintf(devdata->battery_name, sizeof(devdata->battery_name), "axp20x-battery");
> > +	battery->name                   = devdata->battery_name;
> > +	battery->type                   = POWER_SUPPLY_TYPE_BATTERY;
> > +	battery->properties             = axp20x_battery_props;
> > +	battery->num_properties         = ARRAY_SIZE(axp20x_battery_props);
> > +	battery->property_is_writeable  = axp20x_battery_prop_writeable;
> > +	battery->get_property           = axp20x_battery_get_prop;
> > +	battery->set_property           = axp20x_battery_set_prop;
> > +	battery->supplied_from          = devdata->battery_supplies;
> > +	battery->num_supplies           = 1;
> > +	battery->external_power_changed = axp20x_battery_chg_reconfig;
> > +
> > +	/* configure hardware and check FDT params */
> > +	regmap_update_bits(axp20x->regmap, AXP20X_ADC_RATE,
> > +			   AXP20X_ADR_RATE_MASK, AXP20X_ADR_RATE_50Hz);
> > +
> > +	ret = axp20x_backup_config(pdev, axp20x);
> > +	if (ret)
> > +		devdata->backup_name[0] = '\0';
> > +
> > +	ret = axp20x_battery_config(pdev, devdata, axp20x);
> > +	if (ret)
> > +		devdata->battery_name[0] = '\0';
> > +	else if (devdata->tbatt_min == 0 && devdata->tbatt_max == 0)
> > +		battery->num_properties -= 3;
> > +
> > +	ret = axp20x_power_poll(devdata, 2);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (devdata->status1 & AXP20X_PWR_STATUS_AC_VBUS_SHORT)
> > +		devdata->ac_name[0] = '\0';
> > +	else
> > +		battery->num_supplies = 2;
> > +
> > +	/* register present supplies */
> > +	ret = power_supply_register(&pdev->dev, backup);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = power_supply_register(&pdev->dev, vbus);
> > +	if (ret)
> > +		goto err_unreg_backup;
> > +	power_supply_changed(&devdata->vbus);
> > +
> > +	if (devdata->ac_name[0]) {
> > +		ret = power_supply_register(&pdev->dev, ac);
> > +		if (ret)
> > +			goto err_unreg_vbus;
> > +		power_supply_changed(&devdata->ac);
> > +	}
> > +
> > +	if (devdata->battery_name[0]) {
> > +		ret = power_supply_register(&pdev->dev, battery);
> > +		if (ret)
> > +			goto err_unreg_ac;
> > +		power_supply_changed(&devdata->battery);
> > +	}
> 
> It looks like there's a lot more than just one driver here. Would it
> make sense to split this into smaller drivers?

There are 4 parts - AC, VBUS, backup/RTC battery and main battery.

Splitting it into four parts would be possible though there are some
interactions between them:
- AC and VBUS/OTG need to trigger charge current reconfiguration for
  battery charger (due to current supply limit on VBUS/OTG)

In addition, some of supply information is presented in registers shared
with the other supplies which would make caching management harder
unless regmap caching could be controlled in a better way.

> Thanks,
> Maxime

Thanks,
Bruno
