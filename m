From: xiechao.mail@gmail.com (Chao Xie)
Date: Mon, 27 Aug 2012 10:54:02 +0800
Subject: [PATCH 4/5] arm: mmp: move mmp2 clock definition to separated file
In-Reply-To: <1346036043-20115-1-git-send-email-xiechao.mail@gmail.com>
References: <1346036043-20115-1-git-send-email-xiechao.mail@gmail.com>
Message-ID: <1346036043-20115-4-git-send-email-xiechao.mail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

move mmp2 clock definition to another file. Then mmp2 can
choose common clock framework or private clock framework.

Signed-off-by: Chao Xie <xiechao.mail@gmail.com>
---
 arch/arm/mach-mmp/Makefile     |    1 +
 arch/arm/mach-mmp/clock-mmp2.c |  111 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mmp/common.h     |    1 +
 arch/arm/mach-mmp/mmp2.c       |   71 ++------------------------
 4 files changed, 118 insertions(+), 66 deletions(-)
 create mode 100644 arch/arm/mach-mmp/clock-mmp2.c

diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index ac0e885..095c155 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -13,6 +13,7 @@ ifeq ($(CONFIG_COMMON_CLK), )
 obj-y				+= clock.o
 obj-$(CONFIG_CPU_PXA168)	+= clock-pxa168.o
 obj-$(CONFIG_CPU_PXA910)	+= clock-pxa910.o
