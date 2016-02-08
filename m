From: bp@alien8.de (Borislav Petkov)
Date: Mon, 8 Feb 2016 12:39:19 +0100
Subject: [PATCHv9 1/4] EDAC, altera: Add Altera L2 Cache and OCRAM EDAC
 Support
In-Reply-To: <1453911203-30202-1-git-send-email-tthayer@opensource.altera.com>
References: <1453911203-30202-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <20160208113919.GB28980@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 10:13:20AM -0600, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> Adding L2 Cache and On-Chip RAM EDAC support for the
> Altera SoCs using the EDAC device  model. The SDRAM
> controller is using the Memory Controller model.
> 
> Each type of ECC is individually configurable.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
> v9: Improve device tree node release. Free managed resources
>     on error path. Fix ocram memory leak.
> v8: Remove MASK from single bit mask names.
>     s/altr,edac/altr,socfpga-ecc-manager
>     Use debugfs instead of sysfs.
>     Add chip family name to match string.
>     Fix header year.
>     Fix build dependencies & change commit accordingly.
>     s/CONFIG_EDAC_ALTERA_MC/CONFIG_EDAC_ALTERA
> v7: s/of_get_named_gen_pool/of_gen_pool_get
>     Remove #ifdef for EDAC_DEBUG
>     Use -ENODEV instead of EPROBE_DEFER
> v6: Convert to nested EDAC in device tree. Force L2 cache
>     on for L2Cache ECC & remove L2 cache syscon for checking
>     enable bit. Update year in header.
> v5: No change.
> v4: Change mask defines to use BIT().
>     Fix comment style to agree with kernel coding style.
>     Better printk description for read != write in trigger.
>     Remove SysFS debugging message.
>     Better dci->mod_name
>     Move gen_pool pointer assignment to end of function.
>     Invert logic to reduce indent in ocram depenency check.
>     Change from dev_err() to edac_printk()
>     Replace magic numbers with defines & comments.
>     Improve error injection test.
>     Change Makefile intermediary name to altr (from alt)
> v3: Move OCRAM and L2 cache EDAC functions into altera_edac.c
>     instead of separate files.
> v2: Fix L2 dependency comments.
> ---
>  drivers/edac/Kconfig       |   26 ++-
>  drivers/edac/Makefile      |    2 +-
>  drivers/edac/altera_edac.c |  487 +++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 507 insertions(+), 8 deletions(-)

I'm still waiting for the people on CC to confirm the DT changes. A
couple of comments on the EDAC bits below.


....


> +static irqreturn_t altr_edac_device_handler(int irq, void *dev_id)
> +{
> +	struct edac_device_ctl_info *dci = dev_id;
> +	struct altr_edac_device_dev *drvdata = dci->pvt_info;
> +	const struct edac_device_prv_data *priv = drvdata->data;
> +
> +	if (irq == drvdata->sb_irq) {
> +		if (priv->ce_clear_mask)
> +			writel(priv->ce_clear_mask, drvdata->base);
> +		edac_device_handle_ce(dci, 0, 0, drvdata->edac_dev_name);
> +	}
> +	if (irq == drvdata->db_irq) {
> +		if (priv->ue_clear_mask)
> +			writel(priv->ue_clear_mask, drvdata->base);
> +		edac_device_handle_ue(dci, 0, 0, drvdata->edac_dev_name);
> +		panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
> +	}

And irq is guaranteed to always be ->sb_irq or ->db_irq?

Otherwise, you can do

	else
		WARN_ON(1);

just in case.

> +
> +	return IRQ_HANDLED;
> +}

...

