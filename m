From: gdavis@mvista.com (gdavis at mvista.com)
Date: Tue, 18 Oct 2011 09:47:34 -0400
Subject: [RFC/PATCH v4 7/7] ARM: ARM11 MPCore: cpu_v6_set_pte_ext is not
	preempt safe
In-Reply-To: <1318945654-548-1-git-send-email-gdavis@mvista.com>
References: <1318004800-6525-1-git-send-email-gdavis@mvista.com>
	<1318945654-548-1-git-send-email-gdavis@mvista.com>
Message-ID: <1318945654-548-8-git-send-email-gdavis@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: George G. Davis <gdavis@mvista.com>

If preemption and subsequent task migration occurs during calls to
cpu_v6_set_pte_ext on ARM11 MPCore machines, global memory state
can become inconsistent.  To prevent inconsistent memory state on
these machines, disable preemption in cpu_v6_set_pte_ext.

This change depends on "ARM: Move get_thread_info macro definition
to <asm/assembler.h>".

Signed-off-by: George G. Davis <gdavis@mvista.com>
---
 arch/arm/mm/proc-v6.S |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index a923aa0..be0ab8d 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -122,7 +122,22 @@ ENTRY(cpu_v6_switch_mm)
 
 ENTRY(cpu_v6_set_pte_ext)
 #ifdef CONFIG_MMU
+#if	defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
+	stmdb	sp!, {r4, r5}
+	get_thread_info r5
+	ldr	r4, [r5, #TI_PREEMPT]	@ get preempt count
+	add	r3, r4, #1		@ increment it
+	str	r3, [r5, #TI_PREEMPT]	@ disable preempt
+#endif
 	armv6_set_pte_ext cpu_v6
+#if	defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
+	str	r4, [r5, #TI_PREEMPT]	@ restore preempt count
+	teq	r4, #0			@ preempt count == 0?
+	ldreq	r4, [r5, #TI_FLAGS]	@ load flags if yes
+	tst	r4, #_TIF_NEED_RESCHED	@ need resched?
+	ldmia	sp!, {r4, r5}
+	bne	preempt_schedule	@ ret via preempt_schedule
+#endif
 #endif
 	mov	pc, lr
 
-- 
1.7.4.4
