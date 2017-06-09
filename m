From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Fri, 09 Jun 2017 15:14:22 +0200
Subject: [RFC PATCH 1/4] EDAC: mvebu: Add driver for Marvell Armada SoCs
In-Reply-To: <20170608041124.4624-2-chris.packham@alliedtelesis.co.nz>
References: <20170608041124.4624-1-chris.packham@alliedtelesis.co.nz>
 <20170608041124.4624-2-chris.packham@alliedtelesis.co.nz>
Message-ID: <1497014062.3536.52.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris!

On Do, 2017-06-08 at 16:11 +1200, Chris Packham wrote:
> This adds an EDAC driver for the memory controller and L2 cache used on
> a number of Marvell Armada SoCs.
Why have two separate drivers in the same file and enabled with the same
Kconfig option?

[...]
> +static void mvebu_mc_check(struct mem_ctl_info *mci)
> +{
> +	struct mvebu_mc_pdata *pdata = mci->pvt_info;
> +	u32 reg;
> +	u32 err_addr;
> +	u32 sdram_ecc;
> +	u32 comp_ecc;
> +	u32 syndrome;
> +
> +	reg = readl(pdata->mc_vbase + MVEBU_SDRAM_ERR_ADDR);
> +	if (!reg)
> +		return;
> +
> +	err_addr = reg & ~0x3;
The ERR_ADDR register is not a physical address but contains multiple
fields (bank, col, chip select and error type).

> +	sdram_ecc = readl(pdata->mc_vbase + MVEBU_SDRAM_ERR_ECC_RCVD);
> +	comp_ecc = readl(pdata->mc_vbase + MVEBU_SDRAM_ERR_ECC_CALC);
> +	syndrome = sdram_ecc ^ comp_ecc;
> +
> +	/* first bit clear in ECC Err Reg, 1 bit error, correctable by HW */
> +	if (!(reg & 0x1))
> +		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, 1,
> +				     err_addr >> PAGE_SHIFT,
> +				     err_addr & PAGE_MASK, syndrome,
> +				     0, 0, -1,
> +				     mci->ctl_name, "");
> +	else	/* 2 bit error, UE */
> +		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, 1,
> +				     err_addr >> PAGE_SHIFT,
> +				     err_addr & PAGE_MASK, 0,
> +				     0, 0, -1,
> +				     mci->ctl_name, "");
> +
> +	/* clear the error */
> +	writel(0, pdata->mc_vbase + MVEBU_SDRAM_ERR_ADDR);
This field is documented to be read-only. I had to write the Error
Interrupt Cause Register (0x14d0) or Message Interrupt Cause Register
(0x14d8) to allow the capture of new error details.

[...]
> +static void get_total_mem(struct mvebu_mc_pdata *pdata)
> +{
> +	struct device_node *np = NULL;
> +	struct resource res;
> +	int ret;
> +	unsigned long total_mem = 0;
> +
> +	for_each_node_by_type(np, "memory") {
> +		ret = of_address_to_resource(np, 0, &res);
> +		if (ret)
> +			continue;
> +
> +		total_mem += resource_size(&res);
> +	}
> +
> +	pdata->total_mem = total_mem;
> +}
I think we can calculate the sizes by reading back the individual CS
configuration registers.

> +static void mvebu_init_csrows(struct mem_ctl_info *mci,
> +				struct mvebu_mc_pdata *pdata)
[...]
> +	devtype = (ctl >> 20) & 0x3;
> +	switch (devtype) {
> +	case 0x0:
> +		dimm->dtype = DEV_X32;
> +		break;
> +	case 0x2:		/* could be X8 too, but no way to tell */
> +		dimm->dtype = DEV_X16;
> +		break;
> +	case 0x3:
> +		dimm->dtype = DEV_X4;
> +		break;
> +	default:
> +		dimm->dtype = DEV_UNKNOWN;
> +		break;
> +	}
This register is documented as reserved? I pulled the X8/X16 information
from the Address Control Register (CSnStruct bits).

> +	dimm->edac_mode = EDAC_SECDED;
> +}

[...]
> +	if (!devres_open_group(&pdev->dev, mvebu_mc_err_probe, GFP_KERNEL))
> +		return -ENOMEM;
devres automatically opens a group per device, so this shouln't be
needed (although other EADC drivers do the same).

> +	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
> +	layers[0].size = 1;
> +	layers[0].is_virt_csrow = true;
> +	layers[1].type = EDAC_MC_LAYER_CHANNEL;
> +	layers[1].size = 1;
> +	layers[1].is_virt_csrow = false;
I'm not sure if this is needed. In my driver, only one CHIP_SELECT layer
with size 4 (max number of chip selects) is configured and seems to work
fine.

