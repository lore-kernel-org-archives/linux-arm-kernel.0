From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 2 Aug 2012 23:01:51 +0800
Subject: [PATCH 1/2] ARM: imx: enable emi_slow_gate clock for imx5
Message-ID: <1343919712-6240-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx5 common clock migration causes a regression with smsc911x
driver on imx53-ard board, where a smsc lan9220 controller gets
connected on imx53 with EIM interface.  EIM needs clock emi_slow_gate
to be functional.  In the new imx5 clock driver, there is no use count
incremented for the clock by enabling it, so the framework closes the
clock at late init time and makes EIM stop working then.

Enable emi_slow_gate in clock driver initialization to fix the
regression.

Cc: stable at vger.kernel.org
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/clk-imx51-imx53.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index f608669..6eee32a 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -303,6 +303,7 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 	clk_prepare_enable(clk[aips_tz2]); /* fec */
 	clk_prepare_enable(clk[spba]);
 	clk_prepare_enable(clk[emi_fast_gate]); /* fec */
+	clk_prepare_enable(clk[emi_slow_gate]);
 	clk_prepare_enable(clk[tmax1]);
 	clk_prepare_enable(clk[tmax2]); /* esdhc2, fec */
 	clk_prepare_enable(clk[tmax3]); /* esdhc1, esdhc4 */
-- 
1.7.5.4
