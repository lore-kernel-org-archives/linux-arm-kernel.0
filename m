From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Fri, 22 Jan 2016 18:56:57 +0200
Subject: [PATCHv8 1/4] EDAC, altera: Add Altera L2 Cache and OCRAM EDAC
 Support
In-Reply-To: <56A24C34.3000303@opensource.altera.com>
References: <1453397668-32094-1-git-send-email-tthayer@opensource.altera.com>
 <56A1C5DE.1080501@mentor.com> <56A24C34.3000303@opensource.altera.com>
Message-ID: <56A25F59.5070306@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thor,

On 22.01.2016 17:35, Thor Thayer wrote:
> Hi Vladimir,
> 
> 
> On 01/22/2016 12:02 AM, Vladimir Zapolskiy wrote:
>> Hi Thor,
>>
>> On 21.01.2016 19:34, tthayer at opensource.altera.com wrote:
>>> From: Thor Thayer <tthayer@opensource.altera.com>
>>>
>>> Adding L2 Cache and On-Chip RAM EDAC support for the
>>> Altera SoCs using the EDAC device  model. The SDRAM
>>> controller is using the Memory Controller model.
>>>
>>> Each type of ECC is individually configurable.
>>>
>>> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
>>> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
>>
>> You are sending a change authored by yourself for review, but you add Dinh's
>> SoB, what's his role here?
>>
>> See Documentation/SubmittingPatches "Sign your work".
>>
>> [snip]
> 
> While I was working in a different group at Altera last year, Dinh 
> submitted the previous patch revision so I kept his signed off by for 
> continuity. I'll just use myself in the future. Thank you for clarifying.

it sounds like the author of the original change is Dinh, but if you agreed
about authorship transfer, then "From: Thor Thayer" statement should be
correct, but in any case your SoB should follow Dinh's SoB, if you decide to
keep the latter one.

This consideration may apply to the other changes in the changeset as well.

