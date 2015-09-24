From: lho@apm.com (Loc Ho)
Date: Wed, 23 Sep 2015 17:41:00 -0700
Subject: [PATCH v5 3/4] edac: Add SoC EDAC support to the APM X-Gene SoC EDAC
 driver
In-Reply-To: <1443055261-8613-1-git-send-email-lho@apm.com>
References: <1443055261-8613-1-git-send-email-lho@apm.com>
Message-ID: <1443055261-8613-4-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add EDAC support for the SoC component.

Signed-off-by: Loc Ho <lho@apm.com>
---
 drivers/edac/xgene_edac.c |  498 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 498 insertions(+), 0 deletions(-)

diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index 37121e8..bfca5d2 100644
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -68,6 +68,7 @@ struct xgene_edac {
 	struct list_head	mcus;
 	struct list_head	pmds;
 	struct list_head	l3s;
+	struct list_head	socs;

 	struct mutex		mc_lock;
 	int			mc_active_mask;
@@ -1281,6 +1282,492 @@ static int xgene_edac_l3_remove(struct xgene_edac_dev_ctx *l3)
 	return 0;
 }

+/* SoC error device */
+#define IOBAXIS0TRANSERRINTSTS		0x0000
+#define  IOBAXIS0_M_ILLEGAL_ACCESS_MASK	BIT(1)
+#define  IOBAXIS0_ILLEGAL_ACCESS_MASK	BIT(0)
+#define IOBAXIS0TRANSERRINTMSK		0x0004
+#define IOBAXIS0TRANSERRREQINFOL	0x0008
+#define IOBAXIS0TRANSERRREQINFOH	0x000c
+#define  REQTYPE_RD(src)		(((src) & BIT(0)))
+#define  ERRADDRH_RD(src)		(((src) & 0xffc00000) >> 22)
+#define IOBAXIS1TRANSERRINTSTS		0x0010
+#define IOBAXIS1TRANSERRINTMSK		0x0014
+#define IOBAXIS1TRANSERRREQINFOL	0x0018
+#define IOBAXIS1TRANSERRREQINFOH	0x001c
+#define IOBPATRANSERRINTSTS		0x0020
+#define  IOBPA_M_REQIDRAM_CORRUPT_MASK	BIT(7)
+#define  IOBPA_REQIDRAM_CORRUPT_MASK	BIT(6)
+#define  IOBPA_M_TRANS_CORRUPT_MASK	BIT(5)
+#define  IOBPA_TRANS_CORRUPT_MASK	BIT(4)
+#define  IOBPA_M_WDATA_CORRUPT_MASK	BIT(3)
+#define  IOBPA_WDATA_CORRUPT_MASK	BIT(2)
+#define  IOBPA_M_RDATA_CORRUPT_MASK	BIT(1)
+#define  IOBPA_RDATA_CORRUPT_MASK	BIT(0)
+#define IOBBATRANSERRINTSTS		0x0030
+#define  M_ILLEGAL_ACCESS_MASK		BIT(15)
+#define  ILLEGAL_ACCESS_MASK		BIT(14)
+#define  M_WIDRAM_CORRUPT_MASK		BIT(13)
+#define  WIDRAM_CORRUPT_MASK		BIT(12)
+#define  M_RIDRAM_CORRUPT_MASK		BIT(11)
+#define  RIDRAM_CORRUPT_MASK		BIT(10)
+#define  M_TRANS_CORRUPT_MASK		BIT(9)
+#define  TRANS_CORRUPT_MASK		BIT(8)
+#define  M_WDATA_CORRUPT_MASK		BIT(7)
+#define  WDATA_CORRUPT_MASK		BIT(6)
+#define  M_RBM_POISONED_REQ_MASK	BIT(5)
+#define  RBM_POISONED_REQ_MASK		BIT(4)
+#define  M_XGIC_POISONED_REQ_MASK	BIT(3)
+#define  XGIC_POISONED_REQ_MASK		BIT(2)
+#define  M_WRERR_RESP_MASK		BIT(1)
+#define  WRERR_RESP_MASK		BIT(0)
+#define IOBBATRANSERRREQINFOL		0x0038
+#define IOBBATRANSERRREQINFOH		0x003c
+#define  REQTYPE_F2_RD(src)		((src) & BIT(0))
+#define  ERRADDRH_F2_RD(src)		(((src) & 0xffc00000) >> 22)
+#define IOBBATRANSERRCSWREQID		0x0040
+#define XGICTRANSERRINTSTS		0x0050
+#define  M_WR_ACCESS_ERR_MASK		BIT(3)
+#define  WR_ACCESS_ERR_MASK		BIT(2)
+#define  M_RD_ACCESS_ERR_MASK		BIT(1)
+#define  RD_ACCESS_ERR_MASK		BIT(0)
+#define XGICTRANSERRINTMSK		0x0054
+#define XGICTRANSERRREQINFO		0x0058
+#define  REQTYPE_MASK			BIT(26)
+#define  ERRADDR_RD(src)		((src) & 0x03ffffff)
+#define GLBL_ERR_STS			0x0800
+#define  MDED_ERR_MASK			BIT(3)
+#define  DED_ERR_MASK			BIT(2)
+#define  MSEC_ERR_MASK			BIT(1)
+#define  SEC_ERR_MASK			BIT(0)
+#define GLBL_SEC_ERRL			0x0810
+#define GLBL_SEC_ERRH			0x0818
+#define GLBL_MSEC_ERRL			0x0820
+#define GLBL_MSEC_ERRH			0x0828
+#define GLBL_DED_ERRL			0x0830
+#define GLBL_DED_ERRLMASK		0x0834
+#define GLBL_DED_ERRH			0x0838
+#define GLBL_DED_ERRHMASK		0x083c
+#define GLBL_MDED_ERRL			0x0840
+#define GLBL_MDED_ERRLMASK		0x0844
+#define GLBL_MDED_ERRH			0x0848
+#define GLBL_MDED_ERRHMASK		0x084c
+
+static const char * const soc_mem_err_v1[] = {
+	"10GbE0",
+	"10GbE1",
+	"Security",
+	"SATA45",
+	"SATA23/ETH23",
+	"SATA01/ETH01",
+	"USB1",
+	"USB0",
+	"QML",
+	"QM0",
+	"QM1 (XGbE01)",
+	"PCIE4",
+	"PCIE3",
+	"PCIE2",
+	"PCIE1",
+	"PCIE0",
+	"CTX Manager",
+	"OCM",
+	"1GbE",
+	"CLE",
+	"AHBC",
+	"PktDMA",
+	"GFC",
+	"MSLIM",
+	"10GbE2",
+	"10GbE3",
+	"QM2 (XGbE23)",
+	"IOB",
+	"unknown",
+	"unknown",
+	"unknown",
+	"unknown",
+};
+
+static void xgene_edac_iob_gic_report(struct edac_device_ctl_info *edac_dev)
+{
+	struct xgene_edac_dev_ctx *ctx = edac_dev->pvt_info;
+	u32 err_addr_lo;
+	u32 err_addr_hi;
+	u32 reg;
+	u32 info;
+
+	/* GIC transaction error interrupt */
+	reg = readl(ctx->dev_csr + XGICTRANSERRINTSTS);
+	if (!reg)
+		goto chk_iob_err;
+	dev_err(edac_dev->dev, "XGIC transaction error\n");
+	if (reg & RD_ACCESS_ERR_MASK)
+		dev_err(edac_dev->dev, "XGIC read size error\n");
+	if (reg & M_RD_ACCESS_ERR_MASK)
+		dev_err(edac_dev->dev, "Multiple XGIC read size error\n");
+	if (reg & WR_ACCESS_ERR_MASK)
+		dev_err(edac_dev->dev, "XGIC write size error\n");
+	if (reg & M_WR_ACCESS_ERR_MASK)
+		dev_err(edac_dev->dev, "Multiple XGIC write size error\n");
+	info = readl(ctx->dev_csr + XGICTRANSERRREQINFO);
+	dev_err(edac_dev->dev, "XGIC %s access @ 0x%08X (0x%08X)\n",
+		info & REQTYPE_MASK ? "read" : "write", ERRADDR_RD(info),
+		info);
+	writel(reg, ctx->dev_csr + XGICTRANSERRINTSTS);
+
+chk_iob_err:
+	/* IOB memory error */
+	reg = readl(ctx->dev_csr + GLBL_ERR_STS);
+	if (!reg)
+		return;
+	if (reg & SEC_ERR_MASK) {
+		err_addr_lo = readl(ctx->dev_csr + GLBL_SEC_ERRL);
+		err_addr_hi = readl(ctx->dev_csr + GLBL_SEC_ERRH);
+		dev_err(edac_dev->dev,
+			"IOB single-bit correctable memory at 0x%08X.%08X error\n",
+			err_addr_lo, err_addr_hi);
+		writel(err_addr_lo, ctx->dev_csr + GLBL_SEC_ERRL);
+		writel(err_addr_hi, ctx->dev_csr + GLBL_SEC_ERRH);
+	}
+	if (reg & MSEC_ERR_MASK) {
+		err_addr_lo = readl(ctx->dev_csr + GLBL_MSEC_ERRL);
+		err_addr_hi = readl(ctx->dev_csr + GLBL_MSEC_ERRH);
+		dev_err(edac_dev->dev,
+			"IOB multiple single-bit correctable memory at 0x%08X.%08X error\n",
+			err_addr_lo, err_addr_hi);
+		writel(err_addr_lo, ctx->dev_csr + GLBL_MSEC_ERRL);
+		writel(err_addr_hi, ctx->dev_csr + GLBL_MSEC_ERRH);
+	}
+	if (reg & (SEC_ERR_MASK | MSEC_ERR_MASK))
+		edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
+
+	if (reg & DED_ERR_MASK) {
+		err_addr_lo = readl(ctx->dev_csr + GLBL_DED_ERRL);
+		err_addr_hi = readl(ctx->dev_csr + GLBL_DED_ERRH);
+		dev_err(edac_dev->dev,
+			"IOB double-bit uncorrectable memory at 0x%08X.%08X error\n",
+			err_addr_lo, err_addr_hi);
+		writel(err_addr_lo, ctx->dev_csr + GLBL_DED_ERRL);
+		writel(err_addr_hi, ctx->dev_csr + GLBL_DED_ERRH);
+	}
+	if (reg & MDED_ERR_MASK) {
+		err_addr_lo = readl(ctx->dev_csr + GLBL_MDED_ERRL);
+		err_addr_hi = readl(ctx->dev_csr + GLBL_MDED_ERRH);
+		dev_err(edac_dev->dev,
+			"Multiple IOB double-bit uncorrectable memory at 0x%08X.%08X error\n",
+			err_addr_lo, err_addr_hi);
+		writel(err_addr_lo, ctx->dev_csr + GLBL_MDED_ERRL);
+		writel(err_addr_hi, ctx->dev_csr + GLBL_MDED_ERRH);
+	}
+	if (reg & (DED_ERR_MASK | MDED_ERR_MASK))
+		edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
+}
+
+static void xgene_edac_rb_report(struct edac_device_ctl_info *edac_dev)
+{
+	struct xgene_edac_dev_ctx *ctx = edac_dev->pvt_info;
+	u32 err_addr_lo;
+	u32 err_addr_hi;
+	u32 reg;
+
+	/* IOB Bridge agent transaction error interrupt */
+	reg = readl(ctx->dev_csr + IOBBATRANSERRINTSTS);
+	if (!reg)
+		return;
+
+	dev_err(edac_dev->dev, "IOB bridge agent (BA) transaction error\n");
+	if (reg & WRERR_RESP_MASK)
+		dev_err(edac_dev->dev, "IOB BA write response error\n");
+	if (reg & M_WRERR_RESP_MASK)
+		dev_err(edac_dev->dev,
+			"Multiple IOB BA write response error\n");
+	if (reg & XGIC_POISONED_REQ_MASK)
+		dev_err(edac_dev->dev, "IOB BA XGIC poisoned write error\n");
+	if (reg & M_XGIC_POISONED_REQ_MASK)
+		dev_err(edac_dev->dev,
+			"Multiple IOB BA XGIC poisoned write error\n");
+	if (reg & RBM_POISONED_REQ_MASK)
+		dev_err(edac_dev->dev, "IOB BA RBM poisoned write error\n");
+	if (reg & M_RBM_POISONED_REQ_MASK)
+		dev_err(edac_dev->dev,
+			"Multiple IOB BA RBM poisoned write error\n");
+	if (reg & WDATA_CORRUPT_MASK)
+		dev_err(edac_dev->dev, "IOB BA write error\n");
+	if (reg & M_WDATA_CORRUPT_MASK)
+		dev_err(edac_dev->dev, "Multiple IOB BA write error\n");
+	if (reg & TRANS_CORRUPT_MASK)
+		dev_err(edac_dev->dev, "IOB BA transaction error\n");
+	if (reg & M_TRANS_CORRUPT_MASK)
+		dev_err(edac_dev->dev, "Multiple IOB BA transaction error\n");
+	if (reg & RIDRAM_CORRUPT_MASK)
+		dev_err(edac_dev->dev,
+			"IOB BA RDIDRAM read transaction ID error\n");
+	if (reg & M_RIDRAM_CORRUPT_MASK)
+		dev_err(edac_dev->dev,
+			"Multiple IOB BA RDIDRAM read transaction ID error\n");
+	if (reg & WIDRAM_CORRUPT_MASK)
+		dev_err(edac_dev->dev,
+			"IOB BA RDIDRAM write transaction ID error\n");
+	if (reg & M_WIDRAM_CORRUPT_MASK)
+		dev_err(edac_dev->dev,
+			"Multiple IOB BA RDIDRAM write transaction ID error\n");
+	if (reg & ILLEGAL_ACCESS_MASK)
+		dev_err(edac_dev->dev,
+			"IOB BA XGIC/RB illegal access error\n");
+	if (reg & M_ILLEGAL_ACCESS_MASK)
+		dev_err(edac_dev->dev,
+			"Multiple IOB BA XGIC/RB illegal access error\n");
+
+	err_addr_lo = readl(ctx->dev_csr + IOBBATRANSERRREQINFOL);
+	err_addr_hi = readl(ctx->dev_csr + IOBBATRANSERRREQINFOH);
+	dev_err(edac_dev->dev, "IOB BA %s access at 0x%02X.%08X (0x%08X)\n",
+		REQTYPE_F2_RD(err_addr_hi) ? "read" : "write",
+		ERRADDRH_F2_RD(err_addr_hi), err_addr_lo, err_addr_hi);
+	if (reg & WRERR_RESP_MASK)
+		dev_err(edac_dev->dev, "IOB BA requestor ID 0x%08X\n",
+			readl(ctx->dev_csr + IOBBATRANSERRCSWREQID));
+	writel(reg, ctx->dev_csr + IOBBATRANSERRINTSTS);
+}
+
+static void xgene_edac_pa_report(struct edac_device_ctl_info *edac_dev)
+{
+	struct xgene_edac_dev_ctx *ctx = edac_dev->pvt_info;
+	u32 err_addr_lo;
+	u32 err_addr_hi;
+	u32 reg;
+
+	/* IOB Processing agent transaction error interrupt */
+	reg = readl(ctx->dev_csr + IOBPATRANSERRINTSTS);
+	if (!reg)
+		goto chk_iob_axi0;
+	dev_err(edac_dev->dev, "IOB procesing agent (PA) transaction error\n");
+	if (reg & IOBPA_RDATA_CORRUPT_MASK)
+		dev_err(edac_dev->dev, "IOB PA read data RAM error\n");
+	if (reg & IOBPA_M_RDATA_CORRUPT_MASK)
+		dev_err(edac_dev->dev,
+			"Mutilple IOB PA read data RAM error\n");
+	if (reg & IOBPA_WDATA_CORRUPT_MASK)
+		dev_err(edac_dev->dev, "IOB PA write data RAM error\n");
+	if (reg & IOBPA_M_WDATA_CORRUPT_MASK)
+		dev_err(edac_dev->dev,
+			"Mutilple IOB PA write data RAM error\n");
+	if (reg & IOBPA_TRANS_CORRUPT_MASK)
+		dev_err(edac_dev->dev, "IOB PA transaction error\n");
+	if (reg & IOBPA_M_TRANS_CORRUPT_MASK)
+		dev_err(edac_dev->dev, "Mutilple IOB PA transaction error\n");
+	if (reg & IOBPA_REQIDRAM_CORRUPT_MASK)
+		dev_err(edac_dev->dev, "IOB PA transaction ID RAM error\n");
+	if (reg & IOBPA_M_REQIDRAM_CORRUPT_MASK)
+		dev_err(edac_dev->dev,
+			"Multiple IOB PA transaction ID RAM error\n");
+	writel(reg, ctx->dev_csr + IOBPATRANSERRINTSTS);
+
+chk_iob_axi0:
+	/* IOB AXI0 Error */
+	reg = readl(ctx->dev_csr + IOBAXIS0TRANSERRINTSTS);
+	if (!reg)
+		goto chk_iob_axi1;
+	err_addr_lo = readl(ctx->dev_csr + IOBAXIS0TRANSERRREQINFOL);
+	err_addr_hi = readl(ctx->dev_csr + IOBAXIS0TRANSERRREQINFOH);
+	dev_err(edac_dev->dev,
+		"%sAXI slave 0 illegal %s access @ 0x%02X.%08X (0x%08X)\n",
+		reg & IOBAXIS0_M_ILLEGAL_ACCESS_MASK ? "Multiple " : "",
+		REQTYPE_RD(err_addr_hi) ? "read" : "write",
+		ERRADDRH_RD(err_addr_hi), err_addr_lo, err_addr_hi);
+	writel(reg, ctx->dev_csr + IOBAXIS0TRANSERRINTSTS);
+
+chk_iob_axi1:
+	/* IOB AXI1 Error */
+	reg = readl(ctx->dev_csr + IOBAXIS1TRANSERRINTSTS);
+	if (!reg)
+		return;
+	err_addr_lo = readl(ctx->dev_csr + IOBAXIS1TRANSERRREQINFOL);
+	err_addr_hi = readl(ctx->dev_csr + IOBAXIS1TRANSERRREQINFOH);
+	dev_err(edac_dev->dev,
+		"%sAXI slave 1 illegal %s access @ 0x%02X.%08X (0x%08X)\n",
+		reg & IOBAXIS0_M_ILLEGAL_ACCESS_MASK ? "Multiple " : "",
+		REQTYPE_RD(err_addr_hi) ? "read" : "write",
+		ERRADDRH_RD(err_addr_hi), err_addr_lo, err_addr_hi);
+	writel(reg, ctx->dev_csr + IOBAXIS1TRANSERRINTSTS);
+}
+
+static void xgene_edac_soc_check(struct edac_device_ctl_info *edac_dev)
+{
+	struct xgene_edac_dev_ctx *ctx = edac_dev->pvt_info;
+	const char * const *soc_mem_err = NULL;
+	u32 pcp_hp_stat;
+	u32 pcp_lp_stat;
+	u32 reg;
+	int i;
+
+	xgene_edac_pcp_rd(ctx->edac, PCPHPERRINTSTS, &pcp_hp_stat);
+	xgene_edac_pcp_rd(ctx->edac, PCPLPERRINTSTS, &pcp_lp_stat);
+	xgene_edac_pcp_rd(ctx->edac, MEMERRINTSTS, &reg);
+	if (!((pcp_hp_stat & (IOB_PA_ERR_MASK | IOB_BA_ERR_MASK |
+			      IOB_XGIC_ERR_MASK | IOB_RB_ERR_MASK)) ||
+	      (pcp_lp_stat & CSW_SWITCH_TRACE_ERR_MASK) || reg))
+		return;
+
+	if (pcp_hp_stat & IOB_XGIC_ERR_MASK)
+		xgene_edac_iob_gic_report(edac_dev);
+
+	if (pcp_hp_stat & (IOB_RB_ERR_MASK | IOB_BA_ERR_MASK))
+		xgene_edac_rb_report(edac_dev);
+
+	if (pcp_hp_stat & IOB_PA_ERR_MASK)
+		xgene_edac_pa_report(edac_dev);
+
+	if (pcp_lp_stat & CSW_SWITCH_TRACE_ERR_MASK) {
+		dev_info(edac_dev->dev,
+			 "CSW switch trace correctable memory parity error\n");
+		edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
+	}
+
+	if (!reg)
+		return;
+	if (ctx->version == 1)
+		soc_mem_err = soc_mem_err_v1;
+	if (!soc_mem_err) {
+		dev_err(edac_dev->dev, "SoC memory parity error 0x%08X\n",
+			reg);
+		edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
+		return;
+	}
+	for (i = 0; i < 31; i++) {
+		if (reg & (1 << i)) {
+			dev_err(edac_dev->dev, "%s memory parity error\n",
+				soc_mem_err[i]);
+			edac_device_handle_ue(edac_dev, 0, 0,
+					      edac_dev->ctl_name);
+		}
+	}
+}
+
+static void xgene_edac_soc_hw_init(struct edac_device_ctl_info *edac_dev,
+				   bool enable)
+{
+	struct xgene_edac_dev_ctx *ctx = edac_dev->pvt_info;
+
+	/* Enable SoC IP error interrupt */
+	if (edac_dev->op_state == OP_RUNNING_INTERRUPT) {
+		if (enable) {
+			xgene_edac_pcp_clrbits(ctx->edac, PCPHPERRINTMSK,
+					       IOB_PA_ERR_MASK |
+					       IOB_BA_ERR_MASK |
+					       IOB_XGIC_ERR_MASK |
+					       IOB_RB_ERR_MASK);
+			xgene_edac_pcp_clrbits(ctx->edac, PCPLPERRINTMSK,
+					       CSW_SWITCH_TRACE_ERR_MASK);
+		} else {
+			xgene_edac_pcp_setbits(ctx->edac, PCPHPERRINTMSK,
+					       IOB_PA_ERR_MASK |
+					       IOB_BA_ERR_MASK |
+					       IOB_XGIC_ERR_MASK |
+					       IOB_RB_ERR_MASK);
+			xgene_edac_pcp_setbits(ctx->edac, PCPLPERRINTMSK,
+					       CSW_SWITCH_TRACE_ERR_MASK);
+		}
+
+		writel(enable ? 0x0 : 0xFFFFFFFF,
+		       ctx->dev_csr + IOBAXIS0TRANSERRINTMSK);
+		writel(enable ? 0x0 : 0xFFFFFFFF,
+		       ctx->dev_csr + IOBAXIS1TRANSERRINTMSK);
+		writel(enable ? 0x0 : 0xFFFFFFFF,
+		       ctx->dev_csr + XGICTRANSERRINTMSK);
+
+		xgene_edac_pcp_setbits(ctx->edac, MEMERRINTMSK,
+				       enable ? 0x0 : 0xFFFFFFFF);
+	}
+}
+
+static int xgene_edac_soc_add(struct xgene_edac *edac, struct device_node *np,
+			      int version)
+{
+	struct edac_device_ctl_info *edac_dev;
+	struct xgene_edac_dev_ctx *ctx;
+	void __iomem *dev_csr;
+	struct resource res;
+	int edac_idx;
+	int rc;
+
+	if (!devres_open_group(edac->dev, xgene_edac_soc_add, GFP_KERNEL))
+		return -ENOMEM;
+
+	rc = of_address_to_resource(np, 0, &res);
+	if (rc < 0) {
+		dev_err(edac->dev, "no SoC resource address\n");
+		goto err_release_group;
+	}
+	dev_csr = devm_ioremap_resource(edac->dev, &res);
+	if (IS_ERR(dev_csr)) {
+		dev_err(edac->dev,
+			"devm_ioremap_resource failed for soc resource address\n");
+		rc = PTR_ERR(dev_csr);
+		goto err_release_group;
+	}
+
+	edac_idx = edac_device_alloc_index();
+	edac_dev = edac_device_alloc_ctl_info(sizeof(*ctx),
+					      "SOC", 1, "SOC", 1, 2, NULL, 0,
+					      edac_idx);
+	if (!edac_dev) {
+		rc = -ENOMEM;
+		goto err_release_group;
+	}
+
+	ctx = edac_dev->pvt_info;
+	ctx->dev_csr = dev_csr;
+	ctx->name = "xgene_soc_err";
+	ctx->edac_idx = edac_idx;
+	ctx->edac = edac;
+	ctx->edac_dev = edac_dev;
+	ctx->ddev = *edac->dev;
+	ctx->version = version;
+	edac_dev->dev = &ctx->ddev;
+	edac_dev->ctl_name = ctx->name;
+	edac_dev->dev_name = ctx->name;
+	edac_dev->mod_name = EDAC_MOD_STR;
+
+	if (edac_op_state == EDAC_OPSTATE_POLL)
+		edac_dev->edac_check = xgene_edac_soc_check;
+
+	rc = edac_device_add_device(edac_dev);
+	if (rc > 0) {
+		dev_err(edac->dev, "failed edac_device_add_device()\n");
+		rc = -ENOMEM;
+		goto err_ctl_free;
+	}
+
+	if (edac_op_state == EDAC_OPSTATE_INT)
+		edac_dev->op_state = OP_RUNNING_INTERRUPT;
+
+	list_add(&ctx->next, &edac->socs);
+
+	xgene_edac_soc_hw_init(edac_dev, 1);
+
+	devres_remove_group(edac->dev, xgene_edac_soc_add);
+
+	dev_info(edac->dev, "X-Gene EDAC SoC registered\n");
+
+	return 0;
+
+err_ctl_free:
+	edac_device_free_ctl_info(edac_dev);
+err_release_group:
+	devres_release_group(edac->dev, xgene_edac_soc_add);
+	return rc;
+}
+
+static int xgene_edac_soc_remove(struct xgene_edac_dev_ctx *soc)
+{
+	struct edac_device_ctl_info *edac_dev = soc->edac_dev;
+
+	xgene_edac_soc_hw_init(edac_dev, 0);
+	edac_device_del_device(soc->edac->dev);
+	edac_device_free_ctl_info(edac_dev);
+	return 0;
+}
+
 static irqreturn_t xgene_edac_isr(int irq, void *dev_id)
 {
 	struct xgene_edac *ctx = dev_id;
@@ -1308,6 +1795,9 @@ static irqreturn_t xgene_edac_isr(int irq, void *dev_id)
 	list_for_each_entry(node, &ctx->l3s, next)
 		xgene_edac_l3_check(node->edac_dev);

+	list_for_each_entry(node, &ctx->socs, next)
+		xgene_edac_soc_check(node->edac_dev);
+
 	return IRQ_HANDLED;
 }

