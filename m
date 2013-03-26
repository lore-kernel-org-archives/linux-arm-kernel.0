From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 26 Mar 2013 12:38:05 -0700
Subject: [PATCH] ARM: imx: replace width with mask for clk_busy_mux
Message-ID: <1364326685-8545-1-git-send-email-mturquette@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recent addition of table-based parent lookups[1] in the common
clk_mux implementation removed the width member of struct clk_mux and
replaced it with an arbitrary mask.  This broke compilation for i.MX
platforms using clk_busy_mux which builds upon the common clk_mux.

Fixed by populating the mask member during clk_busy_mux registration
instead of the now non-existent width member.

[1] http://article.gmane.org/gmane.linux.ports.tegra/10028

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Mike Turquette <mturquette@linaro.org>
---
 arch/arm/mach-imx/clk-busy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-busy.c b/arch/arm/mach-imx/clk-busy.c
index 1ab91b5..85b728c 100644
--- a/arch/arm/mach-imx/clk-busy.c
+++ b/arch/arm/mach-imx/clk-busy.c
@@ -169,7 +169,7 @@ struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
 
 	busy->mux.reg = reg;
 	busy->mux.shift = shift;
-	busy->mux.width = width;
+	busy->mux.mask = BIT(width) - 1;
 	busy->mux.lock = &imx_ccm_lock;
 	busy->mux_ops = &clk_mux_ops;
 
-- 
1.7.10.4
