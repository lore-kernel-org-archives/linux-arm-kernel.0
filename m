From: bp@alien8.de (Borislav Petkov)
Date: Wed, 29 Jul 2015 16:29:42 +0200
Subject: [PATCH v2 2/3] edac: Add L3/SoC support to the APM X-Gene SoC
 EDAC driver
In-Reply-To: <1437808063-17592-3-git-send-email-lho@apm.com>
References: <1437808063-17592-1-git-send-email-lho@apm.com>
 <1437808063-17592-2-git-send-email-lho@apm.com>
 <1437808063-17592-3-git-send-email-lho@apm.com>
Message-ID: <20150729142941.GC17367@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 25, 2015 at 01:07:42AM -0600, Loc Ho wrote:
> This patch adds EDAC support for the L3 and SoC components.
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> ---
>  drivers/edac/xgene_edac.c |  804 +++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 804 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
> index ba06904..ed99f85 100644
> --- a/drivers/edac/xgene_edac.c
> +++ b/drivers/edac/xgene_edac.c
> @@ -66,6 +66,8 @@ struct xgene_edac {
>  
>  	struct list_head	mcus;
>  	struct list_head	pmds;
> +	struct list_head	l3s;
> +	struct list_head	socs;
>  
>  	struct mutex		mc_lock;
>  	int			mc_active_mask;
> @@ -1016,10 +1018,783 @@ static int xgene_edac_pmd_remove(struct xgene_edac_pmd_ctx *pmd)
>  	return 0;
>  }
>  
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
> +static void xgene_edac_l3_check(struct edac_device_ctl_info *edac_dev)
> +{
> +	struct xgene_edac_dev_ctx *ctx = edac_dev->pvt_info;
> +	u32 l3cesr;
> +	u32 l3celr;
> +	u32 l3caelr;
> +	u32 l3cbelr;
> +
> +	l3cesr = readl(ctx->dev_csr + L3C_ESR);
> +	if (!(l3cesr & (L3C_ESR_UCERR_MASK | L3C_ESR_CERR_MASK)))
> +		return;
> +
> +	if (l3cesr & L3C_ESR_UCERR_MASK)
> +		dev_err(edac_dev->dev, "L3C uncorrectable error\n");
> +	if (l3cesr & L3C_ESR_CERR_MASK)
> +		dev_warn(edac_dev->dev, "L3C correctable error\n");
> +
> +	l3celr = readl(ctx->dev_csr + L3C_ELR);
> +	l3caelr = readl(ctx->dev_csr + L3C_AELR);
> +	l3cbelr = readl(ctx->dev_csr + L3C_BELR);
> +	if (l3cesr & L3C_ESR_MULTIHIT_MASK)
> +		dev_err(edac_dev->dev, "L3C multiple hit error\n");
> +	if (l3cesr & L3C_ESR_UCEVICT_MASK)
> +		dev_err(edac_dev->dev,
> +			"L3C dropped eviction of line with error\n");
> +	if (l3cesr & L3C_ESR_MULTIUCERR_MASK)
> +		dev_err(edac_dev->dev, "L3C multiple uncorrectable error\n");
> +	if (l3cesr & L3C_ESR_DATATAG_MASK)
> +		dev_err(edac_dev->dev,
> +			"L3C data error syndrome 0x%X group 0x%X\n",
> +			L3C_ELR_ERRSYN(l3celr), L3C_ELR_ERRGRP(l3celr));
> +	else
> +		dev_err(edac_dev->dev,
> +			"L3C tag error syndrome 0x%X Way of Tag 0x%X Agent ID 0x%X Operation type 0x%X\n",
> +			L3C_ELR_ERRSYN(l3celr), L3C_ELR_ERRWAY(l3celr),
> +			L3C_ELR_AGENTID(l3celr), L3C_ELR_OPTYPE(l3celr));
> +	/*
> +	 * NOTE: Address [41:38] in L3C_ELR_PADDRHIGH(l3celr).
> +	 *       Address [37:6] in l3caelr. Lower 6 bits are zero.
> +	 */
> +	dev_err(edac_dev->dev, "L3C error address 0x%08X.%08X bank %d\n",
> +		L3C_ELR_PADDRHIGH(l3celr) << 6 | (l3caelr >> 26),
> +		(l3caelr & 0x3FFFFFFF) << 6, L3C_BELR_BANK(l3cbelr));
> +	dev_err(edac_dev->dev,
> +		"L3C error status register value 0x%X\n", l3cesr);
> +
> +	/* Clear L3C error interrupt */
> +	writel(0, ctx->dev_csr + L3C_ESR);
> +
> +	if (ctx->version <= 1) {
> +		/*
> +		 * Version 1 of the L3C has broken single bit correctable
> +		 * logic. Therefore, map all errors as uncorrectable.
> +		 */
> +		edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
> +	} else {
> +		if (l3cesr & L3C_ESR_CERR_MASK)
> +			edac_device_handle_ce(edac_dev, 0, 0,
> +					      edac_dev->ctl_name);
> +		if (l3cesr & L3C_ESR_UCERR_MASK)
> +			edac_device_handle_ue(edac_dev, 0, 0,
> +					      edac_dev->ctl_name);
> +	}
> +}
> +
> +static void xgene_edac_l3_hw_init(struct edac_device_ctl_info *edac_dev,
> +				  bool enable)

