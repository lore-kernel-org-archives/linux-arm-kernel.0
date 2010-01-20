From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 20 Jan 2010 19:39:24 +0530
Subject: [PATCH] ARM: L2 : Errata 588369: Clean & Invalidate do not invalidate
	clean lines
Message-ID: <1263996564-18703-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements the work-around for the errata 588369. The secure API
is used to alter L2 debug register because of trust-zone.

This version updated with comments from Russell and Catalin and generated
against 2.6.33-rc4 mainline kernel. Detail comments can be found:
	http://www.spinics.net/lists/linux-omap/msg23431.html

Signed-off-by: Woodruff Richard <r-woodruff2@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/Kconfig         |   13 ++++++++++++
 arch/arm/mm/cache-l2x0.c |   49 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c2238cd..f78a51e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -920,6 +920,19 @@ config ARM_ERRATA_460075
 	  ACTLR register. Note that setting specific bits in the ACTLR register
 	  may not be available in non-secure mode.
 
+config PL310_ERRATA_588369
+	bool "Clean & Invalidate maintenance operations do not invalidate clean lines"
+	depends on CACHE_L2X0 && ARCH_OMAP4
+	help
+	   The PL310 L2 cache controller implements three types of Clean &
+	   Invalidate maintenance operations: by Physical Address
+	   (offset 0x7F0), by Index/Way (0x7F8) and by Way (0x7FC).
+	   They are architecturally defined to behave as the execution of a
+	   clean operation followed immediately by an invalidate operation,
+	   both performing to the same memory location. This functionality
+	   is not correctly implemented in PL310 as clean lines are not
+	   invalidated as a result of these operations. Note that this errata
+	   uses Texas Instrument's secure monitor api.
 endmenu
 
 source "arch/arm/common/Kconfig"
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 1a14d18..6597743 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -56,12 +56,55 @@ static inline void l2x0_inv_line(unsigned long addr)
 	writel(addr, base + L2X0_INV_LINE_PA);
 }
 
+#ifdef CONFIG_PL310_ERRATA_588369
+static noinline void debug_writel(unsigned long val)
+{
+	register unsigned long r0 asm("r0") = val;
+	/*
+	 * Texas Instrument secure monitor api to modify the PL310
+	 * Debug Control Register.
+	 * r0 contains the value to be modified and "r12" contains
+	 * the monitor API number. This API uses few CPU registers
+	 * internally and hence they need be backed up including
+	 * link register "lr".
+	 * Explicitly save r11 and r12 since  the compiler generated
+	 * code won't save it.
+	 */
+	__asm__ __volatile__(
+		__asmeq("%0", "r0")
+		"stmfd r13!, {r11,r12}\n"
+		"ldr r12, =0x100\n"
+		"dsb\n"
+		"smc\n"
+		"ldmfd r13!, {r11,r12}\n"
+		: : "r" (r0)
+		: "r4", "r5", "r10", "lr");
+}
+
+static inline void l2x0_flush_line(unsigned long addr)
+{
+	void __iomem *base = l2x0_base;
+
+	/* Clean by PA followed by Invalidate by PA */
+	cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
+	writel(addr, base + L2X0_CLEAN_LINE_PA);
+	cache_wait(base + L2X0_INV_LINE_PA, 1);
+	writel(addr, base + L2X0_INV_LINE_PA);
+}
+#else
+
+/* Optimised out for non-errata case */
+static inline void debug_writel(unsigned long val)
+{
+}
+
 static inline void l2x0_flush_line(unsigned long addr)
 {
 	void __iomem *base = l2x0_base;
 	cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
 	writel(addr, base + L2X0_CLEAN_INV_LINE_PA);
 }
+#endif
 
 static inline void l2x0_inv_all(void)
 {
@@ -83,13 +126,17 @@ static void l2x0_inv_range(unsigned long start, unsigned long end)
 	spin_lock_irqsave(&l2x0_lock, flags);
 	if (start & (CACHE_LINE_SIZE - 1)) {
 		start &= ~(CACHE_LINE_SIZE - 1);
+		debug_writel(0x03);
 		l2x0_flush_line(start);
+		debug_writel(0x00);
 		start += CACHE_LINE_SIZE;
 	}
 
 	if (end & (CACHE_LINE_SIZE - 1)) {
 		end &= ~(CACHE_LINE_SIZE - 1);
+		debug_writel(0x03);
 		l2x0_flush_line(end);
+		debug_writel(0x00);
 	}
 
 	while (start < end) {
@@ -145,10 +192,12 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
 	while (start < end) {
 		unsigned long blk_end = start + min(end - start, 4096UL);
 
+		debug_writel(0x03);
 		while (start < blk_end) {
 			l2x0_flush_line(start);
 			start += CACHE_LINE_SIZE;
 		}
+		debug_writel(0x00);
 
 		if (blk_end < end) {
 			spin_unlock_irqrestore(&l2x0_lock, flags);
-- 
1.6.0.4
