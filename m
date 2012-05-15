From: marex@denx.de (Marek Vasut)
Date: Tue, 15 May 2012 10:23:33 +0200
Subject: [PATCH 2/8] MXS: Add USB EHCI and USB PHY clock handling
In-Reply-To: <1337070219-3630-1-git-send-email-marex@denx.de>
References: <1337070219-3630-1-git-send-email-marex@denx.de>
Message-ID: <1337070219-3630-3-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on code by:
Tony Lin <tony.lin@freescale.com>

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chen Peter-B29397 <B29397@freescale.com>
Cc: Detlev Zundel <dzu@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Li Frank-B20596 <B20596@freescale.com>
Cc: Linux USB <linux-usb@vger.kernel.org>
Cc: Liu JunJie-B08287 <B08287@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Shi Make-B15407 <B15407@freescale.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Subodh Nijsure <snijsure@grid-net.com>
Cc: Wolfgang Denk <wd@denx.de>
---
 arch/arm/mach-mxs/clock-mx28.c |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 43116ba..60ebe99 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -577,6 +577,21 @@ static struct clk usb1_clk = {
 	.parent = &pll1_clk,
 };
 
+static struct clk usb_phy_clk0 = {
+	.parent = &pll0_clk,
+	.enable = _raw_clk_disable,
+	.disable = _raw_clk_enable,
+	.enable_reg = CLKCTRL_BASE_ADDR + HW_CLKCTRL_PLL0CTRL0,
+	.enable_shift = 18,
+};
+
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
@@ -636,8 +651,10 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxs-mmc.3", NULL, ssp3_clk)
 	_REGISTER_CLOCK("flexcan.0", NULL, can0_clk)
 	_REGISTER_CLOCK("flexcan.1", NULL, can1_clk)
-	_REGISTER_CLOCK(NULL, "usb0", usb0_clk)
-	_REGISTER_CLOCK(NULL, "usb1", usb1_clk)
+	_REGISTER_CLOCK("mxs-usb.0", "usb", usb0_clk)
+	_REGISTER_CLOCK("mxs-usb.1", "usb", usb1_clk)
+	_REGISTER_CLOCK("mxs-usb-phy.0", "phy", usb_phy_clk0)
+	_REGISTER_CLOCK("mxs-usb-phy.1", "phy", usb_phy_clk1)
 	_REGISTER_CLOCK("mxs-pwm.0", NULL, pwm_clk)
 	_REGISTER_CLOCK("mxs-pwm.1", NULL, pwm_clk)
 	_REGISTER_CLOCK("mxs-pwm.2", NULL, pwm_clk)
-- 
1.7.10
