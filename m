From: xiechao.mail@gmail.com (Chao Xie)
Date: Mon, 27 Aug 2012 10:54:01 +0800
Subject: [PATCH 3/5] arm: mmp: move pxa910 clock definition to separated file
In-Reply-To: <1346036043-20115-1-git-send-email-xiechao.mail@gmail.com>
References: <1346036043-20115-1-git-send-email-xiechao.mail@gmail.com>
Message-ID: <1346036043-20115-3-git-send-email-xiechao.mail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

move pxa910 clock definition to another file. Then pxa910 can
choose common clock framework or private clock framework.

Signed-off-by: Chao Xie <xiechao.mail@gmail.com>
---
 arch/arm/mach-mmp/Makefile       |    1 +
 arch/arm/mach-mmp/clock-pxa910.c |   67 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mmp/common.h       |    1 +
 arch/arm/mach-mmp/pxa910.c       |   40 ++--------------------
 4 files changed, 73 insertions(+), 36 deletions(-)
 create mode 100644 arch/arm/mach-mmp/clock-pxa910.c

diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index bb63f86..ac0e885 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_CPU_MMP2)		+= mmp2.o sram.o
 ifeq ($(CONFIG_COMMON_CLK), )
 obj-y				+= clock.o
 obj-$(CONFIG_CPU_PXA168)	+= clock-pxa168.o
+obj-$(CONFIG_CPU_PXA910)	+= clock-pxa910.o
 endif
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_CPU_PXA910)	+= pm-pxa910.o
diff --git a/arch/arm/mach-mmp/clock-pxa910.c b/arch/arm/mach-mmp/clock-pxa910.c
new file mode 100644
index 0000000..933ea71
--- /dev/null
+++ b/arch/arm/mach-mmp/clock-pxa910.c
@@ -0,0 +1,67 @@
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
+ * APB Clock register offsets for PXA910
+ */
+#define APBC_UART0	APBC_REG(0x000)
+#define APBC_UART1	APBC_REG(0x004)
+#define APBC_GPIO	APBC_REG(0x008)
+#define APBC_PWM1	APBC_REG(0x00c)
+#define APBC_PWM2	APBC_REG(0x010)
+#define APBC_PWM3	APBC_REG(0x014)
+#define APBC_PWM4	APBC_REG(0x018)
+#define APBC_SSP1	APBC_REG(0x01c)
+#define APBC_SSP2	APBC_REG(0x020)
+#define APBC_RTC	APBC_REG(0x028)
+#define APBC_TWSI0	APBC_REG(0x02c)
+#define APBC_KPC	APBC_REG(0x030)
+#define APBC_SSP3	APBC_REG(0x04c)
+#define APBC_TWSI1	APBC_REG(0x06c)
+
+#define APMU_NAND	APMU_REG(0x060)
+#define APMU_USB	APMU_REG(0x05c)
+
+static APBC_CLK(uart1, UART0, 1, 14745600);
+static APBC_CLK(uart2, UART1, 1, 14745600);
+static APBC_CLK(twsi0, TWSI0, 1, 33000000);
+static APBC_CLK(twsi1, TWSI1, 1, 33000000);
+static APBC_CLK(pwm1, PWM1, 1, 13000000);
+static APBC_CLK(pwm2, PWM2, 1, 13000000);
+static APBC_CLK(pwm3, PWM3, 1, 13000000);
+static APBC_CLK(pwm4, PWM4, 1, 13000000);
+static APBC_CLK(gpio, GPIO, 0, 13000000);
+static APBC_CLK(rtc, RTC, 8, 32768);
+
+static APMU_CLK(nand, NAND, 0x19b, 156000000);
+static APMU_CLK(u2o, USB, 0x1b, 480000000);
+
+/* device and clock bindings */
+static struct clk_lookup pxa910_clkregs[] = {
+	INIT_CLKREG(&clk_uart1, "pxa2xx-uart.0", NULL),
+	INIT_CLKREG(&clk_uart2, "pxa2xx-uart.1", NULL),
+	INIT_CLKREG(&clk_twsi0, "pxa2xx-i2c.0", NULL),
+	INIT_CLKREG(&clk_twsi1, "pxa2xx-i2c.1", NULL),
+	INIT_CLKREG(&clk_pwm1, "pxa910-pwm.0", NULL),
+	INIT_CLKREG(&clk_pwm2, "pxa910-pwm.1", NULL),
+	INIT_CLKREG(&clk_pwm3, "pxa910-pwm.2", NULL),
+	INIT_CLKREG(&clk_pwm4, "pxa910-pwm.3", NULL),
+	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
+	INIT_CLKREG(&clk_gpio, "pxa-gpio", NULL),
+	INIT_CLKREG(&clk_u2o, NULL, "U2OCLK"),
+	INIT_CLKREG(&clk_rtc, "sa1100-rtc", NULL),
+};
+
+void __init pxa910_clk_init(void)
+{
+	clkdev_add_table(ARRAY_AND_SIZE(pxa910_clkregs));
+}
diff --git a/arch/arm/mach-mmp/common.h b/arch/arm/mach-mmp/common.h
index e47f73f..1cad41b 100644
--- a/arch/arm/mach-mmp/common.h
+++ b/arch/arm/mach-mmp/common.h
@@ -8,3 +8,4 @@ extern void __init icu_init_irq(void);
 extern void __init mmp_map_io(void);
 extern void mmp_restart(char, const char *);
 extern void __init pxa168_clk_init(void);
