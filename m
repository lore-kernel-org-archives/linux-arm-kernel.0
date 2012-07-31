From: xiechao.mail@gmail.com (Chao Xie)
Date: Tue, 31 Jul 2012 14:29:03 +0800
Subject: [PATCH 3/8] arm: mmp: move pxa168 clock definition to separated file
In-Reply-To: <1343716148-3899-1-git-send-email-xiechao.mail@gmail.com>
References: <1343716148-3899-1-git-send-email-xiechao.mail@gmail.com>
Message-ID: <1343716148-3899-3-git-send-email-xiechao.mail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

move pxa168 clock definition to another file. Then pxa168 can
choose common clock framework or private clock framework.

Signed-off-by: Chao Xie <xiechao.mail@gmail.com>
---
 arch/arm/mach-mmp/Makefile       |    1 +
 arch/arm/mach-mmp/clock-pxa168.c |   91 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mmp/common.h       |    1 +
 arch/arm/mach-mmp/pxa168.c       |   58 ++----------------------
 4 files changed, 98 insertions(+), 53 deletions(-)
 create mode 100644 arch/arm/mach-mmp/clock-pxa168.c

diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index 815c3e7..bb63f86 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_CPU_MMP2)		+= mmp2.o sram.o
 
 ifeq ($(CONFIG_COMMON_CLK), )
 obj-y				+= clock.o
+obj-$(CONFIG_CPU_PXA168)	+= clock-pxa168.o
 endif
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_CPU_PXA910)	+= pm-pxa910.o
diff --git a/arch/arm/mach-mmp/clock-pxa168.c b/arch/arm/mach-mmp/clock-pxa168.c
new file mode 100644
index 0000000..5e6c18c
--- /dev/null
+++ b/arch/arm/mach-mmp/clock-pxa168.c
@@ -0,0 +1,91 @@
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
+ * APB clock register offsets for PXA168
+ */
+#define APBC_UART1	APBC_REG(0x000)
+#define APBC_UART2	APBC_REG(0x004)
+#define APBC_GPIO	APBC_REG(0x008)
+#define APBC_PWM1	APBC_REG(0x00c)
+#define APBC_PWM2	APBC_REG(0x010)
+#define APBC_PWM3	APBC_REG(0x014)
+#define APBC_PWM4	APBC_REG(0x018)
+#define APBC_RTC	APBC_REG(0x028)
+#define APBC_TWSI0	APBC_REG(0x02c)
+#define APBC_KPC	APBC_REG(0x030)
+#define APBC_TWSI1	APBC_REG(0x06c)
+#define APBC_UART3	APBC_REG(0x070)
+#define APBC_SSP1	APBC_REG(0x81c)
+#define APBC_SSP2	APBC_REG(0x820)
+#define APBC_SSP3	APBC_REG(0x84c)
+#define APBC_SSP4	APBC_REG(0x858)
+#define APBC_SSP5	APBC_REG(0x85c)
+
+#define APMU_NAND	APMU_REG(0x060)
+#define APMU_LCD	APMU_REG(0x04c)
+#define APMU_ETH	APMU_REG(0x0fc)
+#define APMU_USB	APMU_REG(0x05c)
+
+/* APB peripheral clocks */
+static APBC_CLK(uart1, UART1, 1, 14745600);
+static APBC_CLK(uart2, UART2, 1, 14745600);
+static APBC_CLK(uart3, UART3, 1, 14745600);
+static APBC_CLK(twsi0, TWSI0, 1, 33000000);
+static APBC_CLK(twsi1, TWSI1, 1, 33000000);
+static APBC_CLK(pwm1, PWM1, 1, 13000000);
+static APBC_CLK(pwm2, PWM2, 1, 13000000);
+static APBC_CLK(pwm3, PWM3, 1, 13000000);
+static APBC_CLK(pwm4, PWM4, 1, 13000000);
+static APBC_CLK(ssp1, SSP1, 4, 0);
+static APBC_CLK(ssp2, SSP2, 4, 0);
+static APBC_CLK(ssp3, SSP3, 4, 0);
+static APBC_CLK(ssp4, SSP4, 4, 0);
+static APBC_CLK(ssp5, SSP5, 4, 0);
+static APBC_CLK(gpio, GPIO, 0, 13000000);
+static APBC_CLK(keypad, KPC, 0, 32000);
+static APBC_CLK(rtc, RTC, 8, 32768);
+
+static APMU_CLK(nand, NAND, 0x19b, 156000000);
+static APMU_CLK(lcd, LCD, 0x7f, 312000000);
+static APMU_CLK(eth, ETH, 0x09, 0);
+static APMU_CLK(usb, USB, 0x12, 0);
+
+/* device and clock bindings */
+static struct clk_lookup pxa168_clkregs[] = {
+	INIT_CLKREG(&clk_uart1, "pxa2xx-uart.0", NULL),
+	INIT_CLKREG(&clk_uart2, "pxa2xx-uart.1", NULL),
+	INIT_CLKREG(&clk_uart3, "pxa2xx-uart.2", NULL),
+	INIT_CLKREG(&clk_twsi0, "pxa2xx-i2c.0", NULL),
+	INIT_CLKREG(&clk_twsi1, "pxa2xx-i2c.1", NULL),
+	INIT_CLKREG(&clk_pwm1, "pxa168-pwm.0", NULL),
+	INIT_CLKREG(&clk_pwm2, "pxa168-pwm.1", NULL),
+	INIT_CLKREG(&clk_pwm3, "pxa168-pwm.2", NULL),
+	INIT_CLKREG(&clk_pwm4, "pxa168-pwm.3", NULL),
+	INIT_CLKREG(&clk_ssp1, "pxa168-ssp.0", NULL),
+	INIT_CLKREG(&clk_ssp2, "pxa168-ssp.1", NULL),
+	INIT_CLKREG(&clk_ssp3, "pxa168-ssp.2", NULL),
+	INIT_CLKREG(&clk_ssp4, "pxa168-ssp.3", NULL),
+	INIT_CLKREG(&clk_ssp5, "pxa168-ssp.4", NULL),
+	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
+	INIT_CLKREG(&clk_lcd, "pxa168-fb", NULL),
+	INIT_CLKREG(&clk_gpio, "pxa-gpio", NULL),
+	INIT_CLKREG(&clk_keypad, "pxa27x-keypad", NULL),
+	INIT_CLKREG(&clk_eth, "pxa168-eth", "MFUCLK"),
+	INIT_CLKREG(&clk_usb, NULL, "PXA168-USBCLK"),
+	INIT_CLKREG(&clk_rtc, "sa1100-rtc", NULL),
+};
+
+void __init pxa168_clk_init(void)
+{
+	clkdev_add_table(ARRAY_AND_SIZE(pxa168_clkregs));
+}
diff --git a/arch/arm/mach-mmp/common.h b/arch/arm/mach-mmp/common.h
index 1c9d6c1..e47f73f 100644
--- a/arch/arm/mach-mmp/common.h
+++ b/arch/arm/mach-mmp/common.h
@@ -7,3 +7,4 @@ extern void timer_init(int irq);
 extern void __init icu_init_irq(void);
 extern void __init mmp_map_io(void);
 extern void mmp_restart(char, const char *);
