From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 08 Feb 2013 21:48:46 +0000
Subject: [PATCH] i2c: add bcm2835 driver
In-Reply-To: <1357191978-11038-1-git-send-email-swarren@wwwdotorg.org>
References: <1357191978-11038-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130208214846.35F2D3E2C27@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  2 Jan 2013 22:46:18 -0700, Stephen Warren <swarren@wwwdotorg.org> wrote:
> This implements a very basic I2C host driver for the BCM2835 SoC. Missing
> features so far are:
> 
> * Clock rate adjustment.
> * 10-bit addressing.
> * DMA.
> 
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
>  .../devicetree/bindings/i2c/brcm,bcm2835-i2c.txt   |   20 ++
>  drivers/i2c/busses/Kconfig                         |   12 +
>  drivers/i2c/busses/Makefile                        |    1 +
>  drivers/i2c/busses/i2c-bcm2835.c                   |  331 ++++++++++++++++++++
>  4 files changed, 364 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/brcm,bcm2835-i2c.txt
>  create mode 100644 drivers/i2c/busses/i2c-bcm2835.c
> 
> diff --git a/Documentation/devicetree/bindings/i2c/brcm,bcm2835-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,bcm2835-i2c.txt
> new file mode 100644
> index 0000000..e9de375
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/brcm,bcm2835-i2c.txt
> @@ -0,0 +1,20 @@
> +Broadcom BCM2835 I2C controller
> +
> +Required properties:
> +- compatible : Should be "brcm,bcm2835-i2c".
> +- reg: Should contain register location and length.
> +- interrupts: Should contain interrupt.
> +- clocks : The clock feeding the I2C controller.
> +
> +Recommended properties:
> +- clock-frequency : desired I2C bus clock frequency in Hz.
> +
> +Example:
> +
> +i2c at 20205000 {
> +	compatible = "brcm,bcm2835-i2c";
> +	reg = <0x7e205000 0x1000>;
> +	interrupts = <2 21>;
> +	clocks = <&clk_i2c>;
> +	clock-frequency = <100000>;
> +};

Looks good.

> +static int __devinit bcm2835_i2c_probe(struct platform_device *pdev)
> +{
> +	struct bcm2835_i2c_dev *i2c_dev;
> +	struct resource *mem, *requested, *irq;
> +	int ret;
> +	struct i2c_adapter *adap;
> +
> +	i2c_dev = devm_kzalloc(&pdev->dev, sizeof(*i2c_dev), GFP_KERNEL);
> +	if (!i2c_dev) {
> +		dev_err(&pdev->dev, "Cannot allocate i2c_dev\n");
> +		return -ENOMEM;
> +	}
> +	platform_set_drvdata(pdev, i2c_dev);
> +	i2c_dev->dev = &pdev->dev;
> +	init_completion(&i2c_dev->completion);
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!mem) {
> +		dev_err(&pdev->dev, "No mem resource\n");
> +		return -ENODEV;
> +	}
> +
> +	requested = devm_request_mem_region(&pdev->dev, mem->start,
> +					    resource_size(mem),
> +					    dev_name(&pdev->dev));
> +	if (!requested) {
> +		dev_err(&pdev->dev, "Could not claim register region\n");
> +		return -EBUSY;
> +	}
> +
> +	i2c_dev->regs = devm_ioremap(&pdev->dev, mem->start,
> +				     resource_size(mem));
> +	if (!i2c_dev->regs) {
> +		dev_err(&pdev->dev, "Could not map registers\n");
> +		return -ENOMEM;
> +	}
> +
> +	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (!irq) {
> +		dev_err(&pdev->dev, "No IRQ resource\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, irq->start, bcm2835_i2c_isr,
> +			       IRQF_SHARED, dev_name(&pdev->dev), i2c_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Could not request IRQ\n");
> +		return -ENODEV;
> +	}
> +
> +	adap = &i2c_dev->adapter;
> +	i2c_set_adapdata(adap, i2c_dev);
> +	adap->owner = THIS_MODULE;
> +	adap->class = I2C_CLASS_HWMON;
> +	strlcpy(adap->name, "bcm2835 I2C adapter", sizeof(adap->name));
> +	adap->algo = &bcm2835_i2c_algo;
> +	adap->dev.parent = &pdev->dev;
> +	adap->nr = -1;
> +
> +	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, 0);
> +
> +	ret = i2c_add_numbered_adapter(adap);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Could not add adapter\n");
> +		return ret;
> +	}
> +
> +	return 0;

The driver core will print a message if things fail here. The above 6
lines can be replaced with simply:

	return i2c_add_numbered_adapter(adap);

> +}
> +
> +static int bcm2835_i2c_remove(struct platform_device *pdev)
> +{
> +	struct bcm2835_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
> +
> +	i2c_del_adapter(&i2c_dev->adapter);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id bcm2835_i2c_of_match[] = {
> +	{ .compatible = "brcm,bcm2835-i2c" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, bcm2835_i2c_of_match);
> +
> +static struct platform_driver bcm2835_i2c_driver = {
> +	.probe		= bcm2835_i2c_probe,
> +	.remove		= bcm2835_i2c_remove,
> +	.driver		= {
> +		.name	= "i2c-bcm2835",
> +		.owner	= THIS_MODULE,
> +		.of_match_table = bcm2835_i2c_of_match,
> +	},
> +};
> +
> +static int __init bcm2835_i2c_init_driver(void)
> +{
> +	return platform_driver_register(&bcm2835_i2c_driver);
> +}
> +module_init(bcm2835_i2c_init_driver);
> +
> +static void __exit bcm2835_i2c_exit_driver(void)
> +{
> +	platform_driver_unregister(&bcm2835_i2c_driver);
> +}
> +module_exit(bcm2835_i2c_exit_driver);

Nit: module_platform_driver()

Otherwise looks pretty tight.

Reviewed-by: Grant Likely <grant.likely@secretlab.ca>

g.
