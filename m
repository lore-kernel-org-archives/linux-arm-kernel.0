From: weiyi.lu@mediatek.com (Weiyi Lu)
Date: Tue, 6 Nov 2018 14:41:58 +0800
Subject: [PATCH v1 03/11] clk: mediatek: Disable tuner_en before change PLL
 rate
In-Reply-To: <20181106064206.17535-1-weiyi.lu@mediatek.com>
References: <20181106064206.17535-1-weiyi.lu@mediatek.com>
Message-ID: <20181106064206.17535-5-weiyi.lu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Owen Chen <owen.chen@mediatek.com>

PLLs with tuner_en bit, such as APLL1, need to disable
tuner_en before apply new frequency settings, or the new frequency
settings (pcw) will not be applied.
The tuner_en bit will be disabled during changing PLL rate
and be restored after new settings applied.

Signed-off-by: Owen Chen <owen.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-pll.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 0ec2c62d9383..cca9002de91b 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -27,7 +27,7 @@
 #define CON0_BASE_EN		BIT(0)
 #define CON0_PWR_ON		BIT(0)
 #define CON0_ISO_EN		BIT(1)
-#define CON0_PCW_CHG		BIT(31)
+#define CON1_PCW_CHG		BIT(31)
 
 #define AUDPLL_TUNER_EN		BIT(31)
 
@@ -95,9 +95,31 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
 {
 	u32 con1, val;
 	int pll_en;
+	u32 tuner_en = 0;
+	u32 tuner_en_mask;
+	void __iomem *tuner_en_addr = NULL;
 
 	pll_en = readl(pll->base_addr + REG_CON0) & CON0_BASE_EN;
 
+	/* disable tuner */
+	if (pll->tuner_en_addr) {
+		tuner_en_addr = pll->tuner_en_addr;
+		tuner_en_mask = BIT(pll->data->tuner_en_bit);
+	} else if (pll->tuner_addr) {
+		tuner_en_addr = pll->tuner_addr;
+		tuner_en_mask = AUDPLL_TUNER_EN;
+	}
+
+	if (tuner_en_addr) {
+		val = readl(tuner_en_addr);
+		tuner_en = val & tuner_en_mask;
+
+		if (tuner_en) {
+			val &= ~tuner_en_mask;
+			writel(val, tuner_en_addr);
+		}
+	}
+
 	/* set postdiv */
 	val = readl(pll->pd_addr);
 	val &= ~(POSTDIV_MASK << pll->data->pd_shift);
@@ -118,12 +140,19 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
 	con1 = readl(pll->base_addr + REG_CON1);
 
 	if (pll_en)
-		con1 |= CON0_PCW_CHG;
+		con1 |= CON1_PCW_CHG;
 
 	writel(con1, pll->base_addr + REG_CON1);
 	if (pll->tuner_addr)
 		writel(con1 + 1, pll->tuner_addr);
 
+	/* restore tuner_en */
+	if (tuner_en_addr && tuner_en) {
+		val = readl(tuner_en_addr);
+		val |= tuner_en_mask;
+		writel(val, tuner_en_addr);
+	}
+
 	if (pll_en)
 		udelay(20);
 }
-- 
2.18.0
