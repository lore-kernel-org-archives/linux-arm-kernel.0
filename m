From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 22 Mar 2016 22:42:41 +0800
Subject: [PATCH 2/4] ARM: cpuidle: constify return value of
 arm_cpuidle_get_ops()
In-Reply-To: <1458657763-2561-1-git-send-email-jszhang@marvell.com>
References: <1458657763-2561-1-git-send-email-jszhang@marvell.com>
Message-ID: <1458657763-2561-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm_cpuidle_read_ops() just copies '*ops' to cpuidle_ops[cpu], so the
structure '*ops' is not modified at all.

The comment is also updated accordingly.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/kernel/cpuidle.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
index 703926e..a44b268e 100644
--- a/arch/arm/kernel/cpuidle.c
+++ b/arch/arm/kernel/cpuidle.c
@@ -70,7 +70,7 @@ int arm_cpuidle_suspend(int index)
  *
  * Returns a struct cpuidle_ops pointer, NULL if not found.
  */
-static struct cpuidle_ops *__init arm_cpuidle_get_ops(const char *method)
+static const struct cpuidle_ops *__init arm_cpuidle_get_ops(const char *method)
 {
 	struct of_cpuidle_method *m = __cpuidle_method_of_table;
 
@@ -88,7 +88,7 @@ static struct cpuidle_ops *__init arm_cpuidle_get_ops(const char *method)
  *
  * Get the method name defined in the 'enable-method' property, retrieve the
  * associated cpuidle_ops and do a struct copy. This copy is needed because all
- * cpuidle_ops are tagged __initdata and will be unloaded after the init
+ * cpuidle_ops are tagged __initconst and will be unloaded after the init
  * process.
  *
  * Return 0 on sucess, -ENOENT if no 'enable-method' is defined, -EOPNOTSUPP if
@@ -97,7 +97,7 @@ static struct cpuidle_ops *__init arm_cpuidle_get_ops(const char *method)
 static int __init arm_cpuidle_read_ops(struct device_node *dn, int cpu)
 {
 	const char *enable_method;
-	struct cpuidle_ops *ops;
+	const struct cpuidle_ops *ops;
 
 	enable_method = of_get_property(dn, "enable-method", NULL);
 	if (!enable_method)
-- 
2.8.0.rc3
