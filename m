From: gdavis@mvista.com (gdavis at mvista.com)
Date: Thu,  6 Oct 2011 01:08:34 -0400
Subject: [RFC/PATCH 7/7] ARM: ARM11 MPCore: cpu_v6_set_pte_ext is not preempt
	safe
In-Reply-To: <1317877714-11355-1-git-send-email-gdavis@mvista.com>
References: <05942148-7AFB-4755-A22F-355E0360B098@mvista.com>
	<1317877714-11355-1-git-send-email-gdavis@mvista.com>
Message-ID: <1317877714-11355-8-git-send-email-gdavis@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: George G. Davis <gdavis@mvista.com>

If preemption and subsequent task migration occurs during calls to
cpu_v6_set_pte_ext on ARM11 MPCore machines, global memory state
can become inconsistent.  To prevent inconsistent memory state on
these machines, disable preemption in cpu_v6_set_pte_ext.

This changes depends on "ARM: Move get_thread_info macro definition
to <asm/assembler.h>".

Signed-off-by: George G. Davis <gdavis@mvista.com>
---
 arch/arm/mm/proc-v6.S |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index a923aa0..dd2e5e5 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -122,7 +122,18 @@ ENTRY(cpu_v6_switch_mm)
 
 ENTRY(cpu_v6_set_pte_ext)
 #ifdef CONFIG_MMU
+#ifdef CONFIG_PREEMPT
+	ALT_SMP(stmdb	sp!, {r4, r10, r11})
+	ALT_SMP(get_thread_info r10)
+	ALT_SMP(ldr	r4, [r10, #TI_PREEMPT])	@ get preempt count
+	ALT_SMP(add	r11, r4, #1)		@ increment it
+	ALT_SMP(str	r11, [r10, #TI_PREEMPT])	@ disable preempt
+#endif
 	armv6_set_pte_ext cpu_v6
+#ifdef CONFIG_PREEMPT
+	ALT_SMP(str	r4, [r10, #TI_PREEMPT])	@ restore preempt count
+	ALT_SMP(ldmia	sp!, {r4, r10, r11})
+#endif
 #endif
 	mov	pc, lr
 
-- 
1.7.4.4
