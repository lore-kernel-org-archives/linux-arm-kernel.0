From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon, 25 Jan 2010 05:20:33 -0500
Subject: [PATCH] mmp2: add gpio initialization
Message-ID: <mailman.165.1264417442.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/irq-mmp2.c |    2 +-
 arch/arm/mach-mmp/mmp2.c     |   24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/irq-mmp2.c b/arch/arm/mach-mmp/irq-mmp2.c
index ddebde8..41b29f6 100644
--- a/arch/arm/mach-mmp/irq-mmp2.c
+++ b/arch/arm/mach-mmp/irq-mmp2.c
@@ -104,7 +104,7 @@ static void init_mux_irq(struct irq_chip *chip,
int start, int num)
 	}
 }

-void __init mmp2_init_irq(void)
+void __init mmp2_init_icu_irq(void)
 {
 	int irq;

diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index 561194d..8a20819 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -21,6 +21,7 @@
 #include <mach/cputype.h>
 #include <mach/irqs.h>
 #include <mach/mfp.h>
+#include <mach/gpio.h>
 #include <mach/devices.h>

 #include "common.h"
@@ -28,12 +29,35 @@

 #define MFPR_VIRT_BASE	(APB_VIRT_BASE + 0x1e000)

+#define APMASK(i)	(GPIO_REGS_VIRT + BANK_OFF(i) + 0x9c)
+
 static struct mfp_addr_map mmp2_addr_map[] __initdata = {
 	MFP_ADDR(PMIC_INT, 0x2c4),

 	MFP_ADDR_END,
 };

+static void __init mmp2_init_gpio(void)
+{
+	int i;
+
+	/* enable GPIO clock */
+	__raw_writel(APBC_APBCLK | APBC_FNCLK, APBC_MMP2_GPIO);
+
+	/* unmask GPIO edge detection for all 6 banks -- APMASKx */
+	for (i = 0; i < 6; i++)
+		__raw_writel(0xffffffff, APMASK(i));
+
+	pxa_init_gpio(IRQ_MMP2_GPIO, 0, 167, NULL);
+}
+
+extern void mmp2_init_icu_irq(void);
+void __init mmp2_init_irq(void)
+{
+	mmp2_init_icu_irq();
+	mmp2_init_gpio();
+}
+
 /* APB peripheral clocks */
 static APBC_CLK(uart1, MMP2_UART1, 1, 26000000);
 static APBC_CLK(uart2, MMP2_UART2, 1, 26000000);
-- 
1.5.6.5
