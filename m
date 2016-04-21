From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 21 Apr 2016 09:18:22 +0100
Subject: [PATCH RFC 10/10] ARM: V7M: Add support for the Cortex-M7 processor
In-Reply-To: <1461226702-27160-1-git-send-email-vladimir.murzin@arm.com>
References: <1461226702-27160-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1461226702-27160-11-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Austin <jonathan.austin@arm.com>

Cortex-M7 is a new member of the V7M processor family that adds, among
other things, caches over the features available in Cortex-M4.

This patch adds support for recognising the processor at boot time, and
make use of recently introduced cache functions.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/mm/proc-v7m.S |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
index 796a983..60387a0 100644
--- a/arch/arm/mm/proc-v7m.S
+++ b/arch/arm/mm/proc-v7m.S
@@ -15,6 +15,7 @@
 #include <asm/memory.h>
 #include <asm/v7m.h>
 #include "proc-macros.S"
+#include "v7m-cache-macros.S"
 
 ENTRY(cpu_v7m_proc_init)
 	ret	lr
@@ -74,6 +75,25 @@ ENTRY(cpu_v7m_do_resume)
 ENDPROC(cpu_v7m_do_resume)
 #endif
 
+ENTRY(cpu_cm7_dcache_clean_area)
+	dcache_line_size r2, r3
+1:	dccmvac r0, r3				@ clean D entry
+	add	r0, r0, r2
+	subs	r1, r1, r2
+	bhi	1b
+	dsb
+	ret	lr
+ENDPROC(cpu_cm7_dcache_clean_area)
+
+ENTRY(cpu_cm7_proc_fin)
+	movw	r2, #:lower16:(BASEADDR_V7M_SCB + V7M_SCB_CCR)
+	movt	r2, #:upper16:(BASEADDR_V7M_SCB + V7M_SCB_CCR)
+	ldr	r0, [r2]
+	bic	r0, r0, #(V7M_SCB_CCR_DC | V7M_SCB_CCR_IC)
+	str	r0, [r2]
+	ret	lr
+ENDPROC(cpu_cm7_proc_fin)
+
 	.section ".text.init", #alloc, #execinstr
 
 /*
@@ -120,10 +140,22 @@ __v7m_setup:
 	@ Note the STKALIGN bit is either RW or RAO.
 	ldr	r0, [r0, V7M_SCB_CCR]   @ system control register
 	orr	r0, #V7M_SCB_CCR_STKALIGN
+	read_ctr r12
+	teq     r12, #0
+	orrne   r0, r0, #(V7M_SCB_CCR_DC | V7M_SCB_CCR_IC| V7M_SCB_CCR_BP)
 	ret	lr
 ENDPROC(__v7m_setup)
 
+/*
+ * Cortex-M7 processor functions
+ */
+	globl_equ	cpu_cm7_proc_init,	cpu_v7m_proc_init
+	globl_equ	cpu_cm7_reset,		cpu_v7m_reset
+	globl_equ	cpu_cm7_do_idle,	cpu_v7m_do_idle
+	globl_equ	cpu_cm7_switch_mm,	cpu_v7m_switch_mm
+
 	define_processor_functions v7m, dabort=nommu_early_abort, pabort=legacy_pabort, nommu=1
+	define_processor_functions cm7, dabort=nommu_early_abort, pabort=legacy_pabort, nommu=1
 
 	.section ".rodata"
 	string cpu_arch_name, "armv7m"
@@ -147,6 +179,16 @@ ENDPROC(__v7m_setup)
 .endm
 
 	/*
+	 * Match ARM Cortex-M7 processor.
+	 */
+	.type	__v7m_cm7_proc_info, #object
+__v7m_cm7_proc_info:
+	.long	0x410fc270		/* ARM Cortex-M7 0xC27 */
+	.long	0xff0ffff0		/* Mask off revision, patch release */
+	__v7m_proc __v7m_cm7_proc_info, __v7m_setup, hwcaps = HWCAP_EDSP, cache_fns = v7_cache_fns, proc_fns = cm7_processor_functions
+	.size	__v7m_cm7_proc_info, . - __v7m_cm7_proc_info
+
+	/*
 	 * Match ARM Cortex-M4 processor.
 	 */
 	.type	__v7m_cm4_proc_info, #object
-- 
1.7.9.5
