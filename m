From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 24 Mar 2016 13:08:50 +0800
Subject: [PATCH 2/2] arm64: cpuidle: make arm_cpuidle_suspend() a bit more
 efficient
In-Reply-To: <1458796130-6109-1-git-send-email-jszhang@marvell.com>
References: <1458796130-6109-1-git-send-email-jszhang@marvell.com>
Message-ID: <1458796130-6109-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, we check cpu_ops->cpu_suspend every time when entering a
low-power idle state. But this check could be avoided in this hot path
by moving it into arm_cpuidle_init() to reduce arm_cpuidle_suspend()
overhead a bit.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/kernel/cpuidle.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index bd57c59..e11857f 100644
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
@@ -36,10 +37,5 @@ int arm_cpuidle_suspend(int index)
 {
 	int cpu = smp_processor_id();
 
-	/*
-	 * If suspend has not been initialized, cpu_suspend call fails early.
-	 */
-	if (!cpu_ops[cpu]->cpu_suspend)
-		return -EOPNOTSUPP;
 	return cpu_ops[cpu]->cpu_suspend(index);
 }
-- 
2.8.0.rc3
