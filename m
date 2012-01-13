From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 13 Jan 2012 14:38:39 +0800
Subject: [PATCH] ARM: imx6: add missing twd_clk for imx6q clock
Message-ID: <1326436719-16343-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With commit 5def51b (ARM: 7211/1: smp_twd: get the rate from a clock)
hitting mainline, if we do not have a twd_clk for lookup, we will see
the following error message in boot log.

 smp_twd: clock not found: -2

Actually we should add this clock regardless of the error message,
so that we can:

 * Avoid the local timer calibrating at boot time
 * Make the local timer cpufreq aware on imx6q

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/clock-imx6q.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx6q.c b/arch/arm/mach-imx/clock-imx6q.c
index 9273c2a..2d88f8b 100644
--- a/arch/arm/mach-imx/clock-imx6q.c
+++ b/arch/arm/mach-imx/clock-imx6q.c
@@ -814,6 +814,16 @@ DEF_PFD(pll3_pfd_540m, PFD_480, PFD1, &pll3_usb_otg);
 DEF_PFD(pll3_pfd_508m, PFD_480, PFD2, &pll3_usb_otg);
 DEF_PFD(pll3_pfd_454m, PFD_480, PFD3, &pll3_usb_otg);
 
+static unsigned long twd_clk_get_rate(struct clk *clk)
+{
+	return clk_get_rate(clk->parent) / 2;
+}
+
+static struct clk twd_clk = {
+	.parent = &arm_clk,
+	.get_rate = twd_clk_get_rate,
+};
+
 static unsigned long pll2_200m_get_rate(struct clk *clk)
 {
 	return clk_get_rate(clk->parent) / 2;
@@ -1894,6 +1904,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("20ec000.sdma", NULL, sdma_clk),
 	_REGISTER_CLOCK("20bc000.wdog", NULL, dummy_clk),
 	_REGISTER_CLOCK("20c0000.wdog", NULL, dummy_clk),
+	_REGISTER_CLOCK("smp_twd", NULL, twd_clk),
 	_REGISTER_CLOCK(NULL, "ckih", ckih_clk),
 	_REGISTER_CLOCK(NULL, "ckil_clk", ckil_clk),
 	_REGISTER_CLOCK(NULL, "aips_tz1_clk", aips_tz1_clk),
-- 
1.7.4.1
