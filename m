From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon,  4 Mar 2013 14:43:03 -0800
Subject: [PATCH 2/2] ARM: Enable tracing around vfp preemption enable/disable
In-Reply-To: <1362436983-28988-1-git-send-email-sboyd@codeaurora.org>
References: <1362436983-28988-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1362436983-28988-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VFP code enables and disables preemption but doesn't call
into the tracer except for in the VFP bounce code to say that
preemption has been enabled again. Trace the preemption disable
and enable calls made in assembly so that we can accurately
measure how long preemption is disabled while handling VFP
exceptions.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/kernel/entry-header.S | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 130e6a6..75bcb18 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -165,19 +165,33 @@
 
 	.macro preempt_enable_no_resched, tsk, cnt
 #ifdef CONFIG_PREEMPT_COUNT
+#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_PREEMPT_TRACER)
+	stmdb   sp!, {r0-r3, ip, lr}
+	mov	r0, #1
+	bl	sub_preempt_count
+	ldmia	sp!, {r0-r3, ip, lr}
+#else
 	get_thread_info	\tsk
 	ldr	\cnt, [\tsk, #TI_PREEMPT]	@ get preempt count
 	sub	\cnt, \cnt, #1			@ decrement it
 	str	\cnt, [\tsk, #TI_PREEMPT]
 #endif
+#endif
 	.endm
 
 	.macro preempt_disable, tsk, cnt
 #ifdef CONFIG_PREEMPT_COUNT
+#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_PREEMPT_TRACER)
+	stmdb   sp!, {r0-r3, ip, lr}
+	mov	r0, #1
+	bl	add_preempt_count
+	ldmia	sp!, {r0-r3, ip, lr}
+#else
 	ldr	\cnt, [\tsk, #TI_PREEMPT]	@ get preempt count
 	add	\cnt, \cnt, #1			@ increment it
 	str	\cnt, [\tsk, #TI_PREEMPT]
 #endif
+#endif
 	.endm
 
 /*
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
