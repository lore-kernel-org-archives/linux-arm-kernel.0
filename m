From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 29 Jun 2018 14:30:28 +0200
Subject: [PATCH v3 08/17] irqchip/irq-mvebu-icu: disociate ICU and NSR
In-Reply-To: <0d666052-b1f5-a27a-1bc8-fa3ede9e388a@arm.com>
References: <20180622151432.1566-1-miquel.raynal@bootlin.com>
 <20180622151432.1566-9-miquel.raynal@bootlin.com>
 <0d666052-b1f5-a27a-1bc8-fa3ede9e388a@arm.com>
Message-ID: <20180629143028.4059e860@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

[...]

> > -	/*
> > -	 * We're probed after MSI domains have been resolved, so force
> > -	 * resolution here.
> > -	 */
> > -	pdev->dev.msi_domain = of_msi_get_domain(&pdev->dev, node,
> > -						 DOMAIN_BUS_PLATFORM_MSI);
> > -	if (!pdev->dev.msi_domain)
> > -		return -EPROBE_DEFER;
> > -
> > -	gicp_dn = irq_domain_get_of_node(pdev->dev.msi_domain);
> > -	if (!gicp_dn)
> > -		return -ENODEV;
> > -
> >  	/*
> >  	 * Clean all ICU interrupts with type SPI_NSR, required to
> >  	 * avoid unpredictable SPI assignments done by firmware.
> > @@ -282,16 +297,9 @@ static int mvebu_icu_probe(struct platform_device *pdev)
> >  			regmap_write(icu->regmap, ICU_INT_CFG(i), 0);
> >  	}
> >  
> > -	irq_domain =
> > -		platform_msi_create_device_domain(&pdev->dev, ICU_MAX_IRQS,
> > -						  mvebu_icu_write_msg,
> > -						  &mvebu_icu_domain_ops, icu);
> > -	if (!irq_domain) {
> > -		dev_err(&pdev->dev, "Failed to create ICU domain\n");
> > -		return -ENOMEM;
> > -	}
> > +	platform_set_drvdata(pdev, icu);  
> 
> What is the upshot of passing this icu pointer as part of the platform
> device structure instead of simply passing it as a parameter? Is
> anything else using it?

Not at this stage of the series, but right after the patch
"irqchip/irq-mvebu-icu: support ICU subnodes" does the following:

@@ -299,7 +356,10 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, icu);
 
-	return mvebu_icu_subset_probe(pdev);
+	if (icu->legacy_bindings)
+		return mvebu_icu_subset_probe(pdev);
+	else
+		return devm_of_platform_populate(&pdev->dev);
 }
  
Using driver data in both cases was, from my point of view, the easiest
(meanwhile, I'll simplify it thanks to another comment you made).

Thanks,
Miqu?l
