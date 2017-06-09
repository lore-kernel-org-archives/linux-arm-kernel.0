From: bp@alien8.de (Borislav Petkov)
Date: Fri, 9 Jun 2017 12:39:19 +0200
Subject: [RFC PATCH 1/4] EDAC: mvebu: Add driver for Marvell Armada SoCs
In-Reply-To: <20170608041124.4624-2-chris.packham@alliedtelesis.co.nz>
References: <20170608041124.4624-1-chris.packham@alliedtelesis.co.nz>
 <20170608041124.4624-2-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170609103919.6urvd6sd6ggzuctj@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 04:11:21PM +1200, Chris Packham wrote:
> This adds an EDAC driver for the memory controller and L2 cache used on
> a number of Marvell Armada SoCs.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  drivers/edac/Kconfig      |   7 +
>  drivers/edac/Makefile     |   1 +
>  drivers/edac/mvebu_edac.c | 506 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/edac/mvebu_edac.h |  66 ++++++
>  4 files changed, 580 insertions(+)
>  create mode 100644 drivers/edac/mvebu_edac.c
>  create mode 100644 drivers/edac/mvebu_edac.h

...

> diff --git a/drivers/edac/mvebu_edac.c b/drivers/edac/mvebu_edac.c
> new file mode 100644
> index 000000000000..624cf10f821b
> --- /dev/null
> +++ b/drivers/edac/mvebu_edac.c
> @@ -0,0 +1,506 @@
> +/*
> + * EDAC driver for Marvell ARM SoCs
> + *
> + * Copyright (C) 2017 Allied Telesis Labs
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

We have all those fancy edac_printk() macros, no need to use pr_* ones.

...

> +static int mvebu_mc_err_probe(struct platform_device *pdev)
> +{
> +	struct mem_ctl_info *mci;
> +	struct edac_mc_layer layers[2];
> +	struct mvebu_mc_pdata *pdata;
> +	struct resource *r;
> +	u32 ctl;
> +	int res = 0;
> +
> +	if (!devres_open_group(&pdev->dev, mvebu_mc_err_probe, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
> +	layers[0].size = 1;
> +	layers[0].is_virt_csrow = true;
> +	layers[1].type = EDAC_MC_LAYER_CHANNEL;
> +	layers[1].size = 1;
> +	layers[1].is_virt_csrow = false;
> +	mci = edac_mc_alloc(edac_mc_idx, ARRAY_SIZE(layers), layers,
> +			    sizeof(struct mvebu_mc_pdata));
> +	if (!mci) {
> +		pr_err("%s: No memory for CPU err\n", __func__);
> +		devres_release_group(&pdev->dev, mvebu_mc_err_probe);
> +		return -ENOMEM;
> +	}

Make that call after all platform_get_resource(),
devm_ioremap_resource() so that you can save yourself the unwinding
"goto err" and return directly then.

> +
> +	pdata = mci->pvt_info;
> +	mci->pdev = &pdev->dev;
> +	platform_set_drvdata(pdev, mci);
> +	pdata->name = "mvebu_mc_err";
> +	mci->dev_name = dev_name(&pdev->dev);
> +	pdata->edac_idx = edac_mc_idx++;
> +
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!r) {
> +		pr_err("%s: Unable to get resource for MC err regs\n",
> +		       __func__);
> +		res = -ENOENT;
> +		goto err;
> +	}
> +
> +	pdata->mc_vbase = devm_ioremap_resource(&pdev->dev, r);
> +	if (IS_ERR(pdata->mc_vbase)) {
> +		pr_err("%s: Unable to setup MC err regs\n", __func__);
> +		res = PTR_ERR(pdata->mc_vbase);
> +		goto err;
> +	}
> +
> +	ctl = readl(pdata->mc_vbase + MVEBU_SDRAM_CONFIG);
> +	if (!(ctl & MVEBU_SDRAM_ECC)) {
> +		/* Non-ECC RAM? */
> +		pr_warn("%s: No ECC DIMMs discovered\n", __func__);
> +		res = -ENODEV;
> +		goto err;
> +	}
> +
> +	edac_dbg(3, "init mci\n");
> +	mci->mtype_cap = MEM_FLAG_RDDR | MEM_FLAG_DDR;
> +	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
> +	mci->edac_cap = EDAC_FLAG_SECDED;
> +	mci->mod_name = EDAC_MOD_STR;
> +	mci->mod_ver = MVEBU_REVISION;
> +	mci->ctl_name = mvebu_ctl_name;
> +
> +	if (edac_op_state == EDAC_OPSTATE_POLL)
> +		mci->edac_check = mvebu_mc_check;
> +
> +	mci->ctl_page_to_phys = NULL;
> +
> +	mci->scrub_mode = SCRUB_SW_SRC;
> +
> +	mvebu_init_csrows(mci, pdata);
> +
> +	/* setup MC registers */
> +	writel(0, pdata->mc_vbase + MVEBU_SDRAM_ERR_ADDR);
> +	ctl = readl(pdata->mc_vbase + MVEBU_SDRAM_ERR_ECC_CNTL);
> +	ctl = (ctl & 0xff00ffff) | 0x10000;
> +	writel(ctl, pdata->mc_vbase + MVEBU_SDRAM_ERR_ECC_CNTL);
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
> +		if (res < 0) {
> +			pr_err("%s: Unable to request irq %d\n", __func__,
> +			       pdata->irq);
> +			res = -ENODEV;
> +			goto err;
> +		}
> +
> +		pr_info("acquired irq %d for MC Err\n",
> +		       pdata->irq);

