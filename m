From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Feb 2013 00:22:12 -0500
Subject: [PATCH v4 15/15] ARM: vexpress: Select multi-cluster SMP operation if
 required
In-Reply-To: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1360041732-17936-16-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@linaro.org>

Signed-off-by: Jon Medhurst <tixy@linaro.org>
Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-vexpress/core.h    |  2 ++
 arch/arm/mach-vexpress/platsmp.c | 12 ++++++++++++
 arch/arm/mach-vexpress/v2m.c     |  2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-vexpress/core.h
index f134cd4a85..3a761fd76c 100644
--- a/arch/arm/mach-vexpress/core.h
+++ b/arch/arm/mach-vexpress/core.h
@@ -6,6 +6,8 @@
 
 void vexpress_dt_smp_map_io(void);
 
+void vexpress_smp_init_ops(void);
+
 extern struct smp_operations	vexpress_smp_ops;
 
 extern void vexpress_cpu_die(unsigned int cpu);
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index c5d70de9bb..667344b479 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/smp.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/vexpress.h>
 
@@ -206,3 +207,14 @@ struct smp_operations __initdata vexpress_smp_ops = {
 	.cpu_die		= vexpress_cpu_die,
 #endif
 };
+
+void __init vexpress_smp_init_ops(void)
+{
+	struct smp_operations *ops = &vexpress_smp_ops;
+#ifdef CONFIG_CLUSTER_PM
+	extern struct smp_operations mcpm_smp_ops;
+	if(of_find_compatible_node(NULL, NULL, "arm,cci"))
+		ops = &mcpm_smp_ops;
+#endif
+	smp_set_ops(ops);
+}
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 011661a6c5..34172bd504 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -494,7 +494,7 @@ static const char * const v2m_dt_match[] __initconst = {
 
 DT_MACHINE_START(VEXPRESS_DT, "ARM-Versatile Express")
 	.dt_compat	= v2m_dt_match,
-	.smp		= smp_ops(vexpress_smp_ops),
+	.smp_init	= smp_init_ops(vexpress_smp_init_ops),
 	.map_io		= v2m_dt_map_io,
 	.init_early	= v2m_dt_init_early,
 	.init_irq	= v2m_dt_init_irq,
-- 
1.8.1.2
