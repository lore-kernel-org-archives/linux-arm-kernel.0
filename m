From: zhizhou.zh@gmail.com (Zhi-zhou Zhang)
Date: Sat, 26 Dec 2015 13:57:18 +0800
Subject: [PATCH] arm64: entry.S: add missing trace_hardirqs_off
Message-ID: <1451109438-5834-1-git-send-email-zhizhou.zh@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before calling schedule, we should trace hardirqs correctly. If not,
we get following warning message when enabled CONFIG_DEBUG_LOCKDEP:

[    9.243073] DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)
[ ... ]
[    9.262681] possible reason: unannotated irqs-off.
[    9.263018] irq event stamp: 256209
[    9.263266] hardirqs last  enabled at (256209): [<ffffffc000085a98>] el0_irq_naked+0x1c/0x24
[    9.263820] hardirqs last disabled at (256207): [<ffffffc0000bad20>] __do_softirq+0x170/0x28c
[    9.264419] softirqs last  enabled at (256208): [<ffffffc0000bad9c>] __do_softirq+0x1ec/0x28c
[    9.264976] softirqs last disabled at (256189): [<ffffffc0000bb194>] irq_exit+0x9c/0xec

Signed-off-by: Zhi-zhou Zhang <zhizhou.zh@gmail.com>
---
 arch/arm64/kernel/entry.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 7ed3d75..4769190 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -634,6 +634,9 @@ work_pending:
 	bl	do_notify_resume
 	b	ret_to_user
 work_resched:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	trace_hardirqs_off
+#endif
 	bl	schedule
 
 /*
-- 
2.1.4
