From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 29 Jan 2013 10:14:53 -0200
Subject: [PATCH] ARM: imx: clk-imx27: Do not register peripheral clock for SSI
Message-ID: <1359461693-27483-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>>

imx ssi block has two types of clocks:
    
- ipg: bus clock, the clock needed for accessing registers.
- per: peripheral clock, the clock needed for generating the bit rate.

Currently ssi driver only supports slave mode and thus need only to handle
the ipg clock, because the peripheral clock comes from the master codec.

Only register the ipg clock and do not register the peripheral clock for ssi

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/clk-imx27.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index 1ffe3b534..303d7bd 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -274,8 +274,6 @@ int __init mx27_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[scc_ipg_gate], "scc", NULL);
 	clk_register_clkdev(clk[cpu_div], "cpu", NULL);
 	clk_register_clkdev(clk[emi_ahb_gate], "emi_ahb" , NULL);
-	clk_register_clkdev(clk[ssi1_baud_gate], "bitrate" , "imx-ssi.0");
-	clk_register_clkdev(clk[ssi2_baud_gate], "bitrate" , "imx-ssi.1");
 
 	mxc_timer_init(MX27_IO_ADDRESS(MX27_GPT1_BASE_ADDR), MX27_INT_GPT1);
 
-- 
1.7.9.5
