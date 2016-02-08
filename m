From: tthayer@opensource.altera.com (Thor Thayer)
Date: Mon, 8 Feb 2016 10:10:53 -0600
Subject: [PATCHv9 1/4] EDAC, altera: Add Altera L2 Cache and OCRAM EDAC
 Support
In-Reply-To: <20160208113919.GB28980@pd.tnic>
References: <1453911203-30202-1-git-send-email-tthayer@opensource.altera.com>
 <20160208113919.GB28980@pd.tnic>
Message-ID: <56B8BE0D.8070000@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris.

On 02/08/2016 05:39 AM, Borislav Petkov wrote:
> On Wed, Jan 27, 2016 at 10:13:20AM -0600, tthayer at opensource.altera.com wrote:
>> From: Thor Thayer <tthayer@opensource.altera.com>
>>
>> Adding L2 Cache and On-Chip RAM EDAC support for the
>> Altera SoCs using the EDAC device  model. The SDRAM
>> controller is using the Memory Controller model.
>>
>> Each type of ECC is individually configurable.
>>
>> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
>> ---
>> v9: Improve device tree node release. Free managed resources
>>      on error path. Fix ocram memory leak.
>> v8: Remove MASK from single bit mask names.
>>      s/altr,edac/altr,socfpga-ecc-manager
>>      Use debugfs instead of sysfs.
>>      Add chip family name to match string.
>>      Fix header year.
>>      Fix build dependencies & change commit accordingly.
>>      s/CONFIG_EDAC_ALTERA_MC/CONFIG_EDAC_ALTERA
>> v7: s/of_get_named_gen_pool/of_gen_pool_get
>>      Remove #ifdef for EDAC_DEBUG
>>      Use -ENODEV instead of EPROBE_DEFER
>> v6: Convert to nested EDAC in device tree. Force L2 cache
>>      on for L2Cache ECC & remove L2 cache syscon for checking
>>      enable bit. Update year in header.
>> v5: No change.
>> v4: Change mask defines to use BIT().
>>      Fix comment style to agree with kernel coding style.
>>      Better printk description for read != write in trigger.
>>      Remove SysFS debugging message.
>>      Better dci->mod_name
>>      Move gen_pool pointer assignment to end of function.
>>      Invert logic to reduce indent in ocram depenency check.
>>      Change from dev_err() to edac_printk()
>>      Replace magic numbers with defines & comments.
>>      Improve error injection test.
>>      Change Makefile intermediary name to altr (from alt)
>> v3: Move OCRAM and L2 cache EDAC functions into altera_edac.c
>>      instead of separate files.
>> v2: Fix L2 dependency comments.
>> ---
>>   drivers/edac/Kconfig       |   26 ++-
>>   drivers/edac/Makefile      |    2 +-
>>   drivers/edac/altera_edac.c |  487 +++++++++++++++++++++++++++++++++++++++++++-
>>   3 files changed, 507 insertions(+), 8 deletions(-)
>
> I'm still waiting for the people on CC to confirm the DT changes. A
> couple of comments on the EDAC bits below.
>
>

Understood. I did get a conditional ACK from Rob Herring on the DT 
portion of the patch from the last revision (as long as I made the 
changes he suggested which I did in this patch). There may be other 
comments though.

