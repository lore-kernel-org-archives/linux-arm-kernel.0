From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 24 Mar 2016 13:11:09 +0800
Subject: [PATCH 2/2] ARM: cpuidle: make arm_cpuidle_suspend() a bit more
 efficient
In-Reply-To: <1458796269-6158-1-git-send-email-jszhang@marvell.com>
References: <1458796269-6158-1-git-send-email-jszhang@marvell.com>
Message-ID: <1458796269-6158-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, we check cpuidle_ops.suspend every time when entering a
low-power idle state. But this check could be avoided in this hot path
by moving it into arm_cpuidle_init() to reduce arm_cpuidle_suspend()
overhead a bit.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/kernel/cpuidle.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
index f108d8f..bf68d49 100644
--- a/arch/arm/kernel/cpuidle.c
+++ b/arch/arm/kernel/cpuidle.c
@@ -52,13 +52,9 @@ int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
  */
 int arm_cpuidle_suspend(int index)
 {
-	int ret = -EOPNOTSUPP;
 	int cpu = smp_processor_id();
 
-	if (cpuidle_ops[cpu].suspend)
-		ret = cpuidle_ops[cpu].suspend(index);
-
-	return ret;
+	return cpuidle_ops[cpu].suspend(index);
 }
 
 /**
@@ -144,7 +140,7 @@ int __init arm_cpuidle_init(int cpu)
 
 	ret = arm_cpuidle_read_ops(cpu_node, cpu);
 	if (!ret) {
-		if (cpuidle_ops[cpu].init)
+		if (cpuidle_ops[cpu].init && cpuidle_ops[cpu].suspend)
 			ret = cpuidle_ops[cpu].init(cpu_node, cpu);
 		else
 			ret = -EOPNOTSUPP;
-- 
2.8.0.rc3
