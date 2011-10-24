From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 24 Oct 2011 05:49:53 -0400
Subject: [PATCH 04/12] ARM: mach-ebsa110: move special idle code to a
	out-of-line pm_idle hook
In-Reply-To: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
References: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
Message-ID: <1319449801-12367-5-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-ebsa110/core.c                |   28 +++++++++++++++++++++++++++
 arch/arm/mach-ebsa110/include/mach/system.h |   21 +-------------------
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-ebsa110/core.c b/arch/arm/mach-ebsa110/core.c
index d0ce8abdd4..53c6f51015 100644
--- a/arch/arm/mach-ebsa110/core.c
+++ b/arch/arm/mach-ebsa110/core.c
@@ -271,8 +271,36 @@ static struct platform_device *ebsa110_devices[] = {
 	&am79c961_device,
 };
 
+/*
+ * EBSA110 idling methodology:
+ *
+ * We can not execute the "wait for interrupt" instruction since that
+ * will stop our MCLK signal (which provides the clock for the glue
+ * logic, and therefore the timer interrupt).
+ *
+ * Instead, we spin, polling the IRQ_STAT register for the occurrence
+ * of any interrupt with core clock down to the memory clock.
+ */
+static void ebsa110_idle(void)
+{
+	const char *irq_stat = (char *)0xff000000;
+
+	/* disable clock switching */
+	asm volatile ("mcr p15, 0, ip, c15, c2, 2" : : : "cc");
+
+	/* wait for an interrupt to occur */
+	while (!*irq_stat);
+
+	/* enable clock switching */
+	asm volatile ("mcr p15, 0, ip, c15, c1, 2" : : : "cc");
+
+	/* return with IRQ enabled */
+	local_irq_enable();
+}
+
 static int __init ebsa110_init(void)
 {
+	pm_idle = ebsa110_idle;
 	return platform_add_devices(ebsa110_devices, ARRAY_SIZE(ebsa110_devices));
 }
 
diff --git a/arch/arm/mach-ebsa110/include/mach/system.h b/arch/arm/mach-ebsa110/include/mach/system.h
index 9a26245bf1..ac7bd8a74e 100644
--- a/arch/arm/mach-ebsa110/include/mach/system.h
+++ b/arch/arm/mach-ebsa110/include/mach/system.h
@@ -10,28 +10,9 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H
 
-/*
- * EBSA110 idling methodology:
- *
- * We can not execute the "wait for interrupt" instruction since that
- * will stop our MCLK signal (which provides the clock for the glue
- * logic, and therefore the timer interrupt).
- *
- * Instead, we spin, polling the IRQ_STAT register for the occurrence
- * of any interrupt with core clock down to the memory clock.
- */
 static inline void arch_idle(void)
 {
-	const char *irq_stat = (char *)0xff000000;
-
-	/* disable clock switching */
-	asm volatile ("mcr p15, 0, ip, c15, c2, 2" : : : "cc");
-
-	/* wait for an interrupt to occur */
-	while (!*irq_stat);
-
-	/* enable clock switching */
-	asm volatile ("mcr p15, 0, ip, c15, c1, 2" : : : "cc");
+	cpu_do_idle();
 }
 
 #define arch_reset(mode, cmd)	cpu_reset(0x80000000)
-- 
1.7.7.1.431.g10b2a
