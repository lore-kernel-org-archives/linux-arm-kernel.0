From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Jun 2018 16:06:17 +0200
Subject: [PATCH 06/15] ARM: shmobile: apmu: Move cpu_leave_lowpower() to
 SUSPEND section
In-Reply-To: <cover.1529934908.git.horms+renesas@verge.net.au>
References: <cover.1529934908.git.horms+renesas@verge.net.au>
Message-ID: <fa6e9cb2aca1cdca1b85e5b19f9cda8aac78752b.1529934908.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

cpu_leave_lowpower() is used for suspend only, not for CPU hotplug.
Hence move it from the HOTPLUG_CPU || SUSPEND section to the SUSPEND
section.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index ba732effc90b..778b6b618ce7 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -270,21 +270,6 @@ static void shmobile_smp_apmu_cpu_shutdown(unsigned int cpu)
 	/* Do ARM specific CPU shutdown */
 	cpu_enter_lowpower_a15();
 }
-
-static inline void cpu_leave_lowpower(void)
-{
-	unsigned int v;
-
-	asm volatile("mrc    p15, 0, %0, c1, c0, 0\n"
-		     "       orr     %0, %0, %1\n"
-		     "       mcr     p15, 0, %0, c1, c0, 0\n"
-		     "       mrc     p15, 0, %0, c1, c0, 1\n"
-		     "       orr     %0, %0, %2\n"
-		     "       mcr     p15, 0, %0, c1, c0, 1\n"
-		     : "=&r" (v)
-		     : "Ir" (CR_C), "Ir" (0x40)
-		     : "cc");
-}
 #endif
 
 #if defined(CONFIG_HOTPLUG_CPU)
@@ -315,6 +300,21 @@ static int shmobile_smp_apmu_do_suspend(unsigned long cpu)
 	return 1;
 }
 
+static inline void cpu_leave_lowpower(void)
+{
+	unsigned int v;
+
+	asm volatile("mrc    p15, 0, %0, c1, c0, 0\n"
+		     "       orr     %0, %0, %1\n"
+		     "       mcr     p15, 0, %0, c1, c0, 0\n"
+		     "       mrc     p15, 0, %0, c1, c0, 1\n"
+		     "       orr     %0, %0, %2\n"
+		     "       mcr     p15, 0, %0, c1, c0, 1\n"
+		     : "=&r" (v)
+		     : "Ir" (CR_C), "Ir" (0x40)
+		     : "cc");
+}
+
 static int shmobile_smp_apmu_enter_suspend(suspend_state_t state)
 {
 	cpu_suspend(smp_processor_id(), shmobile_smp_apmu_do_suspend);
-- 
2.11.0
