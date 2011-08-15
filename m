From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Aug 2011 18:30:49 +0100
Subject: [PATCH v2 5/8] ARM: msm: convert logical CPU numbers to physical
	numbers
In-Reply-To: <1313429452-2820-1-git-send-email-will.deacon@arm.com>
References: <1313429452-2820-1-git-send-email-will.deacon@arm.com>
Message-ID: <1313429452-2820-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses the new cpu_logical_map() macro for converting logical
CPU numbers into physical numbers when dealing with the pen_release
variable in the SMP boot and CPU hotplug paths.

Tested-and-acked-by: David Brown <davidb@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-msm/hotplug.c |    2 +-
 arch/arm/mach-msm/platsmp.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-msm/hotplug.c b/arch/arm/mach-msm/hotplug.c
index 5a31f70..41c252d 100644
--- a/arch/arm/mach-msm/hotplug.c
+++ b/arch/arm/mach-msm/hotplug.c
@@ -37,7 +37,7 @@ static inline void platform_do_lowpower(unsigned int cpu)
 		    :
 		    : "memory", "cc");
 
-		if (pen_release == cpu) {
+		if (pen_release == cpu_logical_map(cpu)) {
 			/*
 			 * OK, proper wakeup, we're done
 			 */
diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
index 1a1af9e..e3375ee 100644
--- a/arch/arm/mach-msm/platsmp.c
+++ b/arch/arm/mach-msm/platsmp.c
@@ -117,7 +117,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * Note that "pen_release" is the hardware CPU ID, whereas
 	 * "cpu" is Linux's internal ID.
 	 */
-	pen_release = cpu;
+	pen_release = cpu_logical_map(cpu);
 	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
 	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
 
-- 
1.7.0.4