>>
>>> +/*
>>> + * altr_edac_device_probe()
>>> + *	This is a generic EDAC device driver that will support
>>> + *	various Altera memory devices such as the L2 cache ECC and
>>> + *	OCRAM ECC as well as the memories for other peripherals.
>>> + *	Module specific initialization is done by passing the
>>> + *	function index in the device tree.
>>> + */
>>> +static int altr_edac_device_probe(struct platform_device *pdev)
>>> +{
>>> +	struct edac_device_ctl_info *dci;
>>> +	struct altr_edac_device_dev *drvdata;
>>> +	struct resource *r;
>>> +	int res = 0;
>>> +	struct device_node *np = pdev->dev.of_node;
>>> +	char *ecc_name = (char *)np->name;
>>> +	static int dev_instance;
>>> +	struct dentry *debugfs;
>>> +
>>> +	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL)) {
>>> +		edac_printk(KERN_ERR, EDAC_DEVICE,
>>> +			    "Unable to open devm\n");
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	if (!r) {
>>> +		edac_printk(KERN_ERR, EDAC_DEVICE,
>>> +			    "Unable to get mem resource\n");
>>
>> Missing devres_release_group(&pdev->dev, NULL) on error path.
>>
> Yes. Thank you.
> 
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	if (!devm_request_mem_region(&pdev->dev, r->start, resource_size(r),
>>> +				     dev_name(&pdev->dev))) {
>>> +		edac_printk(KERN_ERR, EDAC_DEVICE,
>>> +			    "%s:Error requesting mem region\n", ecc_name);
>>
>> See above.
>>
>>> +		return -EBUSY;
>>> +	}
>>> +
>>> +	dci = edac_device_alloc_ctl_info(sizeof(*drvdata), ecc_name,
>>> +					 1, ecc_name, 1, 0, NULL, 0,
>>> +					 dev_instance++);
>>> +
>>> +	if (!dci) {
>>> +		edac_printk(KERN_ERR, EDAC_DEVICE,
>>> +			    "%s: Unable to allocate EDAC device\n", ecc_name);
>>
>> See above.
>>
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	drvdata = dci->pvt_info;
>>> +	dci->dev = &pdev->dev;
>>> +	platform_set_drvdata(pdev, dci);
>>> +	drvdata->edac_dev_name = ecc_name;
>>> +
>>> +	drvdata->base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
>>> +	if (!drvdata->base)
>>> +		goto err;
>>> +
>>> +	/* Get driver specific data for this EDAC device */
>>> +	drvdata->data = of_match_node(altr_edac_device_of_match, np)->data;
>>> +
>>> +	/* Check specific dependencies for the module */
>>> +	if (drvdata->data->setup) {
>>> +		res = drvdata->data->setup(pdev, drvdata->base);
>>> +		if (res < 0)
>>> +			goto err;
>>> +	}
>>> +
>>> +	drvdata->sb_irq = platform_get_irq(pdev, 0);
>>> +	res = devm_request_irq(&pdev->dev, drvdata->sb_irq,
>>> +			       altr_edac_device_handler,
>>> +			       0, dev_name(&pdev->dev), dci);
>>> +	if (res < 0)
>>> +		goto err;
>>> +
>>> +	drvdata->db_irq = platform_get_irq(pdev, 1);
>>> +	res = devm_request_irq(&pdev->dev, drvdata->db_irq,
>>> +			       altr_edac_device_handler,
>>> +			       0, dev_name(&pdev->dev), dci);
>>> +	if (res < 0)
>>> +		goto err;
>>> +
>>> +	dci->mod_name = "Altera ECC Manager";
>>> +	dci->dev_name = drvdata->edac_dev_name;
>>> +
>>> +	debugfs = edac_debugfs_create_dir(ecc_name);
>>> +	if (debugfs)
>>> +		altr_create_edacdev_dbgfs(dci, drvdata->data, debugfs);
>>> +
>>> +	if (edac_device_add_device(dci))
>>> +		goto err;
>>> +
>>> +	devres_close_group(&pdev->dev, NULL);
>>> +
>>> +	return 0;
>>> +err:
>>> +	edac_printk(KERN_ERR, EDAC_DEVICE,
>>> +		    "%s:Error setting up EDAC device: %d\n", ecc_name, res);
>>> +	devres_release_group(&pdev->dev, NULL);
>>> +	edac_device_free_ctl_info(dci);
>>> +
>>> +	return res;
>>> +}
>>> +
>>> +static int altr_edac_device_remove(struct platform_device *pdev)
>>> +{
>>> +	struct edac_device_ctl_info *dci = platform_get_drvdata(pdev);
>>> +
>>> +	edac_device_del_device(&pdev->dev);
>>> +	edac_device_free_ctl_info(dci);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static struct platform_driver altr_edac_device_driver = {
>>> +	.probe =  altr_edac_device_probe,
>>> +	.remove = altr_edac_device_remove,
>>> +	.driver = {
>>> +		.name = "altr_edac_device",
>>> +		.of_match_table = altr_edac_device_of_match,
>>> +	},
>>> +};
>>> +module_platform_driver(altr_edac_device_driver);
>>> +
>>> +/*********************** OCRAM EDAC Device Functions *********************/
>>> +
>>> +#ifdef CONFIG_EDAC_ALTERA_OCRAM
>>> +
>>> +static void *ocram_alloc_mem(size_t size, void **other)
>>> +{
>>> +	struct device_node *np;
>>> +	struct gen_pool *gp;
>>> +	void *sram_addr;
>>> +
>>> +	np = of_find_compatible_node(NULL, NULL, "altr,socfpga-ocram-ecc");
>>> +	if (!np)
>>> +		return NULL;
>>> +
>>> +	gp = of_gen_pool_get(np, "iram", 0);
>>> +	if (!gp) {
>>> +		of_node_put(np);
>>> +		return NULL;
>>> +	}
>>> +	of_node_put(np);
>>
>> 	gp = of_gen_pool_get(np, "iram", 0);
>> 	of_node_put(np);
>> 	if (!gp)
>> 		return NULL;
>>
>> version is better.
>>
> 
> I'm sorry, can you elaborate? Are you saying I should return something 
> other than NULL?

Here I propose to do a tiny code optimization, 4 lines vs yours 6 lines of
code without any functional difference.

>>> +
>>> +	sram_addr = (void *)gen_pool_alloc(gp, size / sizeof(size_t));
>>> +	if (!sram_addr)
>>> +		return NULL;
>>> +
>>> +	memset(sram_addr, 0, size);
>>
>> Potential memory corruption, you allocate (size / sizeof(size_t)) bytes and
>> then write size bytes.
>>
> 
> Yes, good catch. I thought I'd fixed this but missed it when I came back.
> 
>>> +	wmb();	/* Ensure data is written out */
>>> +
>>> +	*other = gp;	/* Remember this handle for freeing  later */
>>> +
>>> +	return sram_addr;
>>> +}
>>> +
>>> +static void ocram_free_mem(void *p, size_t size, void *other)
>>> +{
>>> +	gen_pool_free((struct gen_pool *)other, (u32)p, size / sizeof(size_t));
>>
>> See a comment above.
>>
>>> +}
>>> +
>>
>>
> 
> Thank you for reviewing.
> 

No problem :)

--
With best wishes,
Vladimir
