From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Wed, 22 Aug 2012 20:48:18 -0700
Subject: [V4 3/4] power_supply: Enable battery-charger for 88pm860x
In-Reply-To: <1343377636-16128-1-git-send-email-jtzhou@marvell.com>
References: <20120714081254.GD20018@lizard>
 <1343377636-16128-1-git-send-email-jtzhou@marvell.com>
Message-ID: <20120823034815.GB16674@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2012 at 04:27:16PM +0800, Jett.Zhou wrote:
> There are charger and battery measurement feature for 88pm860x PMIC.
> 
> For charger, it can support pre-charge with small current when battery is
> nearly exausted and then changed into fast-charge with CC&CV mode.
> 
> For battery monitor, it can support battery measurement such as
> vbat,vsys,vchg and ibat etc,it can aslo accumulating the Coulomb value
> charged or discharged from battery based on Conlomb Counter, we use it
> to estimate battery capacity.
> 
> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
> ---

A very nice driver, looks neat!

It slightly touches MFD parts, so Samuel, Mark, can I get your Acks
to pass the driver via battery tree? (For convenience I didn't snip
the MFD parts, they are at the very end of this email.)


Jett,

I also noticed these warnings:

  CHECK   drivers/power/88pm860x_battery.c
drivers/power/88pm860x_battery.c:128:5: warning: symbol 'array_soc' was not declared. Should it be static?
  CHECK   drivers/power/88pm860x_charger.c
drivers/power/88pm860x_charger.c:640:3: warning: symbol 'pm860x_irq_descs' was not declared. Should it be static?
  CHECK   drivers/mfd/88pm860x-core.c
drivers/mfd/88pm860x-core.c:803:53: warning: incorrect type in assignment (different base types)
drivers/mfd/88pm860x-core.c:803:53:    expected struct charger_regulator *charger_regulators
drivers/mfd/88pm860x-core.c:803:53:    got struct regulator_bulk_data static [toplevel] *

They are minor, except for the last one. You seemed to use
'regulator_bulk_data' struct (just as charger manager documentation
wrongly tells you, yup), but in real it should have been
'struct charger_regulator'. The only reason that it worked is
because both 'supply' and 'regulator_name' struct members are the
first in these structs. :-)

So, I had to apply these small fixes on top of you patch, just FYI.

--->8---->8--->8

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 229cb29..76b5b7d 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -157,8 +157,8 @@ static struct regulator_init_data preg_init_data = {
 	.consumer_supplies	= &preg_supply[0],
 };
 
