From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 12 Nov 2009 11:41:57 +0100
Subject: [PATCH 1/9] MXC NFC: Add the clock resource to support NFC in i.MX35
In-Reply-To: <1258022525-21078-1-git-send-email-s.hauer@pengutronix.de>
References: <1258022525-21078-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1258022525-21078-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Juergen Beisert <jbe@pengutronix.de>

Signed-off-by: Juergen Beisert <j.beisert@pengutronix.de>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/clock-imx35.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
index fe5c421..63be4a7 100644
--- a/arch/arm/mach-mx3/clock-imx35.c
+++ b/arch/arm/mach-mx3/clock-imx35.c
@@ -387,6 +387,35 @@ DEFINE_CLOCK(csi_clk,    0, CCM_CGR3,  0, get_rate_csi, NULL);
 DEFINE_CLOCK(iim_clk,    0, CCM_CGR3,  2, NULL, NULL);
 DEFINE_CLOCK(gpu2d_clk,  0, CCM_CGR3,  4, NULL, NULL);
 
+static int clk_dummy_enable(struct clk *clk)
+{
+	return 0;
+}
+
+static void clk_dummy_disable(struct clk *clk)
+{
+}
+
+static unsigned long get_rate_nfc(struct clk *clk)
+{
+	unsigned long div1;
+
+	div1 = (__raw_readl(CCM_BASE + CCM_PDR4) >> 28) + 1;
+
+	return get_rate_ahb(NULL) / div1;
+}
+
+/* NAND Controller: It seems it can't be disabled */
+static struct clk nfc_clk = {
+	.id		= 0,
+	.enable_reg	= 0,
+	.enable_shift	= 0,
+	.get_rate	= get_rate_nfc,
+	.set_rate	= NULL, /* set_rate_nfc, */
+	.enable		= clk_dummy_enable,
+	.disable	= clk_dummy_disable
+};
+
 #define _REGISTER_CLOCK(d, n, c)	\
 	{				\
 		.dev_id = d,		\
@@ -449,6 +478,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "csi", csi_clk)
 	_REGISTER_CLOCK(NULL, "iim", iim_clk)
 	_REGISTER_CLOCK(NULL, "gpu2d", gpu2d_clk)
+	_REGISTER_CLOCK("mxc_nand.0", NULL, nfc_clk)
 };
 
 int __init mx35_clocks_init()
-- 
1.6.5.2
