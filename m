From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 8 Dec 2010 09:38:46 +0100
Subject: [PATCH] Added i2c support for mc13xxx-core
In-Reply-To: <1291762346-29912-1-git-send-email-marc@cpdesign.com.au>
References: <1291761693-29689-2-git-send-email-marc@cpdesign.com.au>
	<1291762346-29912-1-git-send-email-marc@cpdesign.com.au>
Message-ID: <20101208083846.GB18244@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 08, 2010 at 09:52:26AM +1100, Marc Reilly wrote:
> Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
> ---
>  drivers/mfd/mc13xxx-core.c |  341 +++++++++++++++++++++++++++++++-------------
>  1 files changed, 243 insertions(+), 98 deletions(-)
> 
> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> index a2ac2ed..858ad6f 100644
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -9,7 +9,6 @@
>   * the terms of the GNU General Public License version 2 as published by the
>   * Free Software Foundation.
>   */
> -
hmm, I added that line on request of a colleague, I wouldn't have added
it alone, too.  Actually I don't care.

>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> @@ -18,12 +17,28 @@
>  #include <linux/spi/spi.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/mc13xxx.h>
> +#include <linux/i2c.h>
> +
> +enum mc13xxx_id {
> +	MC13XXX_ID_MC13783,
> +	MC13XXX_ID_MC13892,
> +	MC13XXX_ID_INVALID,
> +};
>  
>  struct mc13xxx {
> -	struct spi_device *spidev;
> +	union {
> +		struct spi_device *spidev;
> +		struct i2c_client *client;
> +	};
I know that client is the usual name for i2c drivers, but in this case I
wonder if i2cclient would be better.

> +	struct device *pdev;
> +	enum mc13xxx_id icid;
Do you really need that in struct mc13xxx?  If yes please rename it, see
below.

> +
>  	struct mutex lock;
>  	int irq;
>  
> +	int (*read_dev)(struct mc13xxx*, unsigned int, u32*);
> +	int (*write_dev)(struct mc13xxx*, unsigned int, u32);
> +
>  	irq_handler_t irqhandler[MC13XXX_NUM_IRQ];
>  	void *irqdata[MC13XXX_NUM_IRQ];
>  };
> @@ -150,36 +165,48 @@ EXPORT_SYMBOL(mc13783_to_mc13xxx);
>  void mc13xxx_lock(struct mc13xxx *mc13xxx)
>  {
>  	if (!mutex_trylock(&mc13xxx->lock)) {
> -		dev_dbg(&mc13xxx->spidev->dev, "wait for %s from %pf\n",
> +		dev_dbg(mc13xxx->pdev, "wait for %s from %pf\n",
>  				__func__, __builtin_return_address(0));
>  
>  		mutex_lock(&mc13xxx->lock);
>  	}
> -	dev_dbg(&mc13xxx->spidev->dev, "%s from %pf\n",
> +	dev_dbg(mc13xxx->pdev, "%s from %pf\n",
>  			__func__, __builtin_return_address(0));
>  }
>  EXPORT_SYMBOL(mc13xxx_lock);
>  
>  void mc13xxx_unlock(struct mc13xxx *mc13xxx)
>  {
> -	dev_dbg(&mc13xxx->spidev->dev, "%s from %pf\n",
> +	dev_dbg(mc13xxx->pdev, "%s from %pf\n",
>  			__func__, __builtin_return_address(0));
>  	mutex_unlock(&mc13xxx->lock);
>  }
>  EXPORT_SYMBOL(mc13xxx_unlock);
>  
> -#define MC13XXX_REGOFFSET_SHIFT 25
>  int mc13xxx_reg_read(struct mc13xxx *mc13xxx, unsigned int offset, u32 *val)
>  {
> -	struct spi_transfer t;
> -	struct spi_message m;
>  	int ret;
> -
> +	BUG_ON(!mc13xxx->read_dev);
>  	BUG_ON(!mutex_is_locked(&mc13xxx->lock));
>  
>  	if (offset > MC13XXX_NUMREGS)
>  		return -EINVAL;
>  
> +	ret = mc13xxx->read_dev(mc13xxx, offset, val);
> +	dev_vdbg(mc13xxx->pdev, "[0x%02x] -> 0x%06x\n", offset, *val);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(mc13xxx_reg_read);
> +
> +#define MC13XXX_REGOFFSET_SHIFT 25
> +static int mc13xxx_spi_reg_read(struct mc13xxx *mc13xxx,
> +				unsigned int offset, u32 *val)
> +{
> +	struct spi_transfer t;
> +	struct spi_message m;
> +	int ret;
> +
>  	*val = offset << MC13XXX_REGOFFSET_SHIFT;
>  
>  	memset(&t, 0, sizeof(t));
> @@ -201,26 +228,30 @@ int mc13xxx_reg_read(struct mc13xxx *mc13xxx, unsigned int offset, u32 *val)
>  
>  	*val &= 0xffffff;
>  
> -	dev_vdbg(&mc13xxx->spidev->dev, "[0x%02x] -> 0x%06x\n", offset, *val);
> -
>  	return 0;
>  }
> -EXPORT_SYMBOL(mc13xxx_reg_read);
>  
>  int mc13xxx_reg_write(struct mc13xxx *mc13xxx, unsigned int offset, u32 val)
>  {
> -	u32 buf;
> -	struct spi_transfer t;
> -	struct spi_message m;
> -	int ret;
> -
>  	BUG_ON(!mutex_is_locked(&mc13xxx->lock));
> -
> -	dev_vdbg(&mc13xxx->spidev->dev, "[0x%02x] <- 0x%06x\n", offset, val);
> +	BUG_ON(!mc13xxx->write_dev);
> +	dev_vdbg(mc13xxx->pdev, "[0x%02x] <- 0x%06x\n", offset, val);
>  
>  	if (offset > MC13XXX_NUMREGS || val > 0xffffff)
>  		return -EINVAL;
>  
> +	return mc13xxx->write_dev(mc13xxx, offset, val);
> +}
> +EXPORT_SYMBOL(mc13xxx_reg_write);
> +
> +static int mc13xxx_spi_reg_write(struct mc13xxx *mc13xxx,
> +				unsigned int offset, u32 val)
> +{
> +	u32 buf;
> +	struct spi_transfer t;
> +	struct spi_message m;
> +	int ret;
> +
>  	buf = 1 << 31 | offset << MC13XXX_REGOFFSET_SHIFT | val;
>  
>  	memset(&t, 0, sizeof(t));
> @@ -241,7 +272,33 @@ int mc13xxx_reg_write(struct mc13xxx *mc13xxx, unsigned int offset, u32 val)
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL(mc13xxx_reg_write);
> +
> +static int mc13xxx_i2c_reg_read(struct mc13xxx *mc13xxx, unsigned int offset,
> +		u32 *val)
> +{
> +	int ret;
> +	unsigned char buff[3] = {0, 0, 0};
> +
> +	ret = i2c_smbus_read_i2c_block_data(mc13xxx->client, offset, 3, buff);
> +	*val = buff[0] << 16 | buff[1] << 8 | buff[2];
> +
> +	return ret == 3 ? 0 : ret;
> +}
> +
> +static int mc13xxx_i2c_reg_write(struct mc13xxx *mc13xxx, unsigned int offset,
> +		u32 val)
> +{
> +	int ret;
> +	unsigned char buff[3];
> +
> +	buff[0] = (val >> 16) & 0xff;
> +	buff[1] = (val >> 8) & 0xff;
> +	buff[2] = val & 0xff;
> +
> +	ret = i2c_smbus_write_i2c_block_data(mc13xxx->client, offset, 3, buff);
> +
> +	return ret;
> +}
IMHO the order of functions isn't optimal, you have:

	mc13xxx_reg_read
	mc13xxx_spi_reg_read
	mc13xxx_reg_write
	mc13xxx_spi_reg_write
	mc13xxx_i2c_reg_read
	mc13xxx_i2c_reg_write

Better group all read functions/all write functions or do 

	mc13xxx_reg_read
	mc13xxx_reg_write
	mc13xxx_spi_reg_read
	mc13xxx_spi_reg_write
	mc13xxx_i2c_reg_read
	mc13xxx_i2c_reg_write 

>  int mc13xxx_reg_rmw(struct mc13xxx *mc13xxx, unsigned int offset,
>  		u32 mask, u32 val)
> @@ -445,7 +502,7 @@ static int mc13xxx_irq_handle(struct mc13xxx *mc13xxx,
>  			if (handled == IRQ_HANDLED)
>  				num_handled++;
>  		} else {
> -			dev_err(&mc13xxx->spidev->dev,
> +			dev_err(mc13xxx->pdev,
>  					"BUG: irq %u but no handler\n",
>  					baseirq + irq);
>  
> @@ -481,11 +538,6 @@ static irqreturn_t mc13xxx_irq_thread(int irq, void *data)
>  	return IRQ_RETVAL(handled);
>  }
>  
> -enum mc13xxx_id {
> -	MC13XXX_ID_MC13783,
> -	MC13XXX_ID_MC13892,
> -	MC13XXX_ID_INVALID,
> -};
>  
>  const char *mc13xxx_chipname[] = {
>  	[MC13XXX_ID_MC13783] = "mc13783",
> @@ -493,41 +545,38 @@ const char *mc13xxx_chipname[] = {
>  };
>  
>  #define maskval(reg, mask)	(((reg) & (mask)) >> __ffs(mask))
> -static int mc13xxx_identify(struct mc13xxx *mc13xxx, enum mc13xxx_id *id)
> +static int mc13xxx_identify(struct mc13xxx *mc13xxx, int usespi)
>  {
>  	u32 icid;
>  	u32 revision;
>  	const char *name;
>  	int ret;
>  
> -	ret = mc13xxx_reg_read(mc13xxx, 46, &icid);
> +	ret = mc13xxx_reg_read(mc13xxx, MC13XXX_REVISION, &revision);
This is wrong.  Here I read register 46 on purpose, not the REVISION
register (i.e. 7).  I remember having read somewhere that there are
(older) PMICs that only have icid in register 46, so using that one is
more conservative.  (I looked quickly in our documentation pool, but
couldn't find the right one.)

>  	if (ret)
>  		return ret;
>  
> -	icid = (icid >> 6) & 0x7;
> +	icid = (revision >> 6) & 0x7;
>  
>  	switch (icid) {
>  	case 2:
> -		*id = MC13XXX_ID_MC13783;
> +		mc13xxx->icid = MC13XXX_ID_MC13783;
MC13XXX_ID_MC13783 is not an icid.  The latter is a register field, e.g.
mc13783 has ICID[2:0] = b010

>  		name = "mc13783";
>  		break;
>  	case 7:
> -		*id = MC13XXX_ID_MC13892;
> +		mc13xxx->icid = MC13XXX_ID_MC13892;
>  		name = "mc13892";
>  		break;
>  	default:
> -		*id = MC13XXX_ID_INVALID;
> +		mc13xxx->icid = MC13XXX_ID_INVALID;
>  		break;
>  	}
>  
> -	if (*id == MC13XXX_ID_MC13783 || *id == MC13XXX_ID_MC13892) {
> -		ret = mc13xxx_reg_read(mc13xxx, MC13XXX_REVISION, &revision);
> -		if (ret)
> -			return ret;
> -
> -		dev_info(&mc13xxx->spidev->dev, "%s: rev: %d.%d, "
> +	if (mc13xxx->icid == MC13XXX_ID_MC13783 ||
> +			mc13xxx->icid == MC13XXX_ID_MC13892) {
> +		dev_info(mc13xxx->pdev, "%s: rev: %d.%d, "
>  				"fin: %d, fab: %d, icid: %d/%d\n",
> -				mc13xxx_chipname[*id],
> +				mc13xxx_chipname[mc13xxx->icid],
>  				maskval(revision, MC13XXX_REVISION_REVFULL),
>  				maskval(revision, MC13XXX_REVISION_REVMETAL),
>  				maskval(revision, MC13XXX_REVISION_FIN),
> @@ -535,27 +584,23 @@ static int mc13xxx_identify(struct mc13xxx *mc13xxx, enum mc13xxx_id *id)
>  				maskval(revision, MC13XXX_REVISION_ICID),
>  				maskval(revision, MC13XXX_REVISION_ICIDCODE));
>  	}
> -
> -	if (*id != MC13XXX_ID_INVALID) {
> -		const struct spi_device_id *devid =
> -			spi_get_device_id(mc13xxx->spidev);
> -		if (!devid || devid->driver_data != *id)
> -			dev_warn(&mc13xxx->spidev->dev, "device id doesn't "
> -					"match auto detection!\n");
> +	if (mc13xxx->icid != MC13XXX_ID_INVALID) {
> +		if (usespi) {
> +			const struct spi_device_id *devid =
> +				spi_get_device_id(mc13xxx->spidev);
> +			if (!devid || devid->driver_data != mc13xxx->icid)
> +				dev_warn(mc13xxx->pdev, "device id doesn't "
> +						"match auto detection!\n");
> +		} else {
> +			/* TODO */
> +		}
I don't like that, maybe better pass the (bus dependent) id (or more
exact the id's driver_data) to mc13xxx_identify?  For i2c you get it
passed to mc13xxx_i2c_probe BTW.

>  	}
> -
>  	return 0;
>  }
>  
>  static const char *mc13xxx_get_chipname(struct mc13xxx *mc13xxx)
>  {
> -	const struct spi_device_id *devid =
> -		spi_get_device_id(mc13xxx->spidev);
> -
> -	if (!devid)
> -		return NULL;
> -
> -	return mc13xxx_chipname[devid->driver_data];
> +	return mc13xxx_chipname[mc13xxx->icid];
>  }
>  
>  #include <linux/mfd/mc13783.h>
> @@ -563,7 +608,7 @@ static const char *mc13xxx_get_chipname(struct mc13xxx *mc13xxx)
>  int mc13xxx_get_flags(struct mc13xxx *mc13xxx)
>  {
>  	struct mc13xxx_platform_data *pdata =
> -		dev_get_platdata(&mc13xxx->spidev->dev);
> +		dev_get_platdata(mc13xxx->pdev);
>  
>  	return pdata->flags;
>  }
> @@ -601,7 +646,7 @@ int mc13783_adc_do_conversion(struct mc13783 *mc13783, unsigned int mode,
>  	};
>  	init_completion(&adcdone_data.done);
>  
> -	dev_dbg(&mc13xxx->spidev->dev, "%s\n", __func__);
> +	dev_dbg(mc13xxx->pdev, "%s\n", __func__);
>  
>  	mc13xxx_lock(mc13xxx);
>  
> @@ -643,7 +688,7 @@ int mc13783_adc_do_conversion(struct mc13783 *mc13783, unsigned int mode,
>  		return -EINVAL;
>  	}
>  
> -	dev_dbg(&mc13783->mc13xxx.spidev->dev, "%s: request irq\n", __func__);
> +	dev_dbg(mc13783->mc13xxx.pdev, "%s: request irq\n", __func__);
>  	mc13xxx_irq_request(mc13xxx, MC13783_IRQ_ADCDONE,
>  			mc13783_handler_adcdone, __func__, &adcdone_data);
>  	mc13xxx_irq_ack(mc13xxx, MC13783_IRQ_ADCDONE);
> @@ -701,7 +746,7 @@ static int mc13xxx_add_subdevice_pdata(struct mc13xxx *mc13xxx,
>  	if (!cell.name)
>  		return -ENOMEM;
>  
> -	return mfd_add_devices(&mc13xxx->spidev->dev, -1, &cell, 1, NULL, 0);
> +	return mfd_add_devices(mc13xxx->pdev, -1, &cell, 1, NULL, 0);
>  }
>  
>  static int mc13xxx_add_subdevice(struct mc13xxx *mc13xxx, const char *format)
> @@ -709,11 +754,48 @@ static int mc13xxx_add_subdevice(struct mc13xxx *mc13xxx, const char *format)
>  	return mc13xxx_add_subdevice_pdata(mc13xxx, format, NULL, 0);
>  }
>  
> -static int mc13xxx_probe(struct spi_device *spi)
> +static int mc13xxx_common_probe(struct mc13xxx *mc13xxx,
> +				struct mc13xxx_platform_data *pdata)
> +{
> +	mc13xxx_unlock(mc13xxx);
> +
> +	if (!pdata)
> +		return 0;
This check is new, I think returning 0 isn't right.  If you ask me just
remove the check.

> +
> +	if (pdata->flags & MC13XXX_USE_ADC)
> +		mc13xxx_add_subdevice(mc13xxx, "%s-adc");
> +
> +	if (pdata->flags & MC13XXX_USE_CODEC)
> +		mc13xxx_add_subdevice(mc13xxx, "%s-codec");
> +
> +	if (pdata->flags & MC13XXX_USE_REGULATOR) {
> +		struct mc13xxx_regulator_platform_data regulator_pdata = {
> +			.num_regulators = pdata->num_regulators,
> +			.regulators = pdata->regulators,
> +		};
> +
> +		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-regulator",
> +				&regulator_pdata, sizeof(regulator_pdata));
> +	}
> +
> +	if (pdata->flags & MC13XXX_USE_RTC)
> +		mc13xxx_add_subdevice(mc13xxx, "%s-rtc");
> +
> +	if (pdata->flags & MC13XXX_USE_TOUCHSCREEN)
> +		mc13xxx_add_subdevice(mc13xxx, "%s-ts");
> +
> +	if (pdata->flags & MC13XXX_USE_LED) {
> +		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-led",
> +					pdata->leds, sizeof(*pdata->leds));
> +	}
> +
> +	return 0;
> +}
> +
> +static int mc13xxx_spi_probe(struct spi_device *spi)
>  {
>  	struct mc13xxx *mc13xxx;
>  	struct mc13xxx_platform_data *pdata = dev_get_platdata(&spi->dev);
> -	enum mc13xxx_id id;
>  	int ret;
>  
>  	mc13xxx = kzalloc(sizeof(*mc13xxx), GFP_KERNEL);
> @@ -725,13 +807,17 @@ static int mc13xxx_probe(struct spi_device *spi)
>  	spi->bits_per_word = 32;
>  	spi_setup(spi);
>  
> +	mc13xxx->pdev = &spi->dev;
>  	mc13xxx->spidev = spi;
> +	mc13xxx->read_dev = mc13xxx_spi_reg_read;
> +	mc13xxx->write_dev = mc13xxx_spi_reg_write;
> +	mc13xxx->irq = spi->irq;
This isn't used and so can even be removed from struct mc13xxx
(preferably in a separate patch).
 
>  	mutex_init(&mc13xxx->lock);
>  	mc13xxx_lock(mc13xxx);
>  
> -	ret = mc13xxx_identify(mc13xxx, &id);
> -	if (ret || id == MC13XXX_ID_INVALID)
> +	ret = mc13xxx_identify(mc13xxx, 1);
> +	if (ret || (mc13xxx->icid == MC13XXX_ID_INVALID))
>  		goto err_revision;
>  
>  	/* mask all irqs */
> @@ -743,7 +829,7 @@ static int mc13xxx_probe(struct spi_device *spi)
>  	if (ret)
>  		goto err_mask;
>  
> -	ret = request_threaded_irq(spi->irq, NULL, mc13xxx_irq_thread,
> +	ret = request_threaded_irq(mc13xxx->irq, NULL, mc13xxx_irq_thread,
>  			IRQF_ONESHOT | IRQF_TRIGGER_HIGH, "mc13xxx", mc13xxx);
>  
>  	if (ret) {
> @@ -755,43 +841,15 @@ err_revision:
>  		return ret;
>  	}
>  
> -	mc13xxx_unlock(mc13xxx);
> -
> -	if (pdata->flags & MC13XXX_USE_ADC)
> -		mc13xxx_add_subdevice(mc13xxx, "%s-adc");
> -
> -	if (pdata->flags & MC13XXX_USE_CODEC)
> -		mc13xxx_add_subdevice(mc13xxx, "%s-codec");
> -
> -	if (pdata->flags & MC13XXX_USE_REGULATOR) {
> -		struct mc13xxx_regulator_platform_data regulator_pdata = {
> -			.num_regulators = pdata->num_regulators,
> -			.regulators = pdata->regulators,
> -		};
> -
> -		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-regulator",
> -				&regulator_pdata, sizeof(regulator_pdata));
> -	}
> -
> -	if (pdata->flags & MC13XXX_USE_RTC)
> -		mc13xxx_add_subdevice(mc13xxx, "%s-rtc");
> -
> -	if (pdata->flags & MC13XXX_USE_TOUCHSCREEN)
> -		mc13xxx_add_subdevice(mc13xxx, "%s-ts");
> -
> -	if (pdata->flags & MC13XXX_USE_LED) {
> -		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-led",
> -					pdata->leds, sizeof(*pdata->leds));
> -	}
> -
> -	return 0;
> +	return mc13xxx_common_probe(mc13xxx, pdata);
>  }
>  
> -static int __devexit mc13xxx_remove(struct spi_device *spi)
> +
> +static int __devexit mc13xxx_spi_remove(struct spi_device *spi)
>  {
>  	struct mc13xxx *mc13xxx = dev_get_drvdata(&spi->dev);
>  
> -	free_irq(mc13xxx->spidev->irq, mc13xxx);
> +	free_irq(mc13xxx->irq, mc13xxx);
>  
>  	mfd_remove_devices(&spi->dev);
>  
> @@ -819,18 +877,105 @@ static struct spi_driver mc13xxx_driver = {
>  		.bus = &spi_bus_type,
>  		.owner = THIS_MODULE,
>  	},
> -	.probe = mc13xxx_probe,
> -	.remove = __devexit_p(mc13xxx_remove),
> +	.probe = mc13xxx_spi_probe,
> +	.remove = __devexit_p(mc13xxx_spi_remove),
> +};
> +
> +static int mc13xxx_i2c_probe(struct i2c_client *client,
> +			     const struct i2c_device_id *id)
> +{
> +	struct mc13xxx *mc13xxx;
> +	struct mc13xxx_platform_data *pdata = dev_get_platdata(&client->dev);
> +	int ret;
> +
> +	mc13xxx = kzalloc(sizeof(*mc13xxx), GFP_KERNEL);
> +	if (!mc13xxx)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&client->dev, mc13xxx);
> +	mc13xxx->pdev = &client->dev;
> +	mc13xxx->client = client;
> +	mc13xxx->read_dev = mc13xxx_i2c_reg_read;
> +	mc13xxx->write_dev = mc13xxx_i2c_reg_write;
> +	mc13xxx->irq = client->irq;
> +
> +	mutex_init(&mc13xxx->lock);
> +	mc13xxx_lock(mc13xxx);
> +
> +	ret = mc13xxx_identify(mc13xxx, 0);
> +	if (ret || (mc13xxx->icid == MC13XXX_ID_INVALID))
> +		goto err_revision;
> +
> +	/* mask all irqs */
> +	ret = mc13xxx_reg_write(mc13xxx, MC13XXX_IRQMASK0, 0x00ffffff);
> +	if (ret)
> +		goto err_mask;
> +
> +	ret = mc13xxx_reg_write(mc13xxx, MC13XXX_IRQMASK1, 0x00ffffff);
> +	if (ret)
> +		goto err_mask;
> +
> +	ret = request_threaded_irq(mc13xxx->irq, NULL, mc13xxx_irq_thread,
> +			IRQF_ONESHOT | IRQF_TRIGGER_HIGH, "mc13xxx", mc13xxx);
> +
> +	if (ret) {
> +err_mask:
> +err_revision:
> +		mutex_unlock(&mc13xxx->lock);
> +		kfree(mc13xxx);
> +		return ret;
> +	}
> +
> +	return mc13xxx_common_probe(mc13xxx, pdata);
> +}
> +
> +static int __devexit mc13xxx_i2c_remove(struct i2c_client *client)
> +{
> +	struct mc13xxx *mc13xxx = dev_get_drvdata(&client->dev);
> +
> +	free_irq(mc13xxx->irq, mc13xxx);
> +
> +	mfd_remove_devices(&client->dev);
> +
> +	kfree(mc13xxx);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id mc13xxx_i2c_idtable[] = {
> +	{ "mc13892", MC13XXX_ID_MC13892},
> +	{ }
> +};
> +
> +static struct i2c_driver mc13xxx_i2c_driver = {
> +	.driver = {
> +		.owner = THIS_MODULE,
> +		.name = "mc13xxx-i2c"
> +	},
> +	.id_table = mc13xxx_i2c_idtable,
> +	.probe = mc13xxx_i2c_probe,
> +	.remove = __devexit_p(mc13xxx_i2c_remove),
>  };
>  
>  static int __init mc13xxx_init(void)
>  {
> -	return spi_register_driver(&mc13xxx_driver);
> +	int i2cret;
> +	int spiret;
> +	i2cret = i2c_add_driver(&mc13xxx_i2c_driver);
> +	spiret = spi_register_driver(&mc13xxx_driver);
> +
> +	if (i2cret != 0)
> +		return i2cret;
> +	if (spiret != 0)
> +		return spiret;
> +
> +	return 0;
>  }
>  subsys_initcall(mc13xxx_init);
>  
>  static void __exit mc13xxx_exit(void)
>  {
> +	i2c_del_driver(&mc13xxx_i2c_driver);
>  	spi_unregister_driver(&mc13xxx_driver);
>  }
>  module_exit(mc13xxx_exit);
> -- 
> 1.7.1

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
