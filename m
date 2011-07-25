From: tony.lin@freescale.com (Tony Lin)
Date: Mon, 25 Jul 2011 15:01:21 +0800
Subject: [PATCH v2 3/6] ARM: mxs: add usb clocks to clock tree
In-Reply-To: <1311577284-11506-1-git-send-email-tony.lin@freescale.com>
References: <1311577284-11506-1-git-send-email-tony.lin@freescale.com>
Message-ID: <1311577284-11506-4-git-send-email-tony.lin@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add usb host clock and usb host phy clock to clock tree
add usb dummy clocks to clock tree to get rid of adding
more cpu_is_mx macros

Signed-off-by: Tony Lin <tony.lin@freescale.com>
---
 arch/arm/mach-mxs/clock-mx28.c |   28 +++++++++++++++++++---------
 1 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 5dcc59d..6f3cd40 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -554,15 +554,15 @@ static struct clk rtc_clk = {
 	.parent = &ref_xtal_clk,
 };
 
-/* usb_clk gate is controlled in DIGCTRL other than CLKCTRL */
-static struct clk usb0_clk = {
-	.enable_reg = DIGCTRL_BASE_ADDR,
-	.enable_shift = 2,
-	.enable = _raw_clk_enable,
-	.disable = _raw_clk_disable,
-	.parent = &pll0_clk,
+static struct clk dummy_clk = {
+	.enable_reg = 0,
+	.enable_shift = 0,
+	.enable = NULL,
+	.disable = NULL,
+	.parent = NULL,
 };
 
+/* usb_clk gate is controlled in DIGCTRL other than CLKCTRL */
 static struct clk usb1_clk = {
 	.enable_reg = DIGCTRL_BASE_ADDR,
 	.enable_shift = 16,
@@ -571,6 +571,14 @@ static struct clk usb1_clk = {
 	.parent = &pll1_clk,
 };
 
+/* usb phy clock for usb1 */
+static struct clk usb_phy_clk1 = {
+	.parent = &pll1_clk,
+	.enable = _raw_clk_disable,
+	.disable = _raw_clk_enable,
+	.enable_reg = CLKCTRL_BASE_ADDR + HW_CLKCTRL_PLL1CTRL0,
+	.enable_shift = 18,
+};
 #define _DEFINE_CLOCK(name, er, es, p)					\
 	static struct clk name = {					\
 		.enable_reg	= CLKCTRL_BASE_ADDR + HW_CLKCTRL_##er,	\
@@ -627,8 +635,10 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxs-mmc.1", NULL, ssp1_clk)
 	_REGISTER_CLOCK("flexcan.0", NULL, can0_clk)
 	_REGISTER_CLOCK("flexcan.1", NULL, can1_clk)
-	_REGISTER_CLOCK(NULL, "usb0", usb0_clk)
-	_REGISTER_CLOCK(NULL, "usb1", usb1_clk)
+	_REGISTER_CLOCK("mxc-ehci", "usb1", usb1_clk)
+	_REGISTER_CLOCK("mxc-ehci", "usb1_phy", usb_phy_clk1)
+	_REGISTER_CLOCK("mxc-ehci", "usb", dummy_clk)
+	_REGISTER_CLOCK("mxc-ehci", "usb_ahb", dummy_clk)
 	_REGISTER_CLOCK("mxs-pwm.0", NULL, pwm_clk)
 	_REGISTER_CLOCK("mxs-pwm.1", NULL, pwm_clk)
 	_REGISTER_CLOCK("mxs-pwm.2", NULL, pwm_clk)
-- 
1.7.0.4