[...]
> +	mci->scrub_mode = SCRUB_SW_SRC;
I'm not sure if this works as expected ARM as it is currently
implemented, but that's a topic for a different mail.

[...]
> +	/* setup MC registers */
> +	writel(0, pdata->mc_vbase + MVEBU_SDRAM_ERR_ADDR);
> +	ctl = readl(pdata->mc_vbase + MVEBU_SDRAM_ERR_ECC_CNTL);
> +	ctl = (ctl & 0xff00ffff) | 0x10000;
> +	writel(ctl, pdata->mc_vbase + MVEBU_SDRAM_ERR_ECC_CNTL);
This configures the single bit error threshold to 1. My driver does the
same.

> +
> +	if (edac_op_state == EDAC_OPSTATE_INT) {
> +		/* acquire interrupt that reports errors */
> +		pdata->irq = platform_get_irq(pdev, 0);
> +		res = devm_request_irq(&pdev->dev,
> +				       pdata->irq,
> +				       mvebu_mc_isr,
> +				       0,
> +				       "[EDAC] MC err",
> +				       mci);
Which IRQ do you use? The current DT doesn't configure interrupts. Also
it seems that the events are passed through additional layers of
mask/status registers which are not yet represented in the Armada-XP IRQ
hierarchy. So my driver currently uses polling.

[...]
> +static const struct of_device_id mvebu_mc_err_of_match[] = {
> +	{ .compatible = "marvell,armada-xp-sdram-controller", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mvebu_mc_err_of_match);
I currently do the same, but that's not really correct:
In arch/arm/mach-mvebu/pm.c mvebu_pm_suspend_init already uses that
compatible to call request_mem_region(). So need some coordination
between that and the new EDAC driver.

> +/*********************** L2 err device **********************************/
> +static void mvebu_l2_check(struct edac_device_ctl_info *edac_dev)
> +{
> +
> +	struct mvebu_l2_pdata *pdata = edac_dev->pvt_info;
> +	u32 val;
> +
> +	val = readl(pdata->l2_vbase + MVEBU_L2_ERR_ATTR);
> +	if (!(val & 1))
> +		return;
> +
> +	pr_err("ECC Error in CPU L2 cache\n");
> +	pr_err("L2 Error Attributes Capture Register: 0x%08x\n", val);
> +	pr_err("L2 Error Address Capture Register: 0x%08x\n",
> +		readl(pdata->l2_vbase + MVEBU_L2_ERR_ADDR));
> +
> +	if (L2_ERR_TYPE(val) == 0)
> +		edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
> +
> +	if (L2_ERR_TYPE(val) == 1)
> +		edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
We can use the address and attribute registers to collect more
information. Also, the counter registers need to be handled.

> +	writel(BIT(0), pdata->l2_vbase + MVEBU_L2_ERR_ATTR);
OK, I do the same.

> +}
> +
> +static irqreturn_t mvebu_l2_isr(int irq, void *dev_id)
> +{
> +	struct edac_device_ctl_info *edac_dev = dev_id;
> +	struct mvebu_l2_pdata *pdata = edac_dev->pvt_info;
> +	u32 val;
> +
> +	val = readl(pdata->l2_vbase + MVEBU_L2_ERR_ATTR);
> +	if (!(val & 1))
> +		return IRQ_NONE;
> +
> +	mvebu_l2_check(edac_dev);
> +
> +	return IRQ_HANDLED;
> +}
This interrupt seems to be shared with the PMU? Does this work without
implementing support for the additional IRQ status register?

> +static ssize_t inject_ctrl_show(struct edac_device_ctl_info *edac_dev,
[...]
> +static ssize_t inject_ctrl_store(struct edac_device_ctl_info *edac_dev,
> +				 const char *data, size_t count)
[...]
> +static ssize_t inject_mask_show(struct edac_device_ctl_info *edac_dev,
> +				     char *data)
[...]
> +static ssize_t inject_mask_store(struct edac_device_ctl_info *edac_dev,
> +				      const char *data, size_t count)
[...]
> +static struct edac_dev_sysfs_attribute mvebu_l2_sysfs_attributes[] = {
> +	__ATTR_RW(inject_ctrl),
> +	__ATTR_RW(inject_mask),
> +	{},
> +};
I'd prefer to use debugfs for that.

> +static int mvebu_l2_err_probe(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *edac_dev;
> +	struct mvebu_l2_pdata *pdata;
> +	struct resource *r;
> +	int res;
> +
> +	if (!devres_open_group(&pdev->dev, mvebu_l2_err_probe, GFP_KERNEL))
> +		return -ENOMEM;
This is is not needed.

[...]

Regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
