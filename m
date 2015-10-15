From: jonmason@broadcom.com (Jon Mason)
Date: Thu, 15 Oct 2015 15:48:26 -0400
Subject: [PATCH v3 03/10] clk: iproc: Add PWRCTRL support
In-Reply-To: <1444938513-10758-1-git-send-email-jonmason@broadcom.com>
References: <1444938513-10758-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1444938513-10758-4-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some iProc SoC clocks use a different way to control clock power, via
the PWRDWN bit in the PLL control register.  Since the PLL control
register is used to access the PWRDWN bit, there is no need for the
pwr_base when this is being used.  A new flag, IPROC_CLK_EMBED_PWRCTRL,
has been added to identify this usage.  We can use the AON interface to
write the values to enable/disable PWRDOWN.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 drivers/clk/bcm/clk-iproc-pll.c | 55 ++++++++++++++++++++++++++++-------------
 drivers/clk/bcm/clk-iproc.h     |  6 +++++
 2 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/bcm/clk-iproc-pll.c b/drivers/clk/bcm/clk-iproc-pll.c
index 2dda4e8..e029ab3 100644
--- a/drivers/clk/bcm/clk-iproc-pll.c
+++ b/drivers/clk/bcm/clk-iproc-pll.c
@@ -148,14 +148,25 @@ static void __pll_disable(struct iproc_pll *pll)
 		writel(val, pll->asiu_base + ctrl->asiu.offset);
 	}
 
-	/* latch input value so core power can be shut down */
-	val = readl(pll->pwr_base + ctrl->aon.offset);
-	val |= (1 << ctrl->aon.iso_shift);
-	writel(val, pll->pwr_base + ctrl->aon.offset);
-
-	/* power down the core */
-	val &= ~(bit_mask(ctrl->aon.pwr_width) << ctrl->aon.pwr_shift);
-	writel(val, pll->pwr_base + ctrl->aon.offset);
+	if (ctrl->flags & IPROC_CLK_EMBED_PWRCTRL) {
+		val = readl(pll->pll_base + ctrl->aon.offset);
+		val |= (bit_mask(ctrl->aon.pwr_width) << ctrl->aon.pwr_shift);
+		writel(val, pll->pll_base + ctrl->aon.offset);
+
+		if (unlikely(ctrl->flags & IPROC_CLK_NEEDS_READ_BACK))
+			readl(pll->pll_base + ctrl->aon.offset);
+	}
+
+	if (pll->pwr_base) {
+		/* latch input value so core power can be shut down */
+		val = readl(pll->pwr_base + ctrl->aon.offset);
+		val |= (1 << ctrl->aon.iso_shift);
+		writel(val, pll->pwr_base + ctrl->aon.offset);
+
+		/* power down the core */
+		val &= ~(bit_mask(ctrl->aon.pwr_width) << ctrl->aon.pwr_shift);
+		writel(val, pll->pwr_base + ctrl->aon.offset);
+	}
 }
 
 static int __pll_enable(struct iproc_pll *pll)
@@ -163,11 +174,22 @@ static int __pll_enable(struct iproc_pll *pll)
 	const struct iproc_pll_ctrl *ctrl = pll->ctrl;
 	u32 val;
 
-	/* power up the PLL and make sure it's not latched */
-	val = readl(pll->pwr_base + ctrl->aon.offset);
-	val |= bit_mask(ctrl->aon.pwr_width) << ctrl->aon.pwr_shift;
-	val &= ~(1 << ctrl->aon.iso_shift);
-	writel(val, pll->pwr_base + ctrl->aon.offset);
+	if (ctrl->flags & IPROC_CLK_EMBED_PWRCTRL) {
+		val = readl(pll->pll_base + ctrl->aon.offset);
+		val &= ~(bit_mask(ctrl->aon.pwr_width) << ctrl->aon.pwr_shift);
+		writel(val, pll->pll_base + ctrl->aon.offset);
+
+		if (unlikely(ctrl->flags & IPROC_CLK_NEEDS_READ_BACK))
+			readl(pll->pll_base + ctrl->aon.offset);
+	}
+
+	if (pll->pwr_base) {
+		/* power up the PLL and make sure it's not latched */
+		val = readl(pll->pwr_base + ctrl->aon.offset);
+		val |= bit_mask(ctrl->aon.pwr_width) << ctrl->aon.pwr_shift;
+		val &= ~(1 << ctrl->aon.iso_shift);
+		writel(val, pll->pwr_base + ctrl->aon.offset);
+	}
 
 	/* certain PLLs also need to be ungated from the ASIU top level */
 	if (ctrl->flags & IPROC_CLK_PLL_ASIU) {
@@ -610,9 +632,8 @@ void __init iproc_pll_clk_setup(struct device_node *node,
 	if (WARN_ON(!pll->pll_base))
 		goto err_pll_iomap;
 
+	/* Some SoCs do not require the pwr_base, thus failing is not fatal */
 	pll->pwr_base = of_iomap(node, 1);
-	if (WARN_ON(!pll->pwr_base))
-		goto err_pwr_iomap;
 
 	/* some PLLs require gating control at the top ASIU level */
 	if (pll_ctrl->flags & IPROC_CLK_PLL_ASIU) {
@@ -695,9 +716,9 @@ err_pll_register:
 		iounmap(pll->asiu_base);
 
 err_asiu_iomap:
-	iounmap(pll->pwr_base);
+	if (pll->pwr_base)
+		iounmap(pll->pwr_base);
 
-err_pwr_iomap:
 	iounmap(pll->pll_base);
 
 err_pll_iomap:
diff --git a/drivers/clk/bcm/clk-iproc.h b/drivers/clk/bcm/clk-iproc.h
index d834b7a..ff7bfad 100644
--- a/drivers/clk/bcm/clk-iproc.h
+++ b/drivers/clk/bcm/clk-iproc.h
@@ -49,6 +49,12 @@
 #define IPROC_CLK_PLL_NEEDS_SW_CFG BIT(4)
 
 /*
+ * Some PLLs use a different way to control clock power, via the PWRDWN bit in
+ * the PLL control register
+ */
+#define IPROC_CLK_EMBED_PWRCTRL BIT(5)
+
+/*
  * Parameters for VCO frequency configuration
  *
  * VCO frequency =
-- 
1.9.1
