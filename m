From: jett.zhou@gmail.com (jett zhou)
Date: Mon, 16 Jul 2012 13:27:00 +0800
Subject: [V3 3/4] power_supply: Enable battery-charger for 88pm860x
In-Reply-To: <20120714081254.GD20018@lizard>
References: <20120705141541.GO4111@opensource.wolfsonmicro.com>
 <1341543729-6529-1-git-send-email-jtzhou@marvell.com>
 <20120714081254.GD20018@lizard>
Message-ID: <CACDDiy_FbtC5tQhaHVL5KpiLc5bZKHneMD7T-iuKN+x_fW_oPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anton
     Thanks for your review comments and advice, I will amend them and
update again.
Thanks

2012/7/14 Anton Vorontsov <cbouatmailru@gmail.com>

> On Fri, Jul 06, 2012 at 11:02:09AM +0800, Jett.Zhou wrote:
> > There are charger and battery measurement feature for 88pm860x PMIC.
> >
> > For charger, it can support pre-charge with small current when battery is
> > nearly exausted and then changed into fast-charge with CC&CV mode.
> >
> > For battery monitor, it can support battery measurement such as
> > vbat,vsys,vchg and ibat etc,it can aslo accumulating the Coulomb value
> > charged or discharged from battery based on Conlomb Counter, we use it
> > to estimate battery capacity.
> >
> > Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
> > ---
>
> Thanks for the patches, Jett! I see it is a huge and complex driver,
> so no wonder it takes quite a bit of iterations to get it merged.
> It's all right, and you're making a good progress!
>
> [...]
> > diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
> > index d09918c..c8911f4 100644
> > --- a/drivers/mfd/88pm860x-core.c
> > +++ b/drivers/mfd/88pm860x-core.c
> > @@ -18,6 +18,7 @@
> [...]
> >  static struct mfd_cell rtc_devs[] = {
> > @@ -791,6 +798,19 @@ static void __devinit device_power_init(struct
> pm860x_chip *chip,
> >                             &preg_resources[0], chip->irq_base);
> >       if (ret < 0)
> >               dev_err(chip->dev, "Failed to add preg subdev\n");
> > +
> > +     if (pdata->chg_desc) {
> > +             pdata->chg_desc->charger_regulators =
> > +                     &chg_desc_regulator_data[0];
> > +             pdata->chg_desc->num_charger_regulators =
> > +                     ARRAY_SIZE(chg_desc_regulator_data),
> > +             power_devs[3].platform_data = pdata->chg_desc;
> > +             power_devs[3].pdata_size = sizeof(struct charger_desc);
>
> Please use sizeof() of a variable, not a type. I.e.
> sizeof(*pdata->chg_desc). This is usually preferred in the kernel code.
>
> > +             ret = mfd_add_devices(chip->dev, 0, &power_devs[3], 1,
> > +                                   NULL, chip->irq_base);
> > +             if (ret < 0)
> > +                     dev_err(chip->dev, "Failed to add chg-manager
> subdev\n");
> > +     }
> >  }
> >
> >  static void __devinit device_onkey_init(struct pm860x_chip *chip,
> > diff --git a/drivers/power/88pm860x_battery.c
> b/drivers/power/88pm860x_battery.c
> > new file mode 100644
> > index 0000000..132e2ee
> > --- /dev/null
> > +++ b/drivers/power/88pm860x_battery.c
> > @@ -0,0 +1,1026 @@
> > +/*
> > + * Battery driver for Marvell 88PM860x PMIC
> > + *
> > + * Copyright (c) 2012 Marvell International Ltd.
> > + * Author:   Jett Zhou <jtzhou@marvell.com>
> > + *           Haojian Zhuang <haojian.zhuang@marvell.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/mutex.h>
> > +#include <linux/string.h>
> > +#include <linux/power_supply.h>
> > +#include <linux/mfd/88pm860x.h>
> > +#include <linux/delay.h>
> > +
> > +/* bit definitions of Status Query Interface 2 */
> > +#define STATUS2_CHG                  (1 << 2)
> > +#define STATUS2_BAT                  (1 << 3)
> > +#define STATUS2_VBUS                 (1 << 4)
> > +
> > +/* bit definitions of Measurement Enable 1 Register */
> > +#define MEAS1_TINT                   (1 << 3)
> > +#define MEAS1_GP1                    (1 << 5)
> > +
> > +/* bit definitions of Measurement Enable 3 Register */
> > +#define MEAS3_IBAT                   (1 << 0)
> > +#define MEAS3_BAT_DET                        (1 << 1)
> > +#define MEAS3_CC                     (1 << 2)
> > +
> > +/* bit definitions of Measurement Off Time Register */
> > +#define MEAS_OFF_SLEEP_EN            (1 << 1)
> > +
> > +/* bit definitions of GPADC Bias Current 2 Register */
> > +#define GPBIAS2_GPADC1_SET           (2 << 4)
> > +/* GPADC1 Bias Current value in uA unit */
> > +#define GPBIAS2_GPADC1_UA            ((GPBIAS2_GPADC1_SET >> 4) * 5 + 1)
> > +
> > +/* bit definitions of GPADC Misc 1 Register */
> > +#define GPMISC1_GPADC_EN             (1 << 0)
> > +
> > +/* bit definitions of Charger Control 6 Register */
> > +#define CC6_BAT_DET_GPADC1           1
> > +
> > +/* bit definitions of Coulomb Counter Reading Register */
> > +#define CCNT_AVG_SEL                 (4 << 3)
> > +
> > +/* bit definitions of RTC miscellaneous Register1 */
> > +#define RTC_SOC_5LSB         (0x1F << 3)
> > +
> > +/* bit definitions of RTC Register1 */
> > +#define RTC_SOC_3MSB         (0x7)
> > +
> > +/* bit definitions of Power up Log register */
> > +#define BAT_WU_LOG                   (1<<6)
> > +
> > +/* coulomb counter index */
> > +#define CCNT_POS1                    0
> > +#define CCNT_POS2                    1
> > +#define CCNT_NEG1                    2
> > +#define CCNT_NEG2                    3
> > +#define CCNT_SPOS                    4
> > +#define CCNT_SNEG                    5
> > +
> > +/* OCV -- Open Circuit Voltage */
> > +#define OCV_MODE_ACTIVE                      0
> > +#define OCV_MODE_SLEEP                       1
> > +
> > +/* Vbat range of CC for measuring Rbat */
> > +#define LOW_BAT_THRESHOLD            3600
> > +#define VBATT_RESISTOR_MIN           3800
> > +#define VBATT_RESISTOR_MAX           4100
> > +
> > +/* TBAT for batt, TINT for chip itself */
> > +#define PM860X_TEMP_TINT             (0)
> > +#define PM860X_TEMP_TBAT             (1)
> > +
> > +/*
> > + * Battery temperature based on NTC resistor, defined
> > + * corresponding resistor value  -- Ohm / C degeree.
> > + */
> > +#define TBAT_NEG_25D         127773  /* -25 */
> > +#define TBAT_NEG_10D         54564   /* -10 */
> > +#define TBAT_0D                      32330   /* 0 */
> > +#define TBAT_10D             19785   /* 10 */
> > +#define TBAT_20D             12468   /* 20 */
> > +#define TBAT_30D             8072    /* 30 */
> > +#define TBAT_40D             5356    /* 40 */
> > +
> > +struct pm860x_battery_info {
> > +     struct pm860x_chip *chip;
> > +     struct i2c_client *i2c;
> > +     struct device *dev;
> > +
> > +     struct power_supply battery;
> > +     struct mutex lock;
> > +     int status;
> > +     int irq_cc;
> > +     int irq_batt;
> > +     int max_capacity;
> > +     int resistor;           /* Battery Internal Resistor */
> > +     int last_capacity;
> > +     int start_soc;
> > +     unsigned present:1;
> > +     unsigned temp_type:1;   /* TINT or TBAT */
> > +};
> > +
> > +struct ccnt {
> > +     unsigned long long int pos;
> > +     unsigned long long int neg;
> > +     unsigned int spos;
> > +     unsigned int sneg;
> > +
> > +     int total_chg;          /* mAh(3.6C) */
> > +     int total_dischg;       /* mAh(3.6C) */
> > +};
> > +
> > +/*
> > + * State of Charge.
> > + * The first number is mAh(=3.6C), and the second number is percent
> point.
> > + */
> > +int array_soc[][2] = { {4170, 100},
> > +{4154, 99}, {4136, 98}, {4122, 97}, {4107, 96},
>
> Maybe indent it properly? I.e.
>
> int array_soc[][2] = {
>         {...}, {...}, {...},
>         {...}, {...}, {...},
>         {...}, {...}, {...},
> };
>
> > +{4102, 95}, {4088, 94}, {4081, 93}, {4070, 92},
> > +{4060, 91}, {4053, 90}, {4044, 89}, {4035, 88},
> [...]
> > +{3637, 7}, {3622, 6}, {3609, 5}, {3580, 4},
> > +{3558, 3}, {3540, 2}, {3510, 1}, {3429, 0}
> > +};
> > +
> > +static struct ccnt ccnt_data;
> > +
> > +static int calc_ccnt(struct pm860x_battery_info *info, struct ccnt
> *ccnt);
> > +static int calc_soc(struct pm860x_battery_info *info, int state, int
> *soc);
> > +static int clear_ccnt(struct pm860x_battery_info *info, struct ccnt
> *ccnt);
> > +static int measure_current(struct pm860x_battery_info *info, int *data);
>
> Do you really need all these forward declarations, maybe it's possible
> to rearrange the functions and variables and thus avoid forward decls?
>
> > +
> > +static irqreturn_t pm860x_coulomb_handler(int irq, void *data)
> > +{
> > +     struct pm860x_battery_info *info = data;
> > +
> > +     calc_ccnt(info, &ccnt_data);
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t pm860x_batt_handler(int irq, void *data)
> > +{
> > +     struct pm860x_battery_info *info = data;
> > +     int ret;
> > +
> > +     mutex_lock(&info->lock);
> > +     ret = pm860x_reg_read(info->i2c, PM8607_STATUS_2);
> > +     if (ret & STATUS2_BAT) {
> > +             info->present = 1;
> > +             info->temp_type = PM860X_TEMP_TBAT;
> > +     } else {
> > +             info->present = 0;
> > +             info->temp_type = PM860X_TEMP_TINT;
> > +     }
> > +     mutex_unlock(&info->lock);
> > +     /* clear ccnt since battery is attached or dettached */
> > +     clear_ccnt(info, &ccnt_data);
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static void pm860x_init_battery(struct pm860x_battery_info *info)
> > +{
> > +     unsigned char buf[2];
> > +     int ret, data;
> > +     int bat_remove, soc;
>
> Please use one line per variable declaration, i.e.
>
> int ret;
> int data;
> int bat_remove;
> int soc;
>
> This is per linux coding style.
>
> > +
> > +     /* measure enable on GPADC1 */
> > +     data = MEAS1_GP1;
> > +     if (info->temp_type == PM860X_TEMP_TINT)
> > +             data |= MEAS1_TINT;
> > +     ret = pm860x_set_bits(info->i2c, PM8607_MEAS_EN1, data, data);
> > +     if (ret)
> > +             goto out;
> > +
> > +     /* measure enable on IBAT, BAT_DET, CC. IBAT is depend on CC. */
> > +     data = MEAS3_IBAT | MEAS3_BAT_DET | MEAS3_CC;
> > +     ret = pm860x_set_bits(info->i2c, PM8607_MEAS_EN3, data, data);
> > +     if (ret)
> > +             goto out;
> > +
> > +     /* measure disable CC in sleep time  */
> > +     ret = pm860x_reg_write(info->i2c, PM8607_MEAS_OFF_TIME1, 0x82);
> > +     if (ret)
> > +             goto out;
> > +     ret = pm860x_reg_write(info->i2c, PM8607_MEAS_OFF_TIME2, 0x6c);
> > +     if (ret)
> > +             goto out;
> > +
> > +     /* enable GPADC */
> > +     ret = pm860x_set_bits(info->i2c, PM8607_GPADC_MISC1,
> > +                         GPMISC1_GPADC_EN, GPMISC1_GPADC_EN);
> > +     if (ret < 0)
> > +             goto out;
> > +
> > +     /* detect battery via GPADC1 */
> > +     ret = pm860x_set_bits(info->i2c, PM8607_CHG_CTRL6,
> > +                         CC6_BAT_DET_GPADC1, CC6_BAT_DET_GPADC1);
> > +     if (ret < 0)
> > +             goto out;
> > +
> > +     ret = pm860x_set_bits(info->i2c, PM8607_CCNT, 7 << 3,
> > +                           CCNT_AVG_SEL);
> > +     if (ret < 0)
> > +             goto out;
> > +
> > +     /* set GPADC1 bias */
> > +     ret = pm860x_set_bits(info->i2c, PM8607_GP_BIAS2, 0xF << 4,
> > +                           GPBIAS2_GPADC1_SET);
> > +     if (ret < 0)
> > +             goto out;
> > +
> > +     /* check whether battery present) */
> > +     mutex_lock(&info->lock);
> > +     ret = pm860x_reg_read(info->i2c, PM8607_STATUS_2);
> > +     if (ret < 0) {
> > +             mutex_unlock(&info->lock);
> > +             goto out;
> > +     }
> > +     if (ret & STATUS2_BAT) {
> > +             info->present = 1;
> > +             info->temp_type = PM860X_TEMP_TBAT;
> > +     } else {
> > +             info->present = 0;
> > +             info->temp_type = PM860X_TEMP_TINT;
> > +     }
> > +     mutex_unlock(&info->lock);
> > +
> > +     calc_soc(info, OCV_MODE_ACTIVE, &soc);
> > +
> > +     data = pm860x_reg_read(info->i2c, PM8607_POWER_UP_LOG);
> > +     bat_remove = data & BAT_WU_LOG;
> > +
> > +     dev_dbg(info->dev, "battery wake up? %s\n",
> > +             bat_remove != 0 ? "yes" : "no");
> > +
> > +     /* restore SOC from RTC domain register */
> > +     if (bat_remove == 0) {
> > +             buf[0] = pm860x_reg_read(info->i2c, PM8607_RTC_MISC2);
> > +             buf[1] = pm860x_reg_read(info->i2c, PM8607_RTC1);
> > +             data = ((buf[1] & 0x3) << 5) | ((buf[0] >> 3) & 0x1F);
> > +             if (data > soc + 15)
> > +                     info->start_soc = soc;
> > +             else if (data < soc - 15)
> > +                     info->start_soc = soc;
> > +             else
> > +                     info->start_soc = data;
> > +             dev_dbg(info->dev, "soc_rtc %d, soc_ocv :%d\n", data, soc);
> > +     } else {
> > +             pm860x_set_bits(info->i2c, PM8607_POWER_UP_LOG,
> > +                             BAT_WU_LOG, BAT_WU_LOG);
> > +             info->start_soc = soc;
> > +     }
> > +     info->last_capacity = info->start_soc;
> > +     dev_dbg(info->dev, "init soc : %d\n", info->last_capacity);
> > +out:
> > +     return;
> > +}
> > +
> > +/*
> > + * register 1 bit[7:0] -- bit[11:4] of measured value of voltage
> > + * register 0 bit[3:0] -- bit[3:0] of measured value of voltage
> > + */
> > +static int measure_12bit_voltage(struct pm860x_battery_info *info,
> > +                              int offset, int *data)
> > +{
> > +     unsigned char buf[2];
> > +     int ret;
> > +
> > +     if (!data)
> > +             return -EINVAL;
>
> The condition is never true, thus it can be removed.
>
> > +
> > +     ret = pm860x_bulk_read(info->i2c, offset, 2, buf);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     *data = ((buf[0] & 0xff) << 4) | (buf[1] & 0x0f);
> > +     /* V_MEAS(mV) = data * 1.8 * 1000 / (2^12) */
> > +     *data = ((*data & 0xfff) * 9 * 25) >> 9;
> > +     return 0;
> > +}
> > +
> > +static int measure_vbatt(struct pm860x_battery_info *info, int state,
> > +                      int *data)
> > +{
> > +     unsigned char buf[5];
> > +     int ret = 0;
>
> There is no need for the initializer value here.
>
> > +
> > +     switch (state) {
> > +     case OCV_MODE_ACTIVE:
> > +             ret = measure_12bit_voltage(info, PM8607_VBAT_MEAS1, data);
> > +             if (ret)
> > +                     return ret;
> > +             /* V_BATT_MEAS(mV) = value * 3 * 1.8 * 1000 / (2^12) */
> > +             *data *= 3;
> > +             break;
> > +     case OCV_MODE_SLEEP:
> > +             /*
> > +              * voltage value of VBATT in sleep mode is saved in
> different
> > +              * registers.
> > +              * bit[11:10] -- bit[7:6] of LDO9(0x18)
> > +              * bit[9:8] -- bit[7:6] of LDO8(0x17)
> > +              * bit[7:6] -- bit[7:6] of LDO7(0x16)
> > +              * bit[5:4] -- bit[7:6] of LDO6(0x15)
> > +              * bit[3:0] -- bit[7:4] of LDO5(0x14)
> > +              */
> > +             ret = pm860x_bulk_read(info->i2c, PM8607_LDO5, 5, buf);
> > +             if (ret < 0)
> > +                     return ret;
> > +             ret = ((buf[4] >> 6) << 10) | ((buf[3] >> 6) << 8)
> > +                 | ((buf[2] >> 6) << 6) | ((buf[1] >> 6) << 4)
> > +                 | (buf[0] >> 4);
> > +             /* V_BATT_MEAS(mV) = data * 3 * 1.8 * 1000 / (2^12) */
> > +             *data = ((*data & 0xff) * 27 * 25) >> 9;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +     return 0;
> > +}
> > +
> > +static void set_temp_threshold(struct pm860x_battery_info *info,
> > +                            int min, int max)
> > +{
> > +     int data;
> > +
> > +     /* (tmp << 8) / 1800 */
> > +     if (min <= 0)
> > +             data = 0;
> > +     else
> > +             data = (min << 8) / 1800;
> > +     pm860x_reg_write(info->i2c, PM8607_GPADC1_HIGHTH, data);
> > +     dev_dbg(info->dev, "TEMP_HIGHTH : min: %d, 0x%x\n", min, data);
> > +
> > +     if (max <= 0)
> > +             data = 0xff;
> > +     else
> > +             data = (max << 8) / 1800;
> > +     pm860x_reg_write(info->i2c, PM8607_GPADC1_LOWTH, data);
> > +     dev_dbg(info->dev, "TEMP_LOWTH:max : %d, 0x%x\n", max, data);
> > +}
> > +
> > +static int measure_temp(struct pm860x_battery_info *info, int *data)
> > +{
> > +     int ret, temp;
> > +     int min, max;
>
> int ret;
> int temp;
> int min;
> int max;
>
> > +
> > +     if (!data)
> > +             return -EINVAL;
>
> This condition is not possible, so you can remove it.
>
> > +     if (info->temp_type == PM860X_TEMP_TINT) {
> > +             ret = measure_12bit_voltage(info, PM8607_TINT_MEAS1, data);
> > +             if (ret)
> > +                     return ret;
> > +             *data = (*data - 884) * 1000 / 3611;
> > +     } else {
> > +             ret = measure_12bit_voltage(info, PM8607_GPADC1_MEAS1,
> data);
> > +             if (ret)
> > +                     return ret;
> > +             /* meausered Vtbat(mV) / Ibias_current(11uA)*/
> > +             *data = (*data * 1000) / GPBIAS2_GPADC1_UA;
> > +
> > +             if (*data > TBAT_NEG_25D) {
> > +                     temp = -30;     /* over cold , suppose -30 roughly
> */
> > +                     max = TBAT_NEG_10D * GPBIAS2_GPADC1_UA / 1000;
> > +                     set_temp_threshold(info, 0, max);
> > +             } else if (*data > TBAT_NEG_10D) {
> > +                     temp = -15;     /* -15 degree, code */
> > +                     max = TBAT_NEG_10D * GPBIAS2_GPADC1_UA / 1000;
> > +                     set_temp_threshold(info, 0, max);
> > +             } else if (*data > TBAT_0D) {
> > +                     temp = -5;      /* -5 degree */
> > +                     min = TBAT_NEG_10D * GPBIAS2_GPADC1_UA / 1000;
> > +                     max = TBAT_40D * GPBIAS2_GPADC1_UA / 1000;
> > +                     set_temp_threshold(info, min, max);
> > +             } else if (*data > TBAT_10D) {
> > +                     temp = 5;       /* in range of (0, 10) */
> > +                     min = TBAT_NEG_10D * GPBIAS2_GPADC1_UA / 1000;
> > +                     max = TBAT_40D * GPBIAS2_GPADC1_UA / 1000;
> > +                     set_temp_threshold(info, min, max);
> > +             } else if (*data > TBAT_20D) {
> > +                     temp = 15;      /* in range of (10, 20) */
> > +                     min = TBAT_NEG_10D * GPBIAS2_GPADC1_UA / 1000;
> > +                     max = TBAT_40D * GPBIAS2_GPADC1_UA / 1000;
> > +                     set_temp_threshold(info, min, max);
> > +             } else if (*data > TBAT_30D) {
> > +                     temp = 25;      /* in range of (20, 30) */
> > +                     min = TBAT_NEG_10D * GPBIAS2_GPADC1_UA / 1000;
> > +                     max = TBAT_40D * GPBIAS2_GPADC1_UA / 1000;
> > +                     set_temp_threshold(info, min, max);
> > +             } else if (*data > TBAT_40D) {
> > +                     temp = 35;      /* in range of (30, 40) */
> > +                     min = TBAT_NEG_10D * GPBIAS2_GPADC1_UA / 1000;
> > +                     max = TBAT_40D * GPBIAS2_GPADC1_UA / 1000;
> > +                     set_temp_threshold(info, min, max);
> > +             } else {
> > +                     min = TBAT_40D * GPBIAS2_GPADC1_UA / 1000;
> > +                     set_temp_threshold(info, min, 0);
> > +                     temp = 45;      /* over heat ,suppose 45 roughly */
> > +             }
> > +
> > +             dev_dbg(info->dev, "temp_C:%d C,temp_mv:%d mv\n", temp,
> *data);
> > +             *data = temp;
> > +     }
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Return value is signed data.
> > + * Negative value means discharging, and positive value means charging.
> > + */
> > +static int measure_current(struct pm860x_battery_info *info, int *data)
> > +{
> > +     unsigned char buf[2];
> > +     short s;
> > +     int ret;
> > +
> > +     if (!data)
> > +             return -EINVAL;
>
> The condition is never true, so can be removed.
>
> > +
> > +     ret = pm860x_bulk_read(info->i2c, PM8607_IBAT_MEAS1, 2, buf);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     s = ((buf[0] & 0xff) << 8) | (buf[1] & 0xff);
> > +     /* current(mA) = value * 0.125 */
> > +     *data = s >> 3;
> > +     return 0;
> > +}
> > +
> > +static int set_charger_current(struct pm860x_battery_info *info, int
> data,
> > +                            int *old)
> > +{
> > +     int ret;
> > +
> > +     if (data < 50 || data > 1600 || !old)
> > +             return -EINVAL;
> > +
> > +     data = ((data - 50) / 50) & 0x1f;
> > +     *old = pm860x_reg_read(info->i2c, PM8607_CHG_CTRL2);
> > +     *old = (*old & 0x1f) * 50 + 50;
> > +     ret = pm860x_set_bits(info->i2c, PM8607_CHG_CTRL2, 0x1f, data);
> > +     if (ret < 0)
> > +             return ret;
> > +     return 0;
> > +}
> > +
> > +static int calc_resistor(struct pm860x_battery_info *info)
> > +{
> > +     int ret, i, data;
> > +     int vbatt_sum1, vbatt_sum2, chg_current;
> > +     int ibatt_sum1, ibatt_sum2;
>
> One variable declaration per line please.
>
> > +
> > +     ret = measure_current(info, &data);
> > +     /* make sure that charging is launched by data > 0 */
> > +     if (ret || data < 0)
> > +             goto out;
> > +
> > +     ret = measure_vbatt(info, OCV_MODE_ACTIVE, &data);
> > +     if (ret)
> > +             goto out;
> > +     /* calculate resistor only in CC charge mode */
> > +     if (data < VBATT_RESISTOR_MIN || data > VBATT_RESISTOR_MAX)
> > +             goto out;
> > +
> > +     /* current is saved */
> > +     if (set_charger_current(info, 500, &chg_current))
> > +             goto out;
> > +
> > +     msleep(500);
>
> Maybe add a comment why there's an msleep, any why it's exactly 500 ms?
>
> > +
> > +     for (i = 0, vbatt_sum1 = 0, ibatt_sum1 = 0; i < 10; i++) {
> > +             ret = measure_vbatt(info, OCV_MODE_ACTIVE, &data);
> > +             if (ret)
> > +                     goto out_meas;
> > +             vbatt_sum1 += data;
> > +             ret = measure_current(info, &data);
> > +             if (ret)
> > +                     goto out_meas;
> > +
> > +             if (data < 0)
> > +                     ibatt_sum1 = ibatt_sum1 - data; /* discharging */
> > +             else
> > +                     ibatt_sum1 = ibatt_sum1 + data; /* charging */
> > +     }
> > +
> > +     if (set_charger_current(info, 100, &ret))
> > +             goto out_meas;
> > +
> > +     msleep(500);
> > +
> > +     for (i = 0, vbatt_sum2 = 0, ibatt_sum2 = 0; i < 10; i++) {
> > +             ret = measure_vbatt(info, OCV_MODE_ACTIVE, &data);
> > +             if (ret)
> > +                     goto out_meas;
> > +             vbatt_sum2 += data;
> > +             ret = measure_current(info, &data);
> > +             if (ret)
> > +                     goto out_meas;
> > +
> > +             if (data < 0)
> > +                     ibatt_sum2 = ibatt_sum2 - data; /* discharging */
> > +             else
> > +                     ibatt_sum2 = ibatt_sum2 + data; /* charging */
> > +     }
> > +
> > +     /* restore current setting */
> > +     if (set_charger_current(info, chg_current, &ret))
> > +             goto out_meas;
> > +
> > +     if ((vbatt_sum1 > vbatt_sum2) && (ibatt_sum1 > ibatt_sum2)
> > +         && (ibatt_sum2 > 0)) {
> > +             /* calculate resistor in discharging case */
> > +             data = 1000 * (vbatt_sum1 - vbatt_sum2)
> > +                 / (ibatt_sum1 - ibatt_sum2);
> > +             if ((data - info->resistor > 0)
> > +                 && (data - info->resistor < info->resistor))
> > +                     info->resistor = data;
> > +             if ((info->resistor - data > 0)
> > +                 && (info->resistor - data < data))
> > +                     info->resistor = data;
> > +     }
> > +     return 0;
> > +
> > +out_meas:
> > +     set_charger_current(info, chg_current, &ret);
> > +out:
> > +     return -EINVAL;
> > +}
> > +
> > +static int read_ccnt(struct pm860x_battery_info *info, int offset,
> > +                  int *ccnt)
> > +{
> > +     unsigned char buf[2];
> > +     int ret;
> > +
> > +     if (!ccnt)
> > +             return -EINVAL;
>
> ccnt is always !NULL, so the check is unnecessary.
>
> > +
> > +     ret = pm860x_set_bits(info->i2c, PM8607_CCNT, 7, offset & 7);
> > +     if (ret < 0)
> > +             goto out;
> > +     ret = pm860x_bulk_read(info->i2c, PM8607_CCNT_MEAS1, 2, buf);
> > +     if (ret < 0)
> > +             goto out;
> > +     *ccnt = ((buf[0] & 0xff) << 8) | (buf[1] & 0xff);
> > +     return 0;
> > +out:
> > +     return ret;
> > +}
> > +
> > +static int calc_ccnt(struct pm860x_battery_info *info, struct ccnt
> *ccnt)
> > +{
> > +     unsigned int sum;
> > +     int ret, data;
>
> int ret;
> int data;
>
> > +
> > +     ret = read_ccnt(info, CCNT_POS1, &data);
> > +     if (ret)
> > +             goto out;
> > +     sum = data & 0xffff;
> > +     ret = read_ccnt(info, CCNT_POS2, &data);
> > +     if (ret)
> > +             goto out;
> > +     sum |= (data & 0xffff) << 16;
> > +     ccnt->pos += sum;
> > +
> > +     ret = read_ccnt(info, CCNT_NEG1, &data);
> > +     if (ret)
> > +             goto out;
> > +     sum = data & 0xffff;
> > +     ret = read_ccnt(info, CCNT_NEG2, &data);
> > +     if (ret)
> > +             goto out;
> > +     sum |= (data & 0xffff) << 16;
> > +     sum = ~sum + 1;         /* since it's negative */
> > +     ccnt->neg += sum;
> > +
> > +     ret = read_ccnt(info, CCNT_SPOS, &data);
> > +     if (ret)
> > +             goto out;
> > +     ccnt->spos += data;
> > +     ret = read_ccnt(info, CCNT_SNEG, &data);
> > +     if (ret)
> > +             goto out;
> > +
> > +     /*
> > +      * charge(mAh)  = count * 1.6984 * 1e(-8)
> > +      *              = count * 16984 * 1.024 * 1.024 * 1.024 / (2 ^ 40)
> > +      *              = count * 18236 / (2 ^ 40)
> > +      */
> > +     ccnt->total_chg = (int) ((ccnt->pos * 18236) >> 40);
> > +     ccnt->total_dischg = (int) ((ccnt->neg * 18236) >> 40);
> > +     return 0;
> > +out:
> > +     return ret;
> > +}
> > +
> > +static int clear_ccnt(struct pm860x_battery_info *info, struct ccnt
> *ccnt)
> > +{
> > +     int data;
> > +
> > +     memset(ccnt, 0, sizeof(struct ccnt));
>
> sizeof(*ccnt), this is what we prefer.
>
> > +     /* read to clear ccnt */
> > +     read_ccnt(info, CCNT_POS1, &data);
> > +     read_ccnt(info, CCNT_POS2, &data);
> > +     read_ccnt(info, CCNT_NEG1, &data);
> > +     read_ccnt(info, CCNT_NEG2, &data);
> > +     read_ccnt(info, CCNT_SPOS, &data);
> > +     read_ccnt(info, CCNT_SNEG, &data);
> > +     return 0;
> > +}
> > +
> > +/* Calculate Open Circuit Voltage */
> > +static int calc_ocv(struct pm860x_battery_info *info, int *ocv)
> > +{
> > +     int ret, i, data;
> > +     int vbatt_avg, vbatt_sum, ibatt_avg, ibatt_sum;
>
> here too.
>
> > +     if (!ocv)
> > +             return -EINVAL;
> > +
> > +     for (i = 0, ibatt_sum = 0, vbatt_sum = 0; i < 10; i++) {
> > +             ret = measure_vbatt(info, OCV_MODE_ACTIVE, &data);
> > +             if (ret)
> > +                     goto out;
> > +             vbatt_sum += data;
> > +             ret = measure_current(info, &data);
> > +             if (ret)
> > +                     goto out;
> > +             ibatt_sum += data;
> > +     }
> > +     vbatt_avg = vbatt_sum / 10;
> > +     ibatt_avg = ibatt_sum / 10;
> > +
> > +     mutex_lock(&info->lock);
> > +     if (info->present)
> > +             *ocv = vbatt_avg - ibatt_avg * info->resistor / 1000;
> > +     else
> > +             *ocv = vbatt_avg;
> > +     mutex_unlock(&info->lock);
> > +     dev_dbg(info->dev, "VBAT average:%d, OCV:%d\n", vbatt_avg, *ocv);
> > +     return 0;
> > +out:
> > +     return ret;
> > +}
> > +
> > +/* Calculate State of Charge (percent points) */
> > +static int calc_soc(struct pm860x_battery_info *info, int state, int
> *soc)
> > +{
> > +     int i, ocv, count, ret = -EINVAL;
>
> and here.
>
> > +
> > +     if (!soc)
> > +             return -EINVAL;
> > +
> > +     switch (state) {
> > +     case OCV_MODE_ACTIVE:
> > +             ret = calc_ocv(info, &ocv);
> > +             break;
> > +     case OCV_MODE_SLEEP:
> > +             ret = measure_vbatt(info, OCV_MODE_SLEEP, &ocv);
> > +             break;
> > +     }
> > +     if (ret)
> > +             goto out;
>
> I think there is no need for the out label. You can just
> write if (ret) return ret;
>
> > +
> > +     count = ARRAY_SIZE(array_soc);
> > +     if (ocv < array_soc[count - 1][0]) {
> > +             *soc = 0;
> > +             return 0;
> > +     }
> > +
> > +     for (i = 0; i < count; i++) {
> > +             if (ocv >= array_soc[i][0]) {
> > +                     *soc = array_soc[i][1];
> > +                     break;
> > +             }
> > +     }
> > +     return 0;
> > +out:
> > +     return ret;
> > +}
> > +
> > +static int calc_capacity(struct pm860x_battery_info *info, int *cap)
> > +{
> > +     int ret, data, ibat;
> > +     int cap_ocv = 0, cap_cc = 0;
>
> One variable declaration per line please.
>
> > +     ret = calc_ccnt(info, &ccnt_data);
> > +     if (ret)
> > +             goto out;
> > +soc:
> > +     data = info->max_capacity * info->start_soc / 100;
> > +     if (ccnt_data.total_dischg - ccnt_data.total_chg <= data) {
> > +             cap_cc =
> > +                 data + ccnt_data.total_chg - ccnt_data.total_dischg;
> > +     } else {
> > +             clear_ccnt(info, &ccnt_data);
> > +             calc_soc(info, OCV_MODE_ACTIVE, &info->start_soc);
> > +             dev_dbg(info->dev, "restart soc = %d !\n",
> > +                     info->start_soc);
> > +             goto soc;
> > +     }
> > +
> > +     cap_cc = cap_cc * 100 / info->max_capacity;
> > +     if (cap_cc < 0)
> > +             cap_cc = 0;
> > +     else if (cap_cc > 100)
> > +             cap_cc = 100;
> > +
> > +     dev_dbg(info->dev, "%s, last cap : %d", __func__,
> > +             info->last_capacity);
> > +
> > +     ret = measure_current(info, &ibat);
> > +     if (ret)
> > +             goto out;
> > +     /* Calculate the capacity when discharging(ibat < 0) */
> > +     if (ibat < 0) {
> > +             ret = calc_soc(info, OCV_MODE_ACTIVE, &cap_ocv);
> > +             if (ret)
> > +                     cap_ocv = info->last_capacity;
> > +             ret = measure_vbatt(info, OCV_MODE_ACTIVE, &data);
> > +             if (ret)
> > +                     goto out;
> > +             if (data <= LOW_BAT_THRESHOLD) {
> > +                     /* choose the lower capacity value to report
> > +                      * between vbat and CC when vbat < 3.6v;
> > +                      * than 3.6v;
> > +                      */
> > +                     *cap = min(cap_ocv, cap_cc);
> > +             } else {
> > +                     /* when detect vbat > 3.6v, but cap_cc < 15,and
> > +                      * cap_ocv is 10% larger than cap_cc, we can think
> > +                      * CC have some accumulation error, switch to OCV
> > +                      * to estimate capacity;
> > +                      * */
> > +                     if (cap_cc < 15 && cap_ocv - cap_cc > 10)
> > +                             *cap = cap_ocv;
> > +                     else
> > +                             *cap = cap_cc;
> > +             }
> > +             /* when discharging, make sure current capacity
> > +              * is lower than last*/
> > +             if (*cap > info->last_capacity)
> > +                     *cap = info->last_capacity;
> > +     } else {
> > +             *cap = cap_cc;
> > +     }
> > +     info->last_capacity = *cap;
> > +
> > +     dev_dbg(info->dev, "%s, cap_ocv:%d cap_cc:%d, cap:%d\n",
> > +             (ibat < 0) ? "discharging" : "charging",
> > +              cap_ocv, cap_cc, *cap);
> > +     /*
> > +      * store the current capacity to RTC domain register,
> > +      * after next power up , it will be restored.
> > +      */
> > +     pm860x_set_bits(info->i2c, PM8607_RTC_MISC2, RTC_SOC_5LSB,
> > +                     (*cap & 0x1F) << 3);
> > +     pm860x_set_bits(info->i2c, PM8607_RTC1, RTC_SOC_3MSB,
> > +                     ((*cap >> 5) & 0x3));
> > +     return 0;
> > +out:
> > +     return ret;
> > +}
> > +
> > +static void pm860x_external_power_changed(struct power_supply *psy)
> > +{
> > +     struct pm860x_battery_info *info;
> > +
> > +     info = container_of(psy, struct pm860x_battery_info, battery);
> > +     calc_resistor(info);
> > +     return;
>
> No need for return statement here.
>
> > +}
> > +
> > +static int pm860x_batt_get_prop(struct power_supply *psy,
> > +                             enum power_supply_property psp,
> > +                             union power_supply_propval *val)
> > +{
> > +     struct pm860x_battery_info *info =
> > +         dev_get_drvdata(psy->dev->parent);
>
> No need for line wrap here.
>
> > +     int data, ret;
>
> One variable per line.
>
> > +
> > +     switch (psp) {
> > +     case POWER_SUPPLY_PROP_PRESENT:
> > +             val->intval = info->present;
> > +             break;
> > +     case POWER_SUPPLY_PROP_CAPACITY:
> > +             ret = calc_capacity(info, &data);
> > +             if (ret)
> > +                     goto out;
> > +             if (data < 0)
> > +                     data = 0;
> > +             else if (data > 100)
> > +                     data = 100;
> > +             /* return 100 if battery is not attached */
> > +             if (!info->present)
> > +                     data = 100;
> > +             val->intval = data;
> > +             break;
> > +     case POWER_SUPPLY_PROP_TECHNOLOGY:
> > +             val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
> > +             break;
> > +     case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> > +             /* return real vbatt Voltage */
> > +             ret = measure_vbatt(info, OCV_MODE_ACTIVE, &data);
> > +             if (ret)
> > +                     goto out;
> > +             val->intval = data * 1000;
> > +             break;
> > +     case POWER_SUPPLY_PROP_VOLTAGE_AVG:
> > +             /* return Open Circuit Voltage (not measured voltage) */
> > +             ret = calc_ocv(info, &data);
> > +             if (ret)
> > +                     goto out;
> > +             val->intval = data * 1000;
> > +             break;
> > +     case POWER_SUPPLY_PROP_CURRENT_NOW:
> > +             ret = measure_current(info, &data);
> > +             if (ret)
> > +                     goto out;
> > +             val->intval = data;
> > +             break;
> > +     case POWER_SUPPLY_PROP_TEMP:
> > +             if (info->present) {
> > +                     ret = measure_temp(info, &data);
> > +                     if (ret)
> > +                             goto out;
> > +                     data *= 10;
> > +             } else {
> > +                     /* Fake Temp 25C Without Battery */
> > +                     data = 250;
> > +             }
> > +             val->intval = data;
> > +             break;
> > +     default:
> > +             return -ENODEV;
> > +     }
> > +     return 0;
> > +out:
>
> No need for the label here, you can just replace all 'goto out;'
> with 'return ret';
>
> > +     return ret;
> > +}
> > +
> > +static int pm860x_batt_set_prop(struct power_supply *psy,
> > +                                    enum power_supply_property psp,
> > +                                    const union power_supply_propval
> *val)
> > +{
> > +     struct pm860x_battery_info *info =
> > +         dev_get_drvdata(psy->dev->parent);
>
> No need to wrap this line, it can fit into 80 chars limit.
>
> > +     switch (psp) {
> > +     case POWER_SUPPLY_PROP_CHARGE_FULL:
> > +             clear_ccnt(info, &ccnt_data);
> > +             info->start_soc = 100;
> > +             dev_dbg(info->dev, "chg done, update soc = %d\n",
> > +                     info->start_soc);
> > +             break;
> > +     default:
> > +             return -EPERM;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +
> > +static enum power_supply_property pm860x_batt_props[] = {
> > +     POWER_SUPPLY_PROP_PRESENT,
> > +     POWER_SUPPLY_PROP_CAPACITY,
> > +     POWER_SUPPLY_PROP_TECHNOLOGY,
> > +     POWER_SUPPLY_PROP_VOLTAGE_NOW,
> > +     POWER_SUPPLY_PROP_VOLTAGE_AVG,
> > +     POWER_SUPPLY_PROP_CURRENT_NOW,
> > +     POWER_SUPPLY_PROP_TEMP,
> > +};
> > +
> > +static __devinit int pm860x_battery_probe(struct platform_device *pdev)
> > +{
> > +     struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
> > +     struct pm860x_battery_info *info;
> > +     struct pm860x_power_pdata *pdata;
> > +     int ret;
> > +
> > +     info = kzalloc(sizeof(struct pm860x_battery_info), GFP_KERNEL);
>
> Please use sizeof(*info), and devm_kzalloc();
>
> > +     if (!info)
> > +             return -ENOMEM;
>
> An empty line here would look nice. :-)
>
> > +     info->irq_cc = platform_get_irq(pdev, 0);
> > +     if (info->irq_cc < 0) {
> > +             dev_err(&pdev->dev, "No IRQ resource!\n");
> > +             ret = -EINVAL;
> > +             goto out;
> > +     }
>
> Here too.
>
> > +     info->irq_batt = platform_get_irq(pdev, 1);
> > +     if (info->irq_batt < 0) {
>
> irq == 0 is also invalid, so the check should be <= 0
>
> > +             dev_err(&pdev->dev, "No IRQ resource!\n");
> > +             ret = -EINVAL;
> > +             goto out;
> > +     }
> > +
> > +     info->chip = chip;
> > +     info->i2c =
> > +         (chip->id == CHIP_PM8607) ? chip->client : chip->companion;
> > +     info->dev = &pdev->dev;
> > +     info->status = POWER_SUPPLY_STATUS_UNKNOWN;
> > +     pdata = pdev->dev.platform_data;
> > +
> > +     ret = request_threaded_irq(info->irq_cc, NULL,
> > +                             pm860x_coulomb_handler, IRQF_ONESHOT,
> > +                             "coulomb", info);
> > +     if (ret < 0) {
> > +             dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
> > +                     info->irq_cc, ret);
> > +             goto out;
> > +     }
>
> empty line here?
>
> > +     ret = request_threaded_irq(info->irq_batt, NULL,
> pm860x_batt_handler,
> > +                             IRQF_ONESHOT, "battery", info);
> > +     if (ret < 0) {
> > +             dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
> > +                     info->irq_batt, ret);
> > +             goto out_coulomb;
> > +     }
>
> You actually want to request irqs only after you sucessfuly
> initialized and registered the power supply (so, request_irq()
> usually is the last step in the probe routine), otherwise if
> interrupt arrives before power_supply object usable, bad things
> may happen.
>
> > +
> > +     mutex_init(&info->lock);
> > +     platform_set_drvdata(pdev, info);
> > +
> > +     pm860x_init_battery(info);
> > +
> > +     info->battery.name = "battery-monitor";
> > +     info->battery.type = POWER_SUPPLY_TYPE_BATTERY;
> > +     info->battery.properties = pm860x_batt_props;
> > +     info->battery.num_properties = ARRAY_SIZE(pm860x_batt_props);
> > +     info->battery.get_property = pm860x_batt_get_prop;
> > +     info->battery.set_property = pm860x_batt_set_prop;
> > +     info->battery.external_power_changed =
> pm860x_external_power_changed;
> > +
> > +     if (pdata && pdata->max_capacity)
> > +             info->max_capacity = pdata->max_capacity;
> > +     else
> > +             info->max_capacity = 1500;      /* set default capacity */
> > +     if (pdata && pdata->resistor)
> > +             info->resistor = pdata->resistor;
> > +     else
> > +             info->resistor = 300;   /* set default internal resistor */
> > +
> > +     ret = power_supply_register(&pdev->dev, &info->battery);
> > +     if (ret)
> > +             goto out_reg;
> > +     info->battery.dev->parent = &pdev->dev;
> > +
> > +     return 0;
> > +
> > +out_reg:
> > +     free_irq(info->irq_batt, info);
> > +out_coulomb:
> > +     free_irq(info->irq_cc, info);
> > +out:
> > +     kfree(info);
> > +     return ret;
> > +}
> > +
> > +static int __devexit pm860x_battery_remove(struct platform_device *pdev)
> > +{
> > +     struct pm860x_battery_info *info = platform_get_drvdata(pdev);
> > +
> > +     power_supply_unregister(&info->battery);
> > +     free_irq(info->irq_batt, info);
> > +     free_irq(info->irq_cc, info);
> > +     kfree(info);
> > +     platform_set_drvdata(pdev, NULL);
> > +     return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static int pm860x_battery_suspend(struct device *dev)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int pm860x_battery_resume(struct device *dev)
> > +{
> > +     return 0;
> > +}
> > +#endif
> > +static SIMPLE_DEV_PM_OPS(pm860x_battery_pm_ops, pm860x_battery_suspend,
> > +                      pm860x_battery_resume);
>
> No need for these empty callbacks.
>
> > +static struct platform_driver pm860x_battery_driver = {
> > +     .driver = {
> > +                .name = "88pm860x-battery",
> > +                .owner = THIS_MODULE,
> > +                .pm = &pm860x_battery_pm_ops,
> > +                },
>
> Wrong indentation for the closing bracket.
>
> > +     .probe = pm860x_battery_probe,
> > +     .remove = __devexit_p(pm860x_battery_remove),
> > +};
> > +
>
> please no empty line here
>
> > +module_platform_driver(pm860x_battery_driver);
> > +
> > +MODULE_DESCRIPTION("Marvell 88PM860x Battery driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/power/88pm860x_charger.c
> b/drivers/power/88pm860x_charger.c
> > new file mode 100644
> > index 0000000..0089ad4
> > --- /dev/null
> > +++ b/drivers/power/88pm860x_charger.c
> > @@ -0,0 +1,833 @@
> > +/*
> > + * Battery driver for Marvell 88PM860x PMIC
> > + *
> > + * Copyright (c) 2012 Marvell International Ltd.
> > + * Author:   Jett Zhou <jtzhou@marvell.com>
> > + *           Haojian Zhuang <haojian.zhuang@marvell.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/power_supply.h>
> > +#include <linux/mfd/88pm860x.h>
> > +#include <linux/delay.h>
> > +#include <linux/uaccess.h>
> > +#include <asm/div64.h>
> > +
> > +
>
> No need for two empty lines.
>
> > +/* bit definitions of Status Query Interface 2 */
> > +#define STATUS2_CHG          (1 << 2)
> > +
> > +/* bit definitions of Reset Out Register */
> > +#define RESET_SW_PD          (1 << 7)
> > +
> > +/* bit definitions of PreReg 1 */
> > +#define PREREG1_90MA         (0x0)
> > +#define PREREG1_180MA                (0x1)
> > +#define PREREG1_450MA                (0x4)
> > +#define PREREG1_540MA                (0x5)
> > +#define PREREG1_1350MA               (0xE)
> > +#define PREREG1_VSYS_4_5V    (3 << 4)
> > +
> > +/* bit definitions of Charger Control 1 Register */
> > +#define CC1_MODE_OFF         (0)
> > +#define CC1_MODE_PRECHARGE   (1)
> > +#define CC1_MODE_FASTCHARGE  (2)
> > +#define CC1_MODE_PULSECHARGE (3)
> > +#define CC1_ITERM_20MA               (0 << 2)
> > +#define CC1_ITERM_60MA               (2 << 2)
> > +#define CC1_VFCHG_4_2V               (9 << 4)
> > +
> > +/* bit definitions of Charger Control 2 Register */
> > +#define CC2_ICHG_100MA               (0x1)
> > +#define CC2_ICHG_500MA               (0x9)
> > +#define CC2_ICHG_1000MA              (0x13)
> > +
> > +/* bit definitions of Charger Control 3 Register */
> > +#define CC3_180MIN_TIMEOUT   (0x6 << 4)
> > +#define CC3_270MIN_TIMEOUT   (0x7 << 4)
> > +#define CC3_360MIN_TIMEOUT   (0xA << 4)
> > +#define CC3_DISABLE_TIMEOUT  (0xF << 4)
> > +
> > +/* bit definitions of Charger Control 4 Register */
> > +#define CC4_IPRE_40MA                (7)
> > +#define CC4_VPCHG_3_2V               (3 << 4)
> > +#define CC4_IFCHG_MON_EN     (1 << 6)
> > +#define CC4_BTEMP_MON_EN     (1 << 7)
> > +
> > +/* bit definitions of Charger Control 6 Register */
> > +#define CC6_BAT_OV_EN                (1 << 2)
> > +#define CC6_BAT_UV_EN                (1 << 3)
> > +#define CC6_UV_VBAT_SET              (0x3 << 6)      /* 2.8v */
> > +
> > +/* bit definitions of Charger Control 7 Register */
> > +#define CC7_BAT_REM_EN               (1 << 3)
> > +#define CC7_IFSM_EN          (1 << 7)
> > +
> > +/* bit definitions of Measurement Enable 1 Register */
> > +#define MEAS1_VBAT           (1 << 0)
> > +
> > +/* bit definitions of Measurement Enable 3 Register */
> > +#define MEAS3_IBAT_EN                (1 << 0)
> > +#define MEAS3_CC_EN          (1 << 2)
> > +
> > +#define FSM_INIT             0
> > +#define FSM_DISCHARGE                1
> > +#define FSM_PRECHARGE                2
> > +#define FSM_FASTCHARGE               3
> > +
> > +#define PRECHARGE_THRESHOLD  3100
> > +#define POWEROFF_THRESHOLD   3400
> > +#define CHARGE_THRESHOLD     4000
> > +#define DISCHARGE_THRESHOLD  4180
> > +
> > +/* over-temperature on PM8606 setting */
> > +#define OVER_TEMP_FLAG               (1 << 6)
> > +#define OVTEMP_AUTORECOVER   (1 << 3)
> > +
> > +/* over-voltage protect on vchg setting mv */
> > +#define VCHG_NORMAL_LOW              4200
> > +#define VCHG_NORMAL_CHECK    5800
> > +#define VCHG_NORMAL_HIGH     6000
> > +#define VCHG_OVP_LOW         5500
> > +
> > +struct pm860x_charger_info {
> > +     struct pm860x_chip *chip;
> > +     struct i2c_client *i2c;
> > +     struct i2c_client *i2c_8606;
> > +     struct device *dev;
> > +
> > +     struct power_supply usb;
> > +     struct mutex lock;
> > +     int irq_nums;
> > +     int irq[7];
> > +     unsigned state:3;       /* fsm state */
> > +     unsigned online:1;      /* usb charger */
> > +     unsigned present:1;     /* battery present */
> > +     unsigned allowed:1;
> > +};
> > +
> > +static char *pm860x_supplied_to[] = {
> > +     "battery-monitor",
> > +};
> > +
> > +static int stop_charge(struct pm860x_charger_info *info, int vbatt);
> > +static int set_charging_fsm(struct pm860x_charger_info *info);
> > +static void set_vbatt_threshold(struct pm860x_charger_info *info,
> > +                             int min, int max);
> > +static void set_vchg_threshold(struct pm860x_charger_info *info,
> > +                            int min, int max);
> > +static int measure_vchg(struct pm860x_charger_info *info, int *data);
>
> The same suggestion: try to reorder functions to avoid forward
> declarations.
>
> > +static irqreturn_t pm860x_charger_handler(int irq, void *data)
> > +{
> > +     struct pm860x_charger_info *info = data;
> > +     int ret;
> > +
> > +     mutex_lock(&info->lock);
> > +     ret = pm860x_reg_read(info->i2c, PM8607_STATUS_2);
> > +     if (ret < 0) {
> > +             mutex_unlock(&info->lock);
> > +             goto out;
> > +     }
> > +     if (ret & STATUS2_CHG) {
> > +             info->online = 1;
> > +             info->allowed = 1;
> > +     } else {
> > +             info->online = 0;
> > +             info->allowed = 0;
> > +     }
> > +     mutex_unlock(&info->lock);
> > +     dev_dbg(info->dev, "%s, Charger:%s, Allowed:%d\n", __func__,
> > +             (info->online) ? "online" : "N/A", info->allowed);
> > +
> > +     set_charging_fsm(info);
> > +
> > +     power_supply_changed(&info->usb);
> > +out:
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t pm860x_temp_handler(int irq, void *data)
> > +{
> > +     struct power_supply *psy;
> > +     struct pm860x_charger_info *info = data;
> > +     union power_supply_propval temp;
> > +     int value, ret = -EINVAL;
>
> no need for the initializer for ret.
> plus again, one variable per line.
>
> > +
> > +     psy = power_supply_get_by_name(pm860x_supplied_to[0]);
> > +     if (!psy)
> > +             goto out;
> > +     ret = psy->get_property(psy, POWER_SUPPLY_PROP_TEMP, &temp);
> > +     if (ret)
> > +             goto out;
> > +     value = temp.intval / 10;
> > +
> > +     mutex_lock(&info->lock);
> > +     /* Temperature < -10 C or >40 C, Will not allow charge */
> > +     if (value < -10 || value > 40)
> > +             info->allowed = 0;
> > +     else
> > +             info->allowed = 1;
> > +     dev_dbg(info->dev, "%s, Allowed: %d\n", __func__, info->allowed);
> > +     mutex_unlock(&info->lock);
> > +
> > +     set_charging_fsm(info);
> > +out:
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t pm860x_exception_handler(int irq, void *data)
> > +{
> > +     struct pm860x_charger_info *info = data;
> > +
> > +     mutex_lock(&info->lock);
> > +     info->allowed = 0;
> > +     mutex_unlock(&info->lock);
> > +     dev_dbg(info->dev, "%s, irq: %d\n", __func__, irq);
> > +
> > +     set_charging_fsm(info);
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t pm860x_done_handler(int irq, void *data)
> > +{
> > +     struct pm860x_charger_info *info = data;
> > +     struct power_supply *psy;
> > +     union power_supply_propval val;
> > +     int ret, vbatt;
>
> int ret;
> int vbatt;
>
> > +
> > +     mutex_lock(&info->lock);
> > +     /* pre-charge done, will transimit to fast-charge stage */
> > +     if (info->state == FSM_PRECHARGE) {
> > +             info->allowed = 1;
> > +             goto out;
> > +     }
> > +     /*
> > +      * Fast charge done, delay to read
> > +      * the correct status of CHG_DET.
> > +      */
> > +     mdelay(5);
> > +     info->allowed = 0;
> > +     psy = power_supply_get_by_name(pm860x_supplied_to[0]);
> > +     if (!psy)
> > +             goto out;
> > +     ret = psy->get_property(psy, POWER_SUPPLY_PROP_VOLTAGE_NOW, &val);
> > +     if (ret)
> > +             goto out;
> > +     vbatt = val.intval / 1000;
> > +     /*
> > +      * CHG_DONE interrupt is faster than CHG_DET interrupt when
> > +      * plug in/out usb, So we can not rely on info->online, we
> > +      * need check pm8607 status register to check usb is online
> > +      * or not, then we can decide it is real charge done
> > +      * automatically or it is triggered by usb plug out;
> > +      */
> > +     ret = pm860x_reg_read(info->i2c, PM8607_STATUS_2);
> > +     if (ret < 0)
> > +             goto out;
> > +     if (vbatt > CHARGE_THRESHOLD && ret & STATUS2_CHG)
> > +             psy->set_property(psy, POWER_SUPPLY_PROP_CHARGE_FULL,
> &val);
> > +
> > +out:
> > +     mutex_unlock(&info->lock);
> > +     dev_dbg(info->dev, "%s, Allowed: %d\n", __func__, info->allowed);
> > +     set_charging_fsm(info);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t pm860x_vbattery_handler(int irq, void *data)
> > +{
> > +     struct pm860x_charger_info *info = data;
> > +
> > +     mutex_lock(&info->lock);
> > +
> > +     set_vbatt_threshold(info, 0, 0);
> > +
> > +     if (info->present && info->online)
> > +             info->allowed = 1;
> > +     else
> > +             info->allowed = 0;
> > +     mutex_unlock(&info->lock);
> > +     dev_dbg(info->dev, "%s, Allowed: %d\n", __func__, info->allowed);
> > +
> > +     set_charging_fsm(info);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t pm860x_vchg_handler(int irq, void *data)
> > +{
> > +     struct pm860x_charger_info *info = data;
> > +     int vchg = 0, status = 0;
>
> No need for the initializer for status. Plus you can move satus
> variable declaration under the "if (!info->online) {" block.
>
> > +
> > +     if (info->present)
> > +             goto out;
> > +
> > +     measure_vchg(info, &vchg);
> > +
> > +     mutex_lock(&info->lock);
> > +     if (!info->online) {
> > +             /* check if over-temp on pm8606 or not */
> > +             status = pm860x_reg_read(info->i2c_8606, PM8606_FLAGS);
> > +             if (status & OVER_TEMP_FLAG) {
> > +                     /* clear over temp flag and set auto recover */
> > +                     pm860x_set_bits(info->i2c_8606, PM8606_FLAGS,
> > +                                     OVER_TEMP_FLAG, OVER_TEMP_FLAG);
> > +                     pm860x_set_bits(info->i2c_8606,
> > +                                     PM8606_VSYS,
> > +                                     OVTEMP_AUTORECOVER,
> > +                                     OVTEMP_AUTORECOVER);
> > +                     dev_dbg(info->dev,
> > +                             "%s, pm8606 over-temp occure\n", __func__);
> > +             }
> > +     }
> > +
> > +     if (vchg > VCHG_NORMAL_CHECK) {
> > +             set_vchg_threshold(info, VCHG_OVP_LOW, 0);
> > +             info->allowed = 0;
> > +             dev_dbg(info->dev,
> > +                     "%s,pm8607 over-vchg occure,vchg = %dmv\n",
> > +                     __func__, vchg);
> > +     } else if (vchg < VCHG_OVP_LOW) {
> > +             set_vchg_threshold(info, VCHG_NORMAL_LOW,
> > +                                VCHG_NORMAL_HIGH);
> > +             info->allowed = 1;
> > +             dev_dbg(info->dev,
> > +                     "%s,pm8607 over-vchg recover,vchg = %dmv\n",
> > +                     __func__, vchg);
> > +     }
> > +     mutex_unlock(&info->lock);
> > +
> > +     dev_dbg(info->dev, "%s, Allowed: %d\n", __func__, info->allowed);
> > +     set_charging_fsm(info);
> > +out:
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static ssize_t stop_charging(struct device *dev,
> > +                          struct device_attribute *attr,
> > +                          const char *buf, size_t count)
> > +{
> > +     struct pm860x_charger_info *info = dev_get_drvdata(dev);
> > +     int disable;
> > +
> > +     sscanf(buf, "%d", &disable);
> > +     if (disable && info) {
> > +             dev_dbg(info->dev, "stop charging by manual\n");
> > +
> > +             mutex_lock(&info->lock);
> > +             info->allowed = 0;
> > +             mutex_unlock(&info->lock);
> > +             set_charging_fsm(info);
> > +     }
> > +     return strnlen(buf, PAGE_SIZE);
> > +}
> > +
> > +static DEVICE_ATTR(stop, S_IWUSR, NULL, stop_charging);
>
> Um... can we handle this via set_property() for PROP_STATUS?
> E.g. if set to "Not charging" you manually disable it. And if set
> for any other value, enable it.
>
> If so, would be nice to have it documented in
> Documentation/power/power_supply_class.txt.
>
> > +static int pm860x_usb_get_prop(struct power_supply *psy,
> > +                            enum power_supply_property psp,
> > +                            union power_supply_propval *val)
> > +{
> > +     struct pm860x_charger_info *info =
> > +         dev_get_drvdata(psy->dev->parent);
> > +
> > +     switch (psp) {
> > +     case POWER_SUPPLY_PROP_STATUS:
> > +             val->intval = (info->state == FSM_FASTCHARGE ||
> > +                             info->state == FSM_PRECHARGE);
>
> This assumes that POWER_SUPPLY_STATUS_CHARGING will always be '1',
> but it is not true. It's better to assign enum value explicitly.
>
> Plus, if not in fastcharge or precharge state, it will return
> 0, which is POWER_SUPPLY_STATUS_UNKNOWN. Is that really what
> you want here?
>
> > +             break;
> > +     case POWER_SUPPLY_PROP_ONLINE:
> > +             val->intval = info->online;
> > +             break;
> > +     default:
> > +             return -ENODEV;
> > +     }
> > +     return 0;
> > +}
> > +
> > +static enum power_supply_property pm860x_usb_props[] = {
> > +     POWER_SUPPLY_PROP_STATUS,
> > +     POWER_SUPPLY_PROP_ONLINE,
> > +};
> > +
> > +static int measure_vchg(struct pm860x_charger_info *info, int *data)
> > +{
> > +     unsigned char buf[2];
> > +     int ret = 0;
> > +
> > +     ret = pm860x_bulk_read(info->i2c, PM8607_VCHG_MEAS1, 2, buf);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     *data = ((buf[0] & 0xff) << 4) | (buf[1] & 0x0f);
> > +     /* V_BATT_MEAS(mV) = value * 5 * 1.8 * 1000 / (2^12) */
> > +     *data = ((*data & 0xfff) * 9 * 125) >> 9;
> > +
> > +     dev_dbg(info->dev, "%s, vchg: %d mv\n", __func__, *data);
> > +
> > +     return ret;
> > +}
> > +
> > +static void set_vchg_threshold(struct pm860x_charger_info *info,
> > +                            int min, int max)
> > +{
> > +     int data;
> > +
> > +     /* (tmp << 8) * / 5 / 1800 */
> > +     if (min <= 0)
> > +             data = 0;
> > +     else
> > +             data = (min << 5) / 1125;
> > +     pm860x_reg_write(info->i2c, PM8607_VCHG_LOWTH, data);
> > +     dev_dbg(info->dev, "VCHG_LOWTH:%dmv, 0x%x\n", min, data);
> > +
> > +     if (max <= 0)
> > +             data = 0xff;
> > +     else
> > +             data = (max << 5) / 1125;
> > +     pm860x_reg_write(info->i2c, PM8607_VCHG_HIGHTH, data);
> > +     dev_dbg(info->dev, "VCHG_HIGHTH:%dmv, 0x%x\n", max, data);
> > +
> > +}
> > +
> > +static void set_vbatt_threshold(struct pm860x_charger_info *info,
> > +                             int min, int max)
> > +{
> > +     int data;
> > +
> > +     /* (tmp << 8) * 3 / 1800 */
> > +     if (min <= 0)
> > +             data = 0;
> > +     else
> > +             data = (min << 5) / 675;
> > +     pm860x_reg_write(info->i2c, PM8607_VBAT_LOWTH, data);
> > +     dev_dbg(info->dev, "VBAT Min:%dmv, LOWTH:0x%x\n", min, data);
> > +
> > +     if (max <= 0)
> > +             data = 0xff;
> > +     else
> > +             data = (max << 5) / 675;
> > +     pm860x_reg_write(info->i2c, PM8607_VBAT_HIGHTH, data);
> > +     dev_dbg(info->dev, "VBAT Max:%dmv, HIGHTH:0x%x\n", max, data);
> > +
> > +     return;
> > +}
> > +
> > +static int start_precharge(struct pm860x_charger_info *info)
> > +{
> > +     int ret;
> > +
> > +     dev_dbg(info->dev, "Start Pre-charging!\n");
> > +     set_vbatt_threshold(info, 0, 0);
> > +
> > +     ret = pm860x_reg_write(info->i2c_8606, PM8606_PREREGULATORA,
> > +                            PREREG1_1350MA | PREREG1_VSYS_4_5V);
> > +     if (ret < 0)
> > +             goto out;
> > +     /* stop charging */
> > +     ret = pm860x_set_bits(info->i2c, PM8607_CHG_CTRL1, 3,
> > +                           CC1_MODE_OFF);
> > +     if (ret < 0)
> > +             goto out;
> > +     /* set 270 minutes timeout */
> > +     ret = pm860x_set_bits(info->i2c, PM8607_CHG_CTRL3, (0xf << 4),
> > +                           CC3_270MIN_TIMEOUT);
> > +     if (ret < 0)
> > +             goto out;
> > +     /* set precharge current, termination voltage, IBAT & TBAT monitor
> */
> > +     ret = pm860x_reg_write(info->i2c, PM8607_CHG_CTRL4,
> > +                            CC4_IPRE_40MA | CC4_VPCHG_3_2V |
> > +                            CC4_IFCHG_MON_EN | CC4_BTEMP_MON_EN);
> > +     if (ret < 0)
> > +             goto out;
> > +     ret = pm860x_set_bits(info->i2c, PM8607_CHG_CTRL7,
> > +                           CC7_BAT_REM_EN | CC7_IFSM_EN,
> > +                           CC7_BAT_REM_EN | CC7_IFSM_EN);
> > +     if (ret < 0)
> > +             goto out;
> > +     /* trigger precharge */
> > +     ret = pm860x_set_bits(info->i2c, PM8607_CHG_CTRL1, 3,
> > +                           CC1_MODE_PRECHARGE);
> > +out:
> > +     return ret;
> > +}
> > +
> > +static int start_fastcharge(struct pm860x_charger_info *info)
> > +{
> > +     int ret;
> > +
> > +     dev_dbg(info->dev, "Start Fast-charging!\n");
> > +
> > +     /* set fastcharge termination current & voltage, disable charging
> */
> > +     ret = pm860x_reg_write(info->i2c, PM8607_CHG_CTRL1,
> > +                            CC1_MODE_OFF | CC1_ITERM_60MA |
> > +                            CC1_VFCHG_4_2V);
> > +     if (ret < 0)
> > +             goto out;
> > +     ret = pm860x_reg_write(info->i2c_8606, PM8606_PREREGULATORA,
> > +                            PREREG1_540MA | PREREG1_VSYS_4_5V);
> > +     if (ret < 0)
> > +             goto out;
> > +     ret = pm860x_set_bits(info->i2c, PM8607_CHG_CTRL2, 0x1f,
> > +                           CC2_ICHG_500MA);
> > +     if (ret < 0)
> > +             goto out;
> > +     /* set 270 minutes timeout */
> > +     ret = pm860x_set_bits(info->i2c, PM8607_CHG_CTRL3, (0xf << 4),
> > +                           CC3_270MIN_TIMEOUT);
> > +     if (ret < 0)
> > +             goto out;
> > +     /* set IBAT & TBAT monitor */
> > +     ret = pm860x_set_bits(info->i2c, PM8607_CHG_CTRL4,
> > +                           CC4_IFCHG_MON_EN | CC4_BTEMP_MON_EN,
> > +                           CC4_IFCHG_MON_EN | CC4_BTEMP_MON_EN);
> > +     if (ret < 0)
> > +             goto out;
> > +     ret = pm860x_set_bits(info->i2c, PM8607_CHG_CTRL6,
> > +                           CC6_BAT_OV_EN | CC6_BAT_UV_EN |
> > +                           CC6_UV_VBAT_SET,
> > +                           CC6_BAT_OV_EN | CC6_BAT_UV_EN |
> > +                           CC6_UV_VBAT_SET);
> > +     if (ret < 0)
> > +             goto out;
> > +     ret = pm860x_set_bits(info->i2c, PM8607_CHG_CTRL7,
> > +                           CC7_BAT_REM_EN | CC7_IFSM_EN,
> > +                           CC7_BAT_REM_EN | CC7_IFSM_EN);
> > +     if (ret < 0)
> > +             goto out;
> > +     /* launch fast-charge */
> > +     ret = pm860x_set_bits(info->i2c, PM8607_CHG_CTRL1, 3,
> > +                           CC1_MODE_FASTCHARGE);
> > +     /* vchg threshold setting */
> > +     set_vchg_threshold(info, VCHG_NORMAL_LOW, VCHG_NORMAL_HIGH);
> > +out:
> > +     return ret;
> > +}
> > +
> > +static int stop_charge(struct pm860x_charger_info *info, int vbatt)
> > +{
> > +     dev_dbg(info->dev, "Stop charging!\n");
> > +     pm860x_set_bits(info->i2c, PM8607_CHG_CTRL1, 3, CC1_MODE_OFF);
> > +     if (vbatt > CHARGE_THRESHOLD && info->online)
> > +             set_vbatt_threshold(info, CHARGE_THRESHOLD, 0);
> > +     return 0;
>
> The return value of the function can be changed to void.
>
> > +}
> > +
> > +static int power_off_notification(struct pm860x_charger_info *info)
> > +{
> > +     dev_dbg(info->dev, "Power-off notification!\n");
> > +     return 0;
>
> Return value can be void, no need for int.
>
> > +}
> > +
> > +static int set_charging_fsm(struct pm860x_charger_info *info)
> > +{
> > +     struct power_supply *psy;
> > +     union power_supply_propval data;
> > +     unsigned char fsm_state[][16] = { "init", "discharge", "precharge",
> > +             "fastcharge",
> > +     };
> > +     int ret = -EINVAL;
> > +     int vbatt;
> > +
> > +     psy = power_supply_get_by_name(pm860x_supplied_to[0]);
> > +     if (!psy)
> > +             goto out;
> > +     ret = psy->get_property(psy, POWER_SUPPLY_PROP_VOLTAGE_NOW, &data);
> > +     if (ret)
> > +             goto out;
> > +     vbatt = data.intval / 1000;
> > +
> > +     ret = psy->get_property(psy, POWER_SUPPLY_PROP_PRESENT, &data);
> > +     if (ret)
> > +             goto out;
> > +
> > +     mutex_lock(&info->lock);
> > +     info->present = data.intval;
> > +
> > +     dev_dbg(info->dev, "Entering FSM:%s, Charger:%s, Battery:%s, "
> > +             "Allowed:%d\n",
> > +             &fsm_state[info->state][0],
> > +             (info->online) ? "online" : "N/A",
> > +             (info->present) ? "present" : "N/A", info->allowed);
> > +     dev_dbg(info->dev, "set_charging_fsm:vbatt:%d(mV)\n", vbatt);
> > +
> > +     switch (info->state) {
> > +     case FSM_INIT:
> > +             if (info->online && info->present && info->allowed) {
> > +                     if (vbatt < PRECHARGE_THRESHOLD) {
> > +                             info->state = FSM_PRECHARGE;
> > +                             start_precharge(info);
> > +                     } else if (vbatt > DISCHARGE_THRESHOLD) {
> > +                             info->state = FSM_DISCHARGE;
> > +                             stop_charge(info, vbatt);
> > +                     } else if (vbatt < DISCHARGE_THRESHOLD) {
> > +                             info->state = FSM_FASTCHARGE;
> > +                             start_fastcharge(info);
> > +                     }
> > +             } else {
> > +                     if (vbatt < POWEROFF_THRESHOLD) {
> > +                             power_off_notification(info);
> > +                     } else {
> > +                             info->state = FSM_DISCHARGE;
> > +                             stop_charge(info, vbatt);
> > +                     }
> > +             }
> > +             break;
> > +     case FSM_PRECHARGE:
> > +             if (info->online && info->present && info->allowed) {
> > +                     if (vbatt > PRECHARGE_THRESHOLD) {
> > +                             info->state = FSM_FASTCHARGE;
> > +                             start_fastcharge(info);
> > +                     }
> > +             } else {
> > +                     info->state = FSM_DISCHARGE;
> > +                     stop_charge(info, vbatt);
> > +             }
> > +             break;
> > +     case FSM_FASTCHARGE:
> > +             if (info->online && info->present && info->allowed) {
> > +                     if (vbatt < PRECHARGE_THRESHOLD) {
> > +                             info->state = FSM_PRECHARGE;
> > +                             start_precharge(info);
> > +                     }
> > +             } else {
> > +                     info->state = FSM_DISCHARGE;
> > +                     stop_charge(info, vbatt);
> > +             }
> > +             break;
> > +     case FSM_DISCHARGE:
> > +             if (info->online && info->present && info->allowed) {
> > +                     if (vbatt < PRECHARGE_THRESHOLD) {
> > +                             info->state = FSM_PRECHARGE;
> > +                             start_precharge(info);
> > +                     } else if (vbatt < DISCHARGE_THRESHOLD) {
> > +                             info->state = FSM_FASTCHARGE;
> > +                             start_fastcharge(info);
> > +                     }
> > +             } else {
> > +                     if (vbatt < POWEROFF_THRESHOLD) {
> > +                             power_off_notification(info);
> > +                     } else if (vbatt > CHARGE_THRESHOLD
> > +                                && info->online)
> > +                             set_vbatt_threshold(info, CHARGE_THRESHOLD,
> > +                                                 0);
> > +             }
> > +             break;
> > +     default:
> > +             dev_warn(info->dev, "FSM meets wrong state:%d\n",
> > +                      info->state);
> > +             break;
> > +     }
> > +     dev_dbg(info->dev,
> > +             "Out FSM:%s, Charger:%s, Battery:%s, Allowed:%d\n",
> > +             &fsm_state[info->state][0],
> > +             (info->online) ? "online" : "N/A",
> > +             (info->present) ? "present" : "N/A", info->allowed);
> > +     mutex_unlock(&info->lock);
> > +
> > +     return 0;
> > +out:
>
> No need for out label here. Just write 'return ret', instead of 'goto out'.
> That way you also won't need the initializer value for ret.
>
> > +     return ret;
> > +}
> > +
> > +static int pm860x_init_charger(struct pm860x_charger_info *info)
> > +{
> > +     int ret;
> > +
> > +     mutex_lock(&info->lock);
> > +     info->state = FSM_INIT;
> > +     ret = pm860x_reg_read(info->i2c, PM8607_STATUS_2);
> > +     if (ret < 0)
> > +             goto out;
>
> The 'out:' branch is missing mutex_unlock().
>
> But I believe it is safe to read i2c devices w/o locking, so you can
> move pm860x_reg_read() out of the lock, into the beginning of
> the function; that way you won't need the 'out:' label anymore.
>
> > +     if (ret & STATUS2_CHG) {
> > +             info->online = 1;
> > +             info->allowed = 1;
> > +     } else {
> > +             info->online = 0;
> > +             info->allowed = 0;
> > +     }
> > +     mutex_unlock(&info->lock);
> > +
> > +     set_charging_fsm(info);
> > +     return 0;
> > +out:
> > +     return ret;
> > +}
> > +
> > +static __devinit int pm860x_charger_probe(struct platform_device *pdev)
> > +{
> > +     struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
> > +     struct pm860x_charger_info *info;
> > +     int ret, i, j, count;
>
> One variable per line;
>
> > +
> > +     info = kzalloc(sizeof(struct pm860x_charger_info), GFP_KERNEL);
>
> Please switch to sizeof(*info) and devm_kzalloc();
>
> > +     if (!info)
> > +             return -ENOMEM;
> > +
> > +     ret = device_create_file(&pdev->dev, &dev_attr_stop);
> > +     if (ret < 0)
> > +             goto out;
> > +
> > +     count = pdev->num_resources;
> > +     for (i = 0, j = 0; i < count; i++) {
> > +             info->irq[j] = platform_get_irq(pdev, i);
> > +             if (info->irq[j] < 0)
> > +                     continue;
> > +             j++;
> > +     }
> > +     info->irq_nums = j;
> > +
> > +     info->chip = chip;
> > +     info->i2c =
> > +         (chip->id == CHIP_PM8607) ? chip->client : chip->companion;
> > +     info->i2c_8606 =
> > +         (chip->id == CHIP_PM8607) ? chip->companion : chip->client;
> > +     if (!info->i2c_8606) {
> > +             dev_err(&pdev->dev, "Missed I2C address of 88PM8606!\n");
> > +             ret = -EINVAL;
> > +             goto out_dev;
> > +     }
> > +     info->dev = &pdev->dev;
> > +
> > +     /* set init value for the case we are not using battery */
> > +     set_vchg_threshold(info, VCHG_NORMAL_LOW, VCHG_OVP_LOW);
> > +
> > +     ret = request_threaded_irq(info->irq[0], NULL,
> > +                                pm860x_charger_handler,
> > +                                IRQF_ONESHOT, "usb supply detect",
> > +                                info);
>
> The same problem w/ requesting interrupt before ensuring that
> everything initialized, registered and thus usable. Imagine that
> irq fires before mutex_init(), which is down below.
>
> > +     if (ret < 0) {
> > +             dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
> > +                     info->irq[0], ret);
> > +             goto out_dev;
> > +     }
> > +
> > +     ret = request_threaded_irq(info->irq[1], NULL,
> > +                                pm860x_done_handler,
> > +                                IRQF_ONESHOT, "charge done", info);
> > +     if (ret < 0) {
> > +             dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
> > +                     info->irq[1], ret);
> > +             goto out_irq1;
> > +     }
> > +     ret = request_threaded_irq(info->irq[2], NULL,
> > +                                pm860x_exception_handler,
> > +                                IRQF_ONESHOT, "charge timeout", info);
> > +     if (ret < 0) {
> > +             dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
> > +                     info->irq[2], ret);
> > +             goto out_irq2;
> > +     }
> > +     ret = request_threaded_irq(info->irq[3], NULL,
> > +                                pm860x_exception_handler,
> > +                                IRQF_ONESHOT, "charge fault", info);
> > +     if (ret < 0) {
> > +             dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
> > +                     info->irq[3], ret);
> > +             goto out_irq3;
> > +     }
> > +     ret = request_threaded_irq(info->irq[4], NULL,
> > +                                pm860x_temp_handler,
> > +                                IRQF_ONESHOT, "temperature", info);
> > +     if (ret < 0) {
> > +             dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
> > +                     info->irq[4], ret);
> > +             goto out_irq4;
> > +     }
> > +     ret = request_threaded_irq(info->irq[5], NULL,
> > +                                pm860x_vbattery_handler,
> > +                                IRQF_ONESHOT, "vbatt", info);
> > +     if (ret < 0) {
> > +             dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
> > +                     info->irq[5], ret);
> > +             goto out_irq5;
> > +     }
> > +     ret = request_threaded_irq(info->irq[6], NULL,
> > +                                pm860x_vchg_handler,
> > +                                IRQF_ONESHOT, "vchg", info);
>
> Quite a lot of interrupts. You probably could make an array that
> maps idx, name and handler, e.g.
>
> struct pm860x_irq_desc {
>         const char *name;
>         irqreturn_t (*handler)(int irq, void *data);
> } pm860x_irq_descs[] = {
>         { "usb supply detect", pm860x_charger_handler },
>         { "charge done", pm860x_done_handler },
> };
>
> and turn the code into a loop that registers all the interrupts, e.g.
>
> for (i = 0; i < ARRAY_SIZE(info->irq); i++) {
>         ret = request_threaded_irq(info->irq[i], NULL,
>                 pm860x_irq_descs[i].handler,
>                 IRQF_ONESHOT, pm860x_irq_descs[i].name, info);
>         ...
> }
>
> That would be much nicer.
>
> > +     if (ret < 0) {
> > +             dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
> > +                     info->irq[6], ret);
> > +             goto out_irq6;
> > +     }
> > +     if (info->irq_nums <= 6) {
>
> Instead of hardcoding 6, you can write ARRAY_SIZE(info->irq);
>
> > +             dev_err(chip->dev, "IRQ numbers aren't matched\n");
> > +             goto out_nums;
> > +     }
> > +
> > +     mutex_init(&info->lock);
> > +     platform_set_drvdata(pdev, info);
> > +
> > +     info->usb.name = "usb";
> > +     info->usb.type = POWER_SUPPLY_TYPE_USB;
> > +     info->usb.supplied_to = pm860x_supplied_to;
> > +     info->usb.num_supplicants = ARRAY_SIZE(pm860x_supplied_to);
> > +     info->usb.properties = pm860x_usb_props;
> > +     info->usb.num_properties = ARRAY_SIZE(pm860x_usb_props);
> > +     info->usb.get_property = pm860x_usb_get_prop;
> > +     ret = power_supply_register(&pdev->dev, &info->usb);
> > +     if (ret)
> > +             goto out_nums;
> > +
> > +     pm860x_init_charger(info);
> > +
> > +     return 0;
> > +
> > +out_nums:
> > +     free_irq(info->irq[6], info);
> > +out_irq6:
> > +     free_irq(info->irq[5], info);
> > +out_irq5:
> > +     free_irq(info->irq[4], info);
> > +out_irq4:
> > +     free_irq(info->irq[3], info);
> > +out_irq3:
> > +     free_irq(info->irq[2], info);
> > +out_irq2:
> > +     free_irq(info->irq[1], info);
> > +out_irq1:
> > +     free_irq(info->irq[0], info);
> > +out_dev:
> > +     device_remove_file(&pdev->dev, &dev_attr_stop);
> > +out:
> > +     kfree(info);
> > +     return ret;
> > +}
> > +
> > +static int __devexit pm860x_charger_remove(struct platform_device *pdev)
> > +{
> > +     struct pm860x_charger_info *info = platform_get_drvdata(pdev);
> > +     int i;
> > +
> > +     platform_set_drvdata(pdev, NULL);
> > +     power_supply_unregister(&info->usb);
> > +     free_irq(info->irq[0], info);
>
> Why irq[0] is special here, i.e. why is it not in the loop down below?
>
> > +     for (i = 1; i < info->irq_nums; i++)
> > +             free_irq(info->irq[i], info);
> > +     device_remove_file(info->dev, &dev_attr_stop);
> > +     kfree(info);
> > +     return 0;
> > +}
> > +
> > +static struct platform_driver pm860x_charger_driver = {
> > +     .driver = {
> > +                .name = "88pm860x-charger",
> > +                .owner = THIS_MODULE,
> > +                },
>
> Improper indentation for the bracket.
>
> > +     .probe = pm860x_charger_probe,
> > +     .remove = __devexit_p(pm860x_charger_remove),
> > +};
> > +
>
> No need for this empty line.
>
> > +module_platform_driver(pm860x_charger_driver);
> > +
> > +MODULE_DESCRIPTION("Marvell 88PM860x Charger driver");
> > +MODULE_LICENSE("GPL");
>
> Thanks!
>
> --
> Anton Vorontsov
> Email: cbouatmailru at gmail.com
>



-- 

----------------------------------
Best Regards
Jett Zhou
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120716/900d14cc/attachment-0001.html>
