From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 20 Oct 2010 16:38:45 -0700
Subject: [RFC/PATCH 1/2] OMAP: PM: add "early" idle notifications
In-Reply-To: <1287617926-24308-1-git-send-email-khilman@deeprootsystems.com>
References: <1287617926-24308-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1287617926-24308-2-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an "early" idle notification chain for device/driver code
that wishes to be notified of idle transitions.

These are called "early" notifiers because they are run early in the
idle path, before interrupts are disabled.  Since interrups are still
enabled, these notifiers can run potentially blocking code.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm.c                 |   27 +++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/common.h |    6 ++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 343e8d6..e927419 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -54,6 +54,33 @@ void omap_idle_notifier_end(void)
 	atomic_notifier_call_chain(&idle_notifier, OMAP_IDLE_END, NULL);
 }
 
+/* idle notifications early in the idle path (interrupts enabled) */
+static BLOCKING_NOTIFIER_HEAD(early_idle_notifier);
+
+void omap_early_idle_notifier_register(struct notifier_block *n)
+{
+	blocking_notifier_chain_register(&early_idle_notifier, n);
+}
+EXPORT_SYMBOL_GPL(omap_early_idle_notifier_register);
+
+void omap_early_idle_notifier_unregister(struct notifier_block *n)
+{
+	blocking_notifier_chain_unregister(&early_idle_notifier, n);
+}
+EXPORT_SYMBOL_GPL(omap_early_idle_notifier_unregister);
+
+void omap_early_idle_notifier_start(void)
+{
+	blocking_notifier_call_chain(&early_idle_notifier,
+				     OMAP_IDLE_START, NULL);
+}
+
+void omap_early_idle_notifier_end(void)
+{
+	blocking_notifier_call_chain(&early_idle_notifier,
+				     OMAP_IDLE_END, NULL);
+}
+
 struct device *omap2_get_mpuss_device(void)
 {
 	WARN_ON_ONCE(!mpu_dev);
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 1ca32cf..1bd57f1 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -106,4 +106,10 @@ extern void omap_idle_notifier_unregister(struct notifier_block *n);
 extern void omap_idle_notifier_start(void);
 extern void omap_idle_notifier_end(void);
 
+/* idle notifications early in the idle path (interrupts enabled) */
+extern void omap_early_idle_notifier_register(struct notifier_block *n);
+extern void omap_early_idle_notifier_unregister(struct notifier_block *n);
+extern void omap_early_idle_notifier_start(void);
+extern void omap_early_idle_notifier_end(void);
+
 #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */
-- 
1.7.2.1
