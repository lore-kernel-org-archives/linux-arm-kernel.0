From: bp@alien8.de (Borislav Petkov)
Date: Mon, 1 Jun 2015 13:43:46 +0200
Subject: [PATCH 2/3] edac: Add L3/SoC support to the APM X-Gene SoC EDAC
 driver
In-Reply-To: <1432937075-16558-3-git-send-email-lho@apm.com>
References: <1432937075-16558-1-git-send-email-lho@apm.com>
 <1432937075-16558-2-git-send-email-lho@apm.com>
 <1432937075-16558-3-git-send-email-lho@apm.com>
Message-ID: <20150601114346.GA10169@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 29, 2015 at 04:04:34PM -0600, Loc Ho wrote:
> This patch adds EDAC support for the L3 and SoC components.

So what was the reason for that split now? None, AFAICT.

> +/* L3 Error device */
> +#define L3C_ESR				(0x0A * 4)
> +#define  L3C_ESR_DATATAG_MASK		0x00000200
> +#define  L3C_ESR_MULTIHIT_MASK		0x00000100
> +#define  L3C_ESR_UCEVICT_MASK		0x00000040
> +#define  L3C_ESR_MULTIUCERR_MASK	0x00000020
> +#define  L3C_ESR_MULTICERR_MASK		0x00000010
> +#define  L3C_ESR_UCERR_MASK		0x00000008
> +#define  L3C_ESR_CERR_MASK		0x00000004
> +#define  L3C_ESR_UCERRINTR_MASK		0x00000002
> +#define  L3C_ESR_CERRINTR_MASK		0x00000001
> +#define L3C_ECR				(0x0B * 4)
> +#define  L3C_ECR_UCINTREN		0x00000008
> +#define  L3C_ECR_CINTREN		0x00000004
> +#define  L3C_UCERREN			0x00000002
> +#define  L3C_CERREN			0x00000001
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

Use BIT() for all those single bits, as before.

...

> +static struct edac_dev_sysfs_attribute xgene_edac_l3_sysfs_attributes[] = {
> +	{ .attr = {
> +		  .name = "inject_ctrl",
> +		  .mode = (S_IRUGO | S_IWUSR)
> +	  },
> +	 .show = xgene_edac_l3_inject_ctrl_show,
> +	 .store = xgene_edac_l3_inject_ctrl_store },
> +
> +	/* End of list */
> +	{ .attr = {.name = NULL } }
> +};

Why are those sysfs nodes? Didn't we say that inject nodes should be in
debugfs?

So I'm going to stop looking here and wait for you to do the same
changes to L3 and SOC as for the rest of the driver. Go through what
just went upstream and do the same changes to that patch instead of
blindly resending the original version.

It is not a competition who gets their stuff upstream first, ok?!

