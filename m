From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 26 Apr 2015 22:31:10 +0800
Subject: [PATCH 09/11] ARM: imx: remove inclusions of platform headers
In-Reply-To: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
References: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1430058672-9267-10-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the cleanup done before, we now can simply define base address and
irq as needed in clock driver, to get those platform header inclusions
removed.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/clk-imx1.c        |  7 +++++--
 arch/arm/mach-imx/clk-imx21.c       |  7 +++++--
 arch/arm/mach-imx/clk-imx25.c       |  2 --
 arch/arm/mach-imx/clk-imx27.c       |  8 ++++++--
 arch/arm/mach-imx/clk-imx31.c       | 21 +++++++++++++++++----
 arch/arm/mach-imx/clk-imx35.c       | 20 +++++++++++++++++---
 arch/arm/mach-imx/clk-imx51-imx53.c |  3 +--
 arch/arm/mach-imx/clk-imx6q.c       |  3 +--
 arch/arm/mach-imx/clk-imx6sl.c      |  1 -
 arch/arm/mach-imx/clk-imx6sx.c      |  1 -
 arch/arm/mach-imx/clk-pllv1.c       |  2 --
 arch/arm/mach-imx/clk.h             |  7 +++++++
 12 files changed, 59 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx1.c b/arch/arm/mach-imx/clk-imx1.c
index 9e68351bb72c..c9812dbacac2 100644
--- a/arch/arm/mach-imx/clk-imx1.c
+++ b/arch/arm/mach-imx/clk-imx1.c
@@ -23,10 +23,13 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <dt-bindings/clock/imx1-clock.h>
+#include <asm/irq.h>
 
 #include "clk.h"
