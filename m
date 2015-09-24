From: lho@apm.com (Loc Ho)
Date: Wed, 23 Sep 2015 17:40:59 -0700
Subject: [PATCH v5 2/4] edac: Add L3 EDAC support to the APM X-Gene SoC EDAC
 driver
In-Reply-To: <1443055261-8613-1-git-send-email-lho@apm.com>
References: <1443055261-8613-1-git-send-email-lho@apm.com>
Message-ID: <1443055261-8613-3-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add EDAC support for the L3 component.

Signed-off-by: Loc Ho <lho@apm.com>
---
 drivers/edac/xgene_edac.c |  669 ++++++++++++++++++++++++++++++++-------------
 1 files changed, 474 insertions(+), 195 deletions(-)

diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index 5ff42d5..37121e8 100644
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -63,10 +63,11 @@ struct xgene_edac {
 	struct regmap		*efuse_map;
 	void __iomem		*pcp_csr;
 	spinlock_t		lock;
-	struct dentry		*dfs;
+	struct dentry           *dfs;

 	struct list_head	mcus;
 	struct list_head	pmds;
+	struct list_head	l3s;

 	struct mutex		mc_lock;
 	int			mc_active_mask;
@@ -537,140 +538,134 @@ static void xgene_edac_pmd_l1_check(struct edac_device_ctl_info *edac_dev,
 	pg_f = ctx->pmd_csr + cpu_idx * CPU_CSR_STRIDE + CPU_MEMERR_CPU_PAGE;

 	val = readl(pg_f + MEMERR_CPU_ICFESR_PAGE_OFFSET);
-	if (val) {
-		dev_err(edac_dev->dev,
-			"CPU%d L1 memory error ICF 0x%08X Way 0x%02X Index 0x%02X Info 0x%02X\n",
-			ctx->pmd * MAX_CPU_PER_PMD + cpu_idx, val,
-			MEMERR_CPU_ICFESR_ERRWAY_RD(val),
-			MEMERR_CPU_ICFESR_ERRINDEX_RD(val),
-			MEMERR_CPU_ICFESR_ERRINFO_RD(val));
-		if (val & MEMERR_CPU_ICFESR_CERR_MASK)
-			dev_err(edac_dev->dev,
-				"One or more correctable error\n");
-		if (val & MEMERR_CPU_ICFESR_MULTCERR_MASK)
-			dev_err(edac_dev->dev, "Multiple correctable error\n");
-		switch (MEMERR_CPU_ICFESR_ERRTYPE_RD(val)) {
-		case 1:
-			dev_err(edac_dev->dev, "L1 TLB multiple hit\n");
-			break;
-		case 2:
-			dev_err(edac_dev->dev, "Way select multiple hit\n");
-			break;
-		case 3:
-			dev_err(edac_dev->dev, "Physical tag parity error\n");
-			break;
-		case 4:
-		case 5:
-			dev_err(edac_dev->dev, "L1 data parity error\n");
-			break;
-		case 6:
-			dev_err(edac_dev->dev, "L1 pre-decode parity error\n");
-			break;
-		}
+	if (!val)
+		goto chk_lsu;
+	dev_err(edac_dev->dev,
+		"CPU%d L1 memory error ICF 0x%08X Way 0x%02X Index 0x%02X Info 0x%02X\n",
+		ctx->pmd * MAX_CPU_PER_PMD + cpu_idx, val,
+		MEMERR_CPU_ICFESR_ERRWAY_RD(val),
+		MEMERR_CPU_ICFESR_ERRINDEX_RD(val),
+		MEMERR_CPU_ICFESR_ERRINFO_RD(val));
+	if (val & MEMERR_CPU_ICFESR_CERR_MASK)
+		dev_err(edac_dev->dev, "One or more correctable error\n");
+	if (val & MEMERR_CPU_ICFESR_MULTCERR_MASK)
+		dev_err(edac_dev->dev, "Multiple correctable error\n");
+	switch (MEMERR_CPU_ICFESR_ERRTYPE_RD(val)) {
+	case 1:
+		dev_err(edac_dev->dev, "L1 TLB multiple hit\n");
+		break;
+	case 2:
+		dev_err(edac_dev->dev, "Way select multiple hit\n");
+		break;
+	case 3:
+		dev_err(edac_dev->dev, "Physical tag parity error\n");
+		break;
+	case 4:
+	case 5:
+		dev_err(edac_dev->dev, "L1 data parity error\n");
+		break;
+	case 6:
+		dev_err(edac_dev->dev, "L1 pre-decode parity error\n");
+		break;
+	}

-		/* Clear any HW errors */
-		writel(val, pg_f + MEMERR_CPU_ICFESR_PAGE_OFFSET);
+	/* Clear any HW errors */
+	writel(val, pg_f + MEMERR_CPU_ICFESR_PAGE_OFFSET);

-		if (val & (MEMERR_CPU_ICFESR_CERR_MASK |
-			   MEMERR_CPU_ICFESR_MULTCERR_MASK))
-			edac_device_handle_ce(edac_dev, 0, 0,
-					      edac_dev->ctl_name);
-	}
+	if (val & (MEMERR_CPU_ICFESR_CERR_MASK |
+		   MEMERR_CPU_ICFESR_MULTCERR_MASK))
+		edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);

+chk_lsu:
 	val = readl(pg_f + MEMERR_CPU_LSUESR_PAGE_OFFSET);
-	if (val) {
+	if (!val)
+		goto chk_mmu;
+	dev_err(edac_dev->dev,
+		"CPU%d memory error LSU 0x%08X Way 0x%02X Index 0x%02X Info 0x%02X\n",
+		ctx->pmd * MAX_CPU_PER_PMD + cpu_idx, val,
+		MEMERR_CPU_LSUESR_ERRWAY_RD(val),
+		MEMERR_CPU_LSUESR_ERRINDEX_RD(val),
+		MEMERR_CPU_LSUESR_ERRINFO_RD(val));
+	if (val & MEMERR_CPU_LSUESR_CERR_MASK)
+		dev_err(edac_dev->dev, "One or more correctable error\n");
+	if (val & MEMERR_CPU_LSUESR_MULTCERR_MASK)
+		dev_err(edac_dev->dev, "Multiple correctable error\n");
+	switch (MEMERR_CPU_LSUESR_ERRTYPE_RD(val)) {
+	case 0:
+		dev_err(edac_dev->dev, "Load tag error\n");
+		break;
+	case 1:
+		dev_err(edac_dev->dev, "Load data error\n");
+		break;
+	case 2:
+		dev_err(edac_dev->dev, "WSL multihit error\n");
+		break;
+	case 3:
+		dev_err(edac_dev->dev, "Store tag error\n");
+		break;
+	case 4:
 		dev_err(edac_dev->dev,
-			"CPU%d memory error LSU 0x%08X Way 0x%02X Index 0x%02X Info 0x%02X\n",
-			ctx->pmd * MAX_CPU_PER_PMD + cpu_idx, val,
-			MEMERR_CPU_LSUESR_ERRWAY_RD(val),
-			MEMERR_CPU_LSUESR_ERRINDEX_RD(val),
-			MEMERR_CPU_LSUESR_ERRINFO_RD(val));
-		if (val & MEMERR_CPU_LSUESR_CERR_MASK)
-			dev_err(edac_dev->dev,
-				"One or more correctable error\n");
-		if (val & MEMERR_CPU_LSUESR_MULTCERR_MASK)
-			dev_err(edac_dev->dev, "Multiple correctable error\n");
-		switch (MEMERR_CPU_LSUESR_ERRTYPE_RD(val)) {
-		case 0:
-			dev_err(edac_dev->dev, "Load tag error\n");
-			break;
-		case 1:
-			dev_err(edac_dev->dev, "Load data error\n");
-			break;
-		case 2:
-			dev_err(edac_dev->dev, "WSL multihit error\n");
-			break;
-		case 3:
-			dev_err(edac_dev->dev, "Store tag error\n");
-			break;
-		case 4:
-			dev_err(edac_dev->dev,
-				"DTB multihit from load pipeline error\n");
-			break;
-		case 5:
-			dev_err(edac_dev->dev,
-				"DTB multihit from store pipeline error\n");
-			break;
-		}
+			"DTB multihit from load pipeline error\n");
+		break;
+	case 5:
+		dev_err(edac_dev->dev,
+			"DTB multihit from store pipeline error\n");
+		break;
+	}

-		/* Clear any HW errors */
-		writel(val, pg_f + MEMERR_CPU_LSUESR_PAGE_OFFSET);
+	/* Clear any HW errors */
+	writel(val, pg_f + MEMERR_CPU_LSUESR_PAGE_OFFSET);

-		if (val & (MEMERR_CPU_LSUESR_CERR_MASK |
-			   MEMERR_CPU_LSUESR_MULTCERR_MASK))
-			edac_device_handle_ce(edac_dev, 0, 0,
-					      edac_dev->ctl_name);
-	}
+	if (val & (MEMERR_CPU_LSUESR_CERR_MASK |
+		   MEMERR_CPU_LSUESR_MULTCERR_MASK))
+		edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);

