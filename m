From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Oct 2015 12:23:20 +0100
Subject: [PATCH v6 2/4] spi: bcm2835: add bcm2835 auxiliary spi device
 driver
In-Reply-To: <1441970527-2403-3-git-send-email-kernel@martin.sperl.org>
References: <1441970527-2403-1-git-send-email-kernel@martin.sperl.org>
 <1441970527-2403-3-git-send-email-kernel@martin.sperl.org>
Message-ID: <20151006112320.GP12635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 11:22:04AM +0000, kernel at martin.sperl.org wrote:

> +	bs->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
> +	if (bs->irq <= 0) {
> +		dev_err(&pdev->dev, "could not get IRQ: %d\n", bs->irq);
> +		err = bs->irq ? bs->irq : -ENODEV;
> +		goto out_master_put;
> +	}

Why are we using this unusual DT specific API here?  I'd expect to see
just use platform_get_irq() here and this seems to be the only DT
dependency in the driver. 

> +	err = devm_request_irq(&pdev->dev, bs->irq,
> +			       bcm2835aux_spi_interrupt,
> +			       IRQF_SHARED,
> +			       dev_name(&pdev->dev), master);
> +	if (err) {
> +		dev_err(&pdev->dev, "could not request IRQ: %d\n", err);
> +		goto out_clk_disable;
> +	}
> +
> +	/* reset SPI-HW block */
> +	bcm2835aux_spi_reset_hw(bs);

I'd expect to request the IRQ after we reset the hardware in order to
ensure that the hardware is in a known good state 

> +
> +	err = devm_spi_register_master(&pdev->dev, master);
> +	if (err) {
> +		dev_err(&pdev->dev, "could not register SPI master: %d\n", err);
> +		goto out_clk_disable;
> +	}
> +
> +	return 0;
> +
> +out_clk_disable:
> +	clk_disable_unprepare(bs->clk);
> +out_master_put:
> +	spi_master_put(master);
> +	return err;
> +}
> +
> +static int bcm2835aux_spi_remove(struct platform_device *pdev)
> +{
> +	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
> +
> +	bcm2835aux_spi_reset_hw(bs);
> +
> +	/* disable the HW block by releasing the clock */
> +	clk_disable_unprepare(bs->clk);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id bcm2835aux_spi_match[] = {
> +	{ .compatible = "brcm,bcm2835-aux-spi", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, bcm2835aux_spi_match);
> +
> +static struct platform_driver bcm2835aux_spi_driver = {
> +	.driver		= {
> +		.name		= "spi-bcm2835aux",
> +		.of_match_table	= bcm2835aux_spi_match,
> +	},
> +	.probe		= bcm2835aux_spi_probe,
> +	.remove		= bcm2835aux_spi_remove,
> +};
> +module_platform_driver(bcm2835aux_spi_driver);
> +
> +MODULE_DESCRIPTION("SPI controller driver for Broadcom BCM2835 aux");
> +MODULE_AUTHOR("Martin Sperl <kernel@martin.sperl.org>");
> +MODULE_LICENSE("GPL v2");
> --
> 1.7.10.4
> 
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151006/0b82b63c/attachment-0001.sig>