> +/*
> + * altr_edac_device_probe()
> + *	This is a generic EDAC device driver that will support
> + *	various Altera memory devices such as the L2 cache ECC and
> + *	OCRAM ECC as well as the memories for other peripherals.
> + *	Module specific initialization is done by passing the
> + *	function index in the device tree.
> + */
> +static int altr_edac_device_probe(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *dci;
> +	struct altr_edac_device_dev *drvdata;
> +	struct resource *r;
> +	int res = 0;
> +	struct device_node *np = pdev->dev.of_node;
> +	char *ecc_name = (char *)np->name;
> +	static int dev_instance;
> +	struct dentry *debugfs;
> +
> +	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL)) {
> +		edac_printk(KERN_ERR, EDAC_DEVICE,
> +			    "Unable to open devm\n");
> +		return -ENOMEM;
> +	}
> +
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!r) {
> +		edac_printk(KERN_ERR, EDAC_DEVICE,
> +			    "Unable to get mem resource\n");
> +		res = -ENODEV;
> +		goto fail;
> +	}
> +
> +	if (!devm_request_mem_region(&pdev->dev, r->start, resource_size(r),
> +				     dev_name(&pdev->dev))) {
> +		edac_printk(KERN_ERR, EDAC_DEVICE,
> +			    "%s:Error requesting mem region\n", ecc_name);
> +		res = -EBUSY;
> +		goto fail;
> +	}
> +
> +	dci = edac_device_alloc_ctl_info(sizeof(*drvdata), ecc_name,
> +					 1, ecc_name, 1, 0, NULL, 0,
> +					 dev_instance++);
> +
> +	if (!dci) {
> +		edac_printk(KERN_ERR, EDAC_DEVICE,
> +			    "%s: Unable to allocate EDAC device\n", ecc_name);
> +		res = -ENOMEM;
> +		goto fail;
> +	}
> +
> +	drvdata = dci->pvt_info;
> +	dci->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, dci);
> +	drvdata->edac_dev_name = ecc_name;
> +
> +	drvdata->base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
> +	if (!drvdata->base)
> +		goto fail1;
> +
> +	/* Get driver specific data for this EDAC device */
> +	drvdata->data = of_match_node(altr_edac_device_of_match, np)->data;
> +
> +	/* Check specific dependencies for the module */
> +	if (drvdata->data->setup) {
> +		res = drvdata->data->setup(pdev, drvdata->base);
> +		if (res < 0)
> +			goto fail1;
> +	}
> +
> +	drvdata->sb_irq = platform_get_irq(pdev, 0);
> +	res = devm_request_irq(&pdev->dev, drvdata->sb_irq,
> +			       altr_edac_device_handler,
> +			       0, dev_name(&pdev->dev), dci);
> +	if (res < 0)
> +		goto fail1;
> +
> +	drvdata->db_irq = platform_get_irq(pdev, 1);
> +	res = devm_request_irq(&pdev->dev, drvdata->db_irq,
> +			       altr_edac_device_handler,
> +			       0, dev_name(&pdev->dev), dci);
> +	if (res < 0)
> +		goto fail1;
> +
> +	dci->mod_name = "Altera ECC Manager";
> +	dci->dev_name = drvdata->edac_dev_name;
> +
> +	debugfs = edac_debugfs_create_dir(ecc_name);
> +	if (debugfs)
> +		altr_create_edacdev_dbgfs(dci, drvdata->data, debugfs);
> +
> +	if (edac_device_add_device(dci))

<--- if you end up here and debugfs nodes have been created, you need to
destroy them here. You probably could change edac_debugfs_exit() to call
debugfs_remove_recursive() and make sure your driver calls it.

Right now we're calling edac_debugfs_exit() in edac_exit() and I *think*
that is ok for a platform device driver as this one but I haven't
actually *verified* that.

