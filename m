From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 7 Feb 2015 10:02:25 +0000
Subject: [PATCHv6 4/5] edac: altera: Add Altera L2 Cache and OCRAM EDAC
 Support
In-Reply-To: <1420772036-3112-5-git-send-email-tthayer@opensource.altera.com>
References: <1420772036-3112-1-git-send-email-tthayer@opensource.altera.com>
 <1420772036-3112-5-git-send-email-tthayer@opensource.altera.com>
Message-ID: <20150207100225.GC8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 08, 2015 at 08:53:55PM -0600, tthayer at opensource.altera.com wrote:
> +static int altr_edac_device_probe(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *dci;
> +	struct altr_edac_device_dev *drvdata;
> +	struct resource *r;
> +	int res = 0;
> +	struct device_node *np = pdev->dev.of_node;
> +	char *ecc_name = (char *)np->name;
> +	static int dev_instance;
> +
> +	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL)) {
> +		edac_printk(KERN_ERR, EDAC_DEVICE,
> +			    "Unable to open devm\n");
> +		return -ENOMEM;
> +	}

Why are you opening a devres group here?  The device model already opens
a devres group ready for the ->probe callback, which is released when
the device is unbound... hmm, see below though...

> +
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!r) {
> +		edac_printk(KERN_ERR, EDAC_DEVICE,
> +			    "Unable to get mem resource\n");
> +		return -EPROBE_DEFER;

Why EPROBE_DEFER for a missing resource?

> +	}
> +
> +	if (!devm_request_mem_region(&pdev->dev, r->start, resource_size(r),
> +				     dev_name(&pdev->dev))) {
> +		edac_printk(KERN_ERR, EDAC_DEVICE,
> +			    "%s:Error requesting mem region\n", ecc_name);
> +		return -EBUSY;
> +	}
> +
> +	dci = edac_device_alloc_ctl_info(sizeof(*drvdata), ecc_name,
> +					 1, ecc_name, 1, 0, NULL, 0,
> +					 dev_instance++);
> +
> +	if (!dci) {
> +		edac_printk(KERN_ERR, EDAC_DEVICE,
> +			    "%s: Unable to allocate EDAC device\n", ecc_name);
> +		return -ENOMEM;
> +	}
> +
> +	drvdata = dci->pvt_info;
> +	dci->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, dci);
> +	drvdata->edac_dev_name = ecc_name;
> +
> +	drvdata->base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
> +	if (!drvdata->base)
> +		goto err;

You could use devm_ioremap_resource() to simplify the mapping, resource
allocation and resource error handling.

> +
> +	/* Get driver specific data for this EDAC device */
> +	drvdata->data = of_match_node(altr_edac_device_of_match, np)->data;
> +
> +	/* Check specific dependencies for the module */
> +	if (drvdata->data->setup) {
> +		res = drvdata->data->setup(pdev, drvdata->base);
> +		if (res < 0)
> +			goto err;
> +	}
> +
> +	drvdata->sb_irq = platform_get_irq(pdev, 0);
> +	res = devm_request_irq(&pdev->dev, drvdata->sb_irq,
> +			       altr_edac_device_handler,
> +			       0, dev_name(&pdev->dev), dci);
> +	if (res < 0)
> +		goto err;
> +
> +	drvdata->db_irq = platform_get_irq(pdev, 1);
> +	res = devm_request_irq(&pdev->dev, drvdata->db_irq,
> +			       altr_edac_device_handler,
> +			       0, dev_name(&pdev->dev), dci);
> +	if (res < 0)
> +		goto err;
> +
> +	dci->mod_name = "Altera EDAC Memory";
> +	dci->dev_name = drvdata->edac_dev_name;
> +
> +	altr_set_sysfs_attr(dci, drvdata->data);
> +
> +	if (edac_device_add_device(dci))
> +		goto err;
> +
> +	devres_close_group(&pdev->dev, NULL);
> +
> +	return 0;
> +err:
> +	edac_printk(KERN_ERR, EDAC_DEVICE,
> +		    "%s:Error setting up EDAC device: %d\n", ecc_name, res);
> +	devres_release_group(&pdev->dev, NULL);
> +	edac_device_free_ctl_info(dci);

Hmm, I guess this is why you're using devm groups - it seems like
edac allocation/freeing needs to be improved to work cooperatively
with devm_* APIs rather than having to add devm group complexity
into drivers.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