+chk_mmu:
 	val = readl(pg_f + MEMERR_CPU_MMUESR_PAGE_OFFSET);
-	if (val) {
-		dev_err(edac_dev->dev,
-			"CPU%d memory error MMU 0x%08X Way 0x%02X Index 0x%02X Info 0x%02X %s\n",
-			ctx->pmd * MAX_CPU_PER_PMD + cpu_idx, val,
-			MEMERR_CPU_MMUESR_ERRWAY_RD(val),
-			MEMERR_CPU_MMUESR_ERRINDEX_RD(val),
-			MEMERR_CPU_MMUESR_ERRINFO_RD(val),
-			val & MEMERR_CPU_MMUESR_ERRREQSTR_LSU_MASK ? "LSU" :
-								     "ICF");
-		if (val & MEMERR_CPU_MMUESR_CERR_MASK)
-			dev_err(edac_dev->dev,
-				"One or more correctable error\n");
-		if (val & MEMERR_CPU_MMUESR_MULTCERR_MASK)
-			dev_err(edac_dev->dev, "Multiple correctable error\n");
-		switch (MEMERR_CPU_MMUESR_ERRTYPE_RD(val)) {
-		case 0:
-			dev_err(edac_dev->dev, "Stage 1 UTB hit error\n");
-			break;
-		case 1:
-			dev_err(edac_dev->dev, "Stage 1 UTB miss error\n");
-			break;
-		case 2:
-			dev_err(edac_dev->dev, "Stage 1 UTB allocate error\n");
-			break;
-		case 3:
-			dev_err(edac_dev->dev,
-				"TMO operation single bank error\n");
-			break;
-		case 4:
-			dev_err(edac_dev->dev, "Stage 2 UTB error\n");
-			break;
-		case 5:
-			dev_err(edac_dev->dev, "Stage 2 UTB miss error\n");
-			break;
-		case 6:
-			dev_err(edac_dev->dev, "Stage 2 UTB allocate error\n");
-			break;
-		case 7:
-			dev_err(edac_dev->dev,
-				"TMO operation multiple bank error\n");
-			break;
-		}
+	if (!val)
+		return;
+	dev_err(edac_dev->dev,
+		"CPU%d memory error MMU 0x%08X Way 0x%02X Index 0x%02X Info 0x%02X %s\n",
+		ctx->pmd * MAX_CPU_PER_PMD + cpu_idx, val,
+		MEMERR_CPU_MMUESR_ERRWAY_RD(val),
+		MEMERR_CPU_MMUESR_ERRINDEX_RD(val),
+		MEMERR_CPU_MMUESR_ERRINFO_RD(val),
+		val & MEMERR_CPU_MMUESR_ERRREQSTR_LSU_MASK ? "LSU" : "ICF");
+	if (val & MEMERR_CPU_MMUESR_CERR_MASK)
+		dev_err(edac_dev->dev, "One or more correctable error\n");
+	if (val & MEMERR_CPU_MMUESR_MULTCERR_MASK)
+		dev_err(edac_dev->dev, "Multiple correctable error\n");
+	switch (MEMERR_CPU_MMUESR_ERRTYPE_RD(val)) {
+	case 0:
+		dev_err(edac_dev->dev, "Stage 1 UTB hit error\n");
+		break;
+	case 1:
+		dev_err(edac_dev->dev, "Stage 1 UTB miss error\n");
+		break;
+	case 2:
+		dev_err(edac_dev->dev, "Stage 1 UTB allocate error\n");
+		break;
+	case 3:
+		dev_err(edac_dev->dev, "TMO operation single bank error\n");
+		break;
+	case 4:
+		dev_err(edac_dev->dev, "Stage 2 UTB error\n");
+		break;
+	case 5:
+		dev_err(edac_dev->dev, "Stage 2 UTB miss error\n");
+		break;
+	case 6:
+		dev_err(edac_dev->dev, "Stage 2 UTB allocate error\n");
+		break;
+	case 7:
+		dev_err(edac_dev->dev, "TMO operation multiple bank error\n");
+		break;
+	}

-		/* Clear any HW errors */
-		writel(val, pg_f + MEMERR_CPU_MMUESR_PAGE_OFFSET);
+	/* Clear any HW errors */
+	writel(val, pg_f + MEMERR_CPU_MMUESR_PAGE_OFFSET);

-		edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
-	}
+	edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
 }

 static void xgene_edac_pmd_l2_check(struct edac_device_ctl_info *edac_dev)
