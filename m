From: b32955@freescale.com (Huang Shijie)
Date: Mon, 10 Sep 2012 15:17:56 +0800
Subject: [PATCH] ARM:IMX6Q:use pll2_pfd2_396m as the enfc_sel's parent
Message-ID: <1347261476-9799-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpmi-nand driver can support the ONFI nand chip's EDO (extra data out)
mode in the asynchrounous mode. In the asynchrounous mode 5, the gpmi
needs 100MHz clock for the IO. But with the pll2_pfd0_352m, we can not
get the 100MHz clock.

So choose pll2_pfd2_396m as enfc_sel's parent.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/mach-imx/clk-imx6q.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 4233d9e..58705b6 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -440,6 +440,13 @@ int __init mx6q_clocks_init(void)
 	clk_register_clkdev(clk[ahb], "ahb", NULL);
 	clk_register_clkdev(clk[cko1], "cko1", NULL);
 
+	/*
+	 * The gpmi needs 100MHz frequency in the EDO/Sync mode,
+	 * We can not get the 100MHz from the pll2_pfd0_352m.
+	 * So choose pll2_pfd2_396m as enfc_sel's parent.
+	 */
+	clk_set_parent(clk[enfc_sel], clk[pll2_pfd2_396m]);
+
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
 		clk_prepare_enable(clk[clks_init_on[i]]);
 
-- 
1.7.0.4
