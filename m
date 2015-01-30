From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 30 Jan 2015 09:16:31 +0100
Subject: [PATCH v6 5/8] iio: adc: fsl,imx25-gcq driver
In-Reply-To: <54CA4419.1060207@gmail.com>
References: <1422540556-14828-1-git-send-email-mpa@pengutronix.de>
 <1422540556-14828-6-git-send-email-mpa@pengutronix.de>
 <54CA4419.1060207@gmail.com>
Message-ID: <20150130081631.GF16879@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 29, 2015 at 08:00:49PM +0530, Varka Bhadram wrote:
> Hi,
> 
> On Thursday 29 January 2015 07:39 PM, Markus Pargmann wrote:
> >This is a conversion queue driver for the mx25 SoC. It uses the central
> >ADC which is used by two seperate independent queues. This driver
> >prepares different conversion configurations for each possible input.
> >For a conversion it creates a conversionqueue of one item with the
> >correct configuration for the chosen channel. It then executes the queue
> >once and disables the conversion queue afterwards.
> >
> >The reference voltages are configurable through devicetree subnodes,
> >depending on the connections of the ADC inputs.
> >
> >Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> >Signed-off-by: Denis Carikli <denis@eukrea.com>
> >Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> >---
> >  drivers/iio/adc/Kconfig                     |   7 +
> >  drivers/iio/adc/Makefile                    |   1 +
> >  drivers/iio/adc/fsl-imx25-gcq.c             | 361 ++++++++++++++++++++++++++++
> >  include/dt-bindings/iio/adc/fsl-imx25-gcq.h |  18 ++
> >  4 files changed, 387 insertions(+)
> >  create mode 100644 drivers/iio/adc/fsl-imx25-gcq.c
> >  create mode 100644 include/dt-bindings/iio/adc/fsl-imx25-gcq.h
> >
> (...)
> 
> >+static int mx25_gcq_probe(struct platform_device *pdev)
> >+{
> >+	struct iio_dev *indio_dev;
> >+	struct mx25_gcq_priv *priv;
> >+	struct mx25_tsadc *tsadc = dev_get_drvdata(pdev->dev.parent);
> >+	struct device *dev = &pdev->dev;
> >+	struct resource *res;
> >+	void __iomem *mem;
> >+	int ret;
> >+
> >+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
> >+	if (!indio_dev)
> >+		return -ENOMEM;
> >+
> >+	priv = iio_priv(indio_dev);
> >+
> >+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >+	mem = devm_ioremap_resource(dev, res);
> >+	if (!mem)
> >+		return -ENOMEM;
> >+
> >+	priv->regs = devm_regmap_init_mmio(dev, mem, &mx25_gcq_regconfig);
> >+	if (IS_ERR(priv->regs)) {
> >+		dev_err(dev, "Failed to initialize regmap\n");
> >+		return PTR_ERR(priv->regs);
> >+	}
> >+
> >+	init_completion(&priv->completed);
> >+
> >+	/* Optional external regulator */
> >+	priv->ext_vref = devm_regulator_get(&pdev->dev, "vref");
> >+	if (!IS_ERR_OR_NULL(priv->ext_vref)) {
> >+		ret = regulator_enable(priv->ext_vref);
> >+		if (ret)
> >+			return ret;
> >+	}
> >+
> >+	ret = mx25_gcq_setup_cfgs(pdev, priv);
> >+	if (ret)
> >+		return ret;
> >+
> >+	priv->clk = tsadc->clk;
> >+	ret = clk_prepare_enable(priv->clk);
> >+	if (ret) {
> >+		dev_err(dev, "Failed to enable clock\n");
> >+		return ret;
> >+	}
> >+
> >+	priv->irq = platform_get_irq(pdev, 0);
> >+	if (priv->irq <= 0) {
> >+		dev_err(dev, "Failed to get IRQ\n");
> >+		ret = priv->irq;
> >+		goto err_clk_unprepare;
> >+	}
> >+
> >+	ret = request_irq(priv->irq, mx25_gcq_irq, 0, pdev->name, priv);
> 
> Use of devm_* API

It seems to be save to use it here, as the interrupt handler only uses
memory allocated for this driver and not the iio framework. So I will
probably change it to devm_*.

Thanks,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150130/4824a8ec/attachment.sig>
