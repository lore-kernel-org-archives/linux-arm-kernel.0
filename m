From: lho@apm.com (Loc Ho)
Date: Tue,  5 May 2015 22:02:26 -0600
Subject: [PATCH v8 4/5] edac: Add APM X-Gene SoC memory controller EDAC driver
In-Reply-To: <1430884947-16787-4-git-send-email-lho@apm.com>
References: <1430884947-16787-1-git-send-email-lho@apm.com>
 <1430884947-16787-2-git-send-email-lho@apm.com>
 <1430884947-16787-3-git-send-email-lho@apm.com>
 <1430884947-16787-4-git-send-email-lho@apm.com>
Message-ID: <1430884947-16787-5-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the APM X-Gene SoC memory controller EDAC driver.

Signed-off-by: Feng Kan <fkan@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>
---
 drivers/edac/Kconfig         |    7 +
 drivers/edac/Makefile        |    1 +
 drivers/edac/xgene_edac_mc.c |  552 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 560 insertions(+), 0 deletions(-)
 create mode 100644 drivers/edac/xgene_edac_mc.c

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index cb59619..8ab74cc 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -392,4 +392,11 @@ config EDAC_SYNOPSYS
 	  Support for error detection and correction on the Synopsys DDR
 	  memory controller.

+config EDAC_XGENE
+	tristate "APM X-Gene SoC"
+	depends on EDAC_MM_EDAC && ARM64
+	help
+	  Support for error detection and correction on the
+	  APM X-Gene family of SOCs.
+
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index b255f36..ff5c316 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -68,3 +68,4 @@ obj-$(CONFIG_EDAC_OCTEON_PCI)		+= octeon_edac-pci.o

 obj-$(CONFIG_EDAC_ALTERA_MC)		+= altera_edac.o
 obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
+obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac_mc.o
diff --git a/drivers/edac/xgene_edac_mc.c b/drivers/edac/xgene_edac_mc.c
new file mode 100644
index 0000000..81ebf1d
--- /dev/null
+++ b/drivers/edac/xgene_edac_mc.c
@@ -0,0 +1,552 @@
+/*
+ * APM X-Gene SoC Memory Controller EDAC (error detection and correction)
+ *
+ * Copyright (c) 2015, Applied Micro Circuits Corporation
+ * Author: Feng Kan <fkan@apm.com>
+ *         Loc Ho <lho@apm.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/ctype.h>
+#include <linux/edac.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+
+#include <asm/cputype.h>
+
+#include "edac_core.h"
+
+#define EDAC_MOD_STR			"xgene_edac_mc"
+
+static int edac_mc_idx;
+static int edac_mc_active_mask;
+static int edac_mc_registered_mask;
+static DEFINE_MUTEX(xgene_edac_mc_lock);
+
+/* Global error configuration status registers (CSR) */
+#define PCPHPERRINTSTS			0x0000
+#define PCPHPERRINTMSK			0x0004
+#define  MCU_CTL_ERR_MASK		BIT(12)
+#define  IOB_PA_ERR_MASK		BIT(11)
+#define  IOB_BA_ERR_MASK		BIT(10)
+#define  IOB_XGIC_ERR_MASK		BIT(9)
+#define  IOB_RB_ERR_MASK		BIT(8)
+#define  L3C_UNCORR_ERR_MASK		BIT(5)
+#define  MCU_UNCORR_ERR_MASK		BIT(4)
+#define  PMD3_MERR_MASK			BIT(3)
+#define  PMD2_MERR_MASK			BIT(2)
+#define  PMD1_MERR_MASK			BIT(1)
+#define  PMD0_MERR_MASK			BIT(0)
+#define PCPLPERRINTSTS			0x0008
+#define PCPLPERRINTMSK			0x000C
+#define  CSW_SWITCH_TRACE_ERR_MASK	BIT(2)
+#define  L3C_CORR_ERR_MASK		BIT(1)
+#define  MCU_CORR_ERR_MASK		BIT(0)
+#define MEMERRINTSTS			0x0010
+#define MEMERRINTMSK			0x0014
+
+/* Memory controller error CSR */
+#define MCU_MAX_RANK			8
+#define MCU_RANK_STRIDE			0x40
+
+#define MCUGECR				0x0110
+#define  MCU_GECR_DEMANDUCINTREN_MASK	BIT(0)
+#define  MCU_GECR_BACKUCINTREN_MASK	BIT(1)
+#define  MCU_GECR_CINTREN_MASK		BIT(2)
+#define  MUC_GECR_MCUADDRERREN_MASK	BIT(9)
+#define MCUGESR				0x0114
+#define  MCU_GESR_ADDRNOMATCH_ERR_MASK	BIT(7)
+#define  MCU_GESR_ADDRMULTIMATCH_ERR_MASK	BIT(6)
+#define  MCU_GESR_PHYP_ERR_MASK		BIT(3)
+#define MCUESRR0			0x0314
+#define  MCU_ESRR_MULTUCERR_MASK	BIT(3)
+#define  MCU_ESRR_BACKUCERR_MASK	BIT(2)
+#define  MCU_ESRR_DEMANDUCERR_MASK	BIT(1)
+#define  MCU_ESRR_CERR_MASK		BIT(0)
+#define MCUESRRA0			0x0318
+#define MCUEBLRR0			0x031c
+#define  MCU_EBLRR_ERRBANK_RD(src)	(((src) & 0x00000007) >> 0)
+#define MCUERCRR0			0x0320
+#define  MCU_ERCRR_ERRROW_RD(src)	(((src) & 0xFFFF0000) >> 16)
+#define  MCU_ERCRR_ERRCOL_RD(src)	((src) & 0x00000FFF)
+#define MCUSBECNT0			0x0324
+#define MCU_SBECNT_COUNT(src)		((src) & 0xFFFF)
+
+#define CSW_CSWCR			0x0000
+#define  CSW_CSWCR_DUALMCB_MASK		BIT(0)
+
+#define MCBADDRMR			0x0000
+#define  MCBADDRMR_MCU_INTLV_MODE_MASK	BIT(3)
+#define  MCBADDRMR_DUALMCU_MODE_MASK	BIT(2)
+#define  MCBADDRMR_MCB_INTLV_MODE_MASK	BIT(1)
+#define  MCBADDRMR_ADDRESS_MODE_MASK	BIT(0)
+
+struct xgene_edac_mc_ctx {
+	char *name;
+	struct regmap *pcp_map;
+	struct regmap *csw_map;
+	struct regmap *mcba_map;
+	struct regmap *mcbb_map;
+	void __iomem *mcu_csr;
+	int mcu_id;
+};
+
+#define to_mci(k) container_of(k, struct mem_ctl_info, dev)
+
+#ifdef CONFIG_EDAC_DEBUG
+static ssize_t xgene_edac_mc_err_inject_write(struct file *file,
+					      const char __user *data,
+					      size_t count, loff_t *ppos)
+{
+	struct mem_ctl_info *mci = file->private_data;
+	struct xgene_edac_mc_ctx *ctx = mci->pvt_info;
+	int i;
+
+	for (i = 0; i < MCU_MAX_RANK; i++) {
+		writel(MCU_ESRR_MULTUCERR_MASK | MCU_ESRR_BACKUCERR_MASK |
+		       MCU_ESRR_DEMANDUCERR_MASK | MCU_ESRR_CERR_MASK,
+		       ctx->mcu_csr + MCUESRRA0 + i * MCU_RANK_STRIDE);
+	}
+	return count;
+}
+
+static const struct file_operations xgene_edac_mc_debug_inject_fops = {
+	.open = simple_open,
+	.write = xgene_edac_mc_err_inject_write,
+	.llseek = generic_file_llseek,
+};
+
+static void xgene_edac_mc_create_debugfs_node(struct mem_ctl_info *mci)
+{
+	if (!mci->debugfs)
+		return;
+
+	debugfs_create_file("inject_ctrl", S_IWUSR, mci->debugfs, mci,
+			    &xgene_edac_mc_debug_inject_fops);
+}
+#else
+static void xgene_edac_mc_create_debugfs_node(struct mem_ctl_info *mci)
+{
+}
+#endif
+
+static void xgene_edac_mc_check(struct mem_ctl_info *mci)
+{
+	struct xgene_edac_mc_ctx *ctx = mci->pvt_info;
+	unsigned int pcp_hp_stat;
+	unsigned int pcp_lp_stat;
+	u32 reg;
+	u32 rank;
+	u32 bank;
+	u32 count;
+	u32 col_row;
+
+	if (regmap_read(ctx->pcp_map, PCPHPERRINTSTS, &pcp_hp_stat))
+		return;
+	if (regmap_read(ctx->pcp_map, PCPLPERRINTSTS, &pcp_lp_stat))
+		return;
+	if (!((MCU_UNCORR_ERR_MASK & pcp_hp_stat) ||
+	      (MCU_CTL_ERR_MASK & pcp_hp_stat) ||
+	      (MCU_CORR_ERR_MASK & pcp_lp_stat)))
+		return;
+
+	for (rank = 0; rank < MCU_MAX_RANK; rank++) {
+		reg = readl(ctx->mcu_csr + MCUESRR0 + rank * MCU_RANK_STRIDE);
+
+		/* Detect uncorrectable memory error */
+		if (reg & (MCU_ESRR_DEMANDUCERR_MASK |
+			   MCU_ESRR_BACKUCERR_MASK)) {
+			/* Detected uncorrectable memory error */
+			edac_mc_chipset_printk(mci, KERN_ERR, "X-Gene",
+				"MCU uncorrectable error at rank %d\n", rank);
+
+			edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
+				1, 0, 0, 0, 0, 0, -1, mci->ctl_name, "");
+		}
+
+		/* Detect correctable memory error */
+		if (reg & MCU_ESRR_CERR_MASK) {
+			bank = readl(ctx->mcu_csr + MCUEBLRR0 +
+				     rank * MCU_RANK_STRIDE);
+			col_row = readl(ctx->mcu_csr + MCUERCRR0 +
+					rank * MCU_RANK_STRIDE);
+			count = readl(ctx->mcu_csr + MCUSBECNT0 +
+				      rank * MCU_RANK_STRIDE);
+			edac_mc_chipset_printk(mci, KERN_WARNING, "X-Gene",
+				"MCU correctable error at rank %d bank %d column %d row %d count %d\n",
+				rank, MCU_EBLRR_ERRBANK_RD(bank),
+				MCU_ERCRR_ERRCOL_RD(col_row),
+				MCU_ERCRR_ERRROW_RD(col_row),
+				MCU_SBECNT_COUNT(count));
+
+			edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
+				1, 0, 0, 0, 0, 0, -1, mci->ctl_name, "");
+		}
+
+		/* Clear all error registers */
+		writel(0x0, ctx->mcu_csr + MCUEBLRR0 + rank * MCU_RANK_STRIDE);
+		writel(0x0, ctx->mcu_csr + MCUERCRR0 + rank * MCU_RANK_STRIDE);
+		writel(0x0, ctx->mcu_csr + MCUSBECNT0 +
+		       rank * MCU_RANK_STRIDE);
+		writel(reg, ctx->mcu_csr + MCUESRR0 + rank * MCU_RANK_STRIDE);
+	}
+
+	/* Detect memory controller error */
+	reg = readl(ctx->mcu_csr + MCUGESR);
+	if (reg) {
+		if (reg & MCU_GESR_ADDRNOMATCH_ERR_MASK)
+			edac_mc_chipset_printk(mci, KERN_WARNING, "X-Gene",
+				"MCU address miss-match error\n");
+		if (reg & MCU_GESR_ADDRMULTIMATCH_ERR_MASK)
+			edac_mc_chipset_printk(mci, KERN_WARNING, "X-Gene",
+				"MCU address multi-match error\n");
+
+		writel(reg, ctx->mcu_csr + MCUGESR);
+	}
+}
+
+static irqreturn_t xgene_edac_mc_isr(int irq, void *dev_id)
+{
+	struct mem_ctl_info *mci = dev_id;
+	struct xgene_edac_mc_ctx *ctx = mci->pvt_info;
+	unsigned int pcp_hp_stat;
+	unsigned int pcp_lp_stat;
+
+	if (regmap_read(ctx->pcp_map, PCPHPERRINTSTS, &pcp_hp_stat))
+		return IRQ_NONE;
+	if (regmap_read(ctx->pcp_map, PCPLPERRINTSTS, &pcp_lp_stat))
+		return IRQ_NONE;
+	if (!((MCU_UNCORR_ERR_MASK & pcp_hp_stat) ||
+	      (MCU_CTL_ERR_MASK & pcp_hp_stat) ||
+	      (MCU_CORR_ERR_MASK & pcp_lp_stat)))
+		return IRQ_NONE;
+
+	xgene_edac_mc_check(mci);
+
+	return IRQ_HANDLED;
+}
+
+static void xgene_edac_mc_irq_ctl(struct mem_ctl_info *mci, bool enable)
+{
+	struct xgene_edac_mc_ctx *ctx = mci->pvt_info;
+	unsigned int val;
+
+	if (edac_op_state != EDAC_OPSTATE_INT)
+		return;
+
+	mutex_lock(&xgene_edac_mc_lock);
+
+	/*
+	 * As there is only single bit for enable error and interrupt mask,
+	 * we must only enable top level interrupt after all MCUs are
+	 * registered. Otherwise, if there is an error and the corresponding
+	 * MCU has not registered, the interrupt will never get cleared. To
+	 * determine all MCU have registered, we will keep track of active
+	 * MCUs and registered MCUs.
+	 */
+	if (enable) {
+		/* Set registered MCU bit */
+		edac_mc_registered_mask |= 1 << ctx->mcu_id;
+
+		/* Enable interrupt after all active MCU registered */
+		if (edac_mc_registered_mask == edac_mc_active_mask) {
+			/* Enable memory controller top level interrupt */
+			if (regmap_read(ctx->pcp_map, PCPHPERRINTMSK, &val))
+				goto err;
+			val &= ~(MCU_UNCORR_ERR_MASK | MCU_CTL_ERR_MASK);
+			if (regmap_write(ctx->pcp_map, PCPHPERRINTMSK, val))
+				goto err;
+			if (regmap_read(ctx->pcp_map, PCPLPERRINTMSK, &val))
+				goto err;
+			val &= ~MCU_CORR_ERR_MASK;
+			if (regmap_write(ctx->pcp_map, PCPLPERRINTMSK, val))
+				goto err;
+		}
+
+		/* Enable MCU interrupt and error reporting */
+		val = readl(ctx->mcu_csr + MCUGECR);
+		val |= MCU_GECR_DEMANDUCINTREN_MASK |
+		       MCU_GECR_BACKUCINTREN_MASK |
+		       MCU_GECR_CINTREN_MASK |
+		       MUC_GECR_MCUADDRERREN_MASK;
+		writel(val, ctx->mcu_csr + MCUGECR);
+	} else {
+		/* Disable MCU interrupt */
+		val = readl(ctx->mcu_csr + MCUGECR);
+		val &= ~(MCU_GECR_DEMANDUCINTREN_MASK |
+			 MCU_GECR_BACKUCINTREN_MASK |
+			 MCU_GECR_CINTREN_MASK |
+			 MUC_GECR_MCUADDRERREN_MASK);
+		writel(val, ctx->mcu_csr + MCUGECR);
+
+		/* Disable memory controller top level interrupt */
+		if (regmap_read(ctx->pcp_map, PCPHPERRINTMSK, &val))
+			goto err;
+		val |= MCU_UNCORR_ERR_MASK | MCU_CTL_ERR_MASK;
+		if (regmap_write(ctx->pcp_map, PCPHPERRINTMSK, val))
+			goto err;
+		if (regmap_read(ctx->pcp_map, PCPLPERRINTMSK, &val))
+			goto err;
+		val |= MCU_CORR_ERR_MASK;
+		if (regmap_write(ctx->pcp_map, PCPLPERRINTMSK, val))
+			goto err;
+
+		/* Clear registered MCU bit */
+		edac_mc_registered_mask &= ~(1 << ctx->mcu_id);
+	}
+
+err:
+	mutex_unlock(&xgene_edac_mc_lock);
+}
+
+static int xgene_edac_mc_is_active(struct xgene_edac_mc_ctx *ctx, int mc_idx)
+{
+	unsigned int reg;
+	u32 mcu_mask;
+
+	if (regmap_read(ctx->csw_map, CSW_CSWCR, &reg))
+		return 0;
+
+	if (reg & CSW_CSWCR_DUALMCB_MASK) {
+		/*
+		 * Dual MCB active - Determine if all 4 active or just MCU0
+		 * and MCU2 active
+		 */
+		if (regmap_read(ctx->mcbb_map, MCBADDRMR, &reg))
+			return 0;
+		mcu_mask = (reg & MCBADDRMR_DUALMCU_MODE_MASK) ? 0xF : 0x5;
+	} else {
+		/*
+		 * Single MCB active - Determine if MCU0/MCU1 or just MCU0
+		 * active
+		 */
+		if (regmap_read(ctx->mcba_map, MCBADDRMR, &reg))
+			return 0;
+		mcu_mask = (reg & MCBADDRMR_DUALMCU_MODE_MASK) ? 0x3 : 0x1;
+	}
+
+	/* Save active MC mask if hasn't set already */
+	if (!edac_mc_active_mask)
+		edac_mc_active_mask = mcu_mask;
+
+	return (mcu_mask & (1 << mc_idx)) ? 1 : 0;
+}
+
+static int xgene_edac_mc_probe(struct platform_device *pdev)
+{
+	struct mem_ctl_info *mci;
+	struct edac_mc_layer layers[2];
+	struct xgene_edac_mc_ctx tmp_ctx;
+	struct xgene_edac_mc_ctx *ctx;
+	struct resource *res;
+	int rc = 0;
+
+	if (!devres_open_group(&pdev->dev, xgene_edac_mc_probe, GFP_KERNEL))
+		return -ENOMEM;
+
+	tmp_ctx.pcp_map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+							  "regmap-pcp");
+	if (IS_ERR(tmp_ctx.pcp_map)) {
+		dev_err(&pdev->dev, "unable to get syscon regmap pcp\n");
+		rc = PTR_ERR(tmp_ctx.pcp_map);
+		goto err_group;
+	}
+
+	tmp_ctx.csw_map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+							  "regmap-csw");
+	if (IS_ERR(tmp_ctx.csw_map)) {
+		dev_err(&pdev->dev, "unable to get syscon regmap csw\n");
+		rc = PTR_ERR(tmp_ctx.csw_map);
+		goto err_group;
+	}
+
+	tmp_ctx.mcba_map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+							   "regmap-mcba");
+	if (IS_ERR(tmp_ctx.mcba_map)) {
+		dev_err(&pdev->dev, "unable to get syscon regmap mcba\n");
+		rc = PTR_ERR(tmp_ctx.mcba_map);
+		goto err_group;
+	}
+
+	tmp_ctx.mcbb_map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+							   "regmap-mcbb");
+	if (IS_ERR(tmp_ctx.mcbb_map)) {
+		dev_err(&pdev->dev, "unable to get syscon regmap mcbb\n");
+		rc = PTR_ERR(tmp_ctx.mcbb_map);
+		goto err_group;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	tmp_ctx.mcu_csr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(tmp_ctx.mcu_csr)) {
+		dev_err(&pdev->dev, "no MCU resource address\n");
+		rc = PTR_ERR(tmp_ctx.mcu_csr);
+		goto err_group;
+	}
+	/* Ignore non-active MCU */
+	tmp_ctx.mcu_id = ((res->start >> 16) & 0xF) / 4;
+	if (!xgene_edac_mc_is_active(&tmp_ctx, tmp_ctx.mcu_id)) {
+		rc = -ENODEV;
+		goto err_group;
+	}
+
+	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
+	layers[0].size = 4;
+	layers[0].is_virt_csrow = true;
+	layers[1].type = EDAC_MC_LAYER_CHANNEL;
+	layers[1].size = 2;
+	layers[1].is_virt_csrow = false;
+	mci = edac_mc_alloc(edac_mc_idx++, ARRAY_SIZE(layers), layers,
+			    sizeof(*ctx));
+	if (!mci) {
+		rc = -ENOMEM;
+		goto err_group;
+	}
+
+	ctx = mci->pvt_info;
+	*ctx = tmp_ctx;		/* Copy over resource value */
+	ctx->name = "xgene_edac_mc_err";
+	mci->pdev = &pdev->dev;
+	dev_set_drvdata(mci->pdev, mci);
+	mci->ctl_name = ctx->name;
+	mci->dev_name = ctx->name;
+
+	mci->mtype_cap = MEM_FLAG_RDDR | MEM_FLAG_RDDR2 | MEM_FLAG_RDDR3 |
+			 MEM_FLAG_DDR | MEM_FLAG_DDR2 | MEM_FLAG_DDR3;
+	mci->edac_ctl_cap = EDAC_FLAG_SECDED;
+	mci->edac_cap = EDAC_FLAG_SECDED;
+	mci->mod_name = EDAC_MOD_STR;
+	mci->mod_ver = "0.1";
+	mci->ctl_page_to_phys = NULL;
+	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
+	mci->scrub_mode = SCRUB_HW_SRC;
+
+	if (edac_op_state == EDAC_OPSTATE_POLL)
+		mci->edac_check = xgene_edac_mc_check;
+
+	if (edac_mc_add_mc(mci)) {
+		dev_err(&pdev->dev, "edac_mc_add_mc failed\n");
+		rc = -EINVAL;
+		goto err_free;
+	}
+
+	xgene_edac_mc_create_debugfs_node(mci);
+
+	if (edac_op_state == EDAC_OPSTATE_INT) {
+		int irq;
+		int i;
+
+		for (i = 0; i < 2; i++) {
+			irq = platform_get_irq(pdev, i);
+			if (irq < 0) {
+				dev_err(&pdev->dev, "No IRQ resource\n");
+				rc = -EINVAL;
+				goto err_del;
+			}
+			rc = devm_request_irq(&pdev->dev, irq,
+					      xgene_edac_mc_isr, IRQF_SHARED,
+					      dev_name(&pdev->dev), mci);
+			if (rc) {
+				dev_err(&pdev->dev,
+					"Could not request IRQ %d\n", irq);
+				goto err_del;
+			}
+		}
+	}
+
+	xgene_edac_mc_irq_ctl(mci, true);
+
+	devres_remove_group(&pdev->dev, xgene_edac_mc_probe);
+
+	dev_info(&pdev->dev, "X-Gene EDAC MC registered\n");
+	return 0;
+
+err_del:
+	edac_mc_del_mc(&pdev->dev);
+err_free:
+	edac_mc_free(mci);
+err_group:
+	devres_release_group(&pdev->dev, xgene_edac_mc_probe);
+	return rc;
+}
+
+static int xgene_edac_mc_remove(struct platform_device *pdev)
+{
+	struct mem_ctl_info *mci = dev_get_drvdata(&pdev->dev);
+
+	xgene_edac_mc_irq_ctl(mci, false);
+	edac_mc_del_mc(&pdev->dev);
+	edac_mc_free(mci);
+	return 0;
+}
+
+static struct of_device_id xgene_edac_mc_of_match[] = {
+	{ .compatible = "apm,xgene-edac-mc" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, xgene_edac_of_match);
+
+static struct platform_driver xgene_edac_mc_driver = {
+	.probe = xgene_edac_mc_probe,
+	.remove = xgene_edac_mc_remove,
+	.driver = {
+		.name = "xgene-edac-mc",
+		.owner = THIS_MODULE,
+		.of_match_table = xgene_edac_mc_of_match,
+	},
+};
+
+static int __init xgene_edac_init(void)
+{
+	int rc;
+
+	/* Make sure error reporting method is sane */
+	switch (edac_op_state) {
+	case EDAC_OPSTATE_POLL:
+	case EDAC_OPSTATE_INT:
+		break;
+	default:
+		edac_op_state = EDAC_OPSTATE_INT;
+		break;
+	}
+
+	rc = platform_driver_register(&xgene_edac_mc_driver);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_MOD_STR, "MCU fails to register\n");
+		goto reg_mc_failed;
+	}
+
+	return 0;
+
+reg_mc_failed:
+	return rc;
+}
+module_init(xgene_edac_init);
+
+static void __exit xgene_edac_exit(void)
+{
+	platform_driver_unregister(&xgene_edac_mc_driver);
+}
+module_exit(xgene_edac_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Feng Kan <fkan@apm.com>");
+MODULE_DESCRIPTION("APM X-Gene Memory Controller EDAC driver");
+module_param(edac_op_state, int, 0444);
+MODULE_PARM_DESC(edac_op_state,
+		 "EDAC Error Reporting state: 0=Poll, 2=Interrupt");
--
1.7.1
