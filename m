From: mirq-linux@rere.qmqm.pl (=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=)
Date: Sat, 10 Nov 2018 22:02:22 +0100
Subject: [PATCH 2/3] ARM: trusted_foundations: enable L2x0 cache via
 firmware_ops
In-Reply-To: <cover.1541882833.git.mirq-linux@rere.qmqm.pl>
References: <cover.1541882833.git.mirq-linux@rere.qmqm.pl>
Message-ID: <7124870dfcabaea33ca3d7623714887f65654646.1541882833.git.mirq-linux@rere.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use firmware_ops to provide hook for cache initialization through
Trusted Foundations firmware, as some writes need Secure mode.

Avoid l2x0_base conflict (duplication) with PMU driver by sharing
l2x0_name and using l2x0_name as the enable flag there.

Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
---
 arch/arm/firmware/trusted_foundations.c | 46 +++++++++++++++++++++++++
 arch/arm/mm/cache-l2x0.c                |  8 +++++
 2 files changed, 54 insertions(+)

diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
index 689e6565abfc..135068119453 100644
--- a/arch/arm/firmware/trusted_foundations.c
+++ b/arch/arm/firmware/trusted_foundations.c
@@ -17,11 +17,19 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/of.h>
+#include <asm/io.h>
 #include <asm/firmware.h>
+#include <asm/outercache.h>
+#include <asm/hardware/cache-l2x0.h>
 #include <asm/trusted_foundations.h>
 
+#define TF_CACHE_MAINT           0xfffff100
 #define TF_SET_CPU_BOOT_ADDR_SMC 0xfffff200
 
+#define TF_CACHE_INIT		1
+#define TF_CACHE_FLUSH		2
+#define TF_CACHE_REENABLE	4
+
 #define TF_CPU_PM		0xfffffffc
 #define TF_CPU_PM_S3		0xffffffe3
 #define TF_CPU_PM_S2		0xffffffe6
@@ -67,9 +75,47 @@ static int tf_prepare_idle(void)
 	return 0;
 }
 
+#ifdef CONFIG_CACHE_L2X0
+static void tf_write_sec(unsigned long val, unsigned reg)
+{
+	unsigned long cur = readl_relaxed(l2x0_base + reg);
+
+	pr_warn("TF: ignoring write_sec[0x%x]: 0x%08lx -> 0x%08lx\n", reg, cur, val);
+}
+
+static void tf_disable_cache(void)
+{
+	tf_generic_smc(TF_CACHE_MAINT, TF_CACHE_FLUSH, l2x0_way_mask);
+}
+
+static void tf_resume_cache(void)
+{
+	unsigned long aux_val = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
+	tf_generic_smc(TF_CACHE_MAINT, TF_CACHE_REENABLE, aux_val);
+}
+
+static void tf_configure_cache(const struct l2x0_regs *regs)
+{
+	outer_cache.disable = tf_disable_cache;
+	outer_cache.resume = tf_resume_cache;
+}
+
+static int tf_init_cache(void)
+{
+	tf_generic_smc(TF_CACHE_MAINT, TF_CACHE_INIT, 0);
+
+	outer_cache.write_sec = tf_write_sec;
+	outer_cache.configure = tf_configure_cache;
+	return 0;
+}
+#endif /* CONFIG_CACHE_L2X0 */
+
 static const struct firmware_ops trusted_foundations_ops = {
 	.set_cpu_boot_addr = tf_set_cpu_boot_addr,
 	.prepare_idle = tf_prepare_idle,
+#ifdef CONFIG_CACHE_L2X0
+	.l2x0_init = tf_init_cache,
+#endif
 };
 
 void register_trusted_foundations(struct trusted_foundations_platform_data *pd)
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 2b6a023fea3f..f1268e9b35f0 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -30,6 +30,7 @@
 #include <asm/cp15.h>
 #include <asm/cputype.h>
 #include <asm/hardware/cache-l2x0.h>
+#include <asm/firmware.h>
 #include "cache-tauros3.h"
 #include "cache-aurora-l2.h"
 
@@ -37,6 +38,7 @@ struct l2c_init_data {
 	const char *type;
 	unsigned way_size_0;
 	unsigned num_lock;
+	void (*init)(void __iomem *, u32 *, u32 *);
 	void (*of_parse)(const struct device_node *, u32 *, u32 *);
 	void (*enable)(void __iomem *, unsigned);
 	void (*fixup)(void __iomem *, u32, struct outer_cache_fns *);
@@ -1760,6 +1762,7 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 	u32 cache_id;
 	u32 cache_level = 2;
 	bool nosync = false;
+	int err;
 
 	np = of_find_matching_node(NULL, l2x0_ids);
 	if (!np)
@@ -1792,6 +1795,11 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 
 	nosync = of_property_read_bool(np, "arm,outer-sync-disable");
 
+	/* Call firmware init */
+	err = call_firmware_op(l2x0_init);
+	if (err && err != -ENOSYS)
+		return err;
+
 	/* Read back current (default) hardware configuration */
 	if (data->save)
 		data->save(l2x0_base);
-- 
2.19.1