> ....
>
>
>> +static irqreturn_t altr_edac_device_handler(int irq, void *dev_id)
>> +{
>> +	struct edac_device_ctl_info *dci = dev_id;
>> +	struct altr_edac_device_dev *drvdata = dci->pvt_info;
>> +	const struct edac_device_prv_data *priv = drvdata->data;
>> +
>> +	if (irq == drvdata->sb_irq) {
>> +		if (priv->ce_clear_mask)
>> +			writel(priv->ce_clear_mask, drvdata->base);
>> +		edac_device_handle_ce(dci, 0, 0, drvdata->edac_dev_name);
>> +	}
>> +	if (irq == drvdata->db_irq) {
>> +		if (priv->ue_clear_mask)
>> +			writel(priv->ue_clear_mask, drvdata->base);
>> +		edac_device_handle_ue(dci, 0, 0, drvdata->edac_dev_name);
>> +		panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
>> +	}
>
> And irq is guaranteed to always be ->sb_irq or ->db_irq?
>
> Otherwise, you can do
>
> 	else
> 		WARN_ON(1);
>
> just in case.

Those are the only cases of irq but it would be good to be alerted if 
that is not the case. I will add. Thanks!

>
>> +
>> +	return IRQ_HANDLED;
>> +}
>
> ...
>
>> +/*
>> + * altr_edac_device_probe()
>> + *	This is a generic EDAC device driver that will support
>> + *	various Altera memory devices such as the L2 cache ECC and
>> + *	OCRAM ECC as well as the memories for other peripherals.
>> + *	Module specific initialization is done by passing the
>> + *	function index in the device tree.
>> + */
>> +static int altr_edac_device_probe(struct platform_device *pdev)
>> +{

<snip>

>> +
>> +	dci->mod_name = "Altera ECC Manager";
>> +	dci->dev_name = drvdata->edac_dev_name;
>> +
>> +	debugfs = edac_debugfs_create_dir(ecc_name);
>> +	if (debugfs)
>> +		altr_create_edacdev_dbgfs(dci, drvdata->data, debugfs);
>> +
>> +	if (edac_device_add_device(dci))
>
> <--- if you end up here and debugfs nodes have been created, you need to
> destroy them here. You probably could change edac_debugfs_exit() to call
> debugfs_remove_recursive() and make sure your driver calls it.
>
> Right now we're calling edac_debugfs_exit() in edac_exit() and I *think*
> that is ok for a platform device driver as this one but I haven't
> actually *verified* that.

Yes, thanks. I was using the xgene code as an example but I missed the 
unregister (although it looks like the xgene's unregister affects sysfs 
instead of debugfs). I'm also moving the debugfs creation to the end of 
the probe since it is not critical and avoids an error path if creation 
fails.

I'll make the debugfs_remove_recursive() change as a separate patch in 
my next version.

>
>> +		goto fail1;
>> +
>> +	devres_close_group(&pdev->dev, NULL);

<snip>

>> +
>> +	memset(sram_addr, 0, size);
>> +	wmb();	/* Ensure data is written out */
>> +
>> +	*other = gp;	/* Remember this handle for freeing  later */
>
> Please put comments ontop of the line they're referring to. Those
> side-things are cluttering the code unnecessarily.
>
OK.

>> +
>> +	return sram_addr;
>> +}
>> +
>> +static void ocram_free_mem(void *p, size_t size, void *other)
>> +{
>> +	gen_pool_free((struct gen_pool *)other, (u32)p, size);
>> +}
>> +
>> +/*
>> + * altr_ocram_dependencies()
>> + *	Test for OCRAM cache ECC dependencies upon entry because
>> + *	platform specific startup should have initialized the
>> + *	On-Chip RAM memory and enabled the ECC.
>> + *	Can't turn on ECC here because accessing un-initialized
>> + *	memory will cause CE/UE errors possibly causing an ABORT.
>> + */
>> +static int altr_ocram_dependencies(struct platform_device *pdev,
>
> A verb in the name?
>
> 	altr_ocram_test_deps
>
> or
> 	altr_ocram_check_deps
>
> or so?
>

OK. Thanks.

>> +				   void __iomem *base)
>> +{
>> +	u32 control;
>> +

<snip>


>> + *	Note that L2 Cache Enable is forced at build time.
>> + */
>> +static int altr_l2_dependencies(struct platform_device *pdev,
>
> Here too, pls add a verb in the function name.
>
OK. Thanks.

>> +				void __iomem *base)
>> +{
>> +	u32 control;
>> +
>> +	control = readl(base) & ALTR_L2_ECC_EN;
>> +	if (!control) {
>> +		edac_printk(KERN_ERR, EDAC_DEVICE,
>> +			    "L2: No ECC present, or ECC disabled\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	return 0;
>> +}
>

Thanks for reviewing!
