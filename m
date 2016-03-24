From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 24 Mar 2016 13:08:49 +0800
Subject: [PATCH 1/2] arm64: cpuidle: remove cpu_ops check from
 arm_cpuidle_suspend()
In-Reply-To: <1458796130-6109-1-git-send-email-jszhang@marvell.com>
References: <1458796130-6109-1-git-send-email-jszhang@marvell.com>
Message-ID: <1458796130-6109-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If cpu_ops has not been registered, arm_cpuidle_init() will return
-EOPNOTSUPP, so arm_cpuidle_suspend() will never have chance to
run. In other word, the cpu_ops check can be avoid.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/kernel/cpuidle.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index 9047cab6..bd57c59 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -37,10 +37,9 @@ int arm_cpuidle_suspend(int index)
 	int cpu = smp_processor_id();
 
 	/*
-	 * If cpu_ops have not been registered or suspend
-	 * has not been initialized, cpu_suspend call fails early.
+	 * If suspend has not been initialized, cpu_suspend call fails early.
 	 */
-	if (!cpu_ops[cpu] || !cpu_ops[cpu]->cpu_suspend)
+	if (!cpu_ops[cpu]->cpu_suspend)
 		return -EOPNOTSUPP;
 	return cpu_ops[cpu]->cpu_suspend(index);
 }
-- 
2.8.0.rc3
