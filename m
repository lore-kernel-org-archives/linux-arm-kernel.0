From: bp@alien8.de (Borislav Petkov)
Date: Tue, 22 Sep 2015 18:40:47 +0200
Subject: [PATCH v4 3/4] edac: Add L3/SoC EDAC support to the APM X-Gene
 SoC EDAC driver
In-Reply-To: <1439534769-22811-4-git-send-email-lho@apm.com>
References: <1439534769-22811-1-git-send-email-lho@apm.com>
 <1439534769-22811-2-git-send-email-lho@apm.com>
 <1439534769-22811-3-git-send-email-lho@apm.com>
 <1439534769-22811-4-git-send-email-lho@apm.com>
Message-ID: <20150922164047.GE3437@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 12:46:08AM -0600, Loc Ho wrote:
> This patch adds EDAC support for the L3 and SoC components.
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> ---
>  drivers/edac/xgene_edac.c | 1169 +++++++++++++++++++++++++++++++++++++--------
>  1 files changed, 975 insertions(+), 194 deletions(-)

...

> +/* L3 Error device */
> +#define L3C_ESR				(0x0A * 4)
> +#define  L3C_ESR_DATATAG_MASK		BIT(9)
> +#define  L3C_ESR_MULTIHIT_MASK		BIT(8)
> +#define  L3C_ESR_UCEVICT_MASK		BIT(6)
> +#define  L3C_ESR_MULTIUCERR_MASK	BIT(5)
> +#define  L3C_ESR_MULTICERR_MASK		BIT(4)
> +#define  L3C_ESR_UCERR_MASK		BIT(3)
> +#define  L3C_ESR_CERR_MASK		BIT(2)
> +#define  L3C_ESR_UCERRINTR_MASK		BIT(1)
> +#define  L3C_ESR_CERRINTR_MASK		BIT(0)
> +#define L3C_ECR				(0x0B * 4)
> +#define  L3C_ECR_UCINTREN		BIT(3)
> +#define  L3C_ECR_CINTREN		BIT(2)
> +#define  L3C_UCERREN			BIT(1)
> +#define  L3C_CERREN			BIT(0)
> +#define L3C_ELR				(0x0C * 4)
> +#define  L3C_ELR_ERRSYN(src)		((src & 0xFF800000) >> 23)
> +#define  L3C_ELR_ERRWAY(src)		((src & 0x007E0000) >> 17)
> +#define  L3C_ELR_AGENTID(src)		((src & 0x0001E000) >> 13)
> +#define  L3C_ELR_ERRGRP(src)		((src & 0x00000F00) >> 8)
> +#define  L3C_ELR_OPTYPE(src)		((src & 0x000000F0) >> 4)
> +#define  L3C_ELR_PADDRHIGH(src)		(src & 0x0000000F)
> +#define L3C_AELR			(0x0D * 4)
> +#define L3C_BELR			(0x0E * 4)
> +#define  L3C_BELR_BANK(src)		(src & 0x0000000F)
> +
> +struct xgene_edac_dev_ctx {
> +	struct list_head	next;
> +	struct device		ddev;
> +	char			*name;
> +	struct xgene_edac	*edac;
> +	struct edac_device_ctl_info *edac_dev;
> +	int			edac_idx;
> +	void __iomem		*dev_csr;
> +	int			version;
> +};
> +

Put the comment ontop of the function. Also, I'd fixup the comment like this:

/*
 * Version 1 of the L3 controller has broken single bit correctable logic for
 * certain error syndromes. Log them as uncorrectable in that case.
 */

and then you can drop the comment in the function itself and at the call site.

> +static bool xgene_edac_l3_v1_errata_chk(u32 l3cesr, u32 l3celr)

This function name should be something like:

should_promote_error_to_uc()

or so because it is what it does.

