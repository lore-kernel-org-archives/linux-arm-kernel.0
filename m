From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 31 Mar 2016 17:31:06 +0800
Subject: [PATCH v3 1/2] ARM: cpuidle: fix !cpuidle_ops[cpu].init case during
 init
In-Reply-To: <1459416667-307-1-git-send-email-jszhang@marvell.com>
References: <1459416667-307-1-git-send-email-jszhang@marvell.com>
Message-ID: <1459416667-307-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's assume cpuidle_ops exists but it doesn't implement the according
init callback, current arm_cpuidle_init() will return success to its
caller, but in fact it should return -EOPNOTSUPP.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/kernel/cpuidle.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
index 703926e..18b5a73 100644
--- a/arch/arm/kernel/cpuidle.c
+++ b/arch/arm/kernel/cpuidle.c
@@ -92,7 +92,8 @@ static struct cpuidle_ops *__init arm_cpuidle_get_ops(const char *method)
  * process.
  *
  * Return 0 on sucess, -ENOENT if no 'enable-method' is defined, -EOPNOTSUPP if
- * no cpuidle_ops is registered for the 'enable-method'.
+ * no cpuidle_ops is registered for the 'enable-method', or if no init callback
+ * is defined.
  */
 static int __init arm_cpuidle_read_ops(struct device_node *dn, int cpu)
 {
@@ -110,6 +111,12 @@ static int __init arm_cpuidle_read_ops(struct device_node *dn, int cpu)
 		return -EOPNOTSUPP;
 	}
 
+	if (!ops->init) {
+		pr_warn("cpuidle_ops '%s': no init callback\n",
+			enable_method);
+		return -EOPNOTSUPP;
+	}
+
 	cpuidle_ops[cpu] = *ops; /* structure copy */
 
 	pr_notice("cpuidle: enable-method property '%s'"
@@ -129,7 +136,8 @@ static int __init arm_cpuidle_read_ops(struct device_node *dn, int cpu)
  * Returns:
  *  0 on success,
  *  -ENODEV if it fails to find the cpu node in the device tree,
- *  -EOPNOTSUPP if it does not find a registered cpuidle_ops for this cpu,
+ *  -EOPNOTSUPP if it does not find a registered and valid cpuidle_ops for
+ *  this cpu,
  *  -ENOENT if it fails to find an 'enable-method' property,
  *  -ENXIO if the HW reports a failure or a misconfiguration,
  *  -ENOMEM if the HW report an memory allocation failure 
@@ -143,7 +151,7 @@ int __init arm_cpuidle_init(int cpu)
 		return -ENODEV;
 
 	ret = arm_cpuidle_read_ops(cpu_node, cpu);
-	if (!ret && cpuidle_ops[cpu].init)
+	if (!ret)
 		ret = cpuidle_ops[cpu].init(cpu_node, cpu);
 
 	of_node_put(cpu_node);
-- 
2.8.0.rc3