+obj-$(CONFIG_CPU_MMP2)		+= clock-mmp2.o
 endif
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_CPU_PXA910)	+= pm-pxa910.o
diff --git a/arch/arm/mach-mmp/clock-mmp2.c b/arch/arm/mach-mmp/clock-mmp2.c
new file mode 100644
index 0000000..21d2200
--- /dev/null
+++ b/arch/arm/mach-mmp/clock-mmp2.c
@@ -0,0 +1,111 @@
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+
+#include <mach/addr-map.h>
+
+#include "common.h"
+#include "clock.h"
+
+/*
+ * APB Clock register offsets for MMP2
+ */
+#define APBC_RTC	APBC_REG(0x000)
+#define APBC_TWSI1	APBC_REG(0x004)
+#define APBC_TWSI2	APBC_REG(0x008)
+#define APBC_TWSI3	APBC_REG(0x00c)
+#define APBC_TWSI4	APBC_REG(0x010)
+#define APBC_KPC	APBC_REG(0x018)
+#define APBC_UART1	APBC_REG(0x02c)
+#define APBC_UART2	APBC_REG(0x030)
+#define APBC_UART3	APBC_REG(0x034)
+#define APBC_GPIO	APBC_REG(0x038)
+#define APBC_PWM0	APBC_REG(0x03c)
+#define APBC_PWM1	APBC_REG(0x040)
+#define APBC_PWM2	APBC_REG(0x044)
+#define APBC_PWM3	APBC_REG(0x048)
+#define APBC_SSP0	APBC_REG(0x04c)
+#define APBC_SSP1	APBC_REG(0x050)
+#define APBC_SSP2	APBC_REG(0x054)
+#define APBC_SSP3	APBC_REG(0x058)
+#define APBC_SSP4	APBC_REG(0x05c)
+#define APBC_SSP5	APBC_REG(0x060)
+#define APBC_TWSI5	APBC_REG(0x07c)
+#define APBC_TWSI6	APBC_REG(0x080)
+#define APBC_UART4	APBC_REG(0x088)
+
+#define APMU_USB	APMU_REG(0x05c)
+#define APMU_NAND	APMU_REG(0x060)
+#define APMU_SDH0	APMU_REG(0x054)
+#define APMU_SDH1	APMU_REG(0x058)
+#define APMU_SDH2	APMU_REG(0x0e8)
+#define APMU_SDH3	APMU_REG(0x0ec)
+
+static void sdhc_clk_enable(struct clk *clk)
+{
+	uint32_t clk_rst;
+
+	clk_rst  =  __raw_readl(clk->clk_rst);
+	clk_rst |= clk->enable_val;
+	__raw_writel(clk_rst, clk->clk_rst);
+}
+
+static void sdhc_clk_disable(struct clk *clk)
+{
+	uint32_t clk_rst;
+
+	clk_rst  =  __raw_readl(clk->clk_rst);
+	clk_rst &= ~clk->enable_val;
+	__raw_writel(clk_rst, clk->clk_rst);
+}
+
+struct clkops sdhc_clk_ops = {
+	.enable		= sdhc_clk_enable,
+	.disable	= sdhc_clk_disable,
+};
+
+/* APB peripheral clocks */
+static APBC_CLK(uart1, UART1, 1, 26000000);
+static APBC_CLK(uart2, UART2, 1, 26000000);
+static APBC_CLK(uart3, UART3, 1, 26000000);
+static APBC_CLK(uart4, UART4, 1, 26000000);
+static APBC_CLK(twsi1, TWSI1, 0, 26000000);
+static APBC_CLK(twsi2, TWSI2, 0, 26000000);
+static APBC_CLK(twsi3, TWSI3, 0, 26000000);
+static APBC_CLK(twsi4, TWSI4, 0, 26000000);
+static APBC_CLK(twsi5, TWSI5, 0, 26000000);
+static APBC_CLK(twsi6, TWSI6, 0, 26000000);
+static APBC_CLK(gpio, GPIO, 0, 26000000);
+
+static APMU_CLK(nand, NAND, 0xbf, 100000000);
+static APMU_CLK_OPS(sdh0, SDH0, 0x1b, 200000000, &sdhc_clk_ops);
+static APMU_CLK_OPS(sdh1, SDH1, 0x1b, 200000000, &sdhc_clk_ops);
+static APMU_CLK_OPS(sdh2, SDH2, 0x1b, 200000000, &sdhc_clk_ops);
+static APMU_CLK_OPS(sdh3, SDH3, 0x1b, 200000000, &sdhc_clk_ops);
+
+static struct clk_lookup mmp2_clkregs[] = {
+	INIT_CLKREG(&clk_uart1, "pxa2xx-uart.0", NULL),
+	INIT_CLKREG(&clk_uart2, "pxa2xx-uart.1", NULL),
+	INIT_CLKREG(&clk_uart3, "pxa2xx-uart.2", NULL),
+	INIT_CLKREG(&clk_uart4, "pxa2xx-uart.3", NULL),
+	INIT_CLKREG(&clk_twsi1, "pxa2xx-i2c.0", NULL),
+	INIT_CLKREG(&clk_twsi2, "pxa2xx-i2c.1", NULL),
+	INIT_CLKREG(&clk_twsi3, "pxa2xx-i2c.2", NULL),
+	INIT_CLKREG(&clk_twsi4, "pxa2xx-i2c.3", NULL),
+	INIT_CLKREG(&clk_twsi5, "pxa2xx-i2c.4", NULL),
+	INIT_CLKREG(&clk_twsi6, "pxa2xx-i2c.5", NULL),
+	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
+	INIT_CLKREG(&clk_gpio, "pxa-gpio", NULL),
+	INIT_CLKREG(&clk_sdh0, "sdhci-pxav3.0", "PXA-SDHCLK"),
+	INIT_CLKREG(&clk_sdh1, "sdhci-pxav3.1", "PXA-SDHCLK"),
+	INIT_CLKREG(&clk_sdh2, "sdhci-pxav3.2", "PXA-SDHCLK"),
+	INIT_CLKREG(&clk_sdh3, "sdhci-pxav3.3", "PXA-SDHCLK"),
+};
+
+void __init mmp2_clk_init(void)
+{
+	clkdev_add_table(ARRAY_AND_SIZE(mmp2_clkregs));
+}
diff --git a/arch/arm/mach-mmp/common.h b/arch/arm/mach-mmp/common.h
index 1cad41b..bd45327 100644
--- a/arch/arm/mach-mmp/common.h
+++ b/arch/arm/mach-mmp/common.h
@@ -9,3 +9,4 @@ extern void __init mmp_map_io(void);
 extern void mmp_restart(char, const char *);
 extern void __init pxa168_clk_init(void);
 extern void __init pxa910_clk_init(void);
+extern void __init mmp2_clk_init(void);
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index c709a24..c2ce3d0 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -20,7 +20,6 @@
 #include <asm/mach/time.h>
 #include <mach/addr-map.h>
 #include <mach/regs-apbc.h>
-#include <mach/regs-apmu.h>
 #include <mach/cputype.h>
 #include <mach/irqs.h>
 #include <mach/dma.h>
@@ -29,7 +28,6 @@
 #include <mach/mmp2.h>
 
 #include "common.h"
-#include "clock.h"
 
 #define MFPR_VIRT_BASE	(APB_VIRT_BASE + 0x1e000)
 
@@ -98,67 +96,6 @@ void __init mmp2_init_irq(void)
 	mmp2_init_icu();
 }
 
