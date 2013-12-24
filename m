From: b20788@freescale.com (Anson Huang)
Date: Tue, 24 Dec 2013 14:05:38 -0500
Subject: [PATCH] ARM: imx: add necessary interface for pfd
Message-ID: <1387911938-4828-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Common clk framework will disable unused clks in late init only if
they are enabled by default and no one is using it, so we need to
add is_enabled callback for clk framework to get clks' status.

PFD clocks are enabled by hardware reset, so we need to add
interface for common clk framework to disable those unused ones for
saving power.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/mach-imx/clk-pfd.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-imx/clk-pfd.c b/arch/arm/mach-imx/clk-pfd.c
index e2ed416..0b0f6f6 100644
--- a/arch/arm/mach-imx/clk-pfd.c
+++ b/arch/arm/mach-imx/clk-pfd.c
@@ -109,12 +109,23 @@ static int clk_pfd_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
+static int clk_pfd_is_enabled(struct clk_hw *hw)
+{
+	struct clk_pfd *pfd = to_clk_pfd(hw);
+
+	if (readl_relaxed(pfd->reg) & (1 << ((pfd->idx + 1) * 8 - 1)))
+		return 0;
+
+	return 1;
+}
+
 static const struct clk_ops clk_pfd_ops = {
 	.enable		= clk_pfd_enable,
 	.disable	= clk_pfd_disable,
 	.recalc_rate	= clk_pfd_recalc_rate,
 	.round_rate	= clk_pfd_round_rate,
 	.set_rate	= clk_pfd_set_rate,
+	.is_enabled     = clk_pfd_is_enabled,
 };
 
 struct clk *imx_clk_pfd(const char *name, const char *parent_name,
-- 
1.7.9.5
