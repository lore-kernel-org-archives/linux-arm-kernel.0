From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 26 Feb 2015 16:23:03 +0100
Subject: [PATCH v6 5/8] iio: adc: fsl,imx25-gcq driver
In-Reply-To: <54D24D63.4040404@kernel.org>
References: <1422540556-14828-1-git-send-email-mpa@pengutronix.de>
 <1422540556-14828-6-git-send-email-mpa@pengutronix.de>
 <54D24D63.4040404@kernel.org>
Message-ID: <20150226152303.GB10070@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 04, 2015 at 04:48:35PM +0000, Jonathan Cameron wrote:
> On 29/01/15 14:09, Markus Pargmann wrote:
> > This is a conversion queue driver for the mx25 SoC. It uses the central
> > ADC which is used by two seperate independent queues. This driver
> > prepares different conversion configurations for each possible input.
> > For a conversion it creates a conversionqueue of one item with the
> > correct configuration for the chosen channel. It then executes the queue
> > once and disables the conversion queue afterwards.
> > 
> > The reference voltages are configurable through devicetree subnodes,
> > depending on the connections of the ADC inputs.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > Signed-off-by: Denis Carikli <denis@eukrea.com>
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Some really small bits and bobs inline...
> Only non trivial one is that I'd prefer that the need for a regulator
> in the event of an external reference being specified was explicitly enforced.
> > ---
> >  drivers/iio/adc/Kconfig                     |   7 +
> >  drivers/iio/adc/Makefile                    |   1 +
> >  drivers/iio/adc/fsl-imx25-gcq.c             | 361 ++++++++++++++++++++++++++++
> >  include/dt-bindings/iio/adc/fsl-imx25-gcq.h |  18 ++
> >  4 files changed, 387 insertions(+)
> >  create mode 100644 drivers/iio/adc/fsl-imx25-gcq.c
> >  create mode 100644 include/dt-bindings/iio/adc/fsl-imx25-gcq.h
> > 
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 0f79e4725763..fccbb4bf44cc 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -143,6 +143,13 @@ config EXYNOS_ADC
> >  	  of SoCs for drivers such as the touchscreen and hwmon to use to share
> >  	  this resource.
> >  
> > +config FSL_MX25_ADC
> > +	tristate "Freescale MX25 ADC driver"
> > +	depends on MFD_MX25_TSADC
> > +	help
> > +	  Generic Conversion Queue driver used for general purpose ADC in the
> > +	  MX25. This driver supports single measurements using the MX25 ADC.
> > +
> >  config LP8788_ADC
> >  	tristate "LP8788 ADC driver"
> >  	depends on MFD_LP8788
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index 701fdb7c96aa..acab8d956371 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -16,6 +16,7 @@ obj-$(CONFIG_AD799X) += ad799x.o
> >  obj-$(CONFIG_AT91_ADC) += at91_adc.o
> >  obj-$(CONFIG_AXP288_ADC) += axp288_adc.o
> >  obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
> > +obj-$(CONFIG_FSL_MX25_ADC) += fsl-imx25-gcq.o
> >  obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
> >  obj-$(CONFIG_MAX1027) += max1027.o
> >  obj-$(CONFIG_MAX1363) += max1363.o
> > diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
> > new file mode 100644
> > index 000000000000..398e40c0e4fd
> > --- /dev/null
> > +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> > @@ -0,0 +1,361 @@
> > +/*
> > + * Copyright 2014 Markus Pargmann, Pengutronix <mpa@pengutronix.de>
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + *
> > + * This is the driver for the imx25 GCQ (Generic Conversion Queue)
> > + * connected to the imx25 ADC.
> > + */
> > +
> > +#include <dt-bindings/iio/adc/fsl-imx25-gcq.h>
> > +#include <linux/clk.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/mfd/imx25-tsadc.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +#define MX25_GCQ_TIMEOUT (msecs_to_jiffies(2000))
> > +
> > +enum mx25_gcq_cfgs {
> > +	MX25_CFG_XP = 0,
> > +	MX25_CFG_YP,
> > +	MX25_CFG_XN,
> > +	MX25_CFG_YN,
> > +	MX25_CFG_WIPER,
> > +	MX25_CFG_INAUX0,
> > +	MX25_CFG_INAUX1,
> > +	MX25_CFG_INAUX2,
> > +	MX25_NUM_CFGS,
> > +};
> > +
> > +struct mx25_gcq_priv {
> > +	struct regmap *regs;
> > +	struct completion completed;
> > +	unsigned int settling_time;
> > +	struct clk *clk;
> > +	int irq;
> > +	struct regulator *ext_vref;
> > +	u32 channel_vref_mv[MX25_NUM_CFGS];
> > +};
> > +
> > +#define MX25_CQG_CHAN(chan, id) {\
> > +	.type = IIO_VOLTAGE,\
> > +	.indexed = 1,\
> > +	.channel = chan,\
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),\
> > +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
> > +	.datasheet_name = id,\
> > +}
> > +
> > +static const struct iio_chan_spec mx25_gcq_channels[MX25_NUM_CFGS] = {
> > +	MX25_CQG_CHAN(0, "xp"),
> > +	MX25_CQG_CHAN(1, "yp"),
> > +	MX25_CQG_CHAN(2, "xn"),
> > +	MX25_CQG_CHAN(3, "yn"),
> > +	MX25_CQG_CHAN(4, "wiper"),
> > +	MX25_CQG_CHAN(5, "inaux0"),
> > +	MX25_CQG_CHAN(6, "inaux1"),
> > +	MX25_CQG_CHAN(7, "inaux2"),
> > +};
> > +
> I'd be tempted to not bother separating out the next two given they
> are only used in one place each..