+extern void __init pxa910_clk_init(void);
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index 6da52e9..7d84521 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -17,7 +17,6 @@
 #include <asm/mach/time.h>
 #include <mach/addr-map.h>
 #include <mach/regs-apbc.h>
-#include <mach/regs-apmu.h>
 #include <mach/cputype.h>
 #include <mach/irqs.h>
 #include <mach/dma.h>
@@ -25,7 +24,6 @@
 #include <mach/devices.h>
 
 #include "common.h"
-#include "clock.h"
 
 #define MFPR_VIRT_BASE	(APB_VIRT_BASE + 0x1e000)
 
@@ -82,44 +80,13 @@ void __init pxa910_init_irq(void)
 	icu_init_irq();
 }
 
-/* APB peripheral clocks */
-static APBC_CLK(uart1, PXA910_UART0, 1, 14745600);
-static APBC_CLK(uart2, PXA910_UART1, 1, 14745600);
-static APBC_CLK(twsi0, PXA168_TWSI0, 1, 33000000);
-static APBC_CLK(twsi1, PXA168_TWSI1, 1, 33000000);
-static APBC_CLK(pwm1, PXA910_PWM1, 1, 13000000);
-static APBC_CLK(pwm2, PXA910_PWM2, 1, 13000000);
-static APBC_CLK(pwm3, PXA910_PWM3, 1, 13000000);
-static APBC_CLK(pwm4, PXA910_PWM4, 1, 13000000);
-static APBC_CLK(gpio, PXA910_GPIO, 0, 13000000);
-static APBC_CLK(rtc, PXA910_RTC, 8, 32768);
-
-static APMU_CLK(nand, NAND, 0x19b, 156000000);
-static APMU_CLK(u2o, USB, 0x1b, 480000000);
-
-/* device and clock bindings */
-static struct clk_lookup pxa910_clkregs[] = {
-	INIT_CLKREG(&clk_uart1, "pxa2xx-uart.0", NULL),
-	INIT_CLKREG(&clk_uart2, "pxa2xx-uart.1", NULL),
-	INIT_CLKREG(&clk_twsi0, "pxa2xx-i2c.0", NULL),
-	INIT_CLKREG(&clk_twsi1, "pxa2xx-i2c.1", NULL),
-	INIT_CLKREG(&clk_pwm1, "pxa910-pwm.0", NULL),
-	INIT_CLKREG(&clk_pwm2, "pxa910-pwm.1", NULL),
-	INIT_CLKREG(&clk_pwm3, "pxa910-pwm.2", NULL),
-	INIT_CLKREG(&clk_pwm4, "pxa910-pwm.3", NULL),
-	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
-	INIT_CLKREG(&clk_gpio, "pxa-gpio", NULL),
-	INIT_CLKREG(&clk_u2o, NULL, "U2OCLK"),
-	INIT_CLKREG(&clk_rtc, "sa1100-rtc", NULL),
-};
-
 static int __init pxa910_init(void)
 {
 	if (cpu_is_pxa910()) {
 		mfp_init_base(MFPR_VIRT_BASE);
 		mfp_init_addr(pxa910_mfp_addr_map);
 		pxa_init_dma(IRQ_PXA910_DMA_INT0, 32);
-		clkdev_add_table(ARRAY_AND_SIZE(pxa910_clkregs));
+		pxa910_clk_init();
 	}
 
 	return 0;
@@ -128,12 +95,13 @@ postcore_initcall(pxa910_init);
 
 /* system timer - clock enabled, 3.25MHz */
 #define TIMER_CLK_RST	(APBC_APBCLK | APBC_FNCLK | APBC_FNCLKSEL(3))
+#define APBC_TIMERS	APBC_REG(0x34)
 
 static void __init pxa910_timer_init(void)
 {
 	/* reset and configure */
-	__raw_writel(APBC_APBCLK | APBC_RST, APBC_PXA910_TIMERS);
-	__raw_writel(TIMER_CLK_RST, APBC_PXA910_TIMERS);
+	__raw_writel(APBC_APBCLK | APBC_RST, APBC_TIMERS);
+	__raw_writel(TIMER_CLK_RST, APBC_TIMERS);
 
 	timer_init(IRQ_PXA910_AP1_TIMER1);
 }
-- 
1.7.0.4
