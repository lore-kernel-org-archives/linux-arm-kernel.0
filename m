From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 22 Jan 2010 08:47:06 +0100
Subject: [PATCH 2/2] i.MX25: implement secondary clocks for uarts and fec
Message-ID: <mailman.161.1264147151.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For uarts and fec need two clocks, implement it using the secondary clock
field in struct clk.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx25/clock.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
index fbe42d2..3be51dd 100644
--- a/arch/arm/mach-mx25/clock.c
+++ b/arch/arm/mach-mx25/clock.c
@@ -157,14 +157,16 @@ static void clk_cgcr_disable(struct clk *clk)
 	}
 
 DEFINE_CLOCK(gpt_clk,    0, CCM_CGCR0,  5, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(uart_per_clk, 0, CCM_CGCR0, 15, get_rate_uart, NULL, NULL);
 DEFINE_CLOCK(cspi1_clk,  0, CCM_CGCR1,  5, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(cspi2_clk,  0, CCM_CGCR1,  6, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(cspi3_clk,  0, CCM_CGCR1,  7, get_rate_ipg, NULL, NULL);
-DEFINE_CLOCK(uart1_clk,  0, CCM_CGCR2, 14, get_rate_uart, NULL, NULL);
-DEFINE_CLOCK(uart2_clk,  0, CCM_CGCR2, 15, get_rate_uart, NULL, NULL);
-DEFINE_CLOCK(uart3_clk,  0, CCM_CGCR2, 16, get_rate_uart, NULL, NULL);
-DEFINE_CLOCK(uart4_clk,  0, CCM_CGCR2, 17, get_rate_uart, NULL, NULL);
-DEFINE_CLOCK(uart5_clk,  0, CCM_CGCR2, 18, get_rate_uart, NULL, NULL);
+DEFINE_CLOCK(fec_ipg_clk, 0, CCM_CGCR1, 15, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(uart1_clk,  0, CCM_CGCR2, 14, get_rate_uart, NULL, &uart_per_clk);
+DEFINE_CLOCK(uart2_clk,  0, CCM_CGCR2, 15, get_rate_uart, NULL, &uart_per_clk);
+DEFINE_CLOCK(uart3_clk,  0, CCM_CGCR2, 16, get_rate_uart, NULL, &uart_per_clk);
+DEFINE_CLOCK(uart4_clk,  0, CCM_CGCR2, 17, get_rate_uart, NULL, &uart_per_clk);
+DEFINE_CLOCK(uart5_clk,  0, CCM_CGCR2, 18, get_rate_uart, NULL, &uart_per_clk);
 DEFINE_CLOCK(nfc_clk,    0, CCM_CGCR0,  8, get_rate_nfc, NULL, NULL);
 DEFINE_CLOCK(usbotg_clk, 0, CCM_CGCR0, 28, get_rate_otg, NULL, NULL);
 DEFINE_CLOCK(pwm1_clk,	 0, CCM_CGCR1, 31, get_rate_ipg, NULL, NULL);
@@ -174,7 +176,7 @@ DEFINE_CLOCK(pwm4_clk,	 0, CCM_CGCR2,  2, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(kpp_clk,	 0, CCM_CGCR1, 28, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(tsc_clk,	 0, CCM_CGCR2, 13, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(i2c_clk,	 0, CCM_CGCR0,  6, get_rate_i2c, NULL, NULL);
-DEFINE_CLOCK(fec_clk,	 0, CCM_CGCR0, 23, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(fec_clk,	 0, CCM_CGCR0, 23, get_rate_ipg, NULL, &fec_ipg_clk);
 
 #define _REGISTER_CLOCK(d, n, c)	\
 	{				\
-- 
1.6.6

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