> +static int xgene_edac_l3_add(struct xgene_edac *edac, struct device_node *np)
> +{
> +	struct edac_device_ctl_info *edac_dev;
> +	struct xgene_edac_dev_ctx *ctx;
> +	struct resource res;
> +	int edac_idx;
> +	int rc = 0;
> +
> +	if (!devres_open_group(edac->dev, xgene_edac_l3_add, GFP_KERNEL))
> +		return -ENOMEM;
> +
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
> +	ctx->name = "xgene_l3_err";
> +	ctx->edac_idx = edac_idx;
> +	ctx->edac = edac;
> +	ctx->edac_dev = edac_dev;
> +	ctx->ddev = *edac->dev;
> +	edac_dev->dev = &ctx->ddev;
> +	edac_dev->ctl_name = ctx->name;
> +	edac_dev->dev_name = ctx->name;
> +	edac_dev->mod_name = EDAC_MOD_STR;

As before, do the allocation and preparation of edac_dev only after ...

> +
> +	rc = of_address_to_resource(np, 0, &res);
> +	if (rc < 0) {
> +		dev_err(edac->dev, "no L3 resource address\n");
> +		goto err1;
> +	}
> +	ctx->dev_csr = devm_ioremap_resource(edac->dev, &res);
> +	if (IS_ERR(ctx->dev_csr)) {
> +		dev_err(edac->dev,
> +			"devm_ioremap_resource failed for L3 resource address\n");
> +		rc = PTR_ERR(ctx->dev_csr);
> +		goto err1;
> +	}

... those above have succeeded.

> +
> +	if (edac_op_state == EDAC_OPSTATE_POLL)
> +		edac_dev->edac_check = xgene_edac_l3_check;
> +
> +	edac_dev->sysfs_attributes = xgene_edac_l3_sysfs_attributes;
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

Shouldn't you init the hw regs *before* you add it to the list of l3s
and *not* after?

> +
> +	devres_remove_group(edac->dev, xgene_edac_l3_add);
> +
> +	dev_info(edac->dev, "X-Gene EDAC L3 registered\n");
> +	return 0;
> +
> +err1:
> +	edac_device_free_ctl_info(edac_dev);
> +err:
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
> +#define  IOBAXIS0_M_ILLEGAL_ACCESS_MASK	0x00000002
> +#define  IOBAXIS0_ILLEGAL_ACCESS_MASK	0x00000001
> +#define IOBAXIS0TRANSERRINTMSK		0x0004
> +#define IOBAXIS0TRANSERRREQINFOL	0x0008
> +#define IOBAXIS0TRANSERRREQINFOH	0x000c
> +#define  REQTYPE_RD(src)		(((src) & 0x00000001))
> +#define  ERRADDRH_RD(src)		(((src) & 0xffc00000) >> 22)
> +#define IOBAXIS1TRANSERRINTSTS		0x0010
> +#define IOBAXIS1TRANSERRINTMSK		0x0014
> +#define IOBAXIS1TRANSERRREQINFOL	0x0018
> +#define IOBAXIS1TRANSERRREQINFOH	0x001c
> +#define IOBPATRANSERRINTSTS		0x0020
> +#define  IOBPA_M_REQIDRAM_CORRUPT_MASK	0x00000080
> +#define  IOBPA_REQIDRAM_CORRUPT_MASK	0x00000040
> +#define  IOBPA_M_TRANS_CORRUPT_MASK	0x00000020
> +#define  IOBPA_TRANS_CORRUPT_MASK	0x00000010
> +#define  IOBPA_M_WDATA_CORRUPT_MASK	0x00000008
> +#define  IOBPA_WDATA_CORRUPT_MASK	0x00000004
> +#define  IOBPA_M_RDATA_CORRUPT_MASK	0x00000002
> +#define  IOBPA_RDATA_CORRUPT_MASK	0x00000001
> +#define IOBBATRANSERRINTSTS		0x0030
> +#define  M_ILLEGAL_ACCESS_MASK		0x00008000
> +#define  ILLEGAL_ACCESS_MASK		0x00004000
> +#define  M_WIDRAM_CORRUPT_MASK		0x00002000
> +#define  WIDRAM_CORRUPT_MASK		0x00001000
> +#define  M_RIDRAM_CORRUPT_MASK		0x00000800
> +#define  RIDRAM_CORRUPT_MASK		0x00000400
> +#define  M_TRANS_CORRUPT_MASK		0x00000200
> +#define  TRANS_CORRUPT_MASK		0x00000100
> +#define  M_WDATA_CORRUPT_MASK		0x00000080
> +#define  WDATA_CORRUPT_MASK		0x00000040
> +#define  M_RBM_POISONED_REQ_MASK	0x00000020
> +#define  RBM_POISONED_REQ_MASK		0x00000010
> +#define  M_XGIC_POISONED_REQ_MASK	0x00000008
> +#define  XGIC_POISONED_REQ_MASK		0x00000004
> +#define  M_WRERR_RESP_MASK		0x00000002
> +#define  WRERR_RESP_MASK		0x00000001
> +#define IOBBATRANSERRREQINFOL		0x0038
> +#define IOBBATRANSERRREQINFOH		0x003c
> +#define  REQTYPE_F2_RD(src)		(((src) & 0x00000001))
> +#define  ERRADDRH_F2_RD(src)		(((src) & 0xffc00000) >> 22)
> +#define IOBBATRANSERRCSWREQID		0x0040
> +#define XGICTRANSERRINTSTS		0x0050
> +#define  M_WR_ACCESS_ERR_MASK		0x00000008
> +#define  WR_ACCESS_ERR_MASK		0x00000004
> +#define  M_RD_ACCESS_ERR_MASK		0x00000002
> +#define  RD_ACCESS_ERR_MASK		0x00000001
> +#define XGICTRANSERRINTMSK		0x0054
> +#define XGICTRANSERRREQINFO		0x0058
> +#define  REQTYPE_MASK			0x04000000
> +#define  ERRADDR_RD(src)		((src) & 0x03ffffff)
> +#define GLBL_ERR_STS			0x0800
> +#define  MDED_ERR_MASK			0x00000008
> +#define  DED_ERR_MASK			0x00000004
> +#define  MSEC_ERR_MASK			0x00000002
> +#define  SEC_ERR_MASK			0x00000001
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

Use BIT() for all those single bits, as before.

And so on and so on...

Please take the time and do it right.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
