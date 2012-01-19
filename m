From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 19 Jan 2012 08:51:48 +0100
Subject: [PATCH 1/3] mc13xxx-core: Prepare for separate spi and i2c
 backends.
In-Reply-To: <1326934894-29516-2-git-send-email-marc@cpdesign.com.au>
References: <1326934894-29516-1-git-send-email-marc@cpdesign.com.au>
 <1326934894-29516-2-git-send-email-marc@cpdesign.com.au>
Message-ID: <20120119075148.GB4066@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Marc,

I'm glad you respin the series. Some comments below.

On Thu, Jan 19, 2012 at 12:01:32PM +1100, Marc Reilly wrote:
> This patch abstracts the bus specific operations from the driver core.
> Read and write handlers are introduced and generic initialization is
> consolidated into mc13xxx_comon_init. The irq member is removed because
> it is unused.
> 
> Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
> ---
>  drivers/mfd/mc13xxx-core.c  |  162 +++++++++++++++++++++++++-----------------
>  include/linux/mfd/mc13xxx.h |    5 ++
>  2 files changed, 101 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> index e9619ac..3c3079f 100644
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -19,10 +19,22 @@
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/mc13xxx.h>
>  
> +enum mc13xxx_id {
> +	MC13XXX_ID_MC13783,
> +	MC13XXX_ID_MC13892,
> +	MC13XXX_ID_INVALID,
> +};
> +
>  struct mc13xxx {
>  	struct spi_device *spidev;
> +
> +	struct device *dev;
> +	enum mc13xxx_id ictype;
> +
>  	struct mutex lock;
> -	int irq;
> +
> +	int (*read_dev)(struct mc13xxx *, unsigned int, u32 *);
> +	int (*write_dev)(struct mc13xxx *, unsigned int, u32);
>  
>  	irq_handler_t irqhandler[MC13XXX_NUM_IRQ];
>  	void *irqdata[MC13XXX_NUM_IRQ];
> @@ -140,36 +152,32 @@ struct mc13xxx {
>  void mc13xxx_lock(struct mc13xxx *mc13xxx)
>  {
>  	if (!mutex_trylock(&mc13xxx->lock)) {
> -		dev_dbg(&mc13xxx->spidev->dev, "wait for %s from %pf\n",
> +		dev_dbg(mc13xxx->dev, "wait for %s from %pf\n",
>  				__func__, __builtin_return_address(0));
>  
>  		mutex_lock(&mc13xxx->lock);
>  	}
> -	dev_dbg(&mc13xxx->spidev->dev, "%s from %pf\n",
> +	dev_dbg(mc13xxx->dev, "%s from %pf\n",
>  			__func__, __builtin_return_address(0));
>  }
>  EXPORT_SYMBOL(mc13xxx_lock);
>  
>  void mc13xxx_unlock(struct mc13xxx *mc13xxx)
>  {
> -	dev_dbg(&mc13xxx->spidev->dev, "%s from %pf\n",
> +	dev_dbg(mc13xxx->dev, "%s from %pf\n",
>  			__func__, __builtin_return_address(0));
>  	mutex_unlock(&mc13xxx->lock);
>  }
>  EXPORT_SYMBOL(mc13xxx_unlock);
>  
>  #define MC13XXX_REGOFFSET_SHIFT 25
> -int mc13xxx_reg_read(struct mc13xxx *mc13xxx, unsigned int offset, u32 *val)
> +static int mc13xxx_spi_reg_read(struct mc13xxx *mc13xxx,
> +				unsigned int offset, u32 *val)
>  {
>  	struct spi_transfer t;
>  	struct spi_message m;
>  	int ret;
>  
> -	BUG_ON(!mutex_is_locked(&mc13xxx->lock));
> -
> -	if (offset > MC13XXX_NUMREGS)
> -		return -EINVAL;
> -
>  	*val = offset << MC13XXX_REGOFFSET_SHIFT;
>  
>  	memset(&t, 0, sizeof(t));
> @@ -191,26 +199,17 @@ int mc13xxx_reg_read(struct mc13xxx *mc13xxx, unsigned int offset, u32 *val)
>  
>  	*val &= 0xffffff;
>  
> -	dev_vdbg(&mc13xxx->spidev->dev, "[0x%02x] -> 0x%06x\n", offset, *val);
> -
>  	return 0;
>  }
> -EXPORT_SYMBOL(mc13xxx_reg_read);
>  
> -int mc13xxx_reg_write(struct mc13xxx *mc13xxx, unsigned int offset, u32 val)
> +static int mc13xxx_spi_reg_write(struct mc13xxx *mc13xxx, unsigned int offset,
> +		u32 val)
>  {
>  	u32 buf;
>  	struct spi_transfer t;
>  	struct spi_message m;
>  	int ret;
>  
> -	BUG_ON(!mutex_is_locked(&mc13xxx->lock));
> -
> -	dev_vdbg(&mc13xxx->spidev->dev, "[0x%02x] <- 0x%06x\n", offset, val);
> -
> -	if (offset > MC13XXX_NUMREGS || val > 0xffffff)
> -		return -EINVAL;
> -
>  	buf = 1 << 31 | offset << MC13XXX_REGOFFSET_SHIFT | val;
>  
>  	memset(&t, 0, sizeof(t));
> @@ -231,6 +230,34 @@ int mc13xxx_reg_write(struct mc13xxx *mc13xxx, unsigned int offset, u32 val)
>  
>  	return 0;
>  }
> +
> +int mc13xxx_reg_read(struct mc13xxx *mc13xxx, unsigned int offset, u32 *val)
> +{
> +	int ret;
> +
> +	BUG_ON(!mutex_is_locked(&mc13xxx->lock));
> +
> +	if (offset > MC13XXX_NUMREGS)
> +		return -EINVAL;
> +
> +	ret = mc13xxx->read_dev(mc13xxx, offset, val);
> +	dev_vdbg(mc13xxx->dev, "[0x%02x] -> 0x%06x\n", offset, *val);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(mc13xxx_reg_read);
> +
> +int mc13xxx_reg_write(struct mc13xxx *mc13xxx, unsigned int offset, u32 val)
> +{
> +	BUG_ON(!mutex_is_locked(&mc13xxx->lock));
> +
> +	dev_vdbg(mc13xxx->dev, "[0x%02x] <- 0x%06x\n", offset, val);
> +
> +	if (offset > MC13XXX_NUMREGS || val > 0xffffff)
> +		return -EINVAL;
> +
> +	return mc13xxx->write_dev(mc13xxx, offset, val);
> +}
>  EXPORT_SYMBOL(mc13xxx_reg_write);
>  
>  int mc13xxx_reg_rmw(struct mc13xxx *mc13xxx, unsigned int offset,
> @@ -435,7 +462,7 @@ static int mc13xxx_irq_handle(struct mc13xxx *mc13xxx,
>  			if (handled == IRQ_HANDLED)
>  				num_handled++;
>  		} else {
> -			dev_err(&mc13xxx->spidev->dev,
> +			dev_err(mc13xxx->dev,
>  					"BUG: irq %u but no handler\n",
>  					baseirq + irq);
>  
> @@ -471,25 +498,23 @@ static irqreturn_t mc13xxx_irq_thread(int irq, void *data)
>  	return IRQ_RETVAL(handled);
>  }
>  
> -enum mc13xxx_id {
> -	MC13XXX_ID_MC13783,
> -	MC13XXX_ID_MC13892,
> -	MC13XXX_ID_INVALID,
> -};
> -
>  static const char *mc13xxx_chipname[] = {
>  	[MC13XXX_ID_MC13783] = "mc13783",
>  	[MC13XXX_ID_MC13892] = "mc13892",
>  };
>  
>  #define maskval(reg, mask)	(((reg) & (mask)) >> __ffs(mask))
> -static int mc13xxx_identify(struct mc13xxx *mc13xxx, enum mc13xxx_id *id)
> +static int mc13xxx_identify(struct mc13xxx *mc13xxx)
>  {
>  	u32 icid;
>  	u32 revision;
> -	const char *name;
>  	int ret;
>  
> +	/*
> +	 * Get the generation ID from register 46, as apparently some older
> +	 * IC revisions only have this info at this location. Newer ICs seem to
> +	 * have both.
> +	 */
>  	ret = mc13xxx_reg_read(mc13xxx, 46, &icid);
>  	if (ret)
>  		return ret;
> @@ -498,26 +523,23 @@ static int mc13xxx_identify(struct mc13xxx *mc13xxx, enum mc13xxx_id *id)
>  
>  	switch (icid) {
>  	case 2:
> -		*id = MC13XXX_ID_MC13783;
> -		name = "mc13783";
> +		mc13xxx->ictype = MC13XXX_ID_MC13783;
>  		break;
>  	case 7:
> -		*id = MC13XXX_ID_MC13892;
> -		name = "mc13892";
> +		mc13xxx->ictype = MC13XXX_ID_MC13892;
>  		break;
>  	default:
> -		*id = MC13XXX_ID_INVALID;
> +		mc13xxx->ictype = MC13XXX_ID_INVALID;
>  		break;
>  	}
>  
> -	if (*id == MC13XXX_ID_MC13783 || *id == MC13XXX_ID_MC13892) {
> +	if (mc13xxx->ictype == MC13XXX_ID_MC13783 ||
> +			mc13xxx->ictype == MC13XXX_ID_MC13892) {
>  		ret = mc13xxx_reg_read(mc13xxx, MC13XXX_REVISION, &revision);
> -		if (ret)
> -			return ret;
>  
> -		dev_info(&mc13xxx->spidev->dev, "%s: rev: %d.%d, "
> +		dev_info(mc13xxx->dev, "%s: rev: %d.%d, "
>  				"fin: %d, fab: %d, icid: %d/%d\n",
> -				mc13xxx_chipname[*id],
> +				mc13xxx_chipname[mc13xxx->ictype],
>  				maskval(revision, MC13XXX_REVISION_REVFULL),
>  				maskval(revision, MC13XXX_REVISION_REVMETAL),
>  				maskval(revision, MC13XXX_REVISION_FIN),
> @@ -526,32 +548,18 @@ static int mc13xxx_identify(struct mc13xxx *mc13xxx, enum mc13xxx_id *id)
>  				maskval(revision, MC13XXX_REVISION_ICIDCODE));
>  	}
>  
> -	if (*id != MC13XXX_ID_INVALID) {
> -		const struct spi_device_id *devid =
> -			spi_get_device_id(mc13xxx->spidev);
> -		if (!devid || devid->driver_data != *id)
> -			dev_warn(&mc13xxx->spidev->dev, "device id doesn't "
> -					"match auto detection!\n");
> -	}
> -
> -	return 0;
> +	return (mc13xxx->ictype == MC13XXX_ID_INVALID) ? -ENODEV : 0;
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
> +	return mc13xxx_chipname[mc13xxx->ictype];
>  }
>  
>  int mc13xxx_get_flags(struct mc13xxx *mc13xxx)
>  {
>  	struct mc13xxx_platform_data *pdata =
> -		dev_get_platdata(&mc13xxx->spidev->dev);
> +		dev_get_platdata(mc13xxx->dev);
>  
>  	return pdata->flags;
>  }
> @@ -588,7 +596,7 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
>  	};
>  	init_completion(&adcdone_data.done);
>  
> -	dev_dbg(&mc13xxx->spidev->dev, "%s\n", __func__);
> +	dev_dbg(mc13xxx->dev, "%s\n", __func__);
>  
>  	mc13xxx_lock(mc13xxx);
>  
> @@ -630,7 +638,7 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
>  		return -EINVAL;
>  	}
>  
> -	dev_dbg(&mc13xxx->spidev->dev, "%s: request irq\n", __func__);
> +	dev_dbg(mc13xxx->dev, "%s: request irq\n", __func__);
>  	mc13xxx_irq_request(mc13xxx, MC13XXX_IRQ_ADCDONE,
>  			mc13xxx_handler_adcdone, __func__, &adcdone_data);
>  	mc13xxx_irq_ack(mc13xxx, MC13XXX_IRQ_ADCDONE);
> @@ -688,7 +696,7 @@ static int mc13xxx_add_subdevice_pdata(struct mc13xxx *mc13xxx,
>  	if (!cell.name)
>  		return -ENOMEM;
>  
> -	return mfd_add_devices(&mc13xxx->spidev->dev, -1, &cell, 1, NULL, 0);
> +	return mfd_add_devices(mc13xxx->dev, -1, &cell, 1, NULL, 0);
>  }
>  
>  static int mc13xxx_add_subdevice(struct mc13xxx *mc13xxx, const char *format)
> @@ -700,7 +708,6 @@ static int mc13xxx_probe(struct spi_device *spi)
>  {
>  	struct mc13xxx *mc13xxx;
>  	struct mc13xxx_platform_data *pdata = dev_get_platdata(&spi->dev);
> -	enum mc13xxx_id id;
>  	int ret;
>  
>  	if (!pdata) {
> @@ -717,13 +724,36 @@ static int mc13xxx_probe(struct spi_device *spi)
>  	spi->bits_per_word = 32;
>  	spi_setup(spi);
>  
> +	mc13xxx->dev = &spi->dev;
>  	mc13xxx->spidev = spi;
> +	mc13xxx->read_dev = mc13xxx_spi_reg_read;
> +	mc13xxx->write_dev = mc13xxx_spi_reg_write;
> +
> +	ret = mc13xxx_common_init(mc13xxx, pdata, spi->irq);
small nitpick: IMHO declaring mc13xxx_common_init globally isn't needed.
For example drivers/mfd/mc13xxx.h would be enough. And this only in
patch 2 if you rearrage it to be defined before mc13xxx_probe.
EXPORT_SYMBOL can then come in patch 2, too.

> +
> +	if (ret) {
> +		dev_set_drvdata(&spi->dev, NULL);
> +	} else {
> +		const struct spi_device_id *devid =
> +			spi_get_device_id(mc13xxx->spidev);
> +		if (!devid || devid->driver_data != mc13xxx->ictype)
> +			dev_warn(mc13xxx->dev,
> +				"device id doesn't match auto detection!\n");
> +	}
> +
> +	return ret;
> +}
> +
> +int mc13xxx_common_init(struct mc13xxx *mc13xxx,
> +		struct mc13xxx_platform_data *pdata, int irq)
> +{
> +	int ret;
>  
>  	mutex_init(&mc13xxx->lock);
>  	mc13xxx_lock(mc13xxx);
>  
> -	ret = mc13xxx_identify(mc13xxx, &id);
> -	if (ret || id == MC13XXX_ID_INVALID)
> +	ret = mc13xxx_identify(mc13xxx);
> +	if (ret)
>  		goto err_revision;
>  
>  	/* mask all irqs */
> @@ -735,14 +765,13 @@ static int mc13xxx_probe(struct spi_device *spi)
>  	if (ret)
>  		goto err_mask;
>  
> -	ret = request_threaded_irq(spi->irq, NULL, mc13xxx_irq_thread,
> +	ret = request_threaded_irq(irq, NULL, mc13xxx_irq_thread,
>  			IRQF_ONESHOT | IRQF_TRIGGER_HIGH, "mc13xxx", mc13xxx);
>  
>  	if (ret) {
>  err_mask:
>  err_revision:
> -		mc13xxx_unlock(mc13xxx);
> -		dev_set_drvdata(&spi->dev, NULL);
> +		mutex_unlock(&mc13xxx->lock);
What is the reason to switch back to an explicit mutex_unlock?
(My guess is a wrong conflict resolution during rebase in the presence
of commit e1b88eb0e08335d2f6c.)

Other than that I'm happy with the patch.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
