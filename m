From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:51:16 +0200
Subject: [PATCH 40/40] ARM: mx5: clock-imx51: make *ipg clocks secondary
	clocks of their corresponding peripheral clocks
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-40-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Currently the uarts and timer only work because they are
turned on by reset default. Make them secondary clocks
of their corresponding peripheral clocks to make sure they
are turned on when necessary. Also, register some clocks
to get rid of compiler warnings

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/clock-mx51.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index 5c79011..e6c17d7 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -914,24 +914,24 @@ DEFINE_CLOCK(spba_clk, 0, MXC_CCM_CCGR5, MXC_CCM_CCGRx_CG0_OFFSET,
 	NULL,  NULL, &ipg_clk, NULL);
 
 /* UART */
-DEFINE_CLOCK(uart1_clk, 0, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG4_OFFSET,
-	NULL,  NULL, &uart_root_clk, NULL);
-DEFINE_CLOCK(uart2_clk, 1, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG6_OFFSET,
-	NULL,  NULL, &uart_root_clk, NULL);
-DEFINE_CLOCK(uart3_clk, 2, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG8_OFFSET,
-	NULL,  NULL, &uart_root_clk, NULL);
 DEFINE_CLOCK(uart1_ipg_clk, 0, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG3_OFFSET,
 	NULL,  NULL, &ipg_clk, &aips_tz1_clk);
 DEFINE_CLOCK(uart2_ipg_clk, 1, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG5_OFFSET,
 	NULL,  NULL, &ipg_clk, &aips_tz1_clk);
 DEFINE_CLOCK(uart3_ipg_clk, 2, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG7_OFFSET,
 	NULL,  NULL, &ipg_clk, &spba_clk);
+DEFINE_CLOCK(uart1_clk, 0, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG4_OFFSET,
+	NULL,  NULL, &uart_root_clk, &uart1_ipg_clk);
+DEFINE_CLOCK(uart2_clk, 1, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG6_OFFSET,
+	NULL,  NULL, &uart_root_clk, &uart2_ipg_clk);
+DEFINE_CLOCK(uart3_clk, 2, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG8_OFFSET,
+	NULL,  NULL, &uart_root_clk, &uart3_ipg_clk);
 
 /* GPT */
-DEFINE_CLOCK(gpt_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG9_OFFSET,
-	NULL,  NULL, &ipg_clk, NULL);
 DEFINE_CLOCK(gpt_ipg_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG10_OFFSET,
 	NULL,  NULL, &ipg_clk, NULL);
+DEFINE_CLOCK(gpt_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG9_OFFSET,
+	NULL,  NULL, &ipg_clk, &gpt_ipg_clk);
 
 /* I2C */
 DEFINE_CLOCK(i2c1_clk, 0, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG9_OFFSET,
@@ -1003,6 +1003,9 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxc_nand", NULL, nfc_clk)
 	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
 	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
+	_REGISTER_CLOCK(NULL, "ckih", ckih_clk)
+	_REGISTER_CLOCK(NULL, "ckih2", ckih2_clk)
+	_REGISTER_CLOCK(NULL, "gpt_32k", gpt_32k_clk)
 	_REGISTER_CLOCK("imx51-ecspi.0", NULL, ecspi1_clk)
 	_REGISTER_CLOCK("imx51-ecspi.1", NULL, ecspi2_clk)
 	_REGISTER_CLOCK("imx51-cspi.0", NULL, cspi_clk)
-- 
1.7.2.3
