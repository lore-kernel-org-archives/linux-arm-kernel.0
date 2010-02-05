From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 5 Feb 2010 16:39:40 +0100
Subject: [PATCH 3/5] mfd: use genirq in 88pm860x
In-Reply-To: <771cded01002030503w15f5394fwd226a26e4deadc6d@mail.gmail.com>
References: <771cded01002030503w15f5394fwd226a26e4deadc6d@mail.gmail.com>
Message-ID: <20100205153938.GB3448@sortiz.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On Wed, Feb 03, 2010 at 08:03:13AM -0500, Haojian Zhuang wrote:
> From 1c49d1bf59a1ec2c59dc093899e6b2d0991bd676 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Wed, 3 Feb 2010 15:39:28 -0500
> Subject: [PATCH] mfd: use genirq in 88pm860x
The patch looks fine to me but:

- Please add some more verbose changelog
- It doesnt build on x86, you need to apply this:

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 0b1eba0..6a14d2b 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -544,7 +544,11 @@ static int __devinit device_irq_init(struct pm860x_chip
*ch
                set_irq_chip_and_handler(__irq, &pm860x_irq_chip,
                                         handle_edge_irq);
                set_irq_nested_thread(__irq, 1);
+#ifdef CONFIG_ARM
                set_irq_flags(__irq, IRQF_VALID);
+#else
+               set_irq_noprobe(__irq);
+#endif
        }
 
        ret = request_threaded_irq(chip->core_irq, NULL, pm860x_irq, flags,

- After applying this patch, 88pm860x-ts.c fails to build. You need to merge
patches 3 and 4 into one single patch to prevent build failure.

Cheers,
Samuel.




> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  drivers/mfd/88pm860x-core.c  |  404 ++++++++++++++++++++++++++++++------------
>  include/linux/mfd/88pm860x.h |   30 ++--
>  2 files changed, 302 insertions(+), 132 deletions(-)
> 
> diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
> index 16f0dca..0b1eba0 100644
> --- a/drivers/mfd/88pm860x-core.c
> +++ b/drivers/mfd/88pm860x-core.c
> @@ -12,11 +12,14 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/i2c.h>
> +#include <linux/irq.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/88pm860x.h>
> 
> +#define INT_STATUS_NUM			3
> +
>  char pm860x_backlight_name[][MFD_NAME_SIZE] = {
>  	"backlight-0",
>  	"backlight-1",
> @@ -119,6 +122,42 @@ static struct mfd_cell touch_devs[] = {
>  	.flags	= IORESOURCE_IO,			\
>  }
> 
> +static struct resource power_supply_resources[] = {
> +	{
> +		.name		= "88pm860x-power",
> +		.start		= PM8607_IRQ_CHG,
> +		.end		= PM8607_IRQ_CHG,
> +		.flags		= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct mfd_cell power_devs[] = {
> +	{
> +		.name		= "88pm860x-power",
> +		.num_resources	= 1,
> +		.resources	= &power_supply_resources[0],
> +		.id		= -1,
> +	},
> +};
> +
> +static struct resource onkey_resources[] = {
> +	{
> +		.name		= "88pm860x-onkey",
> +		.start		= PM8607_IRQ_ONKEY,
> +		.end		= PM8607_IRQ_ONKEY,
> +		.flags		= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct mfd_cell onkey_devs[] = {
> +	{
> +		.name		= "88pm860x-onkey",
> +		.num_resources	= 1,
> +		.resources	= &onkey_resources[0],
> +		.id		= -1,
> +	},
> +};
> +
>  static struct resource regulator_resources[] = {
>  	PM8607_REG_RESOURCE(BUCK1, BUCK1),
>  	PM8607_REG_RESOURCE(BUCK2, BUCK2),
> @@ -163,129 +202,224 @@ static struct mfd_cell regulator_devs[] = {
>  	PM8607_REG_DEVS(ldo14, LDO14),
>  };
> 
> -#define CHECK_IRQ(irq)					\
> -do {							\
> -	if ((irq < 0) || (irq >= PM860X_NUM_IRQ))	\
> -		return -EINVAL;				\
> -} while (0)
> -
> -/* IRQs only occur on 88PM8607 */
> -int pm860x_mask_irq(struct pm860x_chip *chip, int irq)
> -{
> -	struct i2c_client *i2c = (chip->id == CHIP_PM8607) ? chip->client \
> -				: chip->companion;
> -	int offset, data, ret;
> -
> -	CHECK_IRQ(irq);
> -
> -	offset = (irq >> 3) + PM8607_INT_MASK_1;
> -	data = 1 << (irq % 8);
> -	ret = pm860x_set_bits(i2c, offset, data, 0);
> +struct pm860x_irq_data {
> +	int	reg;
> +	int	mask_reg;
> +	int	enable;		/* enable or not */
> +	int	offs;		/* bit offset in mask register */
> +};
> 
> -	return ret;
> -}
> -EXPORT_SYMBOL(pm860x_mask_irq);
> +static struct pm860x_irq_data pm860x_irqs[] = {
> +	[PM8607_IRQ_ONKEY] = {
> +		.reg		= PM8607_INT_STATUS1,
> +		.mask_reg	= PM8607_INT_MASK_1,
> +		.offs		= 1 << 0,
> +	},
> +	[PM8607_IRQ_EXTON] = {
> +		.reg		= PM8607_INT_STATUS1,
> +		.mask_reg	= PM8607_INT_MASK_1,
> +		.offs		= 1 << 1,
> +	},
> +	[PM8607_IRQ_CHG] = {
> +		.reg		= PM8607_INT_STATUS1,
> +		.mask_reg	= PM8607_INT_MASK_1,
> +		.offs		= 1 << 2,
> +	},
> +	[PM8607_IRQ_BAT] = {
> +		.reg		= PM8607_INT_STATUS1,
> +		.mask_reg	= PM8607_INT_MASK_1,
> +		.offs		= 1 << 3,
> +	},
> +	[PM8607_IRQ_RTC] = {
> +		.reg		= PM8607_INT_STATUS1,
> +		.mask_reg	= PM8607_INT_MASK_1,
> +		.offs		= 1 << 4,
> +	},
> +	[PM8607_IRQ_CC] = {
> +		.reg		= PM8607_INT_STATUS1,
> +		.mask_reg	= PM8607_INT_MASK_1,
> +		.offs		= 1 << 5,
> +	},
> +	[PM8607_IRQ_VBAT] = {
> +		.reg		= PM8607_INT_STATUS2,
> +		.mask_reg	= PM8607_INT_MASK_2,
> +		.offs		= 1 << 0,
> +	},
> +	[PM8607_IRQ_VCHG] = {
> +		.reg		= PM8607_INT_STATUS2,
> +		.mask_reg	= PM8607_INT_MASK_2,
> +		.offs		= 1 << 1,
> +	},
> +	[PM8607_IRQ_VSYS] = {
> +		.reg		= PM8607_INT_STATUS2,
> +		.mask_reg	= PM8607_INT_MASK_2,
> +		.offs		= 1 << 2,
> +	},
> +	[PM8607_IRQ_TINT] = {
> +		.reg		= PM8607_INT_STATUS2,
> +		.mask_reg	= PM8607_INT_MASK_2,
> +		.offs		= 1 << 3,
> +	},
> +	[PM8607_IRQ_GPADC0] = {
> +		.reg		= PM8607_INT_STATUS2,
> +		.mask_reg	= PM8607_INT_MASK_2,
> +		.offs		= 1 << 4,
> +	},
> +	[PM8607_IRQ_GPADC1] = {
> +		.reg		= PM8607_INT_STATUS2,
> +		.mask_reg	= PM8607_INT_MASK_2,
> +		.offs		= 1 << 5,
> +	},
> +	[PM8607_IRQ_GPADC2] = {
> +		.reg		= PM8607_INT_STATUS2,
> +		.mask_reg	= PM8607_INT_MASK_2,
> +		.offs		= 1 << 6,
> +	},
> +	[PM8607_IRQ_GPADC3] = {
> +		.reg		= PM8607_INT_STATUS2,
> +		.mask_reg	= PM8607_INT_MASK_2,
> +		.offs		= 1 << 7,
> +	},
> +	[PM8607_IRQ_AUDIO_SHORT] = {
> +		.reg		= PM8607_INT_STATUS3,
> +		.mask_reg	= PM8607_INT_MASK_3,
> +		.offs		= 1 << 0,
> +	},
> +	[PM8607_IRQ_PEN] = {
> +		.reg		= PM8607_INT_STATUS3,
> +		.mask_reg	= PM8607_INT_MASK_3,
> +		.offs		= 1 << 1,
> +	},
> +	[PM8607_IRQ_HEADSET] = {
> +		.reg		= PM8607_INT_STATUS3,
> +		.mask_reg	= PM8607_INT_MASK_3,
> +		.offs		= 1 << 2,
> +	},
> +	[PM8607_IRQ_HOOK] = {
> +		.reg		= PM8607_INT_STATUS3,
> +		.mask_reg	= PM8607_INT_MASK_3,
> +		.offs		= 1 << 3,
> +	},
> +	[PM8607_IRQ_MICIN] = {
> +		.reg		= PM8607_INT_STATUS3,
> +		.mask_reg	= PM8607_INT_MASK_3,
> +		.offs		= 1 << 4,
> +	},
> +	[PM8607_IRQ_CHG_FAIL] = {
> +		.reg		= PM8607_INT_STATUS3,
> +		.mask_reg	= PM8607_INT_MASK_3,
> +		.offs		= 1 << 5,
> +	},
> +	[PM8607_IRQ_CHG_DONE] = {
> +		.reg		= PM8607_INT_STATUS3,
> +		.mask_reg	= PM8607_INT_MASK_3,
> +		.offs		= 1 << 6,
> +	},
> +	[PM8607_IRQ_CHG_FAULT] = {
> +		.reg		= PM8607_INT_STATUS3,
> +		.mask_reg	= PM8607_INT_MASK_3,
> +		.offs		= 1 << 7,
> +	},
> +};
> 
> -int pm860x_unmask_irq(struct pm860x_chip *chip, int irq)
> +static inline struct pm860x_irq_data *irq_to_pm860x(struct pm860x_chip *chip,
> +						    int irq)
>  {
> -	struct i2c_client *i2c = (chip->id == CHIP_PM8607) ? chip->client \
> -				: chip->companion;
> -	int offset, data, ret;
> -
> -	CHECK_IRQ(irq);
> -
> -	offset = (irq >> 3) + PM8607_INT_MASK_1;
> -	data = 1 << (irq % 8);
> -	ret = pm860x_set_bits(i2c, offset, data, data);
> -
> -	return ret;
> +	return &pm860x_irqs[irq - chip->irq_base];
>  }
> -EXPORT_SYMBOL(pm860x_unmask_irq);
> -
> -#define INT_STATUS_NUM		(3)
> 
> -static irqreturn_t pm8607_irq_thread(int irq, void *data)
> +static irqreturn_t pm860x_irq(int irq, void *data)
>  {
> -	DECLARE_BITMAP(irq_status, PM860X_NUM_IRQ);
>  	struct pm860x_chip *chip = data;
> -	struct i2c_client *i2c = (chip->id == CHIP_PM8607) ? chip->client \
> -				: chip->companion;
> -	unsigned char status_buf[INT_STATUS_NUM << 1];
> -	unsigned long value;
> -	int i, ret;
> -
> -	irq_status[0] = 0;
> -
> -	/* read out status register */
> -	ret = pm860x_bulk_read(i2c, PM8607_INT_STATUS1,
> -				INT_STATUS_NUM << 1, status_buf);
> -	if (ret < 0)
> -		goto out;
> -	if (chip->irq_mode) {
> -		/* 0, clear by read. 1, clear by write */
> -		ret = pm860x_bulk_write(i2c, PM8607_INT_STATUS1,
> -					INT_STATUS_NUM, status_buf);
> -		if (ret < 0)
> -			goto out;
> -	}
> -
> -	/* clear masked interrupt status */
> -	for (i = 0, value = 0; i < INT_STATUS_NUM; i++) {
> -		status_buf[i] &= status_buf[i + INT_STATUS_NUM];
> -		irq_status[0] |= status_buf[i] << (i * 8);
> -	}
> -
> -	while (!bitmap_empty(irq_status, PM860X_NUM_IRQ)) {
> -		irq = find_first_bit(irq_status, PM860X_NUM_IRQ);
> -		clear_bit(irq, irq_status);
> -		dev_dbg(chip->dev, "Servicing IRQ #%d\n", irq);
> -
> -		mutex_lock(&chip->irq_lock);
> -		if (chip->irq[irq].handler)
> -			chip->irq[irq].handler(irq, chip->irq[irq].data);
> -		else {
> -			pm860x_mask_irq(chip, irq);
> -			dev_err(chip->dev, "Nobody cares IRQ %d. "
> -				"Now mask it.\n", irq);
> -			for (i = 0; i < (INT_STATUS_NUM << 1); i++) {
> -				dev_err(chip->dev, "status[%d]:%x\n", i,
> -					status_buf[i]);
> -			}
> +	struct pm860x_irq_data *irq_data;
> +	struct i2c_client *i2c;
> +	int read_reg = -1, value = 0;
> +	int i;
> +
> +	i2c = (chip->id == CHIP_PM8607) ? chip->client : chip->companion;
> +	for (i = 0; i < ARRAY_SIZE(pm860x_irqs); i++) {
> +		irq_data = &pm860x_irqs[i];
> +		if (read_reg != irq_data->reg) {
> +			read_reg = irq_data->reg;
> +			value = pm860x_reg_read(i2c, irq_data->reg);
>  		}
> -		mutex_unlock(&chip->irq_lock);
> +		if (value & irq_data->enable)
> +			handle_nested_irq(chip->irq_base + i);
>  	}
> -out:
>  	return IRQ_HANDLED;
>  }
> 
> -int pm860x_request_irq(struct pm860x_chip *chip, int irq,
> -		       irq_handler_t handler, void *data)
> +static void pm860x_irq_lock(unsigned int irq)
>  {
> -	CHECK_IRQ(irq);
> -	if (!handler)
> -		return -EINVAL;
> +	struct pm860x_chip *chip = get_irq_chip_data(irq);
> 
>  	mutex_lock(&chip->irq_lock);
> -	chip->irq[irq].handler = handler;
> -	chip->irq[irq].data = data;
> -	mutex_unlock(&chip->irq_lock);
> -
> -	return 0;
>  }
> -EXPORT_SYMBOL(pm860x_request_irq);
> 
> -int pm860x_free_irq(struct pm860x_chip *chip, int irq)
> +static void pm860x_irq_sync_unlock(unsigned int irq)
>  {
> -	CHECK_IRQ(irq);
> +	struct pm860x_chip *chip = get_irq_chip_data(irq);
> +	struct pm860x_irq_data *irq_data;
> +	struct i2c_client *i2c;
> +	static unsigned char cached[3] = {0x0, 0x0, 0x0};
> +	unsigned char mask[3];
> +	int i;
> +
> +	i2c = (chip->id == CHIP_PM8607) ? chip->client : chip->companion;
> +	/* Load cached value. In initial, all IRQs are masked */
> +	for (i = 0; i < 3; i++)
> +		mask[i] = cached[i];
> +	for (i = 0; i < ARRAY_SIZE(pm860x_irqs); i++) {
> +		irq_data = &pm860x_irqs[i];
> +		switch (irq_data->mask_reg) {
> +		case PM8607_INT_MASK_1:
> +			mask[0] &= ~irq_data->offs;
> +			mask[0] |= irq_data->enable;
> +			break;
> +		case PM8607_INT_MASK_2:
> +			mask[1] &= ~irq_data->offs;
> +			mask[1] |= irq_data->enable;
> +			break;
> +		case PM8607_INT_MASK_3:
> +			mask[2] &= ~irq_data->offs;
> +			mask[2] |= irq_data->enable;
> +			break;
> +		default:
> +			dev_err(chip->dev, "wrong IRQ\n");
> +			break;
> +		}
> +	}
> +	/* update mask into registers */
> +	for (i = 0; i < 3; i++) {
> +		if (mask[i] != cached[i]) {
> +			cached[i] = mask[i];
> +			pm860x_reg_write(i2c, PM8607_INT_MASK_1 + i, mask[i]);
> +		}
> +	}
> 
> -	mutex_lock(&chip->irq_lock);
> -	chip->irq[irq].handler = NULL;
> -	chip->irq[irq].data = NULL;
>  	mutex_unlock(&chip->irq_lock);
> +}
> 
> -	return 0;
> +static void pm860x_irq_enable(unsigned int irq)
> +{
> +	struct pm860x_chip *chip = get_irq_chip_data(irq);
> +	pm860x_irqs[irq - chip->irq_base].enable
> +		= pm860x_irqs[irq - chip->irq_base].offs;
> +}
> +
> +static void pm860x_irq_disable(unsigned int irq)
> +{
> +	struct pm860x_chip *chip = get_irq_chip_data(irq);
> +	pm860x_irqs[irq - chip->irq_base].enable = 0;
>  }
> -EXPORT_SYMBOL(pm860x_free_irq);
> +
> +static struct irq_chip pm860x_irq_chip = {
> +	.name		= "88pm860x",
> +	.bus_lock	= pm860x_irq_lock,
> +	.bus_sync_unlock = pm860x_irq_sync_unlock,
> +	.enable		= pm860x_irq_enable,
> +	.disable	= pm860x_irq_disable,
> +};
> 
>  static int __devinit device_gpadc_init(struct pm860x_chip *chip,
>  				       struct pm860x_platform_data *pdata)
> @@ -348,9 +482,15 @@ static int __devinit device_irq_init(struct
> pm860x_chip *chip,
>  	struct i2c_client *i2c = (chip->id == CHIP_PM8607) ? chip->client \
>  				: chip->companion;
>  	unsigned char status_buf[INT_STATUS_NUM];
> -	int data, mask, ret = -EINVAL;
> +	unsigned long flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
> +	struct irq_desc *desc;
> +	int i, data, mask, ret = -EINVAL;
> +	int __irq;
> 
> -	mutex_init(&chip->irq_lock);
> +	if (!pdata || !pdata->irq_base) {
> +		dev_warn(chip->dev, "No interrupt support on IRQ base\n");
> +		return -EINVAL;
> +	}
> 
>  	mask = PM8607_B0_MISC1_INV_INT | PM8607_B0_MISC1_INT_CLEAR
>  		| PM8607_B0_MISC1_INT_MASK;
> @@ -389,25 +529,41 @@ static int __devinit device_irq_init(struct
> pm860x_chip *chip,
>  	if (ret < 0)
>  		goto out;
> 
> -	memset(chip->irq, 0, sizeof(struct pm860x_irq) * PM860X_NUM_IRQ);
> -
> -	ret = request_threaded_irq(i2c->irq, NULL, pm8607_irq_thread,
> -				IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> -				"88PM8607", chip);
> -	if (ret < 0) {
> -		dev_err(chip->dev, "Failed to request IRQ #%d.\n", i2c->irq);
> +	mutex_init(&chip->irq_lock);
> +	chip->irq_base = pdata->irq_base;
> +	chip->core_irq = i2c->irq;
> +	if (!chip->core_irq)
>  		goto out;
> +
> +	desc = irq_to_desc(chip->core_irq);
> +
> +	/* register IRQ by genirq */
> +	for (i = 0; i < ARRAY_SIZE(pm860x_irqs); i++) {
> +		__irq = i + chip->irq_base;
> +		set_irq_chip_data(__irq, chip);
> +		set_irq_chip_and_handler(__irq, &pm860x_irq_chip,
> +					 handle_edge_irq);
> +		set_irq_nested_thread(__irq, 1);
> +		set_irq_flags(__irq, IRQF_VALID);
>  	}
> -	chip->chip_irq = i2c->irq;
> +
> +	ret = request_threaded_irq(chip->core_irq, NULL, pm860x_irq, flags,
> +				   "88pm860x", chip);
> +	if (ret) {
> +		dev_err(chip->dev, "Failed to request IRQ: %d\n", ret);
> +		chip->core_irq = 0;
> +	}
> +
>  	return 0;
>  out:
> +	chip->core_irq = 0;
>  	return ret;
>  }
> 
>  static void __devexit device_irq_exit(struct pm860x_chip *chip)
>  {
> -	if (chip->chip_irq >= 0)
> -		free_irq(chip->chip_irq, chip);
> +	if (chip->core_irq)
> +		free_irq(chip->core_irq, chip);
>  }
> 
>  static void __devinit device_8606_init(struct pm860x_chip *chip,
> @@ -513,6 +669,26 @@ static void __devinit device_8607_init(struct
> pm860x_chip *chip,
>  			goto out_dev;
>  		}
>  	}
> +
> +	if (pdata && pdata->power) {
> +		ret = mfd_add_devices(chip->dev, 0, &power_devs[0],
> +				      ARRAY_SIZE(power_devs),
> +				      &power_supply_resources[0], 0);
> +		if (ret < 0) {
> +			dev_err(chip->dev, "Failed to add power supply "
> +				"subdev\n");
> +			goto out_dev;
> +		}
> +	}
> +
> +	ret = mfd_add_devices(chip->dev, 0, &onkey_devs[0],
> +			      ARRAY_SIZE(onkey_devs),
> +			      &onkey_resources[0], 0);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Failed to add onkey subdev\n");
> +		goto out_dev;
> +	}
> +
>  	return;
>  out_dev:
>  	mfd_remove_devices(chip->dev);
> @@ -524,7 +700,7 @@ out:
>  int pm860x_device_init(struct pm860x_chip *chip,
>  		       struct pm860x_platform_data *pdata)
>  {
> -	chip->chip_irq = -EINVAL;
> +	chip->core_irq = 0;
> 
>  	switch (chip->id) {
>  	case CHIP_PM8606:
> diff --git a/include/linux/mfd/88pm860x.h b/include/linux/mfd/88pm860x.h
> index 80bc82a..73f92c5 100644
> --- a/include/linux/mfd/88pm860x.h
> +++ b/include/linux/mfd/88pm860x.h
> @@ -262,12 +262,13 @@ enum {
> 
>  /* Interrupt Number in 88PM8607 */
>  enum {
> -	PM8607_IRQ_ONKEY = 0,
> +	PM8607_IRQ_ONKEY,
>  	PM8607_IRQ_EXTON,
>  	PM8607_IRQ_CHG,
>  	PM8607_IRQ_BAT,
>  	PM8607_IRQ_RTC,
> -	PM8607_IRQ_VBAT = 8,
> +	PM8607_IRQ_CC,
> +	PM8607_IRQ_VBAT,
>  	PM8607_IRQ_VCHG,
>  	PM8607_IRQ_VSYS,
>  	PM8607_IRQ_TINT,
> @@ -275,7 +276,7 @@ enum {
>  	PM8607_IRQ_GPADC1,
>  	PM8607_IRQ_GPADC2,
>  	PM8607_IRQ_GPADC3,
> -	PM8607_IRQ_AUDIO_SHORT = 16,
> +	PM8607_IRQ_AUDIO_SHORT,
>  	PM8607_IRQ_PEN,
>  	PM8607_IRQ_HEADSET,
>  	PM8607_IRQ_HOOK,
> @@ -291,26 +292,19 @@ enum {
>  	PM8607_CHIP_B0 = 0x48,
>  };
> 
> -#define PM860X_NUM_IRQ		24
> -
> -struct pm860x_irq {
> -	irq_handler_t		handler;
> -	void			*data;
> -};
> -
>  struct pm860x_chip {
>  	struct device		*dev;
>  	struct mutex		io_lock;
>  	struct mutex		irq_lock;
>  	struct i2c_client	*client;
>  	struct i2c_client	*companion;	/* companion chip client */
> -	struct pm860x_irq	irq[PM860X_NUM_IRQ];
> 
>  	int			buck3_double;	/* DVC ramp slope double */
>  	unsigned short		companion_addr;
>  	int			id;
>  	int			irq_mode;
> -	int			chip_irq;
> +	int			irq_base;
> +	int			core_irq;
>  	unsigned char		chip_version;
> 
>  };
> @@ -347,14 +341,20 @@ struct pm860x_touch_pdata {
>  	unsigned long	flags;
>  };
> 
> +struct pm860x_power_pdata {
> +	unsigned	fast_charge;	/* charge current */
> +};
> +
>  struct pm860x_platform_data {
>  	struct pm860x_backlight_pdata	*backlight;
>  	struct pm860x_led_pdata		*led;
>  	struct pm860x_touch_pdata	*touch;
> +	struct pm860x_power_pdata	*power;
> 
>  	unsigned short	companion_addr;	/* I2C address of companion chip */
>  	int		i2c_port;	/* Controlled by GI2C or PI2C */
>  	int		irq_mode;	/* Clear interrupt by read/write(0/1) */
> +	int		irq_base;	/* IRQ base number of 88pm860x */
>  	struct regulator_init_data *regulator[PM8607_MAX_REGULATOR];
>  };
> 
> @@ -368,12 +368,6 @@ extern int pm860x_bulk_write(struct i2c_client *,
> int, int, unsigned char *);
>  extern int pm860x_set_bits(struct i2c_client *, int, unsigned char,
>  			   unsigned char);
> 
> -extern int pm860x_mask_irq(struct pm860x_chip *, int);
> -extern int pm860x_unmask_irq(struct pm860x_chip *, int);
> -extern int pm860x_request_irq(struct pm860x_chip *, int,
> -			      irq_handler_t handler, void *);
> -extern int pm860x_free_irq(struct pm860x_chip *, int);
> -
>  extern int pm860x_device_init(struct pm860x_chip *chip,
>  			      struct pm860x_platform_data *pdata);
>  extern void pm860x_device_exit(struct pm860x_chip *chip);
> -- 
> 1.5.6.5

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
