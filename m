From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat,  2 May 2015 13:24:33 +0200
Subject: [PATCH 2/8] clk: sunxi: factors: Add a parameter for N and M zeros
In-Reply-To: <1430565879-28113-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1430565879-28113-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1430565879-28113-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some clocks, N and M set to 0 in the register actually mean a value of
'1', but any other value doesn't have that shift anymore.

Add parameters to the factors clock to handle this.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-factors.c | 6 ++++++
 drivers/clk/sunxi/clk-factors.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
index 100a711c3e3d..632926a13c26 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -69,6 +69,12 @@ static unsigned long clk_factors_recalc_rate(struct clk_hw *hw,
 	if (config->pwidth != SUNXI_FACTORS_NOT_APPLICABLE)
 		p = FACTOR_GET(config->pshift, config->pwidth, reg);
 
+	if (!n && config->n_zero)
+		n = config->n_zero;
+
+	if (!m && config->m_zero)
+		m = config->m_zero;
+
 	/* Calculate the rate */
 	rate = parent_rate * (n + config->n_start);
 	rate *= k + 1;
diff --git a/drivers/clk/sunxi/clk-factors.h b/drivers/clk/sunxi/clk-factors.h
index 735d756d2923..fb182d9ccde6 100644
--- a/drivers/clk/sunxi/clk-factors.h
+++ b/drivers/clk/sunxi/clk-factors.h
@@ -19,6 +19,9 @@ struct clk_factors_config {
 
 	u8 m_start;
 	u8 n_start;
+
+	u8 n_zero;
+	u8 m_zero;
 };
 
 struct factors_data {
-- 
2.3.6
