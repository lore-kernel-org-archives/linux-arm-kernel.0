From: rob.rice@broadcom.com (Rob (William) Rice)
Date: Wed, 7 Dec 2016 10:49:22 -0500
Subject: [PATCH 2/3] crypto: brcm: Add Broadcom SPU driver
In-Reply-To: <20161206141826.GC24177@leverpostej>
References: <1480536453-24781-1-git-send-email-rob.rice@broadcom.com>
 <1480536453-24781-3-git-send-email-rob.rice@broadcom.com>
 <20161206141826.GC24177@leverpostej>
Message-ID: <77434ed0-34de-f980-a39b-e1e0dcd6c3d5@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

Thanks for the comments. Replies below.

Rob


On 12/6/2016 9:18 AM, Mark Rutland wrote:
> On Wed, Nov 30, 2016 at 03:07:32PM -0500, Rob Rice wrote:
>> +static const struct of_device_id bcm_spu_dt_ids[] = {
>> +	{
>> +		.compatible = "brcm,spum-crypto",
>> +		.data = &spum_ns2_types,
>> +	},
>> +	{
>> +		.compatible = "brcm,spum-nsp-crypto",
>> +		.data = &spum_nsp_types,
>> +	},
>> +	{
>> +		.compatible = "brcm,spu2-crypto",
>> +		.data = &spu2_types,
>> +	},
>> +	{
>> +		.compatible = "brcm,spu2-v2-crypto",
>> +		.data = &spu2_v2_types,
>> +	},
> These last two weren't in the binding document.
yes, I'll add them.
>
>> +	{ /* sentinel */ }
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, bcm_spu_dt_ids);
>> +
>> +static int spu_dt_read(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct spu_hw *spu = &iproc_priv.spu;
>> +	struct device_node *dn = pdev->dev.of_node;
>> +	struct resource *spu_ctrl_regs;
>> +	const struct of_device_id *match;
>> +	struct spu_type_subtype *matched_spu_type;
>> +	void __iomem *spu_reg_vbase[MAX_SPUS];
>> +	int i;
>> +	int err;
>> +
>> +	if (!of_device_is_available(dn)) {
>> +		dev_crit(dev, "SPU device not available");
>> +		return -ENODEV;
>> +	}
> How can this happen?
You are correct. This is unnecessary. I will remove.
>
>> +	/* Count number of mailbox channels */
>> +	spu->num_chan = of_count_phandle_with_args(dn, "mboxes", "#mbox-cells");
>> +	dev_dbg(dev, "Device has %d SPU channels", spu->num_chan);
>> +
>> +	match = of_match_device(of_match_ptr(bcm_spu_dt_ids), dev);
>> +	matched_spu_type = (struct spu_type_subtype *)match->data;
> This cast usn't necessary.
Ok, will remove.
>
>> +	spu->spu_type = matched_spu_type->type;
>> +	spu->spu_subtype = matched_spu_type->subtype;
>> +
>> +	/* Read registers and count number of SPUs */
>> +	i = 0;
>> +	while ((i < MAX_SPUS) && ((spu_ctrl_regs =
>> +		platform_get_resource(pdev, IORESOURCE_MEM, i)) != NULL)) {
>> +		dev_dbg(dev,
>> +			"SPU %d control register region res.start = %#x, res.end = %#x",
>> +			i,
>> +			(unsigned int)spu_ctrl_regs->start,
>> +			(unsigned int)spu_ctrl_regs->end);
>> +
>> +		spu_reg_vbase[i] = devm_ioremap_resource(dev, spu_ctrl_regs);
>> +		if (IS_ERR(spu_reg_vbase[i])) {
>> +			err = PTR_ERR(spu_reg_vbase[i]);
>> +			dev_err(&pdev->dev, "Failed to map registers: %d\n",
>> +				err);
>> +			spu_reg_vbase[i] = NULL;
>> +			return err;
>> +		}
>> +		i++;
>> +	}
> These *really* sound like independent devices. There are no shared
> registers, and each has its own mbox.
>
> Why do we group them like this?
As I said in the previous email, I want one instance of the driver to 
register crypto algos once with the crypto API and to distribute crypto 
requests among all available SPU hw blocks.
>
> Thanks,
> Mark.