> +		goto fail1;
> +
> +	devres_close_group(&pdev->dev, NULL);
> +
> +	return 0;
> +
> +fail1:
> +	edac_device_free_ctl_info(dci);
> +fail:
> +	devres_release_group(&pdev->dev, NULL);
> +	edac_printk(KERN_ERR, EDAC_DEVICE,
> +		    "%s:Error setting up EDAC device: %d\n", ecc_name, res);
> +
> +	return res;
> +}
> +
> +static int altr_edac_device_remove(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *dci = platform_get_drvdata(pdev);
> +
> +	edac_device_del_device(&pdev->dev);
> +	edac_device_free_ctl_info(dci);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver altr_edac_device_driver = {
> +	.probe =  altr_edac_device_probe,
> +	.remove = altr_edac_device_remove,
> +	.driver = {
> +		.name = "altr_edac_device",
> +		.of_match_table = altr_edac_device_of_match,
> +	},
> +};
> +module_platform_driver(altr_edac_device_driver);
> +
> +/*********************** OCRAM EDAC Device Functions *********************/
> +
> +#ifdef CONFIG_EDAC_ALTERA_OCRAM
> +
> +static void *ocram_alloc_mem(size_t size, void **other)
> +{
> +	struct device_node *np;
> +	struct gen_pool *gp;
> +	void *sram_addr;
> +
> +	np = of_find_compatible_node(NULL, NULL, "altr,socfpga-ocram-ecc");
> +	if (!np)
> +		return NULL;
> +
> +	gp = of_gen_pool_get(np, "iram", 0);
> +	of_node_put(np);
> +	if (!gp)
> +		return NULL;
> +
> +	sram_addr = (void *)gen_pool_alloc(gp, size);
> +	if (!sram_addr)
> +		return NULL;
> +
> +	memset(sram_addr, 0, size);
> +	wmb();	/* Ensure data is written out */
> +
> +	*other = gp;	/* Remember this handle for freeing  later */

Please put comments ontop of the line they're referring to. Those
side-things are cluttering the code unnecessarily.

> +
> +	return sram_addr;
> +}
> +
> +static void ocram_free_mem(void *p, size_t size, void *other)
> +{
> +	gen_pool_free((struct gen_pool *)other, (u32)p, size);
> +}
> +
> +/*
> + * altr_ocram_dependencies()
> + *	Test for OCRAM cache ECC dependencies upon entry because
> + *	platform specific startup should have initialized the
> + *	On-Chip RAM memory and enabled the ECC.
> + *	Can't turn on ECC here because accessing un-initialized
> + *	memory will cause CE/UE errors possibly causing an ABORT.
> + */
> +static int altr_ocram_dependencies(struct platform_device *pdev,

A verb in the name?

	altr_ocram_test_deps

or
	altr_ocram_check_deps

or so?

> +				   void __iomem *base)
> +{
> +	u32 control;
> +
> +	control = readl(base) & ALTR_OCR_ECC_EN;
> +	if (control)
> +		return 0;
> +
> +	edac_printk(KERN_ERR, EDAC_DEVICE,
> +		    "OCRAM: No ECC present or ECC disabled.\n");
> +	return -ENODEV;
> +}
> +
> +const struct edac_device_prv_data ocramecc_data = {
> +	.setup = altr_ocram_dependencies,
> +	.ce_clear_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_SERR),
> +	.ue_clear_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_DERR),
> +	.dbgfs_name = "altr_ocram_trigger",
> +	.alloc_mem = ocram_alloc_mem,
> +	.free_mem = ocram_free_mem,
> +	.ecc_enable_mask = ALTR_OCR_ECC_EN,
> +	.ce_set_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_INJS),
> +	.ue_set_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_INJD),
> +	.trig_alloc_sz = ALTR_TRIG_OCRAM_BYTE_SIZE,
> +};
> +
> +#endif	/* CONFIG_EDAC_ALTERA_OCRAM */
> +
> +/********************* L2 Cache EDAC Device Functions ********************/
> +
> +#ifdef CONFIG_EDAC_ALTERA_L2C
> +
> +static void *l2_alloc_mem(size_t size, void **other)
> +{
> +	struct device *dev = *other;
> +	void *ptemp = devm_kzalloc(dev, size, GFP_KERNEL);
> +
> +	if (!ptemp)
> +		return NULL;
> +
> +	/* Make sure everything is written out */
> +	wmb();

See, it reads much better with the comment ontop. :)

> +
> +	/*
> +	 * Clean all cache levels up to LoC (includes L2)
> +	 * This ensures the corrupted data is written into
> +	 * L2 cache for readback test (which causes ECC error).
> +	 */
> +	flush_cache_all();
> +
> +	return ptemp;
> +}
> +
> +static void l2_free_mem(void *p, size_t size, void *other)
> +{
> +	struct device *dev = other;
> +
> +	if (dev && p)
> +		devm_kfree(dev, p);
> +}
> +
> +/*
> + * altr_l2_dependencies()
> + *	Test for L2 cache ECC dependencies upon entry because
> + *	platform specific startup should have initialized the L2
> + *	memory and enabled the ECC.
> + *	Bail if ECC is not enabled.
> + *	Note that L2 Cache Enable is forced at build time.
> + */
> +static int altr_l2_dependencies(struct platform_device *pdev,

Here too, pls add a verb in the function name.

> +				void __iomem *base)
> +{
> +	u32 control;
> +
> +	control = readl(base) & ALTR_L2_ECC_EN;
> +	if (!control) {
> +		edac_printk(KERN_ERR, EDAC_DEVICE,
> +			    "L2: No ECC present, or ECC disabled\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
