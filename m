From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri,  6 Mar 2015 16:54:53 -0800
Subject: [PATCH 5/5] ARM: B15: Add suspend/resume hooks
In-Reply-To: <1425689693-31034-1-git-send-email-f.fainelli@gmail.com>
References: <1425689693-31034-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1425689693-31034-6-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Broadcom Brahma-B15 CPU readahead cache registers will be restored
to their Power-on-Reset values after a S3 suspend/resume cycles, so we
want to restore what we had enabled before.

Another thing we want to take care of is disabling the read-ahead cache
prior to suspending to avoid any sort of side effect with the spinlock
we need to grab to serialize register accesses.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mm/cache-b15-rac.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/mm/cache-b15-rac.c b/arch/arm/mm/cache-b15-rac.c
index 73d29741f096..adde1808c478 100644
--- a/arch/arm/mm/cache-b15-rac.c
+++ b/arch/arm/mm/cache-b15-rac.c
@@ -15,6 +15,7 @@
 #include <linux/of_address.h>
 #include <linux/notifier.h>
 #include <linux/cpu.h>
+#include <linux/syscore_ops.h>
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-b15-rac.h>
@@ -43,6 +44,10 @@ extern void v7_flush_icache_all(void);
 					 RACENPREF_MASK << RACENDATA_SHIFT)
 
 #define RAC_ENABLED			(1 << 0)
+/* Special state where we want to bypass the spinlock and call directly
+ * into the v7 cache maintenance operations during suspend/resume
+ */
+#define RAC_SUSPENDED			(1 << 1)
 
 static void __iomem *b15_rac_base;
 static DEFINE_SPINLOCK(rac_lock);
@@ -98,6 +103,12 @@ void b15_flush_##name(void)					\
 	unsigned int do_flush;					\
 	u32 val = 0;						\
 								\
+	if (test_bit(RAC_SUSPENDED, &b15_rac_flags)) {		\
+		v7_flush_##name();				\
+		bar;						\
+		return;						\
+	}							\
+								\
 	spin_lock(&rac_lock);					\
 	do_flush = test_bit(RAC_ENABLED, &b15_rac_flags);	\
 	if (do_flush)						\
@@ -233,6 +244,39 @@ static struct notifier_block b15_rac_cpu_nb = {
 };
 #endif /* CONFIG_HOTPLUG_CPU */
 
+#ifdef CONFIG_PM_SLEEP
+static int b15_rac_suspend(void)
+{
+	/* Suspend the read-ahead cache oeprations, forcing our cache
+	 * implementation to fallback to the regular ARMv7 calls.
+	 *
+	 * We are guaranteed to be running on the boot CPU@this point and
+	 * with every other CPU quiesced, so setting RAC_SUSPENDED is not racy
+	 * here.
+	 */
+	rac_config0_reg = b15_rac_disable_and_flush();
+	set_bit(RAC_SUSPENDED, &b15_rac_flags);
+
+	return 0;
+}
+
+static void b15_rac_resume(void)
+{
+	/* Coming out of a S3 suspend/resume cycle, the read-ahead cache
+	 * register RAC_CONFIG0_REG will be restored to its default value, make
+	 * sure we re-enable it and set the enable flag, we are also guaranteed
+	 * to run on the boot CPU, so not racy again.
+	 */
+	__b15_rac_enable(rac_config0_reg);
+	clear_bit(RAC_SUSPENDED, &b15_rac_flags);
+}
+
+static struct syscore_ops b15_rac_syscore_ops = {
+	.suspend	= b15_rac_suspend,
+	.resume		= b15_rac_resume,
+};
+#endif
+
 static int __init b15_rac_init(void)
 {
 	struct device_node *dn;
@@ -261,6 +305,10 @@ static int __init b15_rac_init(void)
 	}
 #endif
 
+#ifdef CONFIG_PM_SLEEP
+	register_syscore_ops(&b15_rac_syscore_ops);
+#endif
+
 	spin_lock(&rac_lock);
 	reg = __raw_readl(b15_rac_base + RAC_CONFIG0_REG);
 	for_each_possible_cpu(cpu)
-- 
2.1.0
