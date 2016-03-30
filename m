From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 30 Mar 2016 15:47:57 +0800
Subject: [PATCH v2] ARM: cpuidle: make arm_cpuidle_suspend() a bit more
 efficient
Message-ID: <1459324077-7116-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, we check cpuidle_ops.suspend every time when entering a
low-power idle state. But this check could be avoided in this hot path
by moving it into arm_cpuidle_read_ops() to reduce arm_cpuidle_suspend
overhead a bit.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
Since v1:
 - drop patch1, I.E "ARM: cpuidle: fix !cpuidle_ops[cpu].init case
   during init", because there may be platforms which doesn't need the
   init member at all.
 - adopt Daniel's suggestion to move the cpuidle_ops.suspend check to
   arm_cpuidle_read_ops().

 arch/arm/kernel/cpuidle.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
index 703926e..e63388e 100644
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
@@ -92,7 +87,8 @@ static struct cpuidle_ops *__init arm_cpuidle_get_ops(const char *method)
  * process.
  *
  * Return 0 on sucess, -ENOENT if no 'enable-method' is defined, -EOPNOTSUPP if
- * no cpuidle_ops is registered for the 'enable-method'.
+ * no cpuidle_ops is registered for the 'enable-method', or if no suspend
+ * callback is defined.
  */
 static int __init arm_cpuidle_read_ops(struct device_node *dn, int cpu)
 {
@@ -110,6 +106,12 @@ static int __init arm_cpuidle_read_ops(struct device_node *dn, int cpu)
 		return -EOPNOTSUPP;
 	}
 
+	if (!ops->suspend) {
+		pr_warn("cpuidle_ops '%s': no suspend callback\n",
+			enable_method);
+		return -EOPNOTSUPP;
+	}
+
 	cpuidle_ops[cpu] = *ops; /* structure copy */
 
 	pr_notice("cpuidle: enable-method property '%s'"
@@ -129,7 +131,8 @@ static int __init arm_cpuidle_read_ops(struct device_node *dn, int cpu)
  * Returns:
  *  0 on success,
  *  -ENODEV if it fails to find the cpu node in the device tree,
- *  -EOPNOTSUPP if it does not find a registered cpuidle_ops for this cpu,
+ *  -EOPNOTSUPP if it does not find a registered and valid cpuidle_ops for
+ *   this cpu,
  *  -ENOENT if it fails to find an 'enable-method' property,
  *  -ENXIO if the HW reports a failure or a misconfiguration,
  *  -ENOMEM if the HW report an memory allocation failure 
-- 
2.8.0.rc3
