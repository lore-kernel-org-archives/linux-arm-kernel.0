From: b32955@freescale.com (Huang Shijie)
Date: Wed, 2 May 2012 10:50:21 +0800
Subject: [PATCH v2 1/3] mtd: gpmi: add device tree support for mx6q and
 mx28
In-Reply-To: <20120501074943.GB2194@S2101-09.ap.freescale.net>
References: <1335323184-11233-1-git-send-email-b32955@freescale.com>
 <1335323184-11233-2-git-send-email-b32955@freescale.com>
 <20120501074943.GB2194@S2101-09.ap.freescale.net>
Message-ID: <4FA0A0ED.7070804@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn:

thanks a lot for your review.
> You are adding device tree support into a driver that is working fine
> for non-DT probe.  So before all the users of this driver are converted
> to DT, you have to ensure the driver works for both non-DT and DT users
> in a single image when you add DT support for it.
The current gpmi-nand driver can not work in the non-DT, as you known, 
there are
several patches which are not accepted to you.

So, does it make sense to still maintain the support for non-DT?

So i prefer to convert the gpmi-nand to a pure DT driver. make the code 
clear and simple.

> So above code should be something like:
>
> 	if (dn) {
> 		/* get channel number from device tree */
> 		......
> 	} else {
> 		/* otherwise it works as before */
> 	}
>
>> >  +	/* gpmi dma interrupt */
>> >    	r_dma = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
>> >    					GPMI_NAND_DMA_INTERRUPT_RES_NAME);
>> >  -	if (!r || !r_dma) {
>> >  +	if (!r_dma) {
>> >    		pr_err("Can't get resource for DMA\n");
>> >  -		return -ENXIO;
>> >  +		goto acquire_err;
>> >    	}
>> >  +	this->dma_data.chan_irq = r_dma->start;
>> >  
>> >  -	/* used in gpmi_dma_filter() */
>> >  -	this->private = r;
>> >  -
>> >  -	for (i = r->start; i<= r->end; i++) {
>> >  -		struct dma_chan *dma_chan;
>> >  -		dma_cap_mask_t mask;
>> >  -
>> >  -		if (i - r->start>= pdata->max_chip_count)
>> >  -			break;
>> >  +	/* request dma channel */
>> >  +	dma_cap_zero(mask);
>> >  +	dma_cap_set(DMA_SLAVE, mask);
>> >  
>> >  -		dma_cap_zero(mask);
>> >  -		dma_cap_set(DMA_SLAVE, mask);
>> >  -
>> >  -		/* get the DMA interrupt */
>> >  -		if (r_dma->start == r_dma->end) {
>> >  -			/* only register the first. */
>> >  -			if (i == r->start)
>> >  -				this->dma_data.chan_irq = r_dma->start;
>> >  -			else
>> >  -				this->dma_data.chan_irq = NO_IRQ;
>> >  -		} else
>> >  -			this->dma_data.chan_irq = r_dma->start + (i - r->start);
>> >  -
>> >  -		dma_chan = dma_request_channel(mask, gpmi_dma_filter, this);
>> >  -		if (!dma_chan)
>> >  -			goto acquire_err;
>> >  -
>> >  -		/* fill the first empty item */
>> >  -		this->dma_chans[i - r->start] = dma_chan;
>> >  +	dma_chan = dma_request_channel(mask, gpmi_dma_filter, this);
>> >  +	if (!dma_chan) {
>> >  +		pr_err("dma_request_channel failed.\n");
>> >  +		goto acquire_err;
>> >    	}
>> >  
>> >  -	res->dma_low_channel = r->start;
>> >  -	res->dma_high_channel = i;
>> >  +	this->dma_chans[0] = dma_chan;
>> >    	return 0;
>> >  
>> >    acquire_err:
>> >  -	pr_err("Can't acquire DMA channel %u\n", i);
>> >    	release_dma_channels(this);
>> >    	return -EINVAL;
>> >    }
>> >  @@ -1461,9 +1452,9 @@ void gpmi_nfc_exit(struct gpmi_nand_data *this)
>> >  
>> >    static int __devinit gpmi_nfc_init(struct gpmi_nand_data *this)
>> >    {
>> >  -	struct gpmi_nand_platform_data *pdata = this->pdata;
>> >    	struct mtd_info  *mtd =&this->mtd;
>> >    	struct nand_chip *chip =&this->nand;
>> >  +	struct mtd_part_parser_data ppdata = {};
>> >    	int ret;
>> >  
>> >    	/* init current chip */
>> >  @@ -1501,14 +1492,14 @@ static int __devinit gpmi_nfc_init(struct gpmi_nand_data *this)
>> >    	if (ret)
>> >    		goto err_out;
>> >  
>> >  -	ret = nand_scan(mtd, pdata->max_chip_count);
>> >  +	ret = nand_scan(mtd, 1);
> Ditto, you should not break non-DT users.
>
>> >    	if (ret) {
>> >    		pr_err("Chip scan failed\n");
>> >    		goto err_out;
>> >    	}
>> >  
>> >  -	ret = mtd_device_parse_register(mtd, NULL, NULL,
>> >  -			pdata->partitions, pdata->partition_count);
>> >  +	ppdata.of_node = this->pdev->dev.of_node;
>> >  +	ret = mtd_device_parse_register(mtd, NULL,&ppdata, NULL, 0);
>> >    	if (ret)
>> >    		goto err_out;
>> >    	return 0;
>> >  @@ -1518,12 +1509,41 @@ err_out:
>> >    	return ret;
>> >    }
>> >  
>> >  +static const struct platform_device_id gpmi_ids[] = {
>> >  +	{ .name = "imx23-gpmi-nand", .driver_data = IS_MX23, },
>> >  +	{ .name = "imx28-gpmi-nand", .driver_data = IS_MX28, },
>> >  +	{ .name = "imx6q-gpmi-nand", .driver_data = IS_MX6Q, },
>> >  +	{},
>> >  +};
>> >  +
>> >  +static const struct of_device_id gpmi_nand_id_table[] = {
>> >  +	{
>> >  +		.compatible = "fsl,imx23-gpmi-nand",
>> >  +		.data = (void *)&gpmi_ids[IS_MX23]
>> >  +	}, {
>> >  +		.compatible = "fsl,imx28-gpmi-nand",
>> >  +		.data = (void *)&gpmi_ids[IS_MX28]
>> >  +	}, {
>> >  +		.compatible = "fsl,imx6q-gpmi-nand",
>> >  +		.data = (void *)&gpmi_ids[IS_MX6Q]
>> >  +	}, {}
>> >  +};
>> >  +MODULE_DEVICE_TABLE(of, gpmi_nand_id_table);
>> >  +
>> >    static int __devinit gpmi_nand_probe(struct platform_device *pdev)
>> >    {
>> >  -	struct gpmi_nand_platform_data *pdata = pdev->dev.platform_data;
>> >    	struct gpmi_nand_data *this;
>> >  +	const struct of_device_id *of_id;
>> >    	int ret;
>> >  
>> >  +	of_id = of_match_device(gpmi_nand_id_table,&pdev->dev);
>> >  +	if (of_id)
>> >  +		pdev->id_entry = of_id->data;
>> >  +	else {
>> >  +		pr_err("Failed to find the right device id.\n");
>> >  +		return -ENOMEM;
>> >  +	}
>> >  +
> Ditto, it should still work for non-DT users.
>
> BTW, it seems Documentation/CodingStyle suggest put brace like the
> following.
>
> 	if (condition) {
> 		do_this();
> 	} else {
> 		otherwise_do_this();
> 		otherwise_do_that();
> 	}
thanks.
But the Documention/CodingStyle tells us "Do not unnecessarily use 
braces where a single statement will do."


Best Regards
Huang Shijie