arg alignment. It should be

function name(arg1, arg2,
	      arg3, arg4,
	      arg5...

Check your other functions too.

> +{
> +	struct xgene_edac_dev_ctx *ctx = edac_dev->pvt_info;
> +	u32 val;
> +
> +	val = readl(ctx->dev_csr + L3C_ECR);
> +	val |= L3C_UCERREN | L3C_CERREN;
> +	/* On disable, we just disable interrupt but keep error enabled */
> +	if (edac_dev->op_state == OP_RUNNING_INTERRUPT) {
> +		if (enable)
> +			val |= L3C_ECR_UCINTREN | L3C_ECR_CINTREN;
> +		else
> +			val &= ~(L3C_ECR_UCINTREN | L3C_ECR_CINTREN);
> +	}
> +	writel(val, ctx->dev_csr + L3C_ECR);
> +
> +	if (edac_dev->op_state == OP_RUNNING_INTERRUPT) {
> +		/* Enable/disable L3 error top level interrupt */
> +		if (enable) {
> +			xgene_edac_pcp_clrbits(ctx->edac, PCPHPERRINTMSK,
> +					       L3C_UNCORR_ERR_MASK);
> +			xgene_edac_pcp_clrbits(ctx->edac, PCPLPERRINTMSK,
> +					       L3C_CORR_ERR_MASK);
> +		} else {
> +			xgene_edac_pcp_setbits(ctx->edac, PCPHPERRINTMSK,
> +					       L3C_UNCORR_ERR_MASK);
> +			xgene_edac_pcp_setbits(ctx->edac, PCPLPERRINTMSK,
> +					       L3C_CORR_ERR_MASK);
> +		}
> +	}
> +}
> +
> +static ssize_t xgene_edac_l3_inject_ctrl_write(struct file *file,
> +					       const char __user *data,
> +					       size_t count, loff_t *ppos)
> +e{
> +	struct edac_device_ctl_info *edac_dev = file->private_data;
> +	struct xgene_edac_dev_ctx *ctx = edac_dev->pvt_info;
> +
> +	/* Generate all errors */
> +	writel(0xFFFFFFFF, ctx->dev_csr + L3C_ESR);
> +	return count;
> +}
> +
> e+static const struct file_operations xgene_edac_l3_debug_inject_fops = {
> +	.open = simple_open,
> +	.write = xgene_edac_l3_inject_ctrl_write,
>n +	.llseek = generic_file_llseek
> +};
> +
> +static void xgene_edac_l3_create_debugfs_nodes(
> +	struct edac_device_ctl_info *edac_dev)

This "(" brace at the end looks ugly. Simply leave it on the same line,
even if if it is longer than 80-cols.

You can do:

static void xgene_edac_l3_create_debugfs_nodes(struct edac_device_ctl_info *edac_dev)
{

or:

static void
xgene_edac_l3_create_debugfs_nodes(struct edac_device_ctl_info *edac_dev)
{

which is more readable.


> +{
> +	struct xgene_edac_dev_ctx *ctx = edac_dev->pvt_info;
> +	struct dentry *edac_debugfs;
> +	char name[30];
> +
> +	if (!IS_ENABLED(CONFIG_EDAC_DEBUG))
> +		return;
> +
> +	/*
> +	 * Todo: Switch to common EDAC debug file system for edac device
> +	 *       when available.
> +	 */

What is that?

> +	if (!ctx->edac->dfs) {
> +		ctx->edac->dfs = debugfs_create_dir(edac_dev->dev->kobj.name,
> +						    NULL);
> +		if (!ctx->edac->dfs)
> +			return;
> +	}
> +	sprintf(name, "l3c%d", ctx->edac_idx);
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
> +		goto err;
> +	}
> +	dev_csr = devm_ioremap_resource(edac->dev, &res);
> +	if (IS_ERR(dev_csr)) {
> +		dev_err(edac->dev,
> +			"devm_ioremap_resource failed for L3 resource address\n");
> +		rc = PTR_ERR(dev_csr);
> +		goto err;
> +	}
> 
> +	edac_idx = edac_device_alloc_index();
> +	edac_dev = edac_device_alloc_ctl_info(sizeof(*ctx),
> +					      "l3c", 1, "l3c", 1, 0, NULL, 0,
> +					      edac_idx);
> +	if (!edac_dev) {
> +		rc = -ENOMEM;
> +		goto err;
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

So depending on what SoC elements you detect, the last one's check
function will win?

If xgene_edac loads on multiple SoC elements, you need a global xgene
check function for which l3, soc, mc, etc register...

> +
> +	xgene_edac_l3_create_debugfs_nodes(edac_dev);
> +
> +	rc = edac_device_add_device(edac_dev);
> +	if (rc > 0) {
> +		dev_err(edac->dev, "failed edac_device_add_device()\n");
> +		rc = -ENOMEM;
> +		goto err1;
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
> +err1:
> +	edac_device_free_ctl_info(edac_dev);
> +err:

Those labels need to be better named.

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
> +#define  IOBPA_M_REQIDRAM_CORRUPT_MASK	BIT(7)
> +#define  IOBPA_REQIDRAM_CORRUPT_MASK	BIT(6)
> +#define  IOBPA_M_TRANS_CORRUPT_MASK	BIT(5)
> +#define  IOBPA_TRANS_CORRUPT_MASK	BIT(4)
> +#define  IOBPA_M_WDATA_CORRUPT_MASK	BIT(3)
> +#define  IOBPA_WDATA_CORRUPT_MASK	BIT(2)
> +#define  IOBPA_M_RDATA_CORRUPT_MASK	BIT(1)
> +#define  IOBPA_RDATA_CORRUPT_MASK	BIT(0)
> +#define IOBBATRANSERRINTSTS		0x0030
> +#define  M_ILLEGAL_ACCESS_MASK		BIT(15)
> +#define  ILLEGAL_ACCESS_MASK		BIT(14)
> +#define  M_WIDRAM_CORRUPT_MASK		BIT(13)
> +#define  WIDRAM_CORRUPT_MASK		BIT(12)
> +#define  M_RIDRAM_CORRUPT_MASK		BIT(11)
> +#define  RIDRAM_CORRUPT_MASK		BIT(10)
> +#define  M_TRANS_CORRUPT_MASK		BIT(9)
> +#define  TRANS_CORRUPT_MASK		BIT(8)
> +#define  M_WDATA_CORRUPT_MASK		BIT(7)
> +#define  WDATA_CORRUPT_MASK		BIT(6)
> +#define  M_RBM_POISONED_REQ_MASK	BIT(5)
> +#define  RBM_POISONED_REQ_MASK		BIT(4)
> +#define  M_XGIC_POISONED_REQ_MASK	BIT(3)
> +#define  XGIC_POISONED_REQ_MASK		BIT(2)
> +#define  M_WRERR_RESP_MASK		BIT(1)
> +#define  WRERR_RESP_MASK		BIT(0)
> +#define IOBBATRANSERRREQINFOL		0x0038
> +#define IOBBATRANSERRREQINFOH		0x003c
> +#define  REQTYPE_F2_RD(src)		((src) & BIT(0))
> +#define  ERRADDRH_F2_RD(src)		(((src) & 0xffc00000) >> 22)
> +#define IOBBATRANSERRCSWREQID		0x0040
> +#define XGICTRANSERRINTSTS		0x0050
> +#define  M_WR_ACCESS_ERR_MASK		BIT(3)
> +#define  WR_ACCESS_ERR_MASK		BIT(2)
> +#define  M_RD_ACCESS_ERR_MASK		BIT(1)
> +#define  RD_ACCESS_ERR_MASK		BIT(0)
> +#define XGICTRANSERRINTMSK		0x0054
> +#define XGICTRANSERRREQINFO		0x0058
> +#define  REQTYPE_MASK			BIT(26)
> +#define  ERRADDR_RD(src)		((src) & 0x03ffffff)
> +#define GLBL_ERR_STS			0x0800
> +#define  MDED_ERR_MASK			BIT(3)
> +#define  DED_ERR_MASK			BIT(2)
> +#define  MSEC_ERR_MASK			BIT(1)
> +#define  SEC_ERR_MASK			BIT(0)
> +#define GLBL_SEC_ERRL			0x0810
> +#define GLBL_SEC_ERRH			0x0818
> +#define GLBL_MSEC_ERRL			0x0820
> +#define GLBL_MSEC_ERRH			0x0828
> +#define GLBL_DED_ERRL			0x0830
> +#define GLBL_DED_ERRLMASK		0x0834
> +#define GLBL_DED_ERRH			0x0838
> +#define GLBL_DED_ERRHMASK		0x083c
> +#define GLBL_MDED_ERRL			0x0840
> +#define GLBL_MDED_ERRLMASK		0x0844
> +#define GLBL_MDED_ERRH			0x0848
> +#define GLBL_MDED_ERRHMASK		0x084c
> +
> +static const char * const soc_mem_err_v1[] = {
> +	"10GbE0",
> +	"10GbE1",
> +	"Security",
> +	"SATA45",
> +	"SATA23/ETH23",
> +	"SATA01/ETH01",
> +	"USB1",
> +	"USB0",
> +	"QML",
> +	"QM0",
> +	"QM1 (XGbE01)",
> +	"PCIE4",
> +	"PCIE3",
> +	"PCIE2",
> +	"PCIE1",
> +	"PCIE0",
> +	"CTX Manager",
> +	"OCM",
> +	"1GbE",
> +	"CLE",
> +	"AHBC",
> +	"PktDMA",
> +	"GFC",
> +	"MSLIM",
> +	"10GbE2",
> +	"10GbE3",
> +	"QM2 (XGbE23)",
> +	"IOB",
> +	"unknown",
> +	"unknown",
> +	"unknown",
> +	"unknown",
> +};
> +
> +static void xgene_edac_iob_gic_report(struct edac_device_ctl_info *edac_dev)
> +{
> +	struct xgene_edac_dev_ctx *ctx = edac_dev->pvt_info;
> +	u32 err_addr_lo;
> +	u32 err_addr_hi;
> +	u32 reg;
> +	u32 info;
> +
> +	/* GIC transaction error interrupt */
> +	reg = readl(ctx->dev_csr + XGICTRANSERRINTSTS);
> +	if (reg) {
> +		dev_err(edac_dev->dev, "XGIC transaction error\n");
> +		if (reg & RD_ACCESS_ERR_MASK)
> +			dev_err(edac_dev->dev, "XGIC read size error\n");
> +		if (reg & M_RD_ACCESS_ERR_MASK)
> +			dev_err(edac_dev->dev,
> +				"Multiple XGIC read size error\n");
> +		if (reg & WR_ACCESS_ERR_MASK)
> +			dev_err(edac_dev->dev, "XGIC write size error\n");
> +		if (reg & M_WR_ACCESS_ERR_MASK)
> +			dev_err(edac_dev->dev,
> +				"Multiple XGIC write size error\n");
> +		info = readl(ctx->dev_csr + XGICTRANSERRREQINFO);
> +		dev_err(edac_dev->dev, "XGIC %s access @ 0x%08X (0x%08X)\n",
> +			info & REQTYPE_MASK ? "read" : "write",
> +			ERRADDR_RD(info), info);
> +		writel(reg, ctx->dev_csr + XGICTRANSERRINTSTS);
> +	}
> +
> +	/* IOB memory error */
> +	reg = readl(ctx->dev_csr + GLBL_ERR_STS);
> +	if (reg) {
> +		if (reg & SEC_ERR_MASK) {
> +			err_addr_lo = readl(ctx->dev_csr + GLBL_SEC_ERRL);
> +			err_addr_hi = readl(ctx->dev_csr + GLBL_SEC_ERRH);
> +			dev_err(edac_dev->dev,
> +				"IOB single-bit correctable memory at 0x%08X.%08X error\n",
> +				err_addr_lo, err_addr_hi);
> +			writel(err_addr_lo, ctx->dev_csr + GLBL_SEC_ERRL);
> +			writel(err_addr_hi, ctx->dev_csr + GLBL_SEC_ERRH);
> +		}
> +		if (reg & MSEC_ERR_MASK) {
> +			err_addr_lo = readl(ctx->dev_csr + GLBL_MSEC_ERRL);
> +			err_addr_hi = readl(ctx->dev_csr + GLBL_MSEC_ERRH);
> +			dev_err(edac_dev->dev,
> +				"IOB multiple single-bit correctable memory at 0x%08X.%08X error\n",
> +				err_addr_lo, err_addr_hi);
> +			writel(err_addr_lo, ctx->dev_csr + GLBL_MSEC_ERRL);
> +			writel(err_addr_hi, ctx->dev_csr + GLBL_MSEC_ERRH);
> +		}
> +		if (reg & (SEC_ERR_MASK | MSEC_ERR_MASK))
> +			edac_device_handle_ce(edac_dev, 0, 0,
> +					      edac_dev->ctl_name);
> +
> +		if (reg & DED_ERR_MASK) {
> +			err_addr_lo = readl(ctx->dev_csr + GLBL_DED_ERRL);
> +			err_addr_hi = readl(ctx->dev_csr + GLBL_DED_ERRH);
> +			dev_err(edac_dev->dev,
> +				"IOB double-bit uncorrectable memory at 0x%08X.%08X error\n",
> +				err_addr_lo, err_addr_hi);
> +			writel(err_addr_lo, ctx->dev_csr + GLBL_DED_ERRL);
> +			writel(err_addr_hi, ctx->dev_csr + GLBL_DED_ERRH);
> +		}
> +		if (reg & MDED_ERR_MASK) {
> +			err_addr_lo = readl(ctx->dev_csr + GLBL_MDED_ERRL);
> +			err_addr_hi = readl(ctx->dev_csr + GLBL_MDED_ERRH);
> +			dev_err(edac_dev->dev,
> +				"Multiple IOB double-bit uncorrectable memory at 0x%08X.%08X error\n",
> +				err_addr_lo, err_addr_hi);
> +			writel(err_addr_lo, ctx->dev_csr + GLBL_MDED_ERRL);
> +			writel(err_addr_hi, ctx->dev_csr + GLBL_MDED_ERRH);
> +		}
> +		if (reg & (DED_ERR_MASK | MDED_ERR_MASK))
> +			edac_device_handle_ue(edac_dev, 0, 0,
> +					      edac_dev->ctl_name);
> +	}

You can flip the logic in that function:

	if (!reg)

and use goto labels and thus save an indentation level. Which looks like
you could use it.

> +}
> +
> +static void xgene_edac_rb_report(struct edac_device_ctl_info *edac_dev)
> +{
> +	struct xgene_edac_dev_ctx *ctx = edac_dev->pvt_info;
> +	u32 err_addr_lo;
> +	u32 err_addr_hi;
> +	u32 reg;
> +
> +	/* IOB Bridge agent transaction error interrupt */
> +	reg = readl(ctx->dev_csr + IOBBATRANSERRINTSTS);
> +	if (!reg)
> +		return;
> +
> +	dev_err(edac_dev->dev, "IOB bridge agent (BA) transaction error\n");
> +	if (reg & WRERR_RESP_MASK)
> +		dev_err(edac_dev->dev, "IOB BA write response error\n");
> +	if (reg & M_WRERR_RESP_MASK)
> +		dev_err(edac_dev->dev,
> +			"Multiple IOB BA write response error\n");
> +	if (reg & XGIC_POISONED_REQ_MASK)
> +		dev_err(edac_dev->dev, "IOB BA XGIC poisoned write error\n");
> +	if (reg & M_XGIC_POISONED_REQ_MASK)
> +		dev_err(edac_dev->dev,
> +			"Multiple IOB BA XGIC poisoned write error\n");
> +	if (reg & RBM_POISONED_REQ_MASK)
> +		dev_err(edac_dev->dev, "IOB BA RBM poisoned write error\n");
> +	if (reg & M_RBM_POISONED_REQ_MASK)
> +		dev_err(edac_dev->dev,
> +			"Multiple IOB BA RBM poisoned write error\n");
> +	if (reg & WDATA_CORRUPT_MASK)
> +		dev_err(edac_dev->dev, "IOB BA write error\n");
> +	if (reg & M_WDATA_CORRUPT_MASK)
> +		dev_err(edac_dev->dev, "Multiple IOB BA write error\n");
> +	if (reg & TRANS_CORRUPT_MASK)
> +		dev_err(edac_dev->dev, "IOB BA transaction error\n");
> +	if (reg & M_TRANS_CORRUPT_MASK)
> +		dev_err(edac_dev->dev, "Multiple IOB BA transaction error\n");
> +	if (reg & RIDRAM_CORRUPT_MASK)
> +		dev_err(edac_dev->dev,
> +			"IOB BA RDIDRAM read transaction ID error\n");
> +	if (reg & M_RIDRAM_CORRUPT_MASK)
> +		dev_err(edac_dev->dev,
> +			"Multiple IOB BA RDIDRAM read transaction ID error\n");
> +	if (reg & WIDRAM_CORRUPT_MASK)
> +		dev_err(edac_dev->dev,
> +			"IOB BA RDIDRAM write transaction ID error\n");
> +	if (reg & M_WIDRAM_CORRUPT_MASK)
> +		dev_err(edac_dev->dev,
> +			"Multiple IOB BA RDIDRAM write transaction ID error\n");
> +	if (reg & ILLEGAL_ACCESS_MASK)
> +		dev_err(edac_dev->dev,
> +			"IOB BA XGIC/RB illegal access error\n");
> +	if (reg & M_ILLEGAL_ACCESS_MASK)
> +		dev_err(edac_dev->dev,
> +			"Multiple IOB BA XGIC/RB illegal access error\n");
> +
> +	err_addr_lo = readl(ctx->dev_csr + IOBBATRANSERRREQINFOL);
> +	err_addr_hi = readl(ctx->dev_csr + IOBBATRANSERRREQINFOH);
> +	dev_err(edac_dev->dev, "IOB BA %s access at 0x%02X.%08X (0x%08X)\n",
> +		REQTYPE_F2_RD(err_addr_hi) ? "read" : "write",
> +		ERRADDRH_F2_RD(err_addr_hi), err_addr_lo, err_addr_hi);
> +	if (reg & WRERR_RESP_MASK)
> +		dev_err(edac_dev->dev, "IOB BA requestor ID 0x%08X\n",
> +			readl(ctx->dev_csr + IOBBATRANSERRCSWREQID));
> +	writel(reg, ctx->dev_csr + IOBBATRANSERRINTSTS);
> +}
> +
> +static void xgene_edac_pa_report(struct edac_device_ctl_info *edac_dev)
> +{
> +	struct xgene_edac_dev_ctx *ctx = edac_dev->pvt_info;
> +	u32 err_addr_lo;
> +	u32 err_addr_hi;
> +	u32 reg;
> +
> +	/* IOB Processing agent transaction error interrupt */
> +	reg = readl(ctx->dev_csr + IOBPATRANSERRINTSTS);
> +	if (reg) {
> +		dev_err(edac_dev->dev,
> +			"IOB procesing agent (PA) transaction error\n");
> +		if (reg & IOBPA_RDATA_CORRUPT_MASK)
> +			dev_err(edac_dev->dev, "IOB PA read data RAM error\n");
> +		if (reg & IOBPA_M_RDATA_CORRUPT_MASK)
> +			dev_err(edac_dev->dev,
> +				"Mutilple IOB PA read data RAM error\n");
> +		if (reg & IOBPA_WDATA_CORRUPT_MASK)
> +			dev_err(edac_dev->dev,
> +				"IOB PA write data RAM error\n");
> +		if (reg & IOBPA_M_WDATA_CORRUPT_MASK)
> +			dev_err(edac_dev->dev,
> +				"Mutilple IOB PA write data RAM error\n");
> +		if (reg & IOBPA_TRANS_CORRUPT_MASK)
> +			dev_err(edac_dev->dev, "IOB PA transaction error\n");
> +		if (reg & IOBPA_M_TRANS_CORRUPT_MASK)
> +			dev_err(edac_dev->dev,
> +				"Mutilple IOB PA transaction error\n");
> +		if (reg & IOBPA_REQIDRAM_CORRUPT_MASK)
> +			dev_err(edac_dev->dev,
> +				"IOB PA transaction ID RAM error\n");
> +		if (reg & IOBPA_M_REQIDRAM_CORRUPT_MASK)
> +			dev_err(edac_dev->dev,
> +				"Multiple IOB PA transaction ID RAM error\n");
> +		writel(reg, ctx->dev_csr + IOBPATRANSERRINTSTS);
> +	}
> +
> +	/* IOB AXI0 Error */
> +	reg = readl(ctx->dev_csr + IOBAXIS0TRANSERRINTSTS);
> +	if (reg) {
> +		err_addr_lo = readl(ctx->dev_csr + IOBAXIS0TRANSERRREQINFOL);
> +		err_addr_hi = readl(ctx->dev_csr + IOBAXIS0TRANSERRREQINFOH);
> +		dev_err(edac_dev->dev,
> +			"%sAXI slave 0 illegal %s access @ 0x%02X.%08X (0x%08X)\n",
> +			reg & IOBAXIS0_M_ILLEGAL_ACCESS_MASK ? "Multiple " : "",
> +			REQTYPE_RD(err_addr_hi) ? "read" : "write",
> +			ERRADDRH_RD(err_addr_hi), err_addr_lo, err_addr_hi);
> +		writel(reg, ctx->dev_csr + IOBAXIS0TRANSERRINTSTS);
> +	}
> +
> +	/* IOB AXI1 Error */
> +	reg = readl(ctx->dev_csr + IOBAXIS1TRANSERRINTSTS);
> +	if (reg) {
> +		err_addr_lo = readl(ctx->dev_csr + IOBAXIS1TRANSERRREQINFOL);
> +		err_addr_hi = readl(ctx->dev_csr + IOBAXIS1TRANSERRREQINFOH);
> +		dev_err(edac_dev->dev,
> +			"%sAXI slave 1 illegal %s access @ 0x%02X.%08X (0x%08X)\n",
> +			reg & IOBAXIS0_M_ILLEGAL_ACCESS_MASK ? "Multiple " : "",
> +			REQTYPE_RD(err_addr_hi) ? "read" : "write",
> +			ERRADDRH_RD(err_addr_hi), err_addr_lo, err_addr_hi);
> +		writel(reg, ctx->dev_csr + IOBAXIS1TRANSERRINTSTS);
> +	}

Same here.

> +}
> +
> +static const char * const *xgene_edac_soc_mem_data(
> +	struct xgene_edac_dev_ctx *ctx)
> +{
> +	switch (ctx->version) {
> +	case 1:
> +		return soc_mem_err_v1;
> +	default:
> +		return NULL;
> +	}
> +}

That's one badly formatted function used only once. Just move the logic
there and kill it.

> +
> +static void xgene_edac_soc_check(struct edac_device_ctl_info *edac_dev)
> +{
> +	struct xgene_edac_dev_ctx *ctx = edac_dev->pvt_info;
> +	const char * const *soc_mem_err;
> +	u32 pcp_hp_stat;
> +	u32 pcp_lp_stat;
> +	u32 reg;
> +	int i;
> +
> +	xgene_edac_pcp_rd(ctx->edac, PCPHPERRINTSTS, &pcp_hp_stat);
> +	xgene_edac_pcp_rd(ctx->edac, PCPLPERRINTSTS, &pcp_lp_stat);
> +	xgene_edac_pcp_rd(ctx->edac, MEMERRINTSTS, &reg);
> +	if (!((pcp_hp_stat & (IOB_PA_ERR_MASK | IOB_BA_ERR_MASK |
> +			     IOB_XGIC_ERR_MASK | IOB_RB_ERR_MASK)) ||
> +	      (pcp_lp_stat & CSW_SWITCH_TRACE_ERR_MASK) || reg))
> +		return;
> +
> +	if (pcp_hp_stat & IOB_XGIC_ERR_MASK)
> +		xgene_edac_iob_gic_report(edac_dev);
> +
> +	if (pcp_hp_stat & (IOB_RB_ERR_MASK | IOB_BA_ERR_MASK))
> +		xgene_edac_rb_report(edac_dev);
> +
> +	if (pcp_hp_stat & IOB_PA_ERR_MASK)
> +		xgene_edac_pa_report(edac_dev);
> +
> +	if (pcp_lp_stat & CSW_SWITCH_TRACE_ERR_MASK) {
> +		dev_info(edac_dev->dev,
> +			 "CSW switch trace correctable memory parity error\n");
> +		edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
> +	}
> +
> +	soc_mem_err = xgene_edac_soc_mem_data(ctx);
> +	if (!soc_mem_err) {
> +		dev_err(edac_dev->dev, "SoC memory parity error 0x%08X\n",
> +			reg);
> +		edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
> +	} else {
> +		for (i = 0; i < 31; i++) {
> +			if (reg & (1 << i)) {
> +				dev_err(edac_dev->dev,
> +					"%s memory parity error\n",
> +					soc_mem_err[i]);
> +				edac_device_handle_ue(edac_dev, 0, 0,
> +						      edac_dev->ctl_name);
> +			}
> +		}
> +	}
> +}
> +
> +static void xgene_edac_soc_hw_init(struct edac_device_ctl_info *edac_dev,
> +				   bool enable)
> +{
> +	struct xgene_edac_dev_ctx *ctx = edac_dev->pvt_info;
> +
> +	/* Enable SoC IP error interrupt */
> +	if (edac_dev->op_state == OP_RUNNING_INTERRUPT) {
> +		if (enable) {
> +			xgene_edac_pcp_clrbits(ctx->edac, PCPHPERRINTMSK,
> +					       IOB_PA_ERR_MASK |
> +					       IOB_BA_ERR_MASK |
> +					       IOB_XGIC_ERR_MASK |
> +					       IOB_RB_ERR_MASK);
> +			xgene_edac_pcp_clrbits(ctx->edac, PCPLPERRINTMSK,
> +					       CSW_SWITCH_TRACE_ERR_MASK);
> +		} else {
> +			xgene_edac_pcp_setbits(ctx->edac, PCPHPERRINTMSK,
> +					       IOB_PA_ERR_MASK |
> +					       IOB_BA_ERR_MASK |
> +					       IOB_XGIC_ERR_MASK |
> +					       IOB_RB_ERR_MASK);
> +			xgene_edac_pcp_setbits(ctx->edac, PCPLPERRINTMSK,
> +					       CSW_SWITCH_TRACE_ERR_MASK);
> +		}
> +
> +		writel(enable ? 0x0 : 0xFFFFFFFF,
> +		       ctx->dev_csr + IOBAXIS0TRANSERRINTMSK);
> +		writel(enable ? 0x0 : 0xFFFFFFFF,
> +		       ctx->dev_csr + IOBAXIS1TRANSERRINTMSK);
> +		writel(enable ? 0x0 : 0xFFFFFFFF,
> +		       ctx->dev_csr + XGICTRANSERRINTMSK);
> +
> +		xgene_edac_pcp_setbits(ctx->edac, MEMERRINTMSK,
> +				       enable ? 0x0 : 0xFFFFFFFF);
> +	}
> +}
> +
> +static int xgene_edac_soc_add(struct xgene_edac *edac, struct device_node *np,
> +			      int version)
> +{
> +	struct edac_device_ctl_info *edac_dev;
> +	struct xgene_edac_dev_ctx *ctx;
> +	void __iomem *dev_csr;
> +	struct resource res;
> +	int edac_idx;
> +	int rc = 0;
> +
> +	if (!devres_open_group(edac->dev, xgene_edac_soc_add, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	rc = of_address_to_resource(np, 0, &res);
> +	if (rc < 0) {
> +		dev_err(edac->dev, "no SoC resource address\n");
> +		goto err;
> +	}
> +	dev_csr = devm_ioremap_resource(edac->dev, &res);
> +	if (IS_ERR(dev_csr)) {
> +		dev_err(edac->dev,
> +			"devm_ioremap_resource failed for soc resource address\n");
> +		rc = PTR_ERR(dev_csr);
> +		goto err;
> +	}
> +
> +	edac_idx = edac_device_alloc_index();
> +	edac_dev = edac_device_alloc_ctl_info(sizeof(*ctx),
> +					      "SOC", 1, "SOC", 1, 2, NULL, 0,
> +					      edac_idx);
> +	if (!edac_dev) {
> +		rc = -ENOMEM;
> +		goto err;
> +	}
> +
> +	ctx = edac_dev->pvt_info;
> +	ctx->dev_csr = dev_csr;
> +	ctx->name = "xgene_soc_err";
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
> +		edac_dev->edac_check = xgene_edac_soc_check;

Same here about the ->edac_check function.

> +
> +	rc = edac_device_add_device(edac_dev);
> +	if (rc > 0) {
> +		dev_err(edac->dev, "failed edac_device_add_device()\n");
> +		rc = -ENOMEM;
> +		goto err1;
> +	}
> +
> +	if (edac_op_state == EDAC_OPSTATE_INT)
> +		edac_dev->op_state = OP_RUNNING_INTERRUPT;
> +
> +	list_add(&ctx->next, &edac->socs);
> +
> +	xgene_edac_soc_hw_init(edac_dev, 1);
> +
> +	devres_remove_group(edac->dev, xgene_edac_soc_add);
> +
> +	dev_info(edac->dev, "X-Gene EDAC SoC registered\n");
> +
> +	return 0;
> +
> +err1:
> +	edac_device_free_ctl_info(edac_dev);
> +err:
> +	devres_release_group(edac->dev, xgene_edac_soc_add);

More descriptive labels.

> +	return rc;
> +}
> +
> +static int xgene_edac_soc_remove(struct xgene_edac_dev_ctx *soc)
> +{
> +	struct edac_device_ctl_info *edac_dev = soc->edac_dev;
> +
> +	xgene_edac_soc_hw_init(edac_dev, 0);
> +	edac_device_del_device(soc->edac->dev);
> +	edac_device_free_ctl_info(edac_dev);
> +	return 0;
> +}
> +
>  static irqreturn_t xgene_edac_isr(int irq, void *dev_id)
>  {
>  	struct xgene_edac *ctx = dev_id;
>  	struct xgene_edac_pmd_ctx *pmd;
> +	struct xgene_edac_dev_ctx *node;
>  	unsigned int pcp_hp_stat;
>  	unsigned int pcp_lp_stat;
>  
> @@ -1040,6 +1815,14 @@ static irqreturn_t xgene_edac_isr(int irq, void *dev_id)
>  			xgene_edac_pmd_check(pmd->edac_dev);
>  	}
>  
> +	list_for_each_entry(node, &ctx->l3s, next) {
> +		xgene_edac_l3_check(node->edac_dev);
> +	}
> +
> +	list_for_each_entry(node, &ctx->socs, next) {
> +		xgene_edac_soc_check(node->edac_dev);
> +	}

Loops with single statements don't need {}

> +
>  	return IRQ_HANDLED;
>  }
>  
> @@ -1058,6 +1841,8 @@ static int xgene_edac_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, edac);
>  	INIT_LIST_HEAD(&edac->mcus);
>  	INIT_LIST_HEAD(&edac->pmds);
> +	INIT_LIST_HEAD(&edac->l3s);
> +	INIT_LIST_HEAD(&edac->socs);
>  	spin_lock_init(&edac->lock);
>  	mutex_init(&edac->mc_lock);
>  
> @@ -1131,6 +1916,14 @@ static int xgene_edac_probe(struct platform_device *pdev)
>  			xgene_edac_pmd_add(edac, child, 1);
>  		if (of_device_is_compatible(child, "apm,xgene-edac-pmd-v2"))
>  			xgene_edac_pmd_add(edac, child, 2);
> +		if (of_device_is_compatible(child, "apm,xgene-edac-l3"))
> +			xgene_edac_l3_add(edac, child, 1);
> +		if (of_device_is_compatible(child, "apm,xgene-edac-l3-v2"))
> +			xgene_edac_l3_add(edac, child, 2);
> +		if (of_device_is_compatible(child, "apm,xgene-edac-soc"))
> +			xgene_edac_soc_add(edac, child, 0);
> +		if (of_device_is_compatible(child, "apm,xgene-edac-soc-v1"))
> +			xgene_edac_soc_add(edac, child, 1);
>  	}
>  
>  	return 0;
> @@ -1146,6 +1939,8 @@ static int xgene_edac_remove(struct platform_device *pdev)
>  	struct xgene_edac_mc_ctx *temp_mcu;
>  	struct xgene_edac_pmd_ctx *pmd;
>  	struct xgene_edac_pmd_ctx *temp_pmd;
> +	struct xgene_edac_dev_ctx *node;
> +	struct xgene_edac_dev_ctx *temp_node;
>  
>  	list_for_each_entry_safe(mcu, temp_mcu, &edac->mcus, next) {
>  		xgene_edac_mc_remove(mcu);
> @@ -1154,6 +1949,15 @@ static int xgene_edac_remove(struct platform_device *pdev)
>  	list_for_each_entry_safe(pmd, temp_pmd, &edac->pmds, next) {
>  		xgene_edac_pmd_remove(pmd);
>  	}
> +
> +	list_for_each_entry_safe(node, temp_node, &edac->l3s, next) {
> +		xgene_edac_l3_remove(node);
> +	}
> +
> +	list_for_each_entry_safe(node, temp_node, &edac->socs, next) {
> +		xgene_edac_soc_remove(node);
> +	}

Ditto.

Also, I'd like Arnd to check the DT changes.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
