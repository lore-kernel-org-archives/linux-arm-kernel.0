From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 30 Nov 2011 16:12:10 +0800
Subject: [PATCH 1/5] mfd: mc13xxx: add device tree probe support
In-Reply-To: <4ED49683.10609@ti.com>
References: <1322487439-27254-1-git-send-email-shawn.guo@linaro.org>
 <1322487439-27254-2-git-send-email-shawn.guo@linaro.org>
 <4ED49683.10609@ti.com>
Message-ID: <20111130081209.GB2506@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 01:53:31PM +0530, Rajendra Nayak wrote:
> []...
> >+};
> >+MODULE_DEVICE_TABLE(of, mc13xxx_dt_ids);
> >+
> >  static int mc13xxx_probe(struct spi_device *spi)
> >  {
> >+	struct device_node *np = spi->dev.of_node;
> >+	const struct of_device_id *of_id;
> >+	struct spi_driver *sdrv = to_spi_driver(spi->dev.driver);
> >  	struct mc13xxx *mc13xxx;
> >  	struct mc13xxx_platform_data *pdata = dev_get_platdata(&spi->dev);
> >  	enum mc13xxx_id id;
> >  	int ret;
> >
> >-	if (!pdata) {
> >-		dev_err(&spi->dev, "invalid platform data\n");
> >-		return -EINVAL;
> >-	}
> >+	of_id = of_match_device(mc13xxx_dt_ids,&spi->dev);
> >+	if (of_id)
> >+		sdrv->id_table =&mc13xxx_device_id[(enum mc13xxx_id) of_id->data];
> >
> >  	mc13xxx = kzalloc(sizeof(*mc13xxx), GFP_KERNEL);
> >  	if (!mc13xxx)
> >@@ -735,6 +787,15 @@ static int mc13xxx_probe(struct spi_device *spi)
> >  	if (ret)
> >  		goto err_mask;
> >
> >+	mc13xxx->irq_gpio = of_get_named_gpio(np, "mc13xxx-irq-gpios", 0);
> >+	if (gpio_is_valid(mc13xxx->irq_gpio)) {
> >+		ret = gpio_request_one(mc13xxx->irq_gpio, GPIOF_IN,
> >+				       "mc13xxx-irq");
> >+		if (ret)
> >+			goto err_mask;
> >+		spi->irq = gpio_to_irq(mc13xxx->irq_gpio);
> 
> This seems wrong, because its adding information about the irq actually
> being a gpio within the driver (which was otherwise hidden by the board
> files doing a gpio_to_irq()). What happens if on some device this is
> actually hooked to an irq line instead of a gpio?
> There should be a better way to do this using Device tree.
> 
Indeed.  I should have 'interrupt-parent' and 'interrupts' encoded as
below, so that 'spi->irq = irq_of_parse_and_map(nc, 0);' in of_spi.c
can get the irq set up properly.

pmic: mc13892 at 0 {
	#address-cells = <1>;
	#size-cells = <0>;
	compatible = "fsl,mc13892";
	spi-max-frequency = <6000000>;
	reg = <0>;
	interrupt-parent = <&gpio0>;
	interrupts = <8>;
};

Thanks for catching this.

-- 
Regards,
Shawn
