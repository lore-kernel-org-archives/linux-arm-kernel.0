From: digetx@gmail.com (Dmitry Osipenko)
Date: Tue, 19 Jun 2018 14:00:23 +0300
Subject: [PATCH v2 1/5] ARM: trusted_foundations: Implement L2 cache
 initialization callback
In-Reply-To: <20180619110027.16935-1-digetx@gmail.com>
References: <20180619110027.16935-1-digetx@gmail.com>
Message-ID: <20180619110027.16935-2-digetx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement L2 cache initialization firmware callback that should be invoked
early in boot to enable cache HW.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/firmware/trusted_foundations.c | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
index 3fb1b5a1dce9..30df6547020f 100644
--- a/arch/arm/firmware/trusted_foundations.c
+++ b/arch/arm/firmware/trusted_foundations.c
@@ -18,8 +18,13 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <asm/firmware.h>
+#include <asm/outercache.h>
 #include <asm/trusted_foundations.h>
 
+#define TF_CACHE_MAINT		0xfffff100
+
+#define TF_CACHE_INIT		1
+
 #define TF_SET_CPU_BOOT_ADDR_SMC 0xfffff200
 
 #define TF_CPU_PM		0xfffffffc
@@ -63,9 +68,31 @@ static int tf_prepare_idle(void)
 	return 0;
 }
 
+#ifdef CONFIG_CACHE_L2X0
+static void tf_cache_write_sec(unsigned long val, unsigned int reg)
+{
+	/*
+	 * The L2X0 cache driver shouldn't invoke a write to a secure registers,
+	 * though it's better to reinsure by printing a warning message.
+	 */
+	pr_warn("%s: Ignoring write [0x%x]: 0x%08lx\n", __func__, reg, val);
+}
+
+static int tf_init_cache(void)
+{
+	outer_cache.write_sec = tf_cache_write_sec;
+	tf_generic_smc(TF_CACHE_MAINT, TF_CACHE_INIT, 0);
+
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
-- 
2.17.1