-static void sdhc_clk_enable(struct clk *clk)
-{
-	uint32_t clk_rst;
-
-	clk_rst  =  __raw_readl(clk->clk_rst);
-	clk_rst |= clk->enable_val;
-	__raw_writel(clk_rst, clk->clk_rst);
-}
-
-static void sdhc_clk_disable(struct clk *clk)
-{
-	uint32_t clk_rst;
-
-	clk_rst  =  __raw_readl(clk->clk_rst);
-	clk_rst &= ~clk->enable_val;
-	__raw_writel(clk_rst, clk->clk_rst);
-}
-
-struct clkops sdhc_clk_ops = {
-	.enable		= sdhc_clk_enable,
-	.disable	= sdhc_clk_disable,
-};
-
-/* APB peripheral clocks */
-static APBC_CLK(uart1, MMP2_UART1, 1, 26000000);
-static APBC_CLK(uart2, MMP2_UART2, 1, 26000000);
-static APBC_CLK(uart3, MMP2_UART3, 1, 26000000);
-static APBC_CLK(uart4, MMP2_UART4, 1, 26000000);
-static APBC_CLK(twsi1, MMP2_TWSI1, 0, 26000000);
-static APBC_CLK(twsi2, MMP2_TWSI2, 0, 26000000);
-static APBC_CLK(twsi3, MMP2_TWSI3, 0, 26000000);
-static APBC_CLK(twsi4, MMP2_TWSI4, 0, 26000000);
-static APBC_CLK(twsi5, MMP2_TWSI5, 0, 26000000);
-static APBC_CLK(twsi6, MMP2_TWSI6, 0, 26000000);
-static APBC_CLK(gpio, MMP2_GPIO, 0, 26000000);
-
-static APMU_CLK(nand, NAND, 0xbf, 100000000);
-static APMU_CLK_OPS(sdh0, SDH0, 0x1b, 200000000, &sdhc_clk_ops);
-static APMU_CLK_OPS(sdh1, SDH1, 0x1b, 200000000, &sdhc_clk_ops);
-static APMU_CLK_OPS(sdh2, SDH2, 0x1b, 200000000, &sdhc_clk_ops);
-static APMU_CLK_OPS(sdh3, SDH3, 0x1b, 200000000, &sdhc_clk_ops);
-
-static struct clk_lookup mmp2_clkregs[] = {
-	INIT_CLKREG(&clk_uart1, "pxa2xx-uart.0", NULL),
-	INIT_CLKREG(&clk_uart2, "pxa2xx-uart.1", NULL),
-	INIT_CLKREG(&clk_uart3, "pxa2xx-uart.2", NULL),
-	INIT_CLKREG(&clk_uart4, "pxa2xx-uart.3", NULL),
-	INIT_CLKREG(&clk_twsi1, "pxa2xx-i2c.0", NULL),
-	INIT_CLKREG(&clk_twsi2, "pxa2xx-i2c.1", NULL),
-	INIT_CLKREG(&clk_twsi3, "pxa2xx-i2c.2", NULL),
-	INIT_CLKREG(&clk_twsi4, "pxa2xx-i2c.3", NULL),
-	INIT_CLKREG(&clk_twsi5, "pxa2xx-i2c.4", NULL),
-	INIT_CLKREG(&clk_twsi6, "pxa2xx-i2c.5", NULL),
-	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
-	INIT_CLKREG(&clk_gpio, "pxa-gpio", NULL),
-	INIT_CLKREG(&clk_sdh0, "sdhci-pxav3.0", "PXA-SDHCLK"),
-	INIT_CLKREG(&clk_sdh1, "sdhci-pxav3.1", "PXA-SDHCLK"),
-	INIT_CLKREG(&clk_sdh2, "sdhci-pxav3.2", "PXA-SDHCLK"),
-	INIT_CLKREG(&clk_sdh3, "sdhci-pxav3.3", "PXA-SDHCLK"),
-};
-
 static int __init mmp2_init(void)
 {
 	if (cpu_is_mmp2()) {
@@ -168,25 +105,27 @@ static int __init mmp2_init(void)
 		mfp_init_base(MFPR_VIRT_BASE);
 		mfp_init_addr(mmp2_addr_map);
 		pxa_init_dma(IRQ_MMP2_DMA_RIQ, 16);
-		clkdev_add_table(ARRAY_AND_SIZE(mmp2_clkregs));
+		mmp2_clk_init();
 	}
 
 	return 0;
 }
 postcore_initcall(mmp2_init);
 
+#define APBC_TIMERS	APBC_REG(0x024)
+
 static void __init mmp2_timer_init(void)
 {
 	unsigned long clk_rst;
 
-	__raw_writel(APBC_APBCLK | APBC_RST, APBC_MMP2_TIMERS);
+	__raw_writel(APBC_APBCLK | APBC_RST, APBC_TIMERS);
 
 	/*
 	 * enable bus/functional clock, enable 6.5MHz (divider 4),
 	 * release reset
 	 */
 	clk_rst = APBC_APBCLK | APBC_FNCLK | APBC_FNCLKSEL(1);
-	__raw_writel(clk_rst, APBC_MMP2_TIMERS);
+	__raw_writel(clk_rst, APBC_TIMERS);
 
 	timer_init(IRQ_MMP2_TIMER1);
 }
-- 
1.7.0.4
