From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 24 Mar 2016 13:11:08 +0800
Subject: [PATCH 1/2] ARM: cpuidle: fix !cpuidle_ops[cpu].init case during init
In-Reply-To: <1458796269-6158-1-git-send-email-jszhang@marvell.com>
References: <1458796269-6158-1-git-send-email-jszhang@marvell.com>
Message-ID: <1458796269-6158-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's assume cpuidle_ops exists but it doesn't implement the according
init member, current arm_cpuidle_init() will return success to its
caller, but in fact it should return -EOPNOTSUPP.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/kernel/cpuidle.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
index 703926e..f108d8f 100644
--- a/arch/arm/kernel/cpuidle.c
+++ b/arch/arm/kernel/cpuidle.c
@@ -143,8 +143,12 @@ int __init arm_cpuidle_init(int cpu)
 		return -ENODEV;
 
 	ret = arm_cpuidle_read_ops(cpu_node, cpu);
-	if (!ret && cpuidle_ops[cpu].init)
-		ret = cpuidle_ops[cpu].init(cpu_node, cpu);
+	if (!ret) {
+		if (cpuidle_ops[cpu].init)
+			ret = cpuidle_ops[cpu].init(cpu_node, cpu);
+		else
+			ret = -EOPNOTSUPP;
+	}
 
 	of_node_put(cpu_node);
 
-- 
2.8.0.rc3
