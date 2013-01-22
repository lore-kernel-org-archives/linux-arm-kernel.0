From: Barry.Song@csr.com (Barry Song)
Date: Tue, 22 Jan 2013 20:22:08 +0800
Subject: [PATCH v3 7/9] ARM: PRIMA2: irq: make prima2 irq can work even we
 enable GIC for Marco
In-Reply-To: <1358857330-10101-1-git-send-email-Barry.Song@csr.com>
References: <1358857330-10101-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1358857330-10101-3-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

in Marco, we will use GIC. this patch prepares the handle_irq for prima2
to avoid the compiling errors since we want only one defconfig and zImage
for both prima2 and marco that means we will need handle_irq for both.

Signed-off-by: Baohua Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/common.c            |    3 +++
 arch/arm/mach-prima2/common.h            |    2 ++
 arch/arm/mach-prima2/include/mach/irqs.h |    4 ++--
 arch/arm/mach-prima2/irq.c               |   16 ++++++++++++++--
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index 8e6f668..99f9c7e 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -41,6 +41,9 @@ DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
 	.map_io         = sirfsoc_map_lluart,
 	.init_irq	= sirfsoc_of_irq_init,
 	.init_time	= sirfsoc_prima2_timer_init,
+#ifdef CONFIG_MULTI_IRQ_HANDLER
+	.handle_irq     = sirfsoc_handle_irq,
+#endif
 	.dma_zone_size	= SZ_256M,
 	.init_machine	= sirfsoc_mach_init,
 	.init_late	= sirfsoc_init_late,
diff --git a/arch/arm/mach-prima2/common.h b/arch/arm/mach-prima2/common.h
index d6890b6..a4f91a6 100644
--- a/arch/arm/mach-prima2/common.h
+++ b/arch/arm/mach-prima2/common.h
@@ -11,12 +11,14 @@
 
 #include <linux/init.h>
 #include <asm/mach/time.h>
+#include <asm/exception.h>
 
 extern void sirfsoc_prima2_timer_init(void);
 
 extern void __init sirfsoc_of_irq_init(void);
 extern void __init sirfsoc_of_clk_init(void);
 extern void sirfsoc_restart(char, const char *);
+extern asmlinkage void __exception_irq_entry sirfsoc_handle_irq(struct pt_regs *regs);
 
 #ifndef CONFIG_DEBUG_LL
 static inline void sirfsoc_map_lluart(void)  {}
diff --git a/arch/arm/mach-prima2/include/mach/irqs.h b/arch/arm/mach-prima2/include/mach/irqs.h
index f6014a0..b778a0f 100644
--- a/arch/arm/mach-prima2/include/mach/irqs.h
+++ b/arch/arm/mach-prima2/include/mach/irqs.h
@@ -10,8 +10,8 @@
 #define __ASM_ARCH_IRQS_H
 
 #define SIRFSOC_INTENAL_IRQ_START  0
-#define SIRFSOC_INTENAL_IRQ_END    59
+#define SIRFSOC_INTENAL_IRQ_END    127
 #define SIRFSOC_GPIO_IRQ_START     (SIRFSOC_INTENAL_IRQ_END + 1)
-#define NR_IRQS	220
+#define NR_IRQS	288
 
 #endif
diff --git a/arch/arm/mach-prima2/irq.c b/arch/arm/mach-prima2/irq.c
index 7dee917..6c0f3e9 100644
--- a/arch/arm/mach-prima2/irq.c
+++ b/arch/arm/mach-prima2/irq.c
@@ -9,17 +9,19 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/irq.h>
-#include <mach/hardware.h>
-#include <asm/mach/irq.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/irqdomain.h>
 #include <linux/syscore_ops.h>
+#include <asm/mach/irq.h>
+#include <asm/exception.h>
+#include <mach/hardware.h>
 
 #define SIRFSOC_INT_RISC_MASK0          0x0018
 #define SIRFSOC_INT_RISC_MASK1          0x001C
 #define SIRFSOC_INT_RISC_LEVEL0         0x0020
 #define SIRFSOC_INT_RISC_LEVEL1         0x0024
+#define SIRFSOC_INIT_IRQ_ID		0x0038
 
 void __iomem *sirfsoc_intc_base;
 
@@ -52,6 +54,16 @@ static __init void sirfsoc_irq_init(void)
 	writel_relaxed(0, sirfsoc_intc_base + SIRFSOC_INT_RISC_MASK1);
 }
 
+asmlinkage void __exception_irq_entry sirfsoc_handle_irq(struct pt_regs *regs)
+{
+	u32 irqstat, irqnr;
+
+	irqstat = readl_relaxed(sirfsoc_intc_base + SIRFSOC_INIT_IRQ_ID);
+	irqnr = irqstat & 0xff;
+
+	handle_IRQ(irqnr, regs);
+}
+
 static struct of_device_id intc_ids[]  = {
 	{ .compatible = "sirf,prima2-intc" },
 	{},
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
