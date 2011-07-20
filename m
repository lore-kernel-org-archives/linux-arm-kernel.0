From: tony.lin@freescale.com (Tony Lin)
Date: Wed, 20 Jul 2011 19:08:22 +0800
Subject: [PATCH 3/7] add usb phy clocks to clock tree
In-Reply-To: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
References: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
Message-ID: <1311160106-4898-4-git-send-email-tony.lin@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tony Lin <tony.lin@freescale.com>
---
 arch/arm/mach-mxs/clock-mx28.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 5dcc59d..6fd0fe6 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -570,7 +570,23 @@ static struct clk usb1_clk = {
 	.disable = _raw_clk_disable,
 	.parent = &pll1_clk,
 };
+/* usb phy clock for usb0 */
+static struct clk usb_phy_clk0 = {
+	.parent = &pll0_clk,
+	.enable = _raw_clk_disable, /* EN_USB_CLKS = 1 means ON */
+	.disable = _raw_clk_enable,
+	.enable_reg = CLKCTRL_BASE_ADDR + HW_CLKCTRL_PLL0CTRL0,
+	.enable_shift = 18,
+};
 
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
@@ -629,6 +645,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("flexcan.1", NULL, can1_clk)
 	_REGISTER_CLOCK(NULL, "usb0", usb0_clk)
 	_REGISTER_CLOCK(NULL, "usb1", usb1_clk)
+	_REGISTER_CLOCK(NULL, "usb0_phy", usb_phy_clk0)
+	_REGISTER_CLOCK(NULL, "usb1_phy", usb_phy_clk1)
 	_REGISTER_CLOCK("mxs-pwm.0", NULL, pwm_clk)
 	_REGISTER_CLOCK("mxs-pwm.1", NULL, pwm_clk)
 	_REGISTER_CLOCK("mxs-pwm.2", NULL, pwm_clk)
-- 
1.7.0.4
