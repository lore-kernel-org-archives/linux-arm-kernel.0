From: a.zummo@towertech.it (Alessandro Zummo)
Date: Mon, 1 Feb 2010 10:20:57 +0100
Subject: [PATCH] rtc: driver for the DryIce block found in i.MX25 chips
In-Reply-To: <f0c75e5d2252a4abc5c2ef480d173a4039c44a5c.1265009145.git.baruch@tkos.co.il>
References: <20100129111055.12837fc1@linux.lan.towertech.it>
	<f0c75e5d2252a4abc5c2ef480d173a4039c44a5c.1265009145.git.baruch@tkos.co.il>
Message-ID: <20100201102057.4937155f@linux.lan.towertech.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  1 Feb 2010 09:36:51 +0200
Baruch Siach <baruch@tkos.co.il> wrote:

> Address the comments of Alessandro Zummo:
> 
> 	* remove the .ioctl implementation

 you did not add the ops for alarm irq handling... ?

 more below.

> +static int dryice_rtc_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct imxdi_dev *imxdi = NULL;

 = NULL is not necessary

> +	int rc = 0;

 idem for = 0

> +	imxdi = kzalloc(sizeof(*imxdi), GFP_KERNEL);
> +	if (!imxdi)
> +		return -ENOMEM;
> +
> +	imxdi->pdev = pdev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;

 you forgot to release imxdi here. I still suggest to
 use devm.

> +
> +	if (!request_mem_region(res->start, resource_size(res),
> +				pdev->name)) {
> +		rc = -EBUSY;
> +		goto err_free_mem;
> +	}
> +	imxdi->ioaddr = ioremap(res->start, resource_size(res));
> +	if (imxdi->ioaddr == NULL) {
> +		rc = -ENOMEM;
> +		goto err_release_region;
> +	}
> +
> +	if ((imxdi->irq = platform_get_irq(pdev, 0)) < 0) {
> +		rc = imxdi->irq;
> +		goto err;
> +	}

 no if inline with the assignment please, it's not readable.

> +	init_waitqueue_head(&imxdi->write_wait);
> +
> +	INIT_WORK(&imxdi->work, dryice_work);
> +
> +	mutex_init(&imxdi->write_mutex);
> +
> +	imxdi->clk = clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(imxdi->clk)) {
> +		rc = PTR_ERR(imxdi->clk);
> +		goto err;
> +	}
> +	clk_enable(imxdi->clk);
> +
> +	/*
> +	 * Initialize dryice hardware
> +	 */
> +
> +	/* put dryice into valid state */
> +	if (__raw_readl(imxdi->ioaddr+DSR) & DSR_NVF)
> +		rc = di_write_wait(imxdi, DSR_NVF | DSR_SVF, DSR);
> +	if (rc)
> +		goto err;
> +
> +	/* mask all interrupts */
> +	__raw_writel(0, imxdi->ioaddr+DIER);
> +
> +	if (request_irq(imxdi->irq, dryice_norm_irq, IRQF_SHARED,
> +				pdev->name, imxdi) < 0) {
> +		dev_warn(&pdev->dev, "interrupt not available.\n");
> +		imxdi->irq = -1;
> +		goto err;
> +	}

 ditto for the if. what's the value of rc here?

> +	/* initialize alarm */
> +	rc = di_write_wait(imxdi, DCAMR_UNSET, DCAMR);
> +	if (rc == 0)
> +		rc = di_write_wait(imxdi, 0, DCALR);
> +	if (rc)
> +		goto err;
> +
> +	/* clear alarm flag */
> +	if (__raw_readl(imxdi->ioaddr+DSR) & DSR_CAF)
> +		rc = di_write_wait(imxdi, DSR_CAF, DSR);
> +	if (rc)
> +		goto err;
> +
> +	/* the timer won't count if it has never been written to */
> +	if (__raw_readl(imxdi->ioaddr+DTCMR) == 0)
> +		rc = di_write_wait(imxdi, 0, DTCMR);
> +	if (rc)
> +		goto err;
> +
> +	/* start keeping time */
> +	if (!(__raw_readl(imxdi->ioaddr+DCR) & DCR_TCE))
> +		rc = di_write_wait(imxdi,
> +				__raw_readl(imxdi->ioaddr+DCR) | DCR_TCE, DCR);
> +	if (rc)
> +		goto err;

 spaces are welcomed around the +

> +	imxdi->rtc = rtc_device_register(pdev->name, &pdev->dev,
> +				  &dryice_rtc_ops, THIS_MODULE);
> +	if (IS_ERR(imxdi->rtc)) {
> +		rc = PTR_ERR(imxdi->rtc);
> +		goto err;
> +	}
> +	platform_set_drvdata(pdev, imxdi);
> +
> +	return 0;
> +err:
> +	if (imxdi->rtc && !IS_ERR(imxdi->rtc))
> +		rtc_device_unregister(imxdi->rtc);
> +
> +	if (imxdi->irq >= 0)
> +		free_irq(imxdi->irq, imxdi);
> +
> +	if (imxdi->clk && !IS_ERR(imxdi->clk)) {
> +		clk_disable(imxdi->clk);
> +		clk_put(imxdi->clk);
> +	}
> +
> +	if (imxdi->ioaddr)
> +		iounmap(imxdi->ioaddr);
> +
> +err_release_region:
> +	release_mem_region(res->start, resource_size(res));
> +
> +err_free_mem:
> +	kfree(imxdi);
> +
> +	return rc;
> +}
> +
> +static int __exit dryice_rtc_remove(struct platform_device *pdev)

 no __devexit? 

> +{
> +	struct imxdi_dev *imxdi = platform_get_drvdata(pdev);
> +	struct resource *mem;
> +
> +	flush_scheduled_work();
> +
> +	/* mask alarm interrupt */
> +	di_int_disable(imxdi, DIER_CAIE);
> +
> +	if (imxdi->irq >= 0)
> +		free_irq(imxdi->irq, imxdi);
> +
> +	rtc_device_unregister(imxdi->rtc);
> +
> +	clk_disable(imxdi->clk);
> +	clk_put(imxdi->clk);
> +
> +	iounmap(imxdi->ioaddr);
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	release_mem_region(mem->start, resource_size(mem));
> +
> +	kfree(imxdi);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver dryice_rtc_driver = {
> +	.driver = {
> +		   .name = "imxdi_rtc",
> +		   .owner = THIS_MODULE,
> +		   },
> +	.probe = dryice_rtc_probe,
> +	.remove = __exit_p(dryice_rtc_remove),
 
 __devexit_p ?

> +};
> +
> +static int __init dryice_rtc_init(void)
> +{
> +	return platform_driver_register(&dryice_rtc_driver);
> +}
> +
> +static void __exit dryice_rtc_exit(void)
> +{
> +	platform_driver_unregister(&dryice_rtc_driver);
> +}
> +
> +module_init(dryice_rtc_init);
> +module_exit(dryice_rtc_exit);
> +
> +MODULE_AUTHOR("Freescale Semiconductor, Inc.");
> +MODULE_AUTHOR("Baruch Siach <baruch@tkos.co.il>");
> +MODULE_DESCRIPTION("IMX DryIce Realtime Clock Driver (RTC)");
> +MODULE_LICENSE("GPL");
> -- 
> 1.6.5
> 


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
