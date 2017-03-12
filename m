From: kernel@esmil.dk (Emil Renner Berthing)
Date: Sun, 12 Mar 2017 11:56:33 +0100
Subject: [PATCH] ARM: imx5x: register SOC device
Message-ID: <20170312105633.21168-1-kernel@esmil.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I noticed that imx_soc_device_init has support for
(almost) all imx SOCs, but it seems like it is only
used by imx6 and higher. Is there any reason for that?

I've tested this on imx50 (kindle 4) and imx51 (Hercules eCAFE),
but I don't have an imx53 to test this on.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 arch/arm/mach-imx/cpu.c           |  3 +++
 arch/arm/mach-imx/mach-imx50.c    | 18 ++++++++++++++++++
 arch/arm/mach-imx/mach-imx51.c    |  7 +++++++
 arch/arm/mach-imx/mach-imx53.c    |  7 +++++++
 arch/arm/mach-imx/mxc.h           |  1 +
 drivers/clk/imx/clk-imx51-imx53.c | 13 +++++++++++--
 include/soc/imx/revision.h        |  1 +
 7 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index b3347d32349f..fba4eb7048d3 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -110,6 +110,9 @@ struct device * __init imx_soc_device_init(void)
 	case MXC_CPU_MX35:
 		soc_id = "i.MX35";
 		break;
+	case MXC_CPU_MX50:
+		soc_id = "i.MX50";
+		break;
 	case MXC_CPU_MX51:
 		soc_id = "i.MX51";
 		break;
diff --git a/arch/arm/mach-imx/mach-imx50.c b/arch/arm/mach-imx/mach-imx50.c
index 4cab5f61260f..9194c5739c98 100644
--- a/arch/arm/mach-imx/mach-imx50.c
+++ b/arch/arm/mach-imx/mach-imx50.c
@@ -15,6 +15,22 @@
 #include <asm/mach/arch.h>
 
 #include "common.h"