-static struct regulator_bulk_data chg_desc_regulator_data[] = {
-	{ .supply = "preg", },
+static struct charger_regulator chg_desc_regulator_data[] = {
+	{ .regulator_name = "preg", },
 };
 
 static struct mfd_cell power_devs[] = {
diff --git a/drivers/power/88pm860x_battery.c b/drivers/power/88pm860x_battery.c
index e84e98d..1c19828 100644
--- a/drivers/power/88pm860x_battery.c
+++ b/drivers/power/88pm860x_battery.c
@@ -125,7 +125,7 @@ struct ccnt {
  * State of Charge.
  * The first number is mAh(=3.6C), and the second number is percent point.
  */
-int array_soc[][2] = {
+static int array_soc[][2] = {
 	{4170, 100}, {4154, 99}, {4136, 98}, {4122, 97}, {4107, 96},
 	{4102, 95}, {4088, 94}, {4081, 93}, {4070, 92}, {4060, 91},
 	{4053, 90}, {4044, 89}, {4035, 88}, {4028, 87}, {4019, 86},
diff --git a/drivers/power/88pm860x_charger.c b/drivers/power/88pm860x_charger.c
index 52b59d8..4eeef9b 100644
--- a/drivers/power/88pm860x_charger.c
+++ b/drivers/power/88pm860x_charger.c
@@ -634,7 +634,7 @@ static int pm860x_init_charger(struct pm860x_charger_info *info)
 	return 0;
 }
 
-struct pm860x_irq_desc {
+static struct pm860x_irq_desc {
 	const char *name;
 	irqreturn_t (*handler)(int irq, void *data);
 } pm860x_irq_descs[] = {

--->8---->8--->8


And the MFD parts for which I'd need some Acks:

> diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
> index d09918c..229cb29 100644
> --- a/drivers/mfd/88pm860x-core.c
> +++ b/drivers/mfd/88pm860x-core.c
> @@ -18,6 +18,7 @@
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/88pm860x.h>
>  #include <linux/regulator/machine.h>
> +#include <linux/power/charger-manager.h>
>  
>  #define INT_STATUS_NUM			3
>  
> @@ -84,7 +85,8 @@ static struct resource battery_resources[] __devinitdata = {
>  static struct resource charger_resources[] __devinitdata = {
>  	{PM8607_IRQ_CHG,  PM8607_IRQ_CHG,  "charger detect",  IORESOURCE_IRQ,},
>  	{PM8607_IRQ_CHG_DONE,  PM8607_IRQ_CHG_DONE,  "charging done",       IORESOURCE_IRQ,},
> -	{PM8607_IRQ_CHG_FAULT, PM8607_IRQ_CHG_FAULT, "charging timeout",    IORESOURCE_IRQ,},
> +	{PM8607_IRQ_CHG_FAIL,  PM8607_IRQ_CHG_FAIL,  "charging timeout",    IORESOURCE_IRQ,},
> +	{PM8607_IRQ_CHG_FAULT, PM8607_IRQ_CHG_FAULT, "charging fault",	    IORESOURCE_IRQ,},
>  	{PM8607_IRQ_GPADC1,    PM8607_IRQ_GPADC1,    "battery temperature", IORESOURCE_IRQ,},
>  	{PM8607_IRQ_VBAT, PM8607_IRQ_VBAT, "battery voltage", IORESOURCE_IRQ,},
>  	{PM8607_IRQ_VCHG, PM8607_IRQ_VCHG, "vchg voltage",    IORESOURCE_IRQ,},
> @@ -155,10 +157,15 @@ static struct regulator_init_data preg_init_data = {
>  	.consumer_supplies	= &preg_supply[0],
>  };
>  
> +static struct regulator_bulk_data chg_desc_regulator_data[] = {
> +	{ .supply = "preg", },
> +};
> +
>  static struct mfd_cell power_devs[] = {
>  	{"88pm860x-battery", -1,},
>  	{"88pm860x-charger", -1,},
>  	{"88pm860x-preg",    -1,},
> +	{"charger-manager", -1,},
>  };
>  
>  static struct mfd_cell rtc_devs[] = {
> @@ -791,6 +798,19 @@ static void __devinit device_power_init(struct pm860x_chip *chip,
>  			      &preg_resources[0], chip->irq_base);
>  	if (ret < 0)
>  		dev_err(chip->dev, "Failed to add preg subdev\n");
> +
> +	if (pdata->chg_desc) {
> +		pdata->chg_desc->charger_regulators =
> +			&chg_desc_regulator_data[0];
> +		pdata->chg_desc->num_charger_regulators	=
> +			ARRAY_SIZE(chg_desc_regulator_data),
> +		power_devs[3].platform_data = pdata->chg_desc;
> +		power_devs[3].pdata_size = sizeof(*pdata->chg_desc);
> +		ret = mfd_add_devices(chip->dev, 0, &power_devs[3], 1,
> +				      NULL, chip->irq_base);
> +		if (ret < 0)
> +			dev_err(chip->dev, "Failed to add chg-manager subdev\n");
> +	}
>  }
>  
>  static void __devinit device_onkey_init(struct pm860x_chip *chip,

> diff --git a/include/linux/mfd/88pm860x.h b/include/linux/mfd/88pm860x.h
> index 7b24943..b7c5a3c 100644
> --- a/include/linux/mfd/88pm860x.h
> +++ b/include/linux/mfd/88pm860x.h
> @@ -55,6 +55,21 @@ enum {
>  #define PM8606_DCM_BOOST		(0x00)
>  #define PM8606_PWM			(0x01)
>  
> +#define PM8607_MISC2			(0x42)
> +
> +/* Power Up Log Register */
> +#define PM8607_POWER_UP_LOG		(0x3F)
> +
> +/* Charger Control Registers */
> +#define PM8607_CCNT			(0x47)
> +#define PM8607_CHG_CTRL1		(0x48)
> +#define PM8607_CHG_CTRL2		(0x49)
> +#define PM8607_CHG_CTRL3		(0x4A)
> +#define PM8607_CHG_CTRL4		(0x4B)
> +#define PM8607_CHG_CTRL5		(0x4C)
> +#define PM8607_CHG_CTRL6		(0x4D)
> +#define PM8607_CHG_CTRL7		(0x4E)
> +
>  /* Backlight Registers */
>  #define PM8606_WLED1A			(0x02)
>  #define PM8606_WLED1B			(0x03)
> @@ -205,6 +220,71 @@ enum {
>  #define PM8607_PD_PREBIAS		(0x56)	/* prebias time */
>  #define PM8607_GPADC_MISC1		(0x57)
>  
> +/* bit definitions of  MEAS_EN1*/
> +#define PM8607_MEAS_EN1_VBAT		(1 << 0)
> +#define PM8607_MEAS_EN1_VCHG		(1 << 1)
> +#define PM8607_MEAS_EN1_VSYS		(1 << 2)
> +#define PM8607_MEAS_EN1_TINT		(1 << 3)
> +#define PM8607_MEAS_EN1_RFTMP		(1 << 4)
> +#define PM8607_MEAS_EN1_TBAT		(1 << 5)
> +#define PM8607_MEAS_EN1_GPADC2		(1 << 6)
> +#define PM8607_MEAS_EN1_GPADC3		(1 << 7)
> +
> +/* Battery Monitor Registers */
> +#define PM8607_GP_BIAS2			(0x5A)
> +#define PM8607_VBAT_LOWTH		(0x5B)
> +#define PM8607_VCHG_LOWTH		(0x5C)
> +#define PM8607_VSYS_LOWTH		(0x5D)
> +#define PM8607_TINT_LOWTH		(0x5E)
> +#define PM8607_GPADC0_LOWTH		(0x5F)
> +#define PM8607_GPADC1_LOWTH		(0x60)
> +#define PM8607_GPADC2_LOWTH		(0x61)
> +#define PM8607_GPADC3_LOWTH		(0x62)
> +#define PM8607_VBAT_HIGHTH		(0x63)
> +#define PM8607_VCHG_HIGHTH		(0x64)
> +#define PM8607_VSYS_HIGHTH		(0x65)
> +#define PM8607_TINT_HIGHTH		(0x66)
> +#define PM8607_GPADC0_HIGHTH		(0x67)
> +#define PM8607_GPADC1_HIGHTH		(0x68)
> +#define PM8607_GPADC2_HIGHTH		(0x69)
> +#define PM8607_GPADC3_HIGHTH		(0x6A)
> +#define PM8607_IBAT_MEAS1		(0x6B)
> +#define PM8607_IBAT_MEAS2		(0x6C)
> +#define PM8607_VBAT_MEAS1		(0x6D)
> +#define PM8607_VBAT_MEAS2		(0x6E)
> +#define PM8607_VCHG_MEAS1		(0x6F)
> +#define PM8607_VCHG_MEAS2		(0x70)
> +#define PM8607_VSYS_MEAS1		(0x71)
> +#define PM8607_VSYS_MEAS2		(0x72)
> +#define PM8607_TINT_MEAS1		(0x73)
> +#define PM8607_TINT_MEAS2		(0x74)
> +#define PM8607_GPADC0_MEAS1		(0x75)
> +#define PM8607_GPADC0_MEAS2		(0x76)
> +#define PM8607_GPADC1_MEAS1		(0x77)
> +#define PM8607_GPADC1_MEAS2		(0x78)
> +#define PM8607_GPADC2_MEAS1		(0x79)
> +#define PM8607_GPADC2_MEAS2		(0x7A)
> +#define PM8607_GPADC3_MEAS1		(0x7B)
> +#define PM8607_GPADC3_MEAS2		(0x7C)
> +#define PM8607_CCNT_MEAS1		(0x95)
> +#define PM8607_CCNT_MEAS2		(0x96)
> +#define PM8607_VBAT_AVG			(0x97)
> +#define PM8607_VCHG_AVG			(0x98)
> +#define PM8607_VSYS_AVG			(0x99)
> +#define PM8607_VBAT_MIN			(0x9A)
> +#define PM8607_VCHG_MIN			(0x9B)
> +#define PM8607_VSYS_MIN			(0x9C)
> +#define PM8607_VBAT_MAX			(0x9D)
> +#define PM8607_VCHG_MAX			(0x9E)
> +#define PM8607_VSYS_MAX			(0x9F)
> +
> +#define PM8607_GPADC_MISC2		(0x59)
> +#define PM8607_GPADC0_GP_BIAS_A0	(1 << 0)
> +#define PM8607_GPADC1_GP_BIAS_A1	(1 << 1)
> +#define PM8607_GPADC2_GP_BIAS_A2	(1 << 2)
> +#define PM8607_GPADC3_GP_BIAS_A3	(1 << 3)
> +#define PM8607_GPADC2_GP_BIAS_OUT2	(1 << 6)
> +
>  /* RTC Control Registers */
>  #define PM8607_RTC1			(0xA0)
>  #define PM8607_RTC_COUNTER1		(0xA1)
> @@ -370,7 +450,8 @@ struct pm860x_touch_pdata {
>  };
>  
>  struct pm860x_power_pdata {
> -	unsigned	fast_charge;	/* charge current */
> +	int		max_capacity;
> +	int		resistor;
>  };
>  
>  struct pm860x_platform_data {
> @@ -379,6 +460,7 @@ struct pm860x_platform_data {
>  	struct pm860x_rtc_pdata		*rtc;
>  	struct pm860x_touch_pdata	*touch;
>  	struct pm860x_power_pdata	*power;
> +	struct charger_desc		*chg_desc;
>  	struct regulator_init_data	*regulator;
>  
>  	unsigned short	companion_addr;	/* I2C address of companion chip */
> -- 
> 1.7.0.4
