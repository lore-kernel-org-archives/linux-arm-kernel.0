From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 30 May 2018 17:15:26 +0200
Subject: [PATCH 1/3] ARM: shmobile: apmu: Move cpu_leave_lowpower() to SUSPEND
 section
In-Reply-To: <1527693328-10559-1-git-send-email-geert+renesas@glider.be>
References: <1527693328-10559-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1527693328-10559-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cpu_leave_lowpower() is used for suspend only, not for CPU hotplug.
Hence move it from the HOTPLUG_CPU || SUSPEND section to the SUSPEND
section.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index ba732effc90b019f..778b6b618ce7c088 100644
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
2.7.4
