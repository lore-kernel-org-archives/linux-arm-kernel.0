From: lenb@kernel.org (Len Brown)
Date: Sun, 10 Feb 2013 00:58:14 -0500
Subject: [PATCH 07/16] ARM64 idle: delete pm_idle
In-Reply-To: <1360475903-30007-1-git-send-email-lenb@kernel.org>
References: <1360475903-30007-1-git-send-email-lenb@kernel.org>
Message-ID: <c09e2c0f2928cfe6173bcafe0d906bf87287d5c2.1360475150.git.len.brown@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Len Brown <len.brown@intel.com>

pm_idle() on arm64 was a synonym for default_idle(),
so remove it and invoke default_idle() directly.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm64/kernel/process.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index cb0956b..c7002d4 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -97,14 +97,9 @@ static void default_idle(void)
 	local_irq_enable();
 }
 
-void (*pm_idle)(void) = default_idle;
-EXPORT_SYMBOL_GPL(pm_idle);
-
 /*
- * The idle thread, has rather strange semantics for calling pm_idle,
- * but this is what x86 does and we need to do the same, so that
- * things like cpuidle get called in the same way.  The only difference
- * is that we always respect 'hlt_counter' to prevent low power idle.
+ * The idle thread.
+ * We always respect 'hlt_counter' to prevent low power idle.
  */
 void cpu_idle(void)
 {
@@ -122,10 +117,10 @@ void cpu_idle(void)
 			local_irq_disable();
 			if (!need_resched()) {
 				stop_critical_timings();
-				pm_idle();
+				default_idle();
 				start_critical_timings();
 				/*
-				 * pm_idle functions should always return
+				 * default_idle functions should always return
 				 * with IRQs enabled.
 				 */
 				WARN_ON(irqs_disabled());
-- 
1.8.1.3.535.ga923c31