@@ -1327,6 +1817,7 @@ static int xgene_edac_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&edac->mcus);
 	INIT_LIST_HEAD(&edac->pmds);
 	INIT_LIST_HEAD(&edac->l3s);
+	INIT_LIST_HEAD(&edac->socs);
 	spin_lock_init(&edac->lock);
 	mutex_init(&edac->mc_lock);

@@ -1406,6 +1897,10 @@ static int xgene_edac_probe(struct platform_device *pdev)
 			xgene_edac_l3_add(edac, child, 1);
 		if (of_device_is_compatible(child, "apm,xgene-edac-l3-v2"))
 			xgene_edac_l3_add(edac, child, 2);
+		if (of_device_is_compatible(child, "apm,xgene-edac-soc"))
+			xgene_edac_soc_add(edac, child, 0);
+		if (of_device_is_compatible(child, "apm,xgene-edac-soc-v1"))
+			xgene_edac_soc_add(edac, child, 1);
 	}

 	return 0;
@@ -1433,6 +1928,9 @@ static int xgene_edac_remove(struct platform_device *pdev)
 	list_for_each_entry_safe(node, temp_node, &edac->l3s, next)
 		xgene_edac_l3_remove(node);

+	list_for_each_entry_safe(node, temp_node, &edac->socs, next)
+		xgene_edac_soc_remove(node);
+
 	return 0;
 }

--
1.7.1
