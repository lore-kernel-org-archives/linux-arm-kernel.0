From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 6 Jul 2016 14:15:55 +0800
Subject: [PATCH v4 2/2] ARM: cpuidle: make arm_cpuidle_suspend() a bit more
 efficient
In-Reply-To: <1467785755-3488-1-git-send-email-jszhang@marvell.com>
References: <1467785755-3488-1-git-send-email-jszhang@marvell.com>
Message-ID: <1467785755-3488-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, we check cpuidle_ops.suspend every time when entering a
low-power idle state. But this check could be avoided in this hot path
by moving it into arm_cpuidle_read_ops() to reduce arm_cpuidle_suspend
overhead a bit.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/kernel/cpuidle.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
index 2129b29..7dccc96 100644
--- a/arch/arm/kernel/cpuidle.c
+++ b/arch/arm/kernel/cpuidle.c
@@ -47,18 +47,13 @@ int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
  * This function calls the underlying arch specific low level PM code as
  * registered at the init time.
  *
- * Returns -EOPNOTSUPP if no suspend callback is defined, the result of the
- * callback otherwise.
+ * Returns the result of the suspend callback.
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
@@ -92,8 +87,8 @@ static const struct cpuidle_ops *__init arm_cpuidle_get_ops(const char *method)
  * process.
  *
  * Return 0 on sucess, -ENOENT if no 'enable-method' is defined, -EOPNOTSUPP if
- * no cpuidle_ops is registered for the 'enable-method', or if no init callback
- * is defined.
+ * no cpuidle_ops is registered for the 'enable-method', or if either init or
+ * suspend callback isn't defined.
  */
 static int __init arm_cpuidle_read_ops(struct device_node *dn, int cpu)
 {
@@ -111,8 +106,8 @@ static int __init arm_cpuidle_read_ops(struct device_node *dn, int cpu)
 		return -EOPNOTSUPP;
 	}
 
-	if (!ops->init) {
-		pr_warn("cpuidle_ops '%s': no init callback\n",
+	if (!ops->init || !ops->suspend) {
+		pr_warn("cpuidle_ops '%s': no init or suspend callback\n",
 			enable_method);
 		return -EOPNOTSUPP;
 	}
-- 
2.8.1
