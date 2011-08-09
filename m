From: will.deacon@arm.com (Will Deacon)
Date: Tue,  9 Aug 2011 22:42:42 +0100
Subject: [RFC PATCH 8/8] ARM: versatile: convert logical CPU numbers to
	physical numbers
In-Reply-To: <1312926162-22469-1-git-send-email-will.deacon@arm.com>
References: <1312926162-22469-1-git-send-email-will.deacon@arm.com>
Message-ID: <1312926162-22469-9-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses the new cpu_logical_map() macro for converting logical
CPU numbers into physical numbers when dealing with the pen_release
variable in the SMP boot and CPU hotplug paths.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-realview/hotplug.c  |    2 +-
 arch/arm/mach-vexpress/hotplug.c  |    2 +-
 arch/arm/plat-versatile/platsmp.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-realview/hotplug.c b/arch/arm/mach-realview/hotplug.c
index a87523d..ac1aed2 100644
--- a/arch/arm/mach-realview/hotplug.c
+++ b/arch/arm/mach-realview/hotplug.c
@@ -69,7 +69,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 		    :
 		    : "memory", "cc");
 
-		if (pen_release == cpu) {
+		if (pen_release == cpu_logical_map(cpu)) {
 			/*
 			 * OK, proper wakeup, we're done
 			 */
diff --git a/arch/arm/mach-vexpress/hotplug.c b/arch/arm/mach-vexpress/hotplug.c
index ea4cbfb..2866ed8 100644
--- a/arch/arm/mach-vexpress/hotplug.c
+++ b/arch/arm/mach-vexpress/hotplug.c
@@ -70,7 +70,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 		    :
 		    : "memory", "cc");
 
-		if (pen_release == cpu) {
+		if (pen_release == cpu_logical_map(cpu)) {
 			/*
 			 * OK, proper wakeup, we're done
 			 */
diff --git a/arch/arm/plat-versatile/platsmp.c b/arch/arm/plat-versatile/platsmp.c
index 51ecfea..92f18d3 100644
--- a/arch/arm/plat-versatile/platsmp.c
+++ b/arch/arm/plat-versatile/platsmp.c
@@ -77,7 +77,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * since we haven't sent them a soft interrupt, they shouldn't
 	 * be there.
 	 */
-	write_pen_release(cpu);
+	write_pen_release(cpu_logical_map(cpu));
 
 	/*
 	 * Send the secondary CPU a soft interrupt, thereby causing
-- 
1.7.0.4
