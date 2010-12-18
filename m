From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Dec 2010 19:05:18 -0800
Subject: [PATCH 1/6] omap1: Fix innovator FPGA init for multi-omap
In-Reply-To: <20101218030406.10251.73118.stgit@baageli.muru.com>
References: <20101218030406.10251.73118.stgit@baageli.muru.com>
Message-ID: <20101218030518.10251.4445.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No need to call this early from init_irq. Also recent changes
initialize GPIO now later, so calling gpio_request from init_irq
will make it fail.

While at it, also remove the unnecessary EXPORT_SYMBOL.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-innovator.c  |    7 ++-----
 arch/arm/mach-omap1/fpga.c             |   10 ++++++----
 arch/arm/plat-omap/include/plat/fpga.h |    4 ----
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index a051acd..8d59b07 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -290,11 +290,6 @@ static void __init innovator_init_irq(void)
 {
 	omap1_init_common_hw();
 	omap_init_irq();
-#ifdef CONFIG_ARCH_OMAP15XX
-	if (cpu_is_omap1510()) {
-		omap1510_fpga_init_irq();
-	}
-#endif
 }
 
 #ifdef CONFIG_ARCH_OMAP15XX
@@ -385,6 +380,8 @@ static struct omap_board_config_kernel innovator_config[] = {
 
 static void __init innovator_init(void)
 {
+	if (cpu_is_omap1510())
+		omap1510_fpga_init_irq();
 	innovator_init_smc91x();
 
 #ifdef CONFIG_ARCH_OMAP15XX
diff --git a/arch/arm/mach-omap1/fpga.c b/arch/arm/mach-omap1/fpga.c
index 5cfce16..8780e75 100644
--- a/arch/arm/mach-omap1/fpga.c
+++ b/arch/arm/mach-omap1/fpga.c
@@ -143,7 +143,7 @@ static struct irq_chip omap_fpga_irq = {
  */
 void omap1510_fpga_init_irq(void)
 {
-	int i;
+	int i, res;
 
 	__raw_writeb(0, OMAP1510_FPGA_IMR_LO);
 	__raw_writeb(0, OMAP1510_FPGA_IMR_HI);
@@ -177,10 +177,12 @@ void omap1510_fpga_init_irq(void)
 	 * NOTE: For general GPIO/MPUIO access and interrupts, please see
 	 * gpio.[ch]
 	 */
-	gpio_request(13, "FPGA irq");
+	res = gpio_request(13, "FPGA irq");
+	if (res) {
+		pr_err("%s failed to get gpio\n", __func__);
+		return;
+	}
 	gpio_direction_input(13);
 	set_irq_type(gpio_to_irq(13), IRQ_TYPE_EDGE_RISING);
 	set_irq_chained_handler(OMAP1510_INT_FPGA, innovator_fpga_IRQ_demux);
 }
-
-EXPORT_SYMBOL(omap1510_fpga_init_irq);
diff --git a/arch/arm/plat-omap/include/plat/fpga.h b/arch/arm/plat-omap/include/plat/fpga.h
index f1864a6..ae39bcb 100644
--- a/arch/arm/plat-omap/include/plat/fpga.h
+++ b/arch/arm/plat-omap/include/plat/fpga.h
@@ -19,11 +19,7 @@
 #ifndef __ASM_ARCH_OMAP_FPGA_H
 #define __ASM_ARCH_OMAP_FPGA_H
 
-#if defined(CONFIG_MACH_OMAP_INNOVATOR) && defined(CONFIG_ARCH_OMAP15XX)
 extern void omap1510_fpga_init_irq(void);
-#else
-#define omap1510_fpga_init_irq()	(0)
-#endif
 
 #define fpga_read(reg)			__raw_readb(reg)
 #define fpga_write(val, reg)		__raw_writeb(val, reg)
