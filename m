From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  6 Aug 2010 16:02:17 +0200
Subject: [PATCH 1/2] ARM i.MX51: Add Nand clock support
In-Reply-To: <1281103338-19423-1-git-send-email-s.hauer@pengutronix.de>
References: <1281103338-19423-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1281103338-19423-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx5/clock-mx51.c |   98 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 98 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index 6af69de..9a05f0d 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -571,6 +571,64 @@ static int _clk_uart_set_parent(struct clk *clk, struct clk *parent)
 	return 0;
 }
 
+#define clk_nfc_set_parent	NULL
+
+static unsigned long clk_nfc_get_rate(struct clk *clk)
+{
+	unsigned long rate;
+	u32 reg, div;
+
+	reg = __raw_readl(MXC_CCM_CBCDR);
+	div = ((reg & MXC_CCM_CBCDR_NFC_PODF_MASK) >>
+	       MXC_CCM_CBCDR_NFC_PODF_OFFSET) + 1;
+	rate = clk_get_rate(clk->parent) / div;
+	WARN_ON(rate == 0);
+	return rate;
+}
+
+static unsigned long clk_nfc_round_rate(struct clk *clk,
+						unsigned long rate)
+{
+	u32 div;
+	unsigned long parent_rate = clk_get_rate(clk->parent);
+
+	if (!rate)
+		return -EINVAL;
+
+	div = parent_rate / rate;
+
+	if (parent_rate % rate)
+		div++;
+
+	if (div > 8)
+		return -EINVAL;
+
+	return parent_rate / div;
+
+}
+
+static int clk_nfc_set_rate(struct clk *clk, unsigned long rate)
+{
+	u32 reg, div;
+
+	div = clk_get_rate(clk->parent) / rate;
+	if (div == 0)
+		div++;
+	if (((clk_get_rate(clk->parent) / div) != rate) || (div > 8))
+		return -EINVAL;
+
+	reg = __raw_readl(MXC_CCM_CBCDR);
+	reg &= ~MXC_CCM_CBCDR_NFC_PODF_MASK;
+	reg |= (div - 1) << MXC_CCM_CBCDR_NFC_PODF_OFFSET;
+	__raw_writel(reg, MXC_CCM_CBCDR);
+
+	while (__raw_readl(MXC_CCM_CDHIPR) &
+			MXC_CCM_CDHIPR_NFC_IPG_INT_MEM_PODF_BUSY){
+	}
+
+	return 0;
+}
+
 static unsigned long clk_usboh3_get_rate(struct clk *clk)
 {
 	u32 reg, prediv, podf;
@@ -620,6 +678,17 @@ static unsigned long get_ckih2_reference_clock_rate(struct clk *clk)
 	return ckih2_reference;
 }
 
+static unsigned long clk_emi_slow_get_rate(struct clk *clk)
+{
+	u32 reg, div;
+
+	reg = __raw_readl(MXC_CCM_CBCDR);
+	div = ((reg & MXC_CCM_CBCDR_EMI_PODF_MASK) >>
+	       MXC_CCM_CBCDR_EMI_PODF_OFFSET) + 1;
+
+	return clk_get_rate(clk->parent) / div;
+}
+
 /* External high frequency clock */
 static struct clk ckih_clk = {
 	.get_rate = get_high_reference_clock_rate,
@@ -762,6 +831,15 @@ static struct clk kpp_clk = {
 	.id = 0,
 };
 
+static struct clk emi_slow_clk = {
+	.parent = &pll2_sw_clk,
+	.enable_reg = MXC_CCM_CCGR5,
+	.enable_shift = MXC_CCM_CCGRx_CG8_OFFSET,
+	.enable = _clk_ccgr_enable,
+	.disable = _clk_ccgr_disable_inwait,
+	.get_rate = clk_emi_slow_get_rate,
+};
+
 #define DEFINE_CLOCK(name, i, er, es, gr, sr, p, s)	\
 	static struct clk name = {			\
 		.id		= i,			\
@@ -775,6 +853,21 @@ static struct clk kpp_clk = {
 		.secondary	= s,			\
 	}
 
+#define DEFINE_CLOCK1(name, i, er, es, pfx, p, s)	\
+	static struct clk name = {			\
+		.id		= i,			\
+		.enable_reg	= er,			\
+		.enable_shift	= es,			\
+		.get_rate	= pfx##_get_rate,	\
+		.set_rate	= pfx##_set_rate,	\
+		.round_rate	= pfx##_round_rate,	\
+		.set_parent	= pfx##_set_parent,	\
+		.enable		= _clk_ccgr_enable,	\
+		.disable	= _clk_ccgr_disable,	\
+		.parent		= p,			\
+		.secondary	= s,			\
+	}
+
 /* DEFINE_CLOCK(name, id, enable_reg, enable_shift,
    get_rate, set_rate, parent, secondary); */
 
@@ -814,6 +907,10 @@ DEFINE_CLOCK(hsi2c_clk, 0, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG11_OFFSET,
 DEFINE_CLOCK(fec_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG12_OFFSET,
 	NULL,  NULL, &ipg_clk, NULL);
 
+/* NFC */
+DEFINE_CLOCK1(nfc_clk, 0, MXC_CCM_CCGR5, MXC_CCM_CCGRx_CG10_OFFSET,
+	clk_nfc, &emi_slow_clk, NULL);
+
 #define _REGISTER_CLOCK(d, n, c) \
        { \
 		.dev_id = d, \
@@ -837,6 +934,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usboh3_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", ahb_clk)
 	_REGISTER_CLOCK("imx-keypad.0", NULL, kpp_clk)
+	_REGISTER_CLOCK("mxc_nand", NULL, nfc_clk)
 };
 
 static void clk_tree_init(void)
-- 
1.7.1
