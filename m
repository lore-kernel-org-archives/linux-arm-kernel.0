From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 25 Mar 2016 11:08:55 +0800
Subject: [PATCH v2] arm64: cpuidle: make arm_cpuidle_suspend() a bit more
 efficient
Message-ID: <1458875335-1843-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, we check two pointers: cpu_ops and cpu_suspend on every idle
state entry. These pointers check can be avoided:

If cpu_ops has not been registered, arm_cpuidle_init() will return
-EOPNOTSUPP, so arm_cpuidle_suspend() will never have chance to
run. In other word, the cpu_ops check can be avoid.

Similarly, the cpu_suspend check could be avoided in this hot path by
moving it into arm_cpuidle_init().

I measured the 4096 * time from arm_cpuidle_suspend entry point to the
cpu_psci_cpu_suspend entry point. HW platform is Marvell BG4CT STB
board.

1. only one shell, no other process, hot-unplug secondary cpus, execute
the following cmd

while true
do
	sleep 0.2
done

before the patch: 1581220ns

after the patch: 1579630ns

reduced by 0.1%

2. only one shell, no other process, hot-unplug secondary cpus, execute
the following cmd

while true
do
	md5sum /tmp/testfile
	sleep 0.2
done

NOTE: the testfile size should be larger than L1+L2 cache size

before the patch: 1961960ns
after the patch: 1912500ns

reduced by 2.5%

So the more complex the system load, the bigger the improvement.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
Since v1:
 - add performance numbers
 - combine two small patches into one
 - add Lorenzo's ack

 arch/arm64/kernel/cpuidle.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index 9047cab6..e11857f 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -19,7 +19,8 @@ int __init arm_cpuidle_init(unsigned int cpu)
 {
 	int ret = -EOPNOTSUPP;
 
-	if (cpu_ops[cpu] && cpu_ops[cpu]->cpu_init_idle)
+	if (cpu_ops[cpu] && cpu_ops[cpu]->cpu_suspend &&
+			cpu_ops[cpu]->cpu_init_idle)
 		ret = cpu_ops[cpu]->cpu_init_idle(cpu);
 
 	return ret;
@@ -36,11 +37,5 @@ int arm_cpuidle_suspend(int index)
 {
 	int cpu = smp_processor_id();
 
-	/*
-	 * If cpu_ops have not been registered or suspend
-	 * has not been initialized, cpu_suspend call fails early.
-	 */
-	if (!cpu_ops[cpu] || !cpu_ops[cpu]->cpu_suspend)
-		return -EOPNOTSUPP;
 	return cpu_ops[cpu]->cpu_suspend(index);
 }
-- 
2.8.0.rc3
