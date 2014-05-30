From: bp@alien8.de (Borislav Petkov)
Date: Fri, 30 May 2014 12:29:14 +0200
Subject: [PATCH v2 3/4] edac: Add APM X-Gene SoC EDAC driver
In-Reply-To: <1400894467-1585-4-git-send-email-lho@apm.com>
References: <1400894467-1585-1-git-send-email-lho@apm.com>
 <1400894467-1585-2-git-send-email-lho@apm.com>
 <1400894467-1585-3-git-send-email-lho@apm.com>
 <1400894467-1585-4-git-send-email-lho@apm.com>
Message-ID: <20140530102914.GF28131@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 07:21:06PM -0600, Loc Ho wrote:
> +static ssize_t xgene_edac_mc_inject_ctrl_store(struct device *dev,
> +					       struct device_attribute *mattr,
> +					       const char *data, size_t count)
> +{
> +	struct mem_ctl_info *mci = to_mci(dev);
> +	struct xgene_edac_mc_ctx *ctx = mci->pvt_info;
> +	u32 val;
> +	int i;
> +
> +	if (isdigit(*data)) {
> +		if (kstrtou32(data, 0, &val))
> +			return 0;
> +		for (i = 0; i < MCU_MAX_RANK; i++) {
> +			writel(val,
> +			       ctx->mcu_csr + MCUESRRA0 + i * MCU_RANK_STRIDE);
> +		}
> +		return count;
> +	}
> +	return 0;
> +}
> +
> +DEVICE_ATTR(inject_ctrl, S_IRUGO | S_IWUSR,
> +	    xgene_edac_mc_inject_ctrl_show, xgene_edac_mc_inject_ctrl_store);
> +
> +static int xgene_edac_mc_create_sysfs_attributes(struct mem_ctl_info *mci)
> +{
> +#if defined(CONFIG_EDAC_DEBUG)

Why #if defined()?

#ifdef CONFIG_EDAC_DEBUG is normally enough.

But more importantly, why not wrap around the whole injection code with
#ifdef CONFIG_EDAC_DEBUG instead of only the parts that create the sysfs
nodes?

Also, this is for debugging only so it shouldn't be in sysfs but
debugfs. And yes, there are other edac drivers which use sysfs for
injection but this should be fixed too and I'll be looking into that
too soon.

IOW, here's a good example how it should be done:

http://lkml.kernel.org/r/1399330337-16748-4-git-send-email-tthayer at altera.com

...

> +static int xgene_edac_mc_probe(struct platform_device *pdev)
> +{
> +	struct mem_ctl_info *mci;
> +	struct edac_mc_layer layers[2];
> +	struct xgene_edac_mc_ctx tmp_ctx;
> +	struct xgene_edac_mc_ctx *ctx;
> +	struct resource *res;
> +	int rc = 0;

...

> +	ctx = mci->pvt_info;
> +	*ctx = tmp_ctx;		/* Copy over resource value */
> +	ctx->name = "xgene_edac_mc_err";
> +	mci->pdev = &pdev->dev;
> +	dev_set_drvdata(mci->pdev, mci);
> +	mci->ctl_name = ctx->name;
> +	mci->dev_name = ctx->name;
> +
> +	mci->mtype_cap = MEM_FLAG_RDDR | MEM_FLAG_RDDR2 | MEM_FLAG_RDDR3 |
> +			 MEM_FLAG_DDR | MEM_FLAG_DDR2 | MEM_FLAG_DDR3;
> +	mci->edac_ctl_cap = EDAC_FLAG_SECDED;
> +	mci->edac_cap = EDAC_FLAG_SECDED;
> +	mci->mod_name = EDAC_MOD_STR;
> +	mci->mod_ver = "0.1";
> +	mci->ctl_page_to_phys = NULL;
> +	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
> +	mci->scrub_mode = SCRUB_HW_SRC;
> +
> +	if (edac_op_state == EDAC_OPSTATE_POLL)
> +		mci->edac_check = xgene_edac_mc_check;
> +
> +	if (edac_mc_add_mc(mci)) {
> +		dev_err(&pdev->dev, "failed add edac mc\n");

You forgot to fix those:

"failed add edac mc\n" --> "edac_mc_add_mc failed\n"

> +		rc = -EINVAL;
> +		goto err_free;
> +	}
> +
> +	if (xgene_edac_mc_create_sysfs_attributes(mci)) {
> +		dev_err(&pdev->dev, "failed create edac sysfs\n");

"failed create edac sysfs\n" --> "Failure creating sysfs injection node\n"

Also, please go over the rest of the driver and correct similar error
messages into proper English.

> +		goto err_del;
> +	}
> +
> +	if (edac_op_state == EDAC_OPSTATE_INT) {
> +		int irq = platform_get_irq(pdev, 0);
> +		if (irq < 0) {
> +			dev_err(&pdev->dev, "No IRQ resource\n");
> +			rc = -EINVAL;
> +			goto err_sysfs;
> +		}
> +		rc = devm_request_irq(&pdev->dev, irq,
> +				      xgene_edac_mc_isr, IRQF_SHARED,
> +				      dev_name(&pdev->dev), mci);
> +		if (rc) {
> +			dev_err(&pdev->dev, "Could not request IRQ\n");
> +			goto err_sysfs;
> +		}
> +	}
> +
> +	xgene_edac_mc_irq_ctl(mci, 1);

Forgot this one too:

	xgene_edac_mc_irq_ctl(mci, 1); --> xgene_edac_mc_irq_ctl(mci, true);

> +
> +	devres_remove_group(&pdev->dev, xgene_edac_mc_probe);
> +
> +	dev_info(&pdev->dev, "X-Gene EDAC MC registered\n");
> +	return 0;
> +
> +err_sysfs:
> +	xgene_edac_mc_remove_sysfs_attributes(mci);
> +err_del:
> +	edac_mc_del_mc(&pdev->dev);
> +err_free:
> +	edac_mc_free(mci);
> +err_group:
> +	devres_release_group(&pdev->dev, xgene_edac_mc_probe);
> +	return rc;
> +}
> +
> +static int xgene_edac_mc_remove(struct platform_device *pdev)
> +{
> +	struct mem_ctl_info *mci = dev_get_drvdata(&pdev->dev);
> +
> +	xgene_edac_mc_irq_ctl(mci, 0);

xgene_edac_mc_irq_ctl(mci, 0); --> xgene_edac_mc_irq_ctl(mci, false);

> +	xgene_edac_mc_remove_sysfs_attributes(mci);
> +	edac_mc_del_mc(&pdev->dev);
> +	edac_mc_free(mci);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static struct of_device_id xgene_edac_mc_of_match[] = {
> +	{ .compatible = "apm,xgene-edac-mc" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, xgene_edac_of_match);
> +#endif
> +
> +static struct platform_driver xgene_edac_mc_driver = {
> +	.probe = xgene_edac_mc_probe,
> +	.remove = xgene_edac_mc_remove,
> +	.driver = {
> +		.name = "xgene-edac-mc",
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(xgene_edac_mc_of_match),
> +	},
> +};
> +
> +/* CPU L1/L2 error device */
> +#define MAX_CPU_PER_PMD				2
> +#define CPU_CSR_STRIDE				0x00100000
> +#define CPU_L2C_PAGE				0x000D0000
> +#define CPU_MEMERR_L2C_PAGE			0x000E0000
> +#define CPU_MEMERR_CPU_PAGE			0x000F0000
> +
> +#define MEMERR_CPU_ICFECR_PAGE_OFFSET		0x0000
> +#define MEMERR_CPU_ICFESR_PAGE_OFFSET		0x0004
> +#define  MEMERR_CPU_ICFESR_ERRWAY_RD(src)	(((src) & 0xFF000000) >> 24)
> +#define  MEMERR_CPU_ICFESR_ERRINDEX_RD(src)	(((src) & 0x003F0000) >> 16)
> +#define  MEMERR_CPU_ICFESR_ERRINFO_RD(src)	(((src) & 0x0000FF00) >> 8)
> +#define  MEMERR_CPU_ICFESR_ERRTYPE_RD(src)	(((src) & 0x00000070) >> 4)
> +#define  MEMERR_CPU_ICFESR_MULTCERR_MASK	BIT(2)
> +#define  MEMERR_CPU_ICFESR_CERR_MASK		BIT(0)
> +#define MEMERR_CPU_LSUESR_PAGE_OFFSET		0x000c
> +#define  MEMERR_CPU_LSUESR_ERRWAY_RD(src)	(((src) & 0xFF000000) >> 24)
> +#define  MEMERR_CPU_LSUESR_ERRINDEX_RD(src)	(((src) & 0x003F0000) >> 16)
> +#define  MEMERR_CPU_LSUESR_ERRINFO_RD(src)	(((src) & 0x0000FF00) >> 8)
> +#define  MEMERR_CPU_LSUESR_ERRTYPE_RD(src)	(((src) & 0x00000070) >> 4)
> +#define  MEMERR_CPU_LSUESR_MULTCERR_MASK	BIT(2)
> +#define  MEMERR_CPU_LSUESR_CERR_MASK		BIT(0)
> +#define MEMERR_CPU_LSUECR_PAGE_OFFSET		0x0008
> +#define MEMERR_CPU_MMUECR_PAGE_OFFSET		0x0010
> +#define MEMERR_CPU_MMUESR_PAGE_OFFSET		0x0014
> +#define MEMERR_CPU_ICFESRA_PAGE_OFFSET		0x0804
> +#define MEMERR_CPU_LSUESRA_PAGE_OFFSET		0x080c
> +#define MEMERR_CPU_MMUESRA_PAGE_OFFSET		0x0814
> +
> +#define MEMERR_L2C_L2ECR_PAGE_OFFSET		0x0000
> +#define MEMERR_L2C_L2ESR_PAGE_OFFSET		0x0004
> +#define  MEMERR_L2C_L2ESR_ERRSYN_RD(src)	(((src) & 0xFF000000) >> 24)
> +#define  MEMERR_L2C_L2ESR_ERRWAY_RD(src)	(((src) & 0x00FC0000) >> 18)
> +#define  MEMERR_L2C_L2ESR_ERRCPU_RD(src)	(((src) & 0x00020000) >> 17)
> +#define  MEMERR_L2C_L2ESR_ERRGROUP_RD(src)	(((src) & 0x0000E000) >> 13)
> +#define  MEMERR_L2C_L2ESR_ERRACTION_RD(src)	(((src) & 0x00001C00) >> 10)
> +#define  MEMERR_L2C_L2ESR_ERRTYPE_RD(src)	(((src) & 0x00000300) >> 8)
> +#define  MEMERR_L2C_L2ESR_MULTUCERR_MASK	BIT(3)
> +#define  MEMERR_L2C_L2ESR_MULTICERR_MASK	BIT(2)
> +#define  MEMERR_L2C_L2ESR_UCERR_MASK		BIT(1)
> +#define  MEMERR_L2C_L2ESR_ERR_MASK		BIT(0)
> +#define MEMERR_L2C_L2EALR_PAGE_OFFSET		0x0008
> +#define CPUX_L2C_L2RTOCR_PAGE_OFFSET		0x0010
> +#define MEMERR_L2C_L2EAHR_PAGE_OFFSET		0x000c
> +#define CPUX_L2C_L2RTOSR_PAGE_OFFSET		0x0014
> +#define CPUX_L2C_L2RTOALR_PAGE_OFFSET		0x0018
> +#define CPUX_L2C_L2RTOAHR_PAGE_OFFSET		0x001c
> +#define MEMERR_L2C_L2ESRA_PAGE_OFFSET		0x0804
> +
> +/*
> + * Processor Module Domain (PMD) context - Context for an pair of processsors.

							s/ an / a /

> + * Each PMD consists of 2 CPU's and an shared L2 cache. Each CPU consists of

s/CPU's/CPUs/; 				s/ an / a /

> + * its own L1 cache.
> + */
> +struct xgene_edac_pmd_ctx {
> +	struct device *dev;
> +	char *name;
> +	void __iomem *pcp_csr;	/* PCP CSR for reading error interrupt reg */
> +	void __iomem *pmd_csr;	/* PMD CSR for reading L1/L2 error reg */
> +	int pmd;		/* Identify the register in pcp_csr */
> +};

...

> +static struct edac_dev_sysfs_attribute xgene_edac_pmd_sysfs_attributes[] = {
> +	{ .attr = {
> +		  .name = "l1_inject_ctrl",
> +		  .mode = (S_IRUGO | S_IWUSR)
> +	  },
> +	 .show = xgene_edac_pmd_l1_inject_ctrl_show,
> +	 .store = xgene_edac_pmd_l1_inject_ctrl_store },
> +	{ .attr = {
> +		  .name = "l2_inject_ctrl",
> +		  .mode = (S_IRUGO | S_IWUSR)
> +	  },
> +	 .show = xgene_edac_pmd_l2_inject_ctrl_show,
> +	 .store = xgene_edac_pmd_l2_inject_ctrl_store },
> +
> +	/* End of list */
> +	{ .attr = {.name = NULL } }
> +};
> +#endif

Yep, this is exactly what I meant with CONFIG_EDAC_DEBUG. This looks
good except it should be in debugfs and not sysfs.

> +
> +static int xgene_edac_pmd_probe(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *edac_dev;
> +	struct xgene_edac_pmd_ctx *ctx;
> +	char edac_name[10];
> +	struct resource *res;
> +	int pmd;
> +	int rc = 0;
> +
> +	if (!devres_open_group(&pdev->dev, xgene_edac_pmd_probe, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	/* Find the PMD number from its address */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res || resource_size(res) <= 0) {
> +		rc = -ENODEV;
> +		goto err_group;
> +	}
> +	pmd = ((res->start >> 20) & 0x1E) >> 1;
> +
> +	sprintf(edac_name, "l2c%d", pmd);
> +	edac_dev = edac_device_alloc_ctl_info(sizeof(*ctx),
> +					      edac_name, 1, "l2c", 1, 2, NULL,
> +					      0, edac_device_alloc_index());
> +	if (!edac_dev) {
> +		rc = -ENOMEM;
> +		goto err_group;
> +	}
> +
> +	ctx = edac_dev->pvt_info;
> +	ctx->name = "xgene_pmd_err";
> +	ctx->pmd = pmd;
> +	edac_dev->dev = &pdev->dev;
> +	dev_set_drvdata(edac_dev->dev, edac_dev);
> +	edac_dev->ctl_name = ctx->name;
> +	edac_dev->dev_name = ctx->name;
> +	edac_dev->mod_name = EDAC_MOD_STR;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "no PCP resource address\n");
> +		rc = -EINVAL;
> +		goto err_free;
> +	}
> +	ctx->pcp_csr = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	if (IS_ERR(ctx->pcp_csr)) {
> +		dev_err(&pdev->dev, "no PCP resource address\n");
> +		rc = PTR_ERR(ctx->pcp_csr);
> +		goto err_free;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res) {
> +		dev_err(&pdev->dev, "no PMD resource address\n");
> +		rc = -EINVAL;
> +		goto err_free;
> +	}
> +	ctx->pmd_csr = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	if (IS_ERR(ctx->pmd_csr)) {
> +		dev_err(&pdev->dev, "no PMD resource address\n");
> +		rc = PTR_ERR(ctx->pmd_csr);
> +		goto err_free;
> +	}
> +
> +	if (edac_op_state == EDAC_OPSTATE_POLL)
> +		edac_dev->edac_check = xgene_edac_pmd_check;
> +

...

> +static int __init xgene_edac_init(void)
> +{
> +	int rc;
> +
> +	/* make sure error reporting method is sane */
> +	switch (edac_op_state) {
> +	case EDAC_OPSTATE_POLL:
> +	case EDAC_OPSTATE_INT:
> +		break;
> +	default:
> +		edac_op_state = EDAC_OPSTATE_INT;
> +		break;
> +	}
> +
> +	rc = platform_driver_register(&xgene_edac_mc_driver);
> +	if (rc) {
> +		pr_err(EDAC_MOD_STR "MCU fails to register\n");
> +		goto reg_mc_failed;
> +	}
> +	rc = platform_driver_register(&xgene_edac_pmd_driver);
> +	if (rc) {
> +		pr_err(EDAC_MOD_STR "PMD fails to register\n");
> +		goto reg_pmd_failed;
> +	}
> +	rc = platform_driver_register(&xgene_edac_l3_driver);
> +	if (rc) {
> +		pr_warn(EDAC_MOD_STR "L3 fails to register\n");
> +		goto reg_l3_failed;
> +	}
> +	rc = platform_driver_register(&xgene_edac_soc_driver);
> +	if (rc) {
> +		pr_warn(EDAC_MOD_STR "SoC fails to register\n");

Those pr_warn can all be edac_printk.

Ok, overall it is getting better, just needs a bit more work. Also, the
devicetree stuff would need an ack before it goes through the edac tree.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
