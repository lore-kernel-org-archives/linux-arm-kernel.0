From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 23 Sep 2013 19:17:55 -0400
Subject: [PATCH 12/13] ARM: bL_switcher/trace: Add kernel trace trigger
 interface
In-Reply-To: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
References: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1379978276-31241-13-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <dave.martin@linaro.org>

This patch exports a bL_switcher_trace_trigger() function to
provide a means for drivers using the trace events to get the
current status when starting a trace session.

Calling this function is equivalent to pinging the trace_trigger
file in sysfs.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/common/bL_switcher.c      | 3 ++-
 arch/arm/include/asm/bL_switcher.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index f0dc025077..f4878a3604 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -537,7 +537,7 @@ static void bL_switcher_trace_trigger_cpu(void *__always_unused info)
 	trace_cpu_migrate_current(get_ns(), read_mpidr());
 }
 
-static int bL_switcher_trace_trigger(void)
+int bL_switcher_trace_trigger(void)
 {
 	int ret;
 
@@ -550,6 +550,7 @@ static int bL_switcher_trace_trigger(void)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(bL_switcher_trace_trigger);
 
 static int bL_switcher_enable(void)
 {
diff --git a/arch/arm/include/asm/bL_switcher.h b/arch/arm/include/asm/bL_switcher.h
index 7d1cce8b8a..8ada5a885c 100644
--- a/arch/arm/include/asm/bL_switcher.h
+++ b/arch/arm/include/asm/bL_switcher.h
@@ -54,6 +54,8 @@ int bL_switcher_unregister_notifier(struct notifier_block *nb);
 bool bL_switcher_get_enabled(void);
 void bL_switcher_put_enabled(void);
 
+int bL_switcher_trace_trigger(void);
+
 #else
 static inline int bL_switcher_register_notifier(struct notifier_block *nb)
 {
@@ -67,6 +69,7 @@ static inline int bL_switcher_unregister_notifier(struct notifier_block *nb)
 
 static inline bool bL_switcher_get_enabled(void) { return false; }
 static inline void bL_switcher_put_enabled(void) { }
+static inline int bL_switcher_trace_trigger(void) { return 0; }
 #endif /* CONFIG_BL_SWITCHER */
 
 #endif
-- 
1.8.4.98.gb022869