-#include "common.h"
-#include "hardware.h"
+
+#define MX1_CCM_BASE_ADDR	0x0021b000
+#define MX1_TIM1_BASE_ADDR	0x00220000
+#define MX1_TIM1_INT		(NR_IRQS_LEGACY + 59)
 
 static const char *prem_sel_clks[] = { "clk32_premult", "clk16m", };
 static const char *clko_sel_clks[] = { "per1", "hclk", "clk48m", "clk16m",
diff --git a/arch/arm/mach-imx/clk-imx21.c b/arch/arm/mach-imx/clk-imx21.c
index bc4254dd40a1..0ca842cf4ca7 100644
--- a/arch/arm/mach-imx/clk-imx21.c
+++ b/arch/arm/mach-imx/clk-imx21.c
@@ -15,10 +15,13 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <dt-bindings/clock/imx21-clock.h>
+#include <asm/irq.h>
 
 #include "clk.h"
-#include "common.h"
-#include "hardware.h"
+
+#define MX21_CCM_BASE_ADDR	0x10027000
+#define MX21_GPT1_BASE_ADDR	0x10003000
+#define MX21_INT_GPT1		(NR_IRQS_LEGACY + 26)
 
 static void __iomem *ccm __initdata;
 
diff --git a/arch/arm/mach-imx/clk-imx25.c b/arch/arm/mach-imx/clk-imx25.c
index 485d090d2267..ec1a4c1dacf1 100644
--- a/arch/arm/mach-imx/clk-imx25.c
+++ b/arch/arm/mach-imx/clk-imx25.c
@@ -28,8 +28,6 @@
 #include <linux/of_irq.h>
 
 #include "clk.h"
-#include "common.h"
-#include "hardware.h"
 
 #define CCM_MPCTL	0x00
 #define CCM_UPCTL	0x04
diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index 530af09c6bc7..df2dfc081c71 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -5,10 +5,14 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <dt-bindings/clock/imx27-clock.h>
+#include <soc/imx/revision.h>
+#include <asm/irq.h>
 
 #include "clk.h"
-#include "common.h"
-#include "hardware.h"
+
+#define MX27_CCM_BASE_ADDR	0x10027000
+#define MX27_GPT1_BASE_ADDR	0x10003000
+#define MX27_INT_GPT1		(NR_IRQS_LEGACY + 26)
 
 static void __iomem *ccm __initdata;
 
diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
index caa26ec32152..a55290c1c264 100644
--- a/arch/arm/mach-imx/clk-imx31.c
+++ b/arch/arm/mach-imx/clk-imx31.c
@@ -21,12 +21,25 @@
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/of.h>
+#include <soc/imx/revision.h>
+#include <asm/irq.h>
 
 #include "clk.h"
-#include "common.h"
-#include "crmregs-imx3.h"
-#include "hardware.h"
-#include "mx31.h"
+
+#define MX31_CCM_BASE_ADDR	0x53f80000
+#define MX31_GPT1_BASE_ADDR	0x53f90000
+#define MX31_INT_GPT		(NR_IRQS_LEGACY + 29)
+
+#define MXC_CCM_CCMR		0x00
+#define MXC_CCM_PDR0		0x04
+#define MXC_CCM_PDR1		0x08
+#define MXC_CCM_MPCTL		0x10
+#define MXC_CCM_UPCTL		0x14
+#define MXC_CCM_SRPCTL		0x18
+#define MXC_CCM_CGR0		0x20
+#define MXC_CCM_CGR1		0x24
+#define MXC_CCM_CGR2		0x28
+#define MXC_CCM_PMCR0		0x5c
 
 static const char *mcu_main_sel[] = { "spll", "mpll", };
 static const char *per_sel[] = { "per_div", "ipg", };
diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
index f53d2b502479..bb0a39158f04 100644
--- a/arch/arm/mach-imx/clk-imx35.c
+++ b/arch/arm/mach-imx/clk-imx35.c
@@ -13,11 +13,25 @@
 #include <linux/clkdev.h>
 #include <linux/of.h>
 #include <linux/err.h>
+#include <soc/imx/revision.h>
+#include <asm/irq.h>
 
-#include "crmregs-imx3.h"
 #include "clk.h"
-#include "common.h"
-#include "hardware.h"
+
+#define MX35_CCM_BASE_ADDR	0x53f80000
+#define MX35_GPT1_BASE_ADDR	0x53f90000
+#define MX35_INT_GPT		(NR_IRQS_LEGACY + 29)
+
+#define MXC_CCM_PDR0		0x04
+#define MX35_CCM_PDR2		0x0c
+#define MX35_CCM_PDR3		0x10
+#define MX35_CCM_PDR4		0x14
+#define MX35_CCM_MPCTL		0x1c
+#define MX35_CCM_PPCTL		0x20
+#define MX35_CCM_CGR0		0x2c
+#define MX35_CCM_CGR1		0x30
+#define MX35_CCM_CGR2		0x34
+#define MX35_CCM_CGR3		0x38
 
 struct arm_ahb_div {
 	unsigned char arm, ahb, sel;
diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index f341464fe7e9..a7e4f394be0d 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -16,11 +16,10 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <soc/imx/revision.h>
 #include <dt-bindings/clock/imx5-clock.h>
 
 #include "clk.h"
-#include "common.h"
-#include "hardware.h"
 
 #define MX51_DPLL1_BASE		0x83f80000
 #define MX51_DPLL2_BASE		0x83f84000
diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index d0135c62d21a..128f8871cbd8 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -19,11 +19,10 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <soc/imx/revision.h>
 #include <dt-bindings/clock/imx6qdl-clock.h>
 
 #include "clk.h"
-#include "common.h"
-#include "hardware.h"
 
 static const char *step_sels[]	= { "osc", "pll2_pfd2_396m", };
 static const char *pll1_sw_sels[]	= { "pll1_sys", "step", };
diff --git a/arch/arm/mach-imx/clk-imx6sl.c b/arch/arm/mach-imx/clk-imx6sl.c
index 3aef26464110..a0d4cf26cfa9 100644
--- a/arch/arm/mach-imx/clk-imx6sl.c
+++ b/arch/arm/mach-imx/clk-imx6sl.c
@@ -16,7 +16,6 @@
 #include <dt-bindings/clock/imx6sl-clock.h>
 
 #include "clk.h"
-#include "common.h"
 
 #define CCSR			0xc
 #define BM_CCSR_PLL1_SW_CLK_SEL	(1 << 2)
diff --git a/arch/arm/mach-imx/clk-imx6sx.c b/arch/arm/mach-imx/clk-imx6sx.c
index 151460a95130..bf04ad5056d4 100644
--- a/arch/arm/mach-imx/clk-imx6sx.c
+++ b/arch/arm/mach-imx/clk-imx6sx.c
@@ -21,7 +21,6 @@
 #include <linux/types.h>
 
 #include "clk.h"
-#include "common.h"
 
 #define CCDR    0x4
 #define BM_CCM_CCDR_MMDC_CH0_MASK       (0x2 << 16)
diff --git a/arch/arm/mach-imx/clk-pllv1.c b/arch/arm/mach-imx/clk-pllv1.c
index 4e1cb9f39a29..c34ad8a611dd 100644
--- a/arch/arm/mach-imx/clk-pllv1.c
+++ b/arch/arm/mach-imx/clk-pllv1.c
@@ -6,8 +6,6 @@
 #include <linux/err.h>
 
 #include "clk.h"
-#include "common.h"
-#include "hardware.h"
 
 /**
  * pll v1
diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
index b5297e457a8e..6bae5374dc83 100644
--- a/arch/arm/mach-imx/clk.h
+++ b/arch/arm/mach-imx/clk.h
@@ -6,6 +6,13 @@
 
 extern spinlock_t imx_ccm_lock;
 
+/*
+ * This is a stop-gap solution for clock drivers like imx1/imx21 which call
+ * mxc_timer_init() to initialize timer for non-DT boot.  It can be removed
+ * when these legacy non-DT support is converted or dropped.
+ */
+void mxc_timer_init(unsigned long pbase, int irq);
+
 void imx_check_clocks(struct clk *clks[], unsigned int count);
 
 extern void imx_cscmr1_fixup(u32 *val);
-- 
1.9.1
