From: jorge.ramirez-ortiz@linaro.org (Jorge Ramirez-Ortiz)
Date: Wed, 13 May 2015 16:38:23 -0400
Subject: [PATCH] arm: topology: fix capacity calculation on SMP SoCs
Message-ID: <1431549503-11799-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit sets the capacity of the average CPU in SMP systems to
SCHED_CAPACITY_SCALE.

Ignoring the condition "min_capacity==max_capacity" causes the function
update_cpu_capacity( .. ) to generate out of range values [1]. This is
because the default value of middle_capacity is used in the final
calculation instead of a valid scaling factor.

Incidentally, when out of range values are generated and if
SCHED_FEAT(ARCH_POWER, true), the load balancing algorithm makes the
wrong decisions typically overallocating work on one of the cores
while leaving the others unused.

[1] val > SCHED_CAPACITY_SCALE

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm/kernel/topology.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 08b7847..509bc9b 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -137,14 +137,14 @@ static void __init parse_dt_topology(void)
 		cpu_capacity(cpu) = capacity;
 	}
 
-	/* If min and max capacities are equals, we bypass the update of the
-	 * cpu_scale because all CPUs have the same capacity. Otherwise, we
-	 * compute a middle_capacity factor that will ensure that the capacity
+	/* Compute a middle_capacity factor that will ensure that the capacity
 	 * of an 'average' CPU of the system will be as close as possible to
 	 * SCHED_CAPACITY_SCALE, which is the default value, but with the
 	 * constraint explained near table_efficiency[].
 	 */
-	if (4*max_capacity < (3*(max_capacity + min_capacity)))
+	if (min_capacity == max_capacity)
+		middle_capacity = min_capacity >> SCHED_CAPACITY_SHIFT;
+	else if (4*max_capacity < (3*(max_capacity + min_capacity)))
 		middle_capacity = (min_capacity + max_capacity)
 				>> (SCHED_CAPACITY_SHIFT+1);
 	else
-- 
2.1.4