Really needed?

> +	}
> +
> +	res = edac_mc_add_mc(mci);
> +	if (res) {
> +		edac_dbg(3, "failed edac_mc_add_mc()\n");
> +		goto err;
> +	}
> +
> +
> +	/* get this far and it's successful */
> +	edac_dbg(3, "success\n");
> +
> +	return 0;
> +
> +err:
> +	devres_release_group(&pdev->dev, mvebu_mc_err_probe);
> +	edac_mc_free(mci);
> +	return res;
> +}
> +
> +static int mvebu_mc_err_remove(struct platform_device *pdev)
> +{
> +	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
> +
> +	edac_dbg(0, "\n");
> +
> +	edac_mc_del_mc(&pdev->dev);
> +	edac_mc_free(mci);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mvebu_mc_err_of_match[] = {
> +	{ .compatible = "marvell,armada-xp-sdram-controller", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mvebu_mc_err_of_match);
> +
> +static struct platform_driver mvebu_mc_err_driver = {
> +	.probe = mvebu_mc_err_probe,
> +	.remove = mvebu_mc_err_remove,
> +	.driver = {
> +		   .name = "mvebu_mc_err",
> +		   .of_match_table = of_match_ptr(mvebu_mc_err_of_match),
> +	},
> +};
> +
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

Ditto as above. edac_printk().

Also, I'd like to see this made more user-friendly and actually the
error decoded to human-readable strings than dumping raw registers and
then forcing users to go dig IP manuals for the definitions.

> +
> +	if (L2_ERR_TYPE(val) == 0)
> +		edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
> +
> +	if (L2_ERR_TYPE(val) == 1)
> +		edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
> +
> +	writel(BIT(0), pdata->l2_vbase + MVEBU_L2_ERR_ATTR);
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
> +
> +static ssize_t inject_ctrl_show(struct edac_device_ctl_info *edac_dev,
> +				char *data)
> +{
> +	struct mvebu_l2_pdata *pdata = edac_dev->pvt_info;
> +
> +	return sprintf(data, "0x%08x",
> +		       readl(pdata->l2_vbase + MVEBU_L2_ERR_INJ_CTRL));
> +}
> +
> +static ssize_t inject_ctrl_store(struct edac_device_ctl_info *edac_dev,
> +				 const char *data, size_t count)
> +{
> +	struct mvebu_l2_pdata *pdata = edac_dev->pvt_info;
> +	unsigned long val;
> +
> +	if (!kstrtoul(data, 0, &val)) {
> +		writel(val, pdata->l2_vbase + MVEBU_L2_ERR_INJ_CTRL);
> +		return count;
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t inject_mask_show(struct edac_device_ctl_info *edac_dev,
> +				     char *data)
> +{
> +	struct mvebu_l2_pdata *pdata = edac_dev->pvt_info;
> +
> +	return sprintf(data, "0x%08x",
> +		       readl(pdata->l2_vbase + MVEBU_L2_ERR_INJ_MASK));
> +}
> +
> +static ssize_t inject_mask_store(struct edac_device_ctl_info *edac_dev,
> +				      const char *data, size_t count)
> +{
> +	struct mvebu_l2_pdata *pdata = edac_dev->pvt_info;
> +	unsigned long val;
> +
> +	if (!kstrtoul(data, 0, &val)) {
> +		writel(val, pdata->l2_vbase + MVEBU_L2_ERR_INJ_MASK);
> +		return count;
> +	}
> +
> +	return 0;
> +}

Do you really want all those injection things to be present even on a
production system and people to inject stuff?

If not, you can stick them under CONFIG_EDAC_DEBUG.

> +
> +static struct edac_dev_sysfs_attribute mvebu_l2_sysfs_attributes[] = {
> +	__ATTR_RW(inject_ctrl),
> +	__ATTR_RW(inject_mask),
> +	{},
> +};
> +
> +static int mvebu_l2_err_probe(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *edac_dev;
> +	struct mvebu_l2_pdata *pdata;
> +	struct resource *r;
> +	int res;
> +
> +	if (!devres_open_group(&pdev->dev, mvebu_l2_err_probe, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	edac_dev = edac_device_alloc_ctl_info(sizeof(*pdata),
> +					      "cpu", 1, "L", 1, 2, NULL, 0,
> +					      edac_l2_idx);
> +	if (!edac_dev) {
> +		devres_release_group(&pdev->dev, mvebu_l2_err_probe);
> +		return -ENOMEM;
> +	}

Same comment here as above - consider moving that call down in the
function to simplify error handling paths.

> +
> +	pdata = edac_dev->pvt_info;
> +	pdata->name = "mvebu_l2_err";
> +	edac_dev->dev = &pdev->dev;
> +	dev_set_drvdata(edac_dev->dev, edac_dev);
> +	edac_dev->mod_name = EDAC_MOD_STR;
> +	edac_dev->ctl_name = pdata->name;
> +	edac_dev->dev_name = pdata->name;

...

> diff --git a/drivers/edac/mvebu_edac.h b/drivers/edac/mvebu_edac.h
> new file mode 100644
> index 000000000000..33f0534b87df
> --- /dev/null
> +++ b/drivers/edac/mvebu_edac.h
> @@ -0,0 +1,66 @@
> +/*
> + * EDAC defs for Marvell SoCs
> + *
> + * Copyright (C) 2017 Allied Telesis Labs
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details
> + */
> +#ifndef _MVEBU_EDAC_H_
> +#define _MVEBU_EDAC_H_
> +
> +#define MVEBU_REVISION " Ver: 2.0.0"
> +#define EDAC_MOD_STR	"MVEBU_edac"
> +
> +/*
> + * L2 Err Registers
> + */
> +#define MVEBU_L2_ERR_COUNT		0x00	/* 0x8600 */
> +#define MVEBU_L2_ERR_THRESH		0x04	/* 0x8604 */
> +#define MVEBU_L2_ERR_ATTR		0x08	/* 0x8608 */
> +#define MVEBU_L2_ERR_ADDR		0x0c	/* 0x860c */
> +#define MVEBU_L2_ERR_CAP		0x10	/* 0x8610 */
> +#define MVEBU_L2_ERR_INJ_CTRL		0x14	/* 0x8614 */
> +#define MVEBU_L2_ERR_INJ_MASK		0x18	/* 0x8618 */
> +
> +#define L2_ERR_UE_THRESH(val)		((val & 0xff) << 16)
> +#define L2_ERR_CE_THRESH(val)		(val & 0xffff)
> +#define L2_ERR_TYPE(val)		((val >> 8) & 0x3)
> +
> +/*
> + * SDRAM Controller Registers
> + */
> +#define MVEBU_SDRAM_CONFIG		0x00	/* 0x1400 */
> +#define MVEBU_SDRAM_ERR_DATA_HI		0x40	/* 0x1440 */
> +#define MVEBU_SDRAM_ERR_DATA_LO		0x44	/* 0x1444 */
> +#define MVEBU_SDRAM_ERR_ECC_RCVD	0x48	/* 0x1448 */
> +#define MVEBU_SDRAM_ERR_ECC_CALC	0x4c	/* 0x144c */
> +#define MVEBU_SDRAM_ERR_ADDR		0x50	/* 0x1450 */
> +#define MVEBU_SDRAM_ERR_ECC_CNTL	0x54	/* 0x1454 */
> +#define MVEBU_SDRAM_ERR_ECC_ERR_CNT	0x58	/* 0x1458 */
> +
> +#define MVEBU_SDRAM_REGISTERED	0x20000
> +#define MVEBU_SDRAM_ECC		0x40000

BIT()

> +
> +struct mvebu_l2_pdata {
> +	void __iomem *l2_vbase;
> +	char *name;
> +	int irq;
> +	int edac_idx;
> +};
> +
> +struct mvebu_mc_pdata {
> +	void __iomem *mc_vbase;
> +	int total_mem;
> +	char *name;
> +	int irq;
> +	int edac_idx;
> +};

Looks like you could merge those two structs into one.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
