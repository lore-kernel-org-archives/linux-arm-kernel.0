From: r.herring@freescale.com (Rob Herring)
Date: Fri, 16 Apr 2010 14:35:23 -0500
Subject: [RFC PATCH 09/10] mx5: determine cpu type at runtime
Message-ID: <1271446524-26450-10-git-send-email-r.herring@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rob Herring <r.herring@freescale.com>
---
 arch/arm/mach-mx5/cpu.c                 |   21 +++++++++++++++++++++
 arch/arm/mach-mx5/mm.c                  |    2 +-
 arch/arm/plat-mxc/include/mach/common.h |    1 +
 3 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/cpu.c b/arch/arm/mach-mx5/cpu.c
index e5e0e30..f197089 100644
--- a/arch/arm/mach-mx5/cpu.c
+++ b/arch/arm/mach-mx5/cpu.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <mach/common.h>
 #include <mach/hardware.h>
 
 static int cpu_silicon_rev = -1;
@@ -70,6 +71,26 @@ int mx51_revision(void)
 }
 EXPORT_SYMBOL(mx51_revision);
 
+int mx53_revision(void)
+{
+	if (!cpu_is_mx53())
+		return -EINVAL;
+
+	if (cpu_silicon_rev == -1)
+		query_silicon_parameter();
+
+	return cpu_silicon_rev;
+}
+EXPORT_SYMBOL(mx53_revision);
+
+void mx5_set_cpu_type(void)
+{
+	if (PHYS_OFFSET < MX51_PHYS_OFFSET)
+		mxc_set_cpu_type(MXC_CPU_MX53);
+	else
+		mxc_set_cpu_type(MXC_CPU_MX51);
+}
+
 static int __init post_cpu_init(void)
 {
 	unsigned int reg;
diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index 1b0cf12..53b68c7 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -42,7 +42,7 @@ void __init mx5_map_io(void)
 {
 	void __iomem *base;
 
-	mxc_set_cpu_type(MXC_CPU_MX51);
+	mx5_set_cpu_type();
 	if (cpu_is_mx53())
 		mxc_io_desc[0].pfn -= __phys_to_pfn(0x20000000);
 
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 478cf7b..b933847 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -48,6 +48,7 @@ extern int mxc91231_clocks_init(unsigned long fref);
 extern int mxc_register_gpios(void);
 extern int mxc_register_device(struct platform_device *pdev, void *data);
 extern void mxc_set_cpu_type(unsigned int type);
+extern void mx5_set_cpu_type(void);
 extern void mxc_arch_reset_init(void __iomem *);
 extern void mxc91231_power_off(void);
 extern void mxc91231_arch_reset(int, const char *);
-- 
1.6.0.4
