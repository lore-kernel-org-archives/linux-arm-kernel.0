From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 2 Feb 2012 10:12:01 +0800
Subject: [PATCH v2 2/9] ARM: imx6q: add cko1 clock
In-Reply-To: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1328148728-32258-3-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- add DEF_CLK_1B to define clocks using one bit gate
- add cko1 clock and set ahb as the default parent

imx6q-sabrelite board use it as audio codec clock.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/mach-imx/clock-imx6q.c |   74 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 73 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx6q.c b/arch/arm/mach-imx/clock-imx6q.c
index 2d88f8b..111c328 100644
--- a/arch/arm/mach-imx/clock-imx6q.c
+++ b/arch/arm/mach-imx/clock-imx6q.c
@@ -329,6 +329,12 @@
 #define BM_CLPCR_MASK_SCU_IDLE		(0x1 << 26)
 #define BM_CLPCR_MASK_L2CC_IDLE		(0x1 << 27)
 
+#define BP_CCOSR_CKO1_EN		7
+#define BP_CCOSR_CKO1_PODF		4
+#define BM_CCOSR_CKO1_PODF		(0x7 << 4)
+#define BP_CCOSR_CKO1_SEL		0
+#define BM_CCOSR_CKO1_SEL		(0xf << 0)
+
 #define FREQ_480M	480000000
 #define FREQ_528M	528000000
 #define FREQ_594M	594000000
@@ -393,6 +399,7 @@ static struct clk ipu1_di1_clk;
 static struct clk ipu2_di0_clk;
 static struct clk ipu2_di1_clk;
 static struct clk enfc_clk;
+static struct clk cko1_clk;
 static struct clk dummy_clk = {};
 
 static unsigned long external_high_reference;
@@ -938,6 +945,24 @@ static void _clk_disable(struct clk *clk)
 	writel_relaxed(reg, clk->enable_reg);
 }
 
