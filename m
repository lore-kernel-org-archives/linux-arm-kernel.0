From: vzapolskiy@gmail.com (Vladimir Zapolskiy)
Date: Wed, 24 Mar 2010 14:32:16 +0300
Subject: [PATCH 1/3] imx31: fix parent clock for rtc
Message-ID: <1269430338-22690-1-git-send-email-vzapolskiy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to imx31 reference manual the signal from external low
frequency clock is sent to RTC clock.
The patch makes redundant the previously defined mxc_rtc clock.

Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-mx3/clock-imx31.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx3/clock-imx31.c b/arch/arm/mach-mx3/clock-imx31.c
index 80dba99..9a9eb6d 100644
--- a/arch/arm/mach-mx3/clock-imx31.c
+++ b/arch/arm/mach-mx3/clock-imx31.c
@@ -468,6 +468,7 @@ static struct clk ahb_clk = {
 	}
 
 DEFINE_CLOCK(perclk_clk,  0, NULL,          0, NULL, NULL, &ipg_clk);
+DEFINE_CLOCK(ckil_clk,    0, NULL,          0, clk_ckil_get_rate, NULL, NULL);
 
 DEFINE_CLOCK(sdhc1_clk,   0, MXC_CCM_CGR0,  0, NULL, NULL, &perclk_clk);
 DEFINE_CLOCK(sdhc2_clk,   1, MXC_CCM_CGR0,  2, NULL, NULL, &perclk_clk);
@@ -490,7 +491,7 @@ DEFINE_CLOCK(mpeg4_clk,   0, MXC_CCM_CGR1,  0, NULL, NULL, &ahb_clk);
 DEFINE_CLOCK(mstick1_clk, 0, MXC_CCM_CGR1,  2, mstick1_get_rate, NULL, &usb_pll_clk);
 DEFINE_CLOCK(mstick2_clk, 1, MXC_CCM_CGR1,  4, mstick2_get_rate, NULL, &usb_pll_clk);
 DEFINE_CLOCK1(csi_clk,    0, MXC_CCM_CGR1,  6, csi, NULL, &serial_pll_clk);
-DEFINE_CLOCK(rtc_clk,     0, MXC_CCM_CGR1,  8, NULL, NULL, &ipg_clk);
+DEFINE_CLOCK(rtc_clk,     0, MXC_CCM_CGR1,  8, NULL, NULL, &ckil_clk);
 DEFINE_CLOCK(wdog_clk,    0, MXC_CCM_CGR1, 10, NULL, NULL, &ipg_clk);
 DEFINE_CLOCK(pwm_clk,     0, MXC_CCM_CGR1, 12, NULL, NULL, &perclk_clk);
 DEFINE_CLOCK(usb_clk2,    0, MXC_CCM_CGR1, 18, usb_get_rate, NULL, &ahb_clk);
@@ -514,7 +515,6 @@ DEFINE_CLOCK(usb_clk1,    0, NULL,          0, usb_get_rate, NULL, &usb_pll_clk)
 DEFINE_CLOCK(nfc_clk,     0, NULL,          0, nfc_get_rate, NULL, &ahb_clk);
 DEFINE_CLOCK(scc_clk,     0, NULL,          0, NULL, NULL, &ipg_clk);
 DEFINE_CLOCK(ipg_clk,     0, NULL,          0, ipg_get_rate, NULL, &ahb_clk);
-DEFINE_CLOCK(ckil_clk,    0, NULL,          0, clk_ckil_get_rate, NULL, NULL);
 
 #define _REGISTER_CLOCK(d, n, c) \
 	{ \
@@ -572,7 +572,6 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "iim", iim_clk)
 	_REGISTER_CLOCK(NULL, "mpeg4", mpeg4_clk)
 	_REGISTER_CLOCK(NULL, "mbx", mbx_clk)
-	_REGISTER_CLOCK("mxc_rtc", NULL, ckil_clk)
 };
 
 int __init mx31_clocks_init(unsigned long fref)
-- 
1.6.6.1