+extern void __init pxa168_clk_init(void);
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 62d787c..b7f074f 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -18,8 +18,8 @@
 
 #include <asm/mach/time.h>
 #include <asm/system_misc.h>
-#include <mach/addr-map.h>
 #include <mach/cputype.h>
+#include <mach/addr-map.h>
 #include <mach/regs-apbc.h>
 #include <mach/regs-apmu.h>
 #include <mach/irqs.h>
@@ -50,62 +50,13 @@ void __init pxa168_init_irq(void)
 	icu_init_irq();
 }
 
-/* APB peripheral clocks */
-static APBC_CLK(uart1, PXA168_UART1, 1, 14745600);
-static APBC_CLK(uart2, PXA168_UART2, 1, 14745600);
-static APBC_CLK(uart3, PXA168_UART3, 1, 14745600);
-static APBC_CLK(twsi0, PXA168_TWSI0, 1, 33000000);
-static APBC_CLK(twsi1, PXA168_TWSI1, 1, 33000000);
-static APBC_CLK(pwm1, PXA168_PWM1, 1, 13000000);
-static APBC_CLK(pwm2, PXA168_PWM2, 1, 13000000);
-static APBC_CLK(pwm3, PXA168_PWM3, 1, 13000000);
-static APBC_CLK(pwm4, PXA168_PWM4, 1, 13000000);
-static APBC_CLK(ssp1, PXA168_SSP1, 4, 0);
-static APBC_CLK(ssp2, PXA168_SSP2, 4, 0);
-static APBC_CLK(ssp3, PXA168_SSP3, 4, 0);
-static APBC_CLK(ssp4, PXA168_SSP4, 4, 0);
-static APBC_CLK(ssp5, PXA168_SSP5, 4, 0);
-static APBC_CLK(gpio, PXA168_GPIO, 0, 13000000);
-static APBC_CLK(keypad, PXA168_KPC, 0, 32000);
-static APBC_CLK(rtc, PXA168_RTC, 8, 32768);
-
-static APMU_CLK(nand, NAND, 0x19b, 156000000);
-static APMU_CLK(lcd, LCD, 0x7f, 312000000);
-static APMU_CLK(eth, ETH, 0x09, 0);
-static APMU_CLK(usb, USB, 0x12, 0);
-
-/* device and clock bindings */
-static struct clk_lookup pxa168_clkregs[] = {
-	INIT_CLKREG(&clk_uart1, "pxa2xx-uart.0", NULL),
-	INIT_CLKREG(&clk_uart2, "pxa2xx-uart.1", NULL),
-	INIT_CLKREG(&clk_uart3, "pxa2xx-uart.2", NULL),
-	INIT_CLKREG(&clk_twsi0, "pxa2xx-i2c.0", NULL),
-	INIT_CLKREG(&clk_twsi1, "pxa2xx-i2c.1", NULL),
-	INIT_CLKREG(&clk_pwm1, "pxa168-pwm.0", NULL),
-	INIT_CLKREG(&clk_pwm2, "pxa168-pwm.1", NULL),
-	INIT_CLKREG(&clk_pwm3, "pxa168-pwm.2", NULL),
-	INIT_CLKREG(&clk_pwm4, "pxa168-pwm.3", NULL),
-	INIT_CLKREG(&clk_ssp1, "pxa168-ssp.0", NULL),
-	INIT_CLKREG(&clk_ssp2, "pxa168-ssp.1", NULL),
-	INIT_CLKREG(&clk_ssp3, "pxa168-ssp.2", NULL),
-	INIT_CLKREG(&clk_ssp4, "pxa168-ssp.3", NULL),
-	INIT_CLKREG(&clk_ssp5, "pxa168-ssp.4", NULL),
-	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
-	INIT_CLKREG(&clk_lcd, "pxa168-fb", NULL),
-	INIT_CLKREG(&clk_gpio, "pxa-gpio", NULL),
-	INIT_CLKREG(&clk_keypad, "pxa27x-keypad", NULL),
-	INIT_CLKREG(&clk_eth, "pxa168-eth", "MFUCLK"),
-	INIT_CLKREG(&clk_usb, NULL, "PXA168-USBCLK"),
-	INIT_CLKREG(&clk_rtc, "sa1100-rtc", NULL),
-};
-
 static int __init pxa168_init(void)
 {
 	if (cpu_is_pxa168()) {
 		mfp_init_base(MFPR_VIRT_BASE);
 		mfp_init_addr(pxa168_mfp_addr_map);
 		pxa_init_dma(IRQ_PXA168_DMA_INT0, 32);
-		clkdev_add_table(ARRAY_AND_SIZE(pxa168_clkregs));
+		pxa168_clk_init();
 	}
 
 	return 0;
@@ -114,6 +65,7 @@ postcore_initcall(pxa168_init);
 
 /* system timer - clock enabled, 3.25MHz */
 #define TIMER_CLK_RST	(APBC_APBCLK | APBC_FNCLK | APBC_FNCLKSEL(3))
+#define APBC_TIMERS	APBC_REG(0x34)
 
 static void __init pxa168_timer_init(void)
 {
@@ -121,10 +73,10 @@ static void __init pxa168_timer_init(void)
 	 * ourselves instead of using clk_* API. Clock rate is defined
 	 * by APBC_TIMERS_CLK_RST (3.25MHz) and enabled free-running
 	 */
-	__raw_writel(APBC_APBCLK | APBC_RST, APBC_PXA168_TIMERS);
+	__raw_writel(APBC_APBCLK | APBC_RST, APBC_TIMERS);
 
 	/* 3.25MHz, bus/functional clock enabled, release reset */
-	__raw_writel(TIMER_CLK_RST, APBC_PXA168_TIMERS);
+	__raw_writel(TIMER_CLK_RST, APBC_TIMERS);
 
 	timer_init(IRQ_PXA168_TIMER1);
 }
-- 
1.7.0.4