+static int _clk_enable_1b(struct clk *clk)
+{
+	u32 reg;
+	reg = readl_relaxed(clk->enable_reg);
+	reg |= 0x1 << clk->enable_shift;
+	writel_relaxed(reg, clk->enable_reg);
+
+	return 0;
+}
+
+static void _clk_disable_1b(struct clk *clk)
+{
+	u32 reg;
+	reg = readl_relaxed(clk->enable_reg);
+	reg &= ~(0x1 << clk->enable_shift);
+	writel_relaxed(reg, clk->enable_reg);
+}
+
 struct divider {
 	struct clk *clk;
 	void __iomem *reg;
@@ -983,6 +1008,7 @@ DEF_CLK_DIV1(ipu2_di0_pre_div,	&ipu2_di0_pre_clk,	CSCDR2,	IPU2_DI0_PRE);
 DEF_CLK_DIV1(ipu2_di1_pre_div,	&ipu2_di1_pre_clk,	CSCDR2,	IPU2_DI1_PRE);
 DEF_CLK_DIV1(ipu1_div,		&ipu1_clk,		CSCDR3,	IPU1_HSP);
 DEF_CLK_DIV1(ipu2_div,		&ipu2_clk,		CSCDR3,	IPU2_HSP);
+DEF_CLK_DIV1(cko1_div,		&cko1_clk,		CCOSR, CKO1);
 
 #define DEF_CLK_DIV2(d, c, r, b)				\
 	static struct divider d = {				\
@@ -1038,6 +1064,7 @@ static struct divider *dividers[] = {
 	&enfc_div,
 	&spdif_div,
 	&asrc_serial_div,
+	&cko1_div,
 };
 
 static unsigned long ldb_di_clk_get_rate(struct clk *clk)
@@ -1625,6 +1652,32 @@ DEF_IPU_DI_MUX(CSCDR2, 2, 1);
 DEF_IPU_MUX(1);
 DEF_IPU_MUX(2);
 
+static struct multiplexer cko1_mux = {
+	.clk = &cko1_clk,
+	.reg = CCOSR,
+	.bp = BP_CCOSR_CKO1_SEL,
+	.bm = BM_CCOSR_CKO1_SEL,
+	.parents = {
+		&pll3_usb_otg,
+		&pll2_bus,
+		&pll1_sys,
+		&pll5_video,
+		&dummy_clk,
+		&axi_clk,
+		&enfc_clk,
+		&ipu1_di0_clk,
+		&ipu1_di1_clk,
+		&ipu2_di0_clk,
+		&ipu2_di1_clk,
+		&ahb_clk,
+		&ipg_clk,
+		&ipg_perclk,
+		&ckil_clk,
+		&pll4_audio,
+		NULL
+	},
+};
+
 static struct multiplexer *multiplexers[] = {
 	&axi_mux,
 	&periph_mux,
@@ -1667,6 +1720,7 @@ static struct multiplexer *multiplexers[] = {
 	&ipu2_di1_mux,
 	&ipu1_mux,
 	&ipu2_mux,
+	&cko1_mux,
 };
 
 static int _clk_set_parent(struct clk *clk, struct clk *parent)
@@ -1690,7 +1744,7 @@ static int _clk_set_parent(struct clk *clk, struct clk *parent)
 			break;
 		i++;
 	}
-	if (!m->parents[i])
+	if (!m->parents[i] || m->parents[i] == &dummy_clk)
 		return -EINVAL;
 
 	val = readl_relaxed(m->reg);
@@ -1745,6 +1799,20 @@ DEF_NG_CLK(asrc_serial_clk,	&pll3_usb_otg);
 		.secondary	= s,			\
 	}
 
+#define DEF_CLK_1B(name, er, es, p, s)			\
+	static struct clk name = {			\
+		.enable_reg	= er,			\
+		.enable_shift	= es,			\
+		.enable		= _clk_enable_1b,	\
+		.disable	= _clk_disable_1b,	\
+		.get_rate	= _clk_get_rate,	\
+		.set_rate	= _clk_set_rate,	\
+		.round_rate	= _clk_round_rate,	\
+		.set_parent	= _clk_set_parent,	\
+		.parent		= p,			\
+		.secondary	= s,			\
+	}
+
 DEF_CLK(aips_tz1_clk,	  CCGR0, CG0,  &ahb_clk,	  NULL);
 DEF_CLK(aips_tz2_clk,	  CCGR0, CG1,  &ahb_clk,	  NULL);
 DEF_CLK(apbh_dma_clk,	  CCGR0, CG2,  &ahb_clk,	  NULL);
@@ -1811,6 +1879,7 @@ DEF_CLK(usdhc4_clk,	  CCGR6, CG4,  &pll2_pfd_400m,	  NULL);
 DEF_CLK(emi_slow_clk,	  CCGR6, CG5,  &axi_clk,	  NULL);
 DEF_CLK(vdo_axi_clk,	  CCGR6, CG6,  &axi_clk,	  NULL);
 DEF_CLK(vpu_clk,	  CCGR6, CG7,  &axi_clk,	  NULL);
+DEF_CLK_1B(cko1_clk,	  CCOSR, BP_CCOSR_CKO1_EN, &pll2_bus, NULL);
 
 static int pcie_clk_enable(struct clk *clk)
 {
@@ -1922,6 +1991,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "gpmi_io_clk", gpmi_io_clk),
 	_REGISTER_CLOCK(NULL, "usboh3_clk", usboh3_clk),
 	_REGISTER_CLOCK(NULL, "sata_clk", sata_clk),
+	_REGISTER_CLOCK(NULL, "cko1_clk", cko1_clk),
 };
 
 int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
@@ -2029,6 +2099,8 @@ int __init mx6q_clocks_init(void)
 	clk_set_rate(&usdhc3_clk, 49500000);
 	clk_set_rate(&usdhc4_clk, 49500000);
 
+	clk_set_parent(&cko1_clk, &ahb_clk);
+
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-gpt");
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
-- 
1.7.5.4