@@ -685,60 +680,56 @@ static void xgene_edac_pmd_l2_check(struct edac_device_ctl_info *edac_dev)
 	/* Check L2 */
 	pg_e = ctx->pmd_csr + CPU_MEMERR_L2C_PAGE;
 	val = readl(pg_e + MEMERR_L2C_L2ESR_PAGE_OFFSET);
-	if (val) {
-		val_lo = readl(pg_e + MEMERR_L2C_L2EALR_PAGE_OFFSET);
-		val_hi = readl(pg_e + MEMERR_L2C_L2EAHR_PAGE_OFFSET);
-		dev_err(edac_dev->dev,
-			"PMD%d memory error L2C L2ESR 0x%08X @ 0x%08X.%08X\n",
-			ctx->pmd, val, val_hi, val_lo);
-		dev_err(edac_dev->dev,
-			"ErrSyndrome 0x%02X ErrWay 0x%02X ErrCpu %d ErrGroup 0x%02X ErrAction 0x%02X\n",
-			MEMERR_L2C_L2ESR_ERRSYN_RD(val),
-			MEMERR_L2C_L2ESR_ERRWAY_RD(val),
-			MEMERR_L2C_L2ESR_ERRCPU_RD(val),
-			MEMERR_L2C_L2ESR_ERRGROUP_RD(val),
-			MEMERR_L2C_L2ESR_ERRACTION_RD(val));
-
-		if (val & MEMERR_L2C_L2ESR_ERR_MASK)
-			dev_err(edac_dev->dev,
-				"One or more correctable error\n");
-		if (val & MEMERR_L2C_L2ESR_MULTICERR_MASK)
-			dev_err(edac_dev->dev, "Multiple correctable error\n");
-		if (val & MEMERR_L2C_L2ESR_UCERR_MASK)
-			dev_err(edac_dev->dev,
-				"One or more uncorrectable error\n");
-		if (val & MEMERR_L2C_L2ESR_MULTUCERR_MASK)
-			dev_err(edac_dev->dev,
-				"Multiple uncorrectable error\n");
-
-		switch (MEMERR_L2C_L2ESR_ERRTYPE_RD(val)) {
-		case 0:
-			dev_err(edac_dev->dev, "Outbound SDB parity error\n");
-			break;
-		case 1:
-			dev_err(edac_dev->dev, "Inbound SDB parity error\n");
-			break;
-		case 2:
-			dev_err(edac_dev->dev, "Tag ECC error\n");
-			break;
-		case 3:
-			dev_err(edac_dev->dev, "Data ECC error\n");
-			break;
-		}
-
-		/* Clear any HW errors */
-		writel(val, pg_e + MEMERR_L2C_L2ESR_PAGE_OFFSET);
-
-		if (val & (MEMERR_L2C_L2ESR_ERR_MASK |
-			   MEMERR_L2C_L2ESR_MULTICERR_MASK))
-			edac_device_handle_ce(edac_dev, 0, 0,
-					      edac_dev->ctl_name);
-		if (val & (MEMERR_L2C_L2ESR_UCERR_MASK |
-			   MEMERR_L2C_L2ESR_MULTUCERR_MASK))
-			edac_device_handle_ue(edac_dev, 0, 0,
-					      edac_dev->ctl_name);
+	if (!val)
+		goto chk_l2c;
+	val_lo = readl(pg_e + MEMERR_L2C_L2EALR_PAGE_OFFSET);
+	val_hi = readl(pg_e + MEMERR_L2C_L2EAHR_PAGE_OFFSET);
+	dev_err(edac_dev->dev,
+		"PMD%d memory error L2C L2ESR 0x%08X @ 0x%08X.%08X\n",
+		ctx->pmd, val, val_hi, val_lo);
+	dev_err(edac_dev->dev,
+		"ErrSyndrome 0x%02X ErrWay 0x%02X ErrCpu %d ErrGroup 0x%02X ErrAction 0x%02X\n",
+		MEMERR_L2C_L2ESR_ERRSYN_RD(val),
+		MEMERR_L2C_L2ESR_ERRWAY_RD(val),
+		MEMERR_L2C_L2ESR_ERRCPU_RD(val),
+		MEMERR_L2C_L2ESR_ERRGROUP_RD(val),
+		MEMERR_L2C_L2ESR_ERRACTION_RD(val));
+
+	if (val & MEMERR_L2C_L2ESR_ERR_MASK)
+		dev_err(edac_dev->dev, "One or more correctable error\n");
+	if (val & MEMERR_L2C_L2ESR_MULTICERR_MASK)
+		dev_err(edac_dev->dev, "Multiple correctable error\n");
+	if (val & MEMERR_L2C_L2ESR_UCERR_MASK)
+		dev_err(edac_dev->dev, "One or more uncorrectable error\n");
+	if (val & MEMERR_L2C_L2ESR_MULTUCERR_MASK)
+		dev_err(edac_dev->dev, "Multiple uncorrectable error\n");
+
+	switch (MEMERR_L2C_L2ESR_ERRTYPE_RD(val)) {
+	case 0:
+		dev_err(edac_dev->dev, "Outbound SDB parity error\n");
+		break;
+	case 1:
+		dev_err(edac_dev->dev, "Inbound SDB parity error\n");
+		break;
+	case 2:
+		dev_err(edac_dev->dev, "Tag ECC error\n");
+		break;
+	case 3:
+		dev_err(edac_dev->dev, "Data ECC error\n");
+		break;
 	}

+	/* Clear any HW errors */
+	writel(val, pg_e + MEMERR_L2C_L2ESR_PAGE_OFFSET);
+
+	if (val & (MEMERR_L2C_L2ESR_ERR_MASK |
+		   MEMERR_L2C_L2ESR_MULTICERR_MASK))
+		edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
+	if (val & (MEMERR_L2C_L2ESR_UCERR_MASK |
+		   MEMERR_L2C_L2ESR_MULTUCERR_MASK))
+		edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
+
+chk_l2c:
 	/* Check if any memory request timed out on L2 cache */
 	pg_d = ctx->pmd_csr + CPU_L2C_PAGE;
 	val = readl(pg_d + CPUX_L2C_L2RTOSR_PAGE_OFFSET);
@@ -878,25 +869,16 @@ static const struct file_operations xgene_edac_pmd_debug_inject_fops[] = {
 	{ }
 };

-static void xgene_edac_pmd_create_debugfs_nodes(
-	struct edac_device_ctl_info *edac_dev)
+static void
+xgene_edac_pmd_create_debugfs_nodes(struct edac_device_ctl_info *edac_dev)
 {
 	struct xgene_edac_pmd_ctx *ctx = edac_dev->pvt_info;
 	struct dentry *dbgfs_dir;
-	char name[30];
+	char name[10];

-	if (!IS_ENABLED(CONFIG_EDAC_DEBUG))
+	if (!IS_ENABLED(CONFIG_EDAC_DEBUG) || !ctx->edac->dfs)
 		return;

-	/*
-	 * Todo: Switch to common EDAC debug file system for edac device
-	 *       when available.
-	 */
-	if (!ctx->edac->dfs) {
-		ctx->edac->dfs = edac_debugfs_create_dir(edac_dev->dev->kobj.name);
-		if (!ctx->edac->dfs)
-			return;
-	}
 	sprintf(name, "PMD%d", ctx->pmd);
 	dbgfs_dir = edac_debugfs_create_dir_at(name, ctx->edac->dfs);
 	if (!dbgfs_dir)
@@ -1016,10 +998,294 @@ static int xgene_edac_pmd_remove(struct xgene_edac_pmd_ctx *pmd)
 	return 0;
 }

+/* L3 Error device */
+#define L3C_ESR				(0x0A * 4)
+#define  L3C_ESR_DATATAG_MASK		BIT(9)
+#define  L3C_ESR_MULTIHIT_MASK		BIT(8)
+#define  L3C_ESR_UCEVICT_MASK		BIT(6)
+#define  L3C_ESR_MULTIUCERR_MASK	BIT(5)
+#define  L3C_ESR_MULTICERR_MASK		BIT(4)
+#define  L3C_ESR_UCERR_MASK		BIT(3)
+#define  L3C_ESR_CERR_MASK		BIT(2)
+#define  L3C_ESR_UCERRINTR_MASK		BIT(1)
+#define  L3C_ESR_CERRINTR_MASK		BIT(0)
+#define L3C_ECR				(0x0B * 4)
+#define  L3C_ECR_UCINTREN		BIT(3)
+#define  L3C_ECR_CINTREN		BIT(2)
+#define  L3C_UCERREN			BIT(1)
+#define  L3C_CERREN			BIT(0)
+#define L3C_ELR				(0x0C * 4)
+#define  L3C_ELR_ERRSYN(src)		((src & 0xFF800000) >> 23)
+#define  L3C_ELR_ERRWAY(src)		((src & 0x007E0000) >> 17)
+#define  L3C_ELR_AGENTID(src)		((src & 0x0001E000) >> 13)
+#define  L3C_ELR_ERRGRP(src)		((src & 0x00000F00) >> 8)
+#define  L3C_ELR_OPTYPE(src)		((src & 0x000000F0) >> 4)
+#define  L3C_ELR_PADDRHIGH(src)		(src & 0x0000000F)
+#define L3C_AELR			(0x0D * 4)
+#define L3C_BELR			(0x0E * 4)
+#define  L3C_BELR_BANK(src)		(src & 0x0000000F)
+
+struct xgene_edac_dev_ctx {
+	struct list_head	next;
+	struct device		ddev;
+	char			*name;
+	struct xgene_edac	*edac;
+	struct edac_device_ctl_info *edac_dev;
+	int			edac_idx;
+	void __iomem		*dev_csr;
+	int			version;
+};
+
+/*
+ * Version 1 of the L3 controller has broken single bit correctable logic for
+ * certain error syndromes. Log them as uncorrectable in that case.
+ */
+static bool xgene_edac_l3_promote_to_uc_err(u32 l3cesr, u32 l3celr)
+{
+	if (l3cesr & L3C_ESR_DATATAG_MASK) {
+		switch (L3C_ELR_ERRSYN(l3celr)) {
+		case 0x13C:
+		case 0x0B4:
+		case 0x007:
+		case 0x00D:
+		case 0x00E:
+		case 0x019:
+		case 0x01A:
+		case 0x01C:
+		case 0x04E:
+		case 0x041:
+			return true;
+		}
+	} else if (L3C_ELR_ERRSYN(l3celr) == 9)
+		return true;
+
+	return false;
+}
+
+static void xgene_edac_l3_check(struct edac_device_ctl_info *edac_dev)
+{
+	struct xgene_edac_dev_ctx *ctx = edac_dev->pvt_info;
+	u32 l3cesr;
+	u32 l3celr;
+	u32 l3caelr;
+	u32 l3cbelr;
+
+	l3cesr = readl(ctx->dev_csr + L3C_ESR);
+	if (!(l3cesr & (L3C_ESR_UCERR_MASK | L3C_ESR_CERR_MASK)))
+		return;
+
+	if (l3cesr & L3C_ESR_UCERR_MASK)
+		dev_err(edac_dev->dev, "L3C uncorrectable error\n");
+	if (l3cesr & L3C_ESR_CERR_MASK)
+		dev_warn(edac_dev->dev, "L3C correctable error\n");
+
+	l3celr = readl(ctx->dev_csr + L3C_ELR);
+	l3caelr = readl(ctx->dev_csr + L3C_AELR);
+	l3cbelr = readl(ctx->dev_csr + L3C_BELR);
+	if (l3cesr & L3C_ESR_MULTIHIT_MASK)
+		dev_err(edac_dev->dev, "L3C multiple hit error\n");
+	if (l3cesr & L3C_ESR_UCEVICT_MASK)
+		dev_err(edac_dev->dev,
+			"L3C dropped eviction of line with error\n");
+	if (l3cesr & L3C_ESR_MULTIUCERR_MASK)
+		dev_err(edac_dev->dev, "L3C multiple uncorrectable error\n");
+	if (l3cesr & L3C_ESR_DATATAG_MASK)
+		dev_err(edac_dev->dev,
+			"L3C data error syndrome 0x%X group 0x%X\n",
+			L3C_ELR_ERRSYN(l3celr), L3C_ELR_ERRGRP(l3celr));
+	else
+		dev_err(edac_dev->dev,
+			"L3C tag error syndrome 0x%X Way of Tag 0x%X Agent ID 0x%X Operation type 0x%X\n",
+			L3C_ELR_ERRSYN(l3celr), L3C_ELR_ERRWAY(l3celr),
+			L3C_ELR_AGENTID(l3celr), L3C_ELR_OPTYPE(l3celr));
+	/*
+	 * NOTE: Address [41:38] in L3C_ELR_PADDRHIGH(l3celr).
+	 *       Address [37:6] in l3caelr. Lower 6 bits are zero.
+	 */
+	dev_err(edac_dev->dev, "L3C error address 0x%08X.%08X bank %d\n",
+		L3C_ELR_PADDRHIGH(l3celr) << 6 | (l3caelr >> 26),
+		(l3caelr & 0x3FFFFFFF) << 6, L3C_BELR_BANK(l3cbelr));
+	dev_err(edac_dev->dev,
+		"L3C error status register value 0x%X\n", l3cesr);
+
+	/* Clear L3C error interrupt */
+	writel(0, ctx->dev_csr + L3C_ESR);
+
+	if (ctx->version <= 1 &&
+	    xgene_edac_l3_promote_to_uc_err(l3cesr, l3celr)) {
+		edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
+		return;
+	}
+	if (l3cesr & L3C_ESR_CERR_MASK)
+		edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
+	if (l3cesr & L3C_ESR_UCERR_MASK)
+		edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
+}
+
+static void xgene_edac_l3_hw_init(struct edac_device_ctl_info *edac_dev,
+				  bool enable)
+{
+	struct xgene_edac_dev_ctx *ctx = edac_dev->pvt_info;
+	u32 val;
+
+	val = readl(ctx->dev_csr + L3C_ECR);
+	val |= L3C_UCERREN | L3C_CERREN;
+	/* On disable, we just disable interrupt but keep error enabled */
+	if (edac_dev->op_state == OP_RUNNING_INTERRUPT) {
+		if (enable)
+			val |= L3C_ECR_UCINTREN | L3C_ECR_CINTREN;
+		else
+			val &= ~(L3C_ECR_UCINTREN | L3C_ECR_CINTREN);
+	}
+	writel(val, ctx->dev_csr + L3C_ECR);
+
+	if (edac_dev->op_state == OP_RUNNING_INTERRUPT) {
+		/* Enable/disable L3 error top level interrupt */
+		if (enable) {
+			xgene_edac_pcp_clrbits(ctx->edac, PCPHPERRINTMSK,
+					       L3C_UNCORR_ERR_MASK);
+			xgene_edac_pcp_clrbits(ctx->edac, PCPLPERRINTMSK,
+					       L3C_CORR_ERR_MASK);
+		} else {
+			xgene_edac_pcp_setbits(ctx->edac, PCPHPERRINTMSK,
+					       L3C_UNCORR_ERR_MASK);
+			xgene_edac_pcp_setbits(ctx->edac, PCPLPERRINTMSK,
+					       L3C_CORR_ERR_MASK);
+		}
+	}
+}
+
+static ssize_t xgene_edac_l3_inject_ctrl_write(struct file *file,
+					       const char __user *data,
+					       size_t count, loff_t *ppos)
+{
+	struct edac_device_ctl_info *edac_dev = file->private_data;
+	struct xgene_edac_dev_ctx *ctx = edac_dev->pvt_info;
+
+	/* Generate all errors */
+	writel(0xFFFFFFFF, ctx->dev_csr + L3C_ESR);
+	return count;
+}
+
+static const struct file_operations xgene_edac_l3_debug_inject_fops = {
+	.open = simple_open,
+	.write = xgene_edac_l3_inject_ctrl_write,
+	.llseek = generic_file_llseek
+};
+
+static void
+xgene_edac_l3_create_debugfs_nodes(struct edac_device_ctl_info *edac_dev)
+{
+	struct xgene_edac_dev_ctx *ctx = edac_dev->pvt_info;
+	struct dentry *dbgfs_dir;
+	char name[10];
+
+	if (!IS_ENABLED(CONFIG_EDAC_DEBUG) || !ctx->edac->dfs)
+		return;
+
+	sprintf(name, "l3c%d", ctx->edac_idx);
+	dbgfs_dir = edac_debugfs_create_dir_at(name, ctx->edac->dfs);
+	if (!dbgfs_dir)
+		return;
+
+	debugfs_create_file("l3_inject_ctrl", S_IWUSR, dbgfs_dir, edac_dev,
+			    &xgene_edac_l3_debug_inject_fops);
+}
+
+static int xgene_edac_l3_add(struct xgene_edac *edac, struct device_node *np,
+			     int version)
+{
+	struct edac_device_ctl_info *edac_dev;
+	struct xgene_edac_dev_ctx *ctx;
+	struct resource res;
+	void __iomem *dev_csr;
+	int edac_idx;
+	int rc = 0;
+
+	if (!devres_open_group(edac->dev, xgene_edac_l3_add, GFP_KERNEL))
+		return -ENOMEM;
+
+	rc = of_address_to_resource(np, 0, &res);
+	if (rc < 0) {
+		dev_err(edac->dev, "no L3 resource address\n");
+		goto err_release_group;
+	}
+	dev_csr = devm_ioremap_resource(edac->dev, &res);
+	if (IS_ERR(dev_csr)) {
+		dev_err(edac->dev,
+			"devm_ioremap_resource failed for L3 resource address\n");
+		rc = PTR_ERR(dev_csr);
+		goto err_release_group;
+	}
+
+	edac_idx = edac_device_alloc_index();
+	edac_dev = edac_device_alloc_ctl_info(sizeof(*ctx),
+					      "l3c", 1, "l3c", 1, 0, NULL, 0,
+					      edac_idx);
+	if (!edac_dev) {
+		rc = -ENOMEM;
+		goto err_release_group;
+	}
+
+	ctx = edac_dev->pvt_info;
+	ctx->dev_csr = dev_csr;
+	ctx->name = "xgene_l3_err";
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
+		edac_dev->edac_check = xgene_edac_l3_check;
+
+	xgene_edac_l3_create_debugfs_nodes(edac_dev);
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
+	list_add(&ctx->next, &edac->l3s);
+
+	xgene_edac_l3_hw_init(edac_dev, 1);
+
+	devres_remove_group(edac->dev, xgene_edac_l3_add);
+
+	dev_info(edac->dev, "X-Gene EDAC L3 registered\n");
+	return 0;
+
+err_ctl_free:
+	edac_device_free_ctl_info(edac_dev);
+err_release_group:
+	devres_release_group(edac->dev, xgene_edac_l3_add);
+	return rc;
+}
+
+static int xgene_edac_l3_remove(struct xgene_edac_dev_ctx *l3)
+{
+	struct edac_device_ctl_info *edac_dev = l3->edac_dev;
+
+	xgene_edac_l3_hw_init(edac_dev, 0);
+	edac_device_del_device(l3->edac->dev);
+	edac_device_free_ctl_info(edac_dev);
+	return 0;
+}
+
 static irqreturn_t xgene_edac_isr(int irq, void *dev_id)
 {
 	struct xgene_edac *ctx = dev_id;
 	struct xgene_edac_pmd_ctx *pmd;
+	struct xgene_edac_dev_ctx *node;
 	unsigned int pcp_hp_stat;
 	unsigned int pcp_lp_stat;

@@ -1030,9 +1296,8 @@ static irqreturn_t xgene_edac_isr(int irq, void *dev_id)
 	    (MCU_CORR_ERR_MASK & pcp_lp_stat)) {
 		struct xgene_edac_mc_ctx *mcu;

-		list_for_each_entry(mcu, &ctx->mcus, next) {
+		list_for_each_entry(mcu, &ctx->mcus, next)
 			xgene_edac_mc_check(mcu->mci);
-		}
 	}

 	list_for_each_entry(pmd, &ctx->pmds, next) {
@@ -1040,6 +1305,9 @@ static irqreturn_t xgene_edac_isr(int irq, void *dev_id)
 			xgene_edac_pmd_check(pmd->edac_dev);
 	}

+	list_for_each_entry(node, &ctx->l3s, next)
+		xgene_edac_l3_check(node->edac_dev);
+
 	return IRQ_HANDLED;
 }

