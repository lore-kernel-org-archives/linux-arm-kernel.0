From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 22 Dec 2009 18:54:56 +0800
Subject: [PATCH 09/11] arm-dt: probe for device-tree enabled platforms
In-Reply-To: <1261479296.245235.191110925832.0.gpush@pororo>
Message-ID: <1261479296.248359.837563567032.9.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a probe_dt pointer to struct machine_desc, which can be populated by
platforms that support discovery via device trees.

At setup_arch time, each compiled-in machine_desc with a dt_probe member
will be probed. If the probe function returns 1, we have a match.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/include/asm/mach/arch.h |   10 ++++++++++
 arch/arm/kernel/devtree.c        |   19 ++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index c59842d..b83af35 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -41,6 +41,7 @@ struct machine_desc {
 	void			(*init_irq)(void);
 	struct sys_timer	*timer;		/* system tick timer	*/
 	void			(*init_machine)(void);
+	int			(*probe_dt)(unsigned long root);
 };
 
 /*
@@ -57,4 +58,13 @@ static const struct machine_desc __mach_desc_##_type	\
 #define MACHINE_END				\
 };
 
+#define MACH_TYPE_DT	0xffffffff
+
+#define DT_MACHINE_START(_name, _namestr)		\
+static const struct machine_desc __mach_desc_##_name	\
+ __used							\
+ __attribute__((__section__(".arch.info.init"))) = {	\
+	.nr		= MACH_TYPE_DT,			\
+	.name		= _namestr,
+
 #endif
diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index a8496f6..2ff4bd0 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -17,6 +17,7 @@
 
 #include <asm/setup.h>
 #include <asm/page.h>
+#include <asm/mach/arch.h>
 
 struct device_node *of_chosen;
 
@@ -52,5 +53,21 @@ int __init early_init_dt_scan_cpus(unsigned long node, const char *uname,
 
 struct machine_desc * __init parse_devicetree(void *devtree)
 {
-	return NULL;
+	extern struct machine_desc __arch_info_begin, __arch_info_end;
+	struct machine_desc *mdesc;
+	unsigned long dt_root;
+
+	early_init_devtree(devtree);
+
+	dt_root = of_get_flat_dt_root();
+
+	for (mdesc = &__arch_info_begin; mdesc < &__arch_info_end; mdesc++) {
+		if (mdesc->probe_dt && mdesc->probe_dt(dt_root))
+			break;
+	}
+
+	if (mdesc >= &__arch_info_end)
+		return NULL;
+
+	return mdesc;
 }