I removed the wrapping functions.

> > +static void mx25_gcq_disable_eoq(struct mx25_gcq_priv *priv)
> > +{
> > +	regmap_update_bits(priv->regs, MX25_ADCQ_MR, MX25_ADCQ_MR_EOQ_IRQ,
> > +			   MX25_ADCQ_MR_EOQ_IRQ);
> > +}
> > +
> > +static void mx25_gcq_enable_eoq(struct mx25_gcq_priv *priv)
> > +{
> > +	regmap_update_bits(priv->regs, MX25_ADCQ_MR,
> > +			   MX25_ADCQ_MR_EOQ_IRQ, 0);
> > +}
> > +
> > +static irqreturn_t mx25_gcq_irq(int irq, void *data)
> > +{
> > +	struct mx25_gcq_priv *priv = data;
> > +	u32 stats;
> > +
> > +	regmap_read(priv->regs, MX25_ADCQ_SR, &stats);
> > +
> > +	if (stats & MX25_ADCQ_SR_EOQ) {
> > +		mx25_gcq_disable_eoq(priv);
> > +		complete(&priv->completed);
> > +	}
> > +
> > +	/* Disable conversion queue run */
> > +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FQS, 0);
> > +
> > +	/* Acknowledge all possible irqs */
> > +	regmap_write(priv->regs, MX25_ADCQ_SR, MX25_ADCQ_SR_FRR |
> > +		     MX25_ADCQ_SR_FUR | MX25_ADCQ_SR_FOR |
> > +		     MX25_ADCQ_SR_EOQ | MX25_ADCQ_SR_PD);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int mx25_gcq_get_raw_value(struct device *dev,
> > +				  struct iio_chan_spec const *chan,
> > +				  struct mx25_gcq_priv *priv,
> > +				  int *val)
> > +{
> > +	long timeout;
> > +	u32 data;
> > +
> > +	/* Setup the configuration we want to use */
> > +	regmap_write(priv->regs, MX25_ADCQ_ITEM_7_0,
> > +		     MX25_ADCQ_ITEM(0, chan->channel));
> > +
> > +	mx25_gcq_enable_eoq(priv);
> > +
> > +	/* Trigger queue for one run */
> > +	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FQS,
> > +			   MX25_ADCQ_CR_FQS);
> > +
> > +	timeout = wait_for_completion_interruptible_timeout(
> > +		&priv->completed, MX25_GCQ_TIMEOUT);
> > +	if (timeout < 0) {
> > +		dev_err(dev,
> > +			"ADC wait for measurement failed\n");
> > +		return timeout;
> > +	} else if (timeout == 0) {
> > +		dev_err(dev, "ADC timed out\n");
> > +		return -ETIMEDOUT;
> > +	}
> > +
> > +	regmap_read(priv->regs, MX25_ADCQ_FIFO, &data);
> > +
> > +	*val = MX25_ADCQ_FIFO_DATA(data);
> > +
> > +	return IIO_VAL_INT;
> > +}
> > +
> > +static int mx25_gcq_read_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan, int *val,
> > +			     int *val2, long mask)
> > +{
> > +	struct mx25_gcq_priv *priv = iio_priv(indio_dev);
> > +	int ret = 0;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		mutex_lock(&indio_dev->mlock);
> > +		ret = mx25_gcq_get_raw_value(&indio_dev->dev, chan, priv, val);
> > +		mutex_unlock(&indio_dev->mlock);
> > +		return ret;
> > +
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*val = priv->channel_vref_mv[chan->channel];
> > +		*val2 = 12;
> > +		return IIO_VAL_FRACTIONAL_LOG2;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static const struct iio_info mx25_gcq_iio_info = {
> > +	.read_raw = mx25_gcq_read_raw,
> > +};
> > +
> > +static const struct regmap_config mx25_gcq_regconfig = {
> > +	.max_register = 0x5c,
> > +	.reg_bits = 32,
> > +	.val_bits = 32,
> > +	.reg_stride = 4,
> > +};
> > +
> > +static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
> > +			       struct mx25_gcq_priv *priv)
> > +{
> > +	struct device_node *np = pdev->dev.of_node;
> > +	struct device_node *child;
> > +	struct device *dev = &pdev->dev;
> > +	int ret, i;
> > +
> > +	/*
> > +	 * Setup all configurations registers with a default conversion
> > +	 * configuration for each input
> > +	 */
> > +	for (i = 0; i < MX25_NUM_CFGS; ++i)
> > +		regmap_write(priv->regs, MX25_ADCQ_CFG(i),
> > +			     MX25_ADCQ_CFG_YPLL_OFF |
> > +			     MX25_ADCQ_CFG_XNUR_OFF |
> > +			     MX25_ADCQ_CFG_XPUL_OFF |
> > +			     MX25_ADCQ_CFG_REFP_INT |
> > +			     MX25_ADCQ_CFG_IN(i) |
> > +			     MX25_ADCQ_CFG_REFN_NGND2);
> > +
> > +	for_each_child_of_node(np, child) {
> > +		u32 reg;
> > +		u32 refp = MX25_ADCQ_CFG_REFP_INT;
> > +		u32 refn = MX25_ADCQ_CFG_REFN_NGND2;
> > +
> > +		ret = of_property_read_u32(child, "reg", &reg);
> > +		if (ret) {
> > +			dev_err(dev, "Failed to get reg property\n");
> > +			return ret;
> > +		}
> > +
> > +		if (reg >= MX25_NUM_CFGS) {
> > +			dev_err(dev,
> > +				"reg value is greater than the number of available configuration registers\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +		of_property_read_u32(child, "fsl,adc-refp", &refp);
> > +		of_property_read_u32(child, "fsl,adc-refn", &refn);
> > +
> > +		/*
> > +		 * Shift the read values to the correct positions within the
> > +		 * register.
> > +		 */
> > +		refp = MX25_ADCQ_CFG_REFP(refp);
> > +		refn = MX25_ADCQ_CFG_REFN(refn);
> > +
> > +		if ((refp & MX25_ADCQ_CFG_REFP_MASK) != refp) {
> > +			dev_err(dev, "Invalid fsl,adc-refp property value\n");
> > +			return -EINVAL;
> > +		}
> > +		if ((refn & MX25_ADCQ_CFG_REFN_MASK) != refn) {
> > +			dev_err(dev, "Invalid fsl,adc-refn property value");
> > +			return -EINVAL;
> > +		}
> > +
> > +		regmap_update_bits(priv->regs, MX25_ADCQ_CFG(reg),
> > +				   MX25_ADCQ_CFG_REFP_MASK |
> > +				   MX25_ADCQ_CFG_REFN_MASK,
> > +				   refp | refn);
> > +	}
> > +	regmap_update_bits(priv->regs, MX25_ADCQ_CR,
> > +			   MX25_ADCQ_CR_FRST | MX25_ADCQ_CR_QRST,
> > +			   MX25_ADCQ_CR_FRST | MX25_ADCQ_CR_QRST);
> > +
> > +	regmap_write(priv->regs, MX25_ADCQ_CR,
> > +		     MX25_ADCQ_CR_PDMSK |
> > +		     MX25_ADCQ_CR_QSM_FQS);
> Odd line breaking. I certainly wouldn't break the last two lines.

Fixed

> > +
> > +	return 0;
> > +}
> > +
> > +static int mx25_gcq_probe(struct platform_device *pdev)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct mx25_gcq_priv *priv;
> > +	struct mx25_tsadc *tsadc = dev_get_drvdata(pdev->dev.parent);
> > +	struct device *dev = &pdev->dev;
> > +	struct resource *res;
> > +	void __iomem *mem;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	priv = iio_priv(indio_dev);
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	mem = devm_ioremap_resource(dev, res);
> > +	if (!mem)
> > +		return -ENOMEM;
> > +
> > +	priv->regs = devm_regmap_init_mmio(dev, mem, &mx25_gcq_regconfig);
> > +	if (IS_ERR(priv->regs)) {
> > +		dev_err(dev, "Failed to initialize regmap\n");
> > +		return PTR_ERR(priv->regs);
> > +	}
> > +
> > +	init_completion(&priv->completed);
> > +
> > +	/* Optional external regulator */
> > +	priv->ext_vref = devm_regulator_get(&pdev->dev, "vref");
> > +	if (!IS_ERR_OR_NULL(priv->ext_vref)) {
> > +		ret = regulator_enable(priv->ext_vref);
> This is documented in the bindings as being only optional in the sense
> that there may or may not be channels using it.  I'd be inclined
> to have it as non optional, but only request it if in use.
> 
> If truely optional then should be using the get_optional form as otherwise
> IIRC the regulator framework will feed you a dummy regulator under some
> circumstances.

I now moved the devm_regulator_get() function into
mx25_gcq_setup_cfgs(). After all configs are setup and parsed we know
if the regulator is necessary. So it is still optional and only required
and checked if REFP_EXT is used in the devicetree.

> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	ret = mx25_gcq_setup_cfgs(pdev, priv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	priv->clk = tsadc->clk;
> > +	ret = clk_prepare_enable(priv->clk);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to enable clock\n");
> > +		return ret;
> > +	}
> > +
> > +	priv->irq = platform_get_irq(pdev, 0);
> > +	if (priv->irq <= 0) {
> > +		dev_err(dev, "Failed to get IRQ\n");
> > +		ret = priv->irq;
> > +		goto err_clk_unprepare;
> > +	}
> > +
> > +	ret = request_irq(priv->irq, mx25_gcq_irq, 0, pdev->name, priv);
> > +	if (ret) {
> > +		dev_err(dev, "Failed requesting IRQ\n");
> > +		goto err_clk_unprepare;
> > +	}
> > +
> > +	indio_dev->dev.parent = &pdev->dev;
> > +	indio_dev->channels = mx25_gcq_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(mx25_gcq_channels);
> > +	indio_dev->info = &mx25_gcq_iio_info;
> > +
> > +	ret = iio_device_register(indio_dev);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to register iio device\n");
> > +		goto err_irq_free;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, priv);
> I'd normally prefer slightly if this used the indio_dev
> (just a case of logically what contains what...)
> Doesn't really matter though.

Changed it to store indio_dev.

Thank you,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150226/10d89c9b/attachment.sig>
