From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 29 Aug 2014 13:43:38 +0200
Subject: [PATCH 2/4] clk: mvebu: armada-370: Fix timer drift caused by the
 SSCG deviation
In-Reply-To: <1409312620-20631-1-git-send-email-gregory.clement@free-electrons.com>
References: <1409312620-20631-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1409312620-20631-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit activates the SSCG deviation correction for the Armada
370. It uses the optional function introduced by the commit "clk:
mvebu: Fix clk frequency value if SSCG is enabled".

Without this fix the deviation measured on a Mirabox was of a few
second each hour, whereas with this fix it was reduced at around
50ppm (around 4s per day).

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/clk/mvebu/armada-370.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/mvebu/armada-370.c b/drivers/clk/mvebu/armada-370.c
index bef198a83863..b084a84d8fad 100644
--- a/drivers/clk/mvebu/armada-370.c
+++ b/drivers/clk/mvebu/armada-370.c
@@ -23,6 +23,7 @@
  */
 
 #define SARL				0	/* Low part [0:31] */
+#define	 SARL_A370_SSCG_ENABLE		BIT(10)
 #define	 SARL_A370_PCLK_FREQ_OPT	11
 #define	 SARL_A370_PCLK_FREQ_OPT_MASK	0xF
 #define	 SARL_A370_FAB_FREQ_OPT		15
@@ -133,10 +134,16 @@ static void __init a370_get_clk_ratio(
 	}
 }
 
+bool a370_is_sscg_enabled(void __iomem *sar)
+{
+	return !(readl(sar) & SARL_A370_SSCG_ENABLE);
+}
+
 static const struct coreclk_soc_desc a370_coreclks = {
 	.get_tclk_freq = a370_get_tclk_freq,
 	.get_cpu_freq = a370_get_cpu_freq,
 	.get_clk_ratio = a370_get_clk_ratio,
+	.is_sscg_enabled = a370_is_sscg_enabled,
 	.ratios = a370_coreclk_ratios,
 	.num_ratios = ARRAY_SIZE(a370_coreclk_ratios),
 };
-- 
1.9.1
