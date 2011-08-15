From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Aug 2011 18:30:51 +0100
Subject: [PATCH v2 7/8] ARM: ux500: convert logical CPU numbers to physical
	numbers
In-Reply-To: <1313429452-2820-1-git-send-email-will.deacon@arm.com>
References: <1313429452-2820-1-git-send-email-will.deacon@arm.com>
Message-ID: <1313429452-2820-8-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses the new cpu_logical_map() macro for converting logical
CPU numbers into physical numbers when dealing with the pen_release
variable in the SMP boot and CPU hotplug paths.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-ux500/hotplug.c |    2 +-
 arch/arm/mach-ux500/platsmp.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/hotplug.c b/arch/arm/mach-ux500/hotplug.c
index dd8037e..572015e 100644
--- a/arch/arm/mach-ux500/hotplug.c
+++ b/arch/arm/mach-ux500/hotplug.c
@@ -24,7 +24,7 @@ static inline void platform_do_lowpower(unsigned int cpu)
 	for (;;) {
 		__asm__ __volatile__("dsb\n\t" "wfi\n\t"
 				: : : "memory");
-		if (pen_release == cpu) {
+		if (pen_release == cpu_logical_map(cpu)) {
 			/*
 			 * OK, proper wakeup, we're done
 			 */
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index a33df5f..27e5281 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -96,7 +96,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * the holding pen - release it, then wait for it to flag
 	 * that it has been released by resetting pen_release.
 	 */
-	write_pen_release(cpu);
+	write_pen_release(cpu_logical_map(cpu));
 
 	gic_raise_softirq(cpumask_of(cpu), 1);
 
-- 
1.7.0.4
