From: b20788@freescale.com (Anson Huang)
Date: Tue, 24 Dec 2013 14:21:27 -0500
Subject: [PATCH] ARM: imx: improve status check of clock gate
Message-ID: <1387912887-6402-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For ccm clock gate, both 2b'11 and 2b'01 should be treated
as clock enabled, see below description in CCM, whenver CPU
trys to check clock gate's status, system will be in run mode.

2b'00: clock is off during all modes;
2b'01: clock is on in run mode, but off in wait and stop mode;
2b'10: Not applicable;
2b'11: clock is on during all modes, except stop mode.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/mach-imx/clk-gate2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-gate2.c b/arch/arm/mach-imx/clk-gate2.c
index a63e415..a2ecc00 100644
--- a/arch/arm/mach-imx/clk-gate2.c
+++ b/arch/arm/mach-imx/clk-gate2.c
@@ -72,7 +72,7 @@ static int clk_gate2_is_enabled(struct clk_hw *hw)
 
 	reg = readl(gate->reg);
 
-	if (((reg >> gate->bit_idx) & 3) == 3)
+	if (((reg >> gate->bit_idx) & 1) == 1)
 		return 1;
 
 	return 0;
-- 
1.7.9.5
