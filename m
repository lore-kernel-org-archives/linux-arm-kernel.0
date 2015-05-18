From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Tue, 19 May 2015 02:45:02 +0800
Subject: [PATCH v10 1/4] ARM: clk: imx: update pllv3 to support imx7
In-Reply-To: <1431974705-14477-1-git-send-email-Frank.Li@freescale.com>
References: <1431974705-14477-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1431974705-14477-2-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

Add type IMX_PLLV3_ENET_IMX7

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 drivers/clk/imx/clk-pllv3.c | 9 ++++++++-
 drivers/clk/imx/clk.h       | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index 641ebc5..2de1060 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -24,12 +24,14 @@
 
 #define BM_PLL_POWER		(0x1 << 12)
 #define BM_PLL_LOCK		(0x1 << 31)
+#define IMX7_ENET_PLL_POWER	(0x1 << 5)
 
 /**
  * struct clk_pllv3 - IMX PLL clock version 3
  * @clk_hw:	 clock source
  * @base:	 base address of PLL registers
  * @powerup_set: set POWER bit to power up the PLL
+ * @powerdown:   pll powerdown offset bit
  * @div_mask:	 mask of divider bits
  * @div_shift:	 shift of divider bits
  *
@@ -40,6 +42,7 @@ struct clk_pllv3 {
 	struct clk_hw	hw;
 	void __iomem	*base;
 	bool		powerup_set;
+	u32		powerdown;
 	u32		div_mask;
 	u32		div_shift;
 };
@@ -49,7 +52,7 @@ struct clk_pllv3 {
 static int clk_pllv3_wait_lock(struct clk_pllv3 *pll)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(10);
-	u32 val = readl_relaxed(pll->base) & BM_PLL_POWER;
+	u32 val = readl_relaxed(pll->base) & pll->powerdown;
 
 	/* No need to wait for lock when pll is not powered up */
 	if ((pll->powerup_set && !val) || (!pll->powerup_set && val))
@@ -293,6 +296,8 @@ struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
 	if (!pll)
 		return ERR_PTR(-ENOMEM);
 
+	pll->powerdown = BM_PLL_POWER;
+
 	switch (type) {
 	case IMX_PLLV3_SYS:
 		ops = &clk_pllv3_sys_ops;
@@ -306,6 +311,8 @@ struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
 	case IMX_PLLV3_AV:
 		ops = &clk_pllv3_av_ops;
 		break;
+	case IMX_PLLV3_ENET_IMX7:
+		pll->powerdown = IMX7_ENET_PLL_POWER;
 	case IMX_PLLV3_ENET:
 		ops = &clk_pllv3_enet_ops;
 		break;
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 6bae537..8b11218 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -39,6 +39,7 @@ enum imx_pllv3_type {
 	IMX_PLLV3_USB_VF610,
 	IMX_PLLV3_AV,
 	IMX_PLLV3_ENET,
+	IMX_PLLV3_ENET_IMX7,
 };
 
 struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
-- 
1.9.1