+#include "hardware.h"
+
+static void __init imx50_init_early(void)
+{
+	mxc_set_cpu_type(MXC_CPU_MX50);
+}
+
+static void __init imx50_init_machine(void)
+{
+	struct device *parent = imx_soc_device_init();
+
+	if (!parent)
+		pr_warn("failed to initialize soc device\n");
+
+	of_platform_default_populate(NULL, NULL, parent);
+}
 
 static const char * const imx50_dt_board_compat[] __initconst = {
 	"fsl,imx50",
@@ -22,5 +38,7 @@ static const char * const imx50_dt_board_compat[] __initconst = {
 };
 
 DT_MACHINE_START(IMX50_DT, "Freescale i.MX50 (Device Tree Support)")
+	.init_early	= imx50_init_early,
+	.init_machine	= imx50_init_machine,
 	.dt_compat	= imx50_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-imx51.c b/arch/arm/mach-imx/mach-imx51.c
index 3835b6a3423c..7204c561b39e 100644
--- a/arch/arm/mach-imx/mach-imx51.c
+++ b/arch/arm/mach-imx/mach-imx51.c
@@ -50,6 +50,13 @@ static void __init imx51_ipu_mipi_setup(void)
 
 static void __init imx51_dt_init(void)
 {
+	struct device *parent = imx_soc_device_init();
+
+	if (!parent)
+		pr_warn("failed to initialize soc device\n");
+
+	of_platform_default_populate(NULL, NULL, parent);
+
 	imx51_ipu_mipi_setup();
 	imx_src_init();
 
diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 07c2e8dca494..12f51ebcf92e 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -30,6 +30,13 @@ static void __init imx53_init_early(void)
 
 static void __init imx53_dt_init(void)
 {
+	struct device *parent = imx_soc_device_init();
+
+	if (!parent)
+		pr_warn("failed to initialize soc device\n");
+
+	of_platform_default_populate(NULL, NULL, parent);
+
 	imx_src_init();
 
 	imx_aips_allow_unprivileged_access("fsl,imx53-aipstz");
diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index 34f2ff62583c..e3972e936cad 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -32,6 +32,7 @@
 #define MXC_CPU_MX27		27
 #define MXC_CPU_MX31		31
 #define MXC_CPU_MX35		35
+#define MXC_CPU_MX50		50
 #define MXC_CPU_MX51		51
 #define MXC_CPU_MX53		53
 #define MXC_CPU_IMX6SL		0x60
diff --git a/drivers/clk/imx/clk-imx51-imx53.c b/drivers/clk/imx/clk-imx51-imx53.c
index 1e3c9ea5f9dc..f9b00f025cc0 100644
--- a/drivers/clk/imx/clk-imx51-imx53.c
+++ b/drivers/clk/imx/clk-imx51-imx53.c
@@ -383,6 +383,7 @@ static void __init mx50_clocks_init(struct device_node *np)
 	clk_set_rate(clk[IMX5_CLK_ESDHC_B_PODF], 200000000);
 
 	clk_prepare_enable(clk[IMX5_CLK_IIM_GATE]);
+	imx_set_soc_revision(IMX_CHIP_REVISION_1_1);
 	imx_print_silicon_rev("i.MX50", IMX_CHIP_REVISION_1_1);
 	clk_disable_unprepare(clk[IMX5_CLK_IIM_GATE]);
 
@@ -396,6 +397,7 @@ static void __init mx51_clocks_init(struct device_node *np)
 	void __iomem *ccm_base;
 	void __iomem *pll_base;
 	u32 val;
+	int rev;
 
 	pll_base = ioremap(MX51_DPLL1_BASE, SZ_16K);
 	WARN_ON(!pll_base);
@@ -460,7 +462,10 @@ static void __init mx51_clocks_init(struct device_node *np)
 	clk_set_rate(clk[IMX5_CLK_ESDHC_B_PODF], 166250000);
 
 	clk_prepare_enable(clk[IMX5_CLK_IIM_GATE]);
-	imx_print_silicon_rev("i.MX51", mx51_revision());
+	rev = mx51_revision();
+	if (rev != IMX_CHIP_REVISION_UNKNOWN)
+		imx_set_soc_revision(rev);
+	imx_print_silicon_rev("i.MX51", rev);
 	clk_disable_unprepare(clk[IMX5_CLK_IIM_GATE]);
 
 	/*
@@ -485,6 +490,7 @@ static void __init mx53_clocks_init(struct device_node *np)
 	void __iomem *ccm_base;
 	void __iomem *pll_base;
 	unsigned long r;
+	int rev;
 
 	pll_base = ioremap(MX53_DPLL1_BASE, SZ_16K);
 	WARN_ON(!pll_base);
@@ -597,7 +603,10 @@ static void __init mx53_clocks_init(struct device_node *np)
 	clk_set_parent(clk[IMX5_CLK_STEP_SEL], clk[IMX5_CLK_LP_APM]);
 
 	clk_prepare_enable(clk[IMX5_CLK_IIM_GATE]);
-	imx_print_silicon_rev("i.MX53", mx53_revision());
+	rev = mx53_revision();
+	if (rev != IMX_CHIP_REVISION_UNKNOWN)
+		imx_set_soc_revision(rev);
+	imx_print_silicon_rev("i.MX53", rev);
 	clk_disable_unprepare(clk[IMX5_CLK_IIM_GATE]);
 
 	r = clk_round_rate(clk[IMX5_CLK_USBOH3_PER_GATE], 54000000);
diff --git a/include/soc/imx/revision.h b/include/soc/imx/revision.h
index 9ea346924c35..778eea7eb747 100644
--- a/include/soc/imx/revision.h
+++ b/include/soc/imx/revision.h
@@ -31,6 +31,7 @@ int mx35_revision(void);
 int mx51_revision(void);
 int mx53_revision(void);
 
+void imx_set_soc_revision(unsigned int rev);
 unsigned int imx_get_soc_revision(void);
 void imx_print_silicon_rev(const char *cpu, int srev);
 
-- 
2.12.0
