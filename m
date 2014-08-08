From: juri.lelli@arm.com (Juri Lelli)
Date: Fri,  8 Aug 2014 13:42:37 +0100
Subject: [PATCH] cpuidle/cpuidle-big_little: fix reading cpu id part number
Message-ID: <1407501757-15231-1-git-send-email-juri.lelli@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit af040ffc9ba1 ("ARM: make it easier to check the CPU part number
correctly") changed ARM_CPU_PART_X masks, and the way they are returned and
checked against. Usage of read_cpuid_part_number() is now deprecated, and
calling places updated accordingly. This actually broke cpuidle-big_little
initialization, as bl_idle_driver_init() performs a check using and hardcoded
mask on cpu_id.

Update the check to reflect changes on ARM_CPU_PART_X masks. Also,
make the check easier to understand.

Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-pm at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Cc: Juri Lelli <juri.lelli@gmail.com>
---
 drivers/cpuidle/cpuidle-big_little.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
index b45fc62..a712896 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -138,7 +138,7 @@ static int bl_enter_powerdown(struct cpuidle_device *dev,
 	return idx;
 }
 
-static int __init bl_idle_driver_init(struct cpuidle_driver *drv, int cpu_id)
+static int __init bl_idle_driver_init(struct cpuidle_driver *drv, int match_id)
 {
 	struct cpuinfo_arm *cpu_info;
 	struct cpumask *cpumask;
@@ -154,7 +154,7 @@ static int __init bl_idle_driver_init(struct cpuidle_driver *drv, int cpu_id)
 		cpuid = is_smp() ? cpu_info->cpuid : read_cpuid_id();
 
 		/* read cpu id part number */
-		if ((cpuid & 0xFFF0) == cpu_id)
+		if (((cpuid ^ match_id) & 0xFF00FFF0) == 0)
 			cpumask_set_cpu(cpu, cpumask);
 	}
 
-- 
1.7.9.5