@@ -1058,6 +1326,7 @@ static int xgene_edac_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, edac);
 	INIT_LIST_HEAD(&edac->mcus);
 	INIT_LIST_HEAD(&edac->pmds);
+	INIT_LIST_HEAD(&edac->l3s);
 	spin_lock_init(&edac->lock);
 	mutex_init(&edac->mc_lock);

@@ -1122,6 +1391,8 @@ static int xgene_edac_probe(struct platform_device *pdev)
 		}
 	}

+	edac->dfs = edac_debugfs_create_dir(pdev->dev.kobj.name);
+
 	for_each_child_of_node(pdev->dev.of_node, child) {
 		if (!of_device_is_available(child))
 			continue;
@@ -1131,6 +1402,10 @@ static int xgene_edac_probe(struct platform_device *pdev)
 			xgene_edac_pmd_add(edac, child, 1);
 		if (of_device_is_compatible(child, "apm,xgene-edac-pmd-v2"))
 			xgene_edac_pmd_add(edac, child, 2);
+		if (of_device_is_compatible(child, "apm,xgene-edac-l3"))
+			xgene_edac_l3_add(edac, child, 1);
+		if (of_device_is_compatible(child, "apm,xgene-edac-l3-v2"))
+			xgene_edac_l3_add(edac, child, 2);
 	}

 	return 0;
@@ -1146,14 +1421,18 @@ static int xgene_edac_remove(struct platform_device *pdev)
 	struct xgene_edac_mc_ctx *temp_mcu;
 	struct xgene_edac_pmd_ctx *pmd;
 	struct xgene_edac_pmd_ctx *temp_pmd;
+	struct xgene_edac_dev_ctx *node;
+	struct xgene_edac_dev_ctx *temp_node;

-	list_for_each_entry_safe(mcu, temp_mcu, &edac->mcus, next) {
+	list_for_each_entry_safe(mcu, temp_mcu, &edac->mcus, next)
 		xgene_edac_mc_remove(mcu);
-	}

-	list_for_each_entry_safe(pmd, temp_pmd, &edac->pmds, next) {
+	list_for_each_entry_safe(pmd, temp_pmd, &edac->pmds, next)
 		xgene_edac_pmd_remove(pmd);
-	}
+
+	list_for_each_entry_safe(node, temp_node, &edac->l3s, next)
+		xgene_edac_l3_remove(node);
+
 	return 0;
 }

--
1.7.1