> +{
> +	/*
> +	 * L3 version 1 has certain conditions in which correctable error
> +	 * needs to be flagged as un-correctable error. This function
> +	 * check for such conditions.
> +	 */
> +	if (l3cesr & L3C_ESR_DATATAG_MASK) {
> +		switch (L3C_ELR_ERRSYN(l3celr)) {
> +		case 0x13C:
> +		case 0x0B4:
> +		case 0x007:
> +		case 0x00D:
> +		case 0x00E:
> +		case 0x019:
> +		case 0x01A:
> +		case 0x01C:
> +		case 0x04E:
> +		case 0x041:
> +			return true;
> +		}
> +	} else if (L3C_ELR_ERRSYN(l3celr) == 9) {
> +		return true;
> +	}

No need for {} around a single statement.

...

> +static ssize_t xgene_edac_l3_inject_ctrl_write(struct file *file,
> +					       const char __user *data,
> +					       size_t count, loff_t *ppos)
> +{
> +	struct edac_device_ctl_info *edac_dev = file->private_data;
> +	struct xgene_edac_dev_ctx *ctx = edac_dev->pvt_info;
> +
> +	/* Generate all errors */
> +	writel(0xFFFFFFFF, ctx->dev_csr + L3C_ESR);
> +	return count;
> +}
> +
> +static const struct file_operations xgene_edac_l3_debug_inject_fops = {
> +	.open = simple_open,
> +	.write = xgene_edac_l3_inject_ctrl_write,
> +	.llseek = generic_file_llseek
> +};
> +
> +static void xgene_edac_l3_create_debugfs_nodes(
> +	struct edac_device_ctl_info *edac_dev)
> +{

This way of formatting the function name should be more readable:

static void
xgene_edac_l3_create_debugfs_nodes(struct edac_device_ctl_info *edac_dev)
{

> +	struct xgene_edac_dev_ctx *ctx = edac_dev->pvt_info;
> +	struct dentry *edac_debugfs;
> +	char name[30];

That's a 30-chars array on the stack ...

> +
> +	if (!ctx->edac->dfs)
> +		return;
> +	sprintf(name, "l3c%d", ctx->edac_idx);

... but you're not clearing or NULL-terminating the rest of it here,
should the string be smaller.

> +	edac_debugfs = debugfs_create_dir(name, ctx->edac->dfs);
> +	if (!edac_debugfs)
> +		return;
> +
> +	debugfs_create_file("l3_inject_ctrl", S_IWUSR, edac_debugfs, edac_dev,
> +			    &xgene_edac_l3_debug_inject_fops);
> +}
> +
> +static int xgene_edac_l3_add(struct xgene_edac *edac, struct device_node *np,
> +			     int version)
> +{
> +	struct edac_device_ctl_info *edac_dev;
> +	struct xgene_edac_dev_ctx *ctx;
> +	struct resource res;
> +	void __iomem *dev_csr;
> +	int edac_idx;
> +	int rc = 0;
> +
> +	if (!devres_open_group(edac->dev, xgene_edac_l3_add, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	rc = of_address_to_resource(np, 0, &res);
> +	if (rc < 0) {
> +		dev_err(edac->dev, "no L3 resource address\n");
> +		goto err_release_group;
> +	}
> +	dev_csr = devm_ioremap_resource(edac->dev, &res);
> +	if (IS_ERR(dev_csr)) {
> +		dev_err(edac->dev,
> +			"devm_ioremap_resource failed for L3 resource address\n");
> +		rc = PTR_ERR(dev_csr);
> +		goto err_release_group;
> +	}
> +
> +	edac_idx = edac_device_alloc_index();
> +	edac_dev = edac_device_alloc_ctl_info(sizeof(*ctx),
> +					      "l3c", 1, "l3c", 1, 0, NULL, 0,
> +					      edac_idx);
> +	if (!edac_dev) {
> +		rc = -ENOMEM;
> +		goto err_release_group;
> +	}
> +
> +	ctx = edac_dev->pvt_info;
> +	ctx->dev_csr = dev_csr;
> +	ctx->name = "xgene_l3_err";
> +	ctx->edac_idx = edac_idx;
> +	ctx->edac = edac;
> +	ctx->edac_dev = edac_dev;
> +	ctx->ddev = *edac->dev;
> +	ctx->version = version;
> +	edac_dev->dev = &ctx->ddev;
> +	edac_dev->ctl_name = ctx->name;
> +	edac_dev->dev_name = ctx->name;
> +	edac_dev->mod_name = EDAC_MOD_STR;
> +
> +	if (edac_op_state == EDAC_OPSTATE_POLL)
> +		edac_dev->edac_check = xgene_edac_l3_check;
> +
> +	xgene_edac_l3_create_debugfs_nodes(edac_dev);
> +
> +	rc = edac_device_add_device(edac_dev);
> +	if (rc > 0) {
> +		dev_err(edac->dev, "failed edac_device_add_device()\n");
> +		rc = -ENOMEM;
> +		goto err_ctl_free;
> +	}
> +
> +	if (edac_op_state == EDAC_OPSTATE_INT)
> +		edac_dev->op_state = OP_RUNNING_INTERRUPT;
> +
> +	list_add(&ctx->next, &edac->l3s);
> +
> +	xgene_edac_l3_hw_init(edac_dev, 1);
> +
> +	devres_remove_group(edac->dev, xgene_edac_l3_add);
> +
> +	dev_info(edac->dev, "X-Gene EDAC L3 registered\n");
> +	return 0;
> +
> +err_ctl_free:
> +	edac_device_free_ctl_info(edac_dev);
> +err_release_group:
> +	devres_release_group(edac->dev, xgene_edac_l3_add);
> +	return rc;
> +}
> +
> +static int xgene_edac_l3_remove(struct xgene_edac_dev_ctx *l3)
> +{
> +	struct edac_device_ctl_info *edac_dev = l3->edac_dev;
> +
> +	xgene_edac_l3_hw_init(edac_dev, 0);
> +	edac_device_del_device(l3->edac->dev);
> +	edac_device_free_ctl_info(edac_dev);
> +	return 0;
> +}

This is a natural point to stop. The rest should be in a separate patch
called something like "EDAC, xgene: Add SoC support...".

> +
> +/* SoC Error device */
> +#define IOBAXIS0TRANSERRINTSTS		0x0000
> +#define  IOBAXIS0_M_ILLEGAL_ACCESS_MASK	BIT(1)
> +#define  IOBAXIS0_ILLEGAL_ACCESS_MASK	BIT(0)
> +#define IOBAXIS0TRANSERRINTMSK		0x0004
> +#define IOBAXIS0TRANSERRREQINFOL	0x0008
> +#define IOBAXIS0TRANSERRREQINFOH	0x000c
> +#define  REQTYPE_RD(src)		(((src) & BIT(0)))
> +#define  ERRADDRH_RD(src)		(((src) & 0xffc00000) >> 22)
> +#define IOBAXIS1TRANSERRINTSTS		0x0010
> +#define IOBAXIS1TRANSERRINTMSK		0x0014
> +#define IOBAXIS1TRANSERRREQINFOL	0x0018
> +#define IOBAXIS1TRANSERRREQINFOH	0x001c
> +#define IOBPATRANSERRINTSTS		0x0020

...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
