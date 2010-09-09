From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu,  9 Sep 2010 12:58:08 -0700
Subject: [PATCH 3/4] arm: mm: add proc info for ARM11MPCore/Cortex-A9 from ARM
In-Reply-To: <1284062289-10914-1-git-send-email-dwalker@codeaurora.org>
References: <1284062289-10914-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1284062289-10914-4-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setting of these bits can cause issues on other SMP SoC's not produced
by ARM.

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/mm/proc-v7.S |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 6a8506d..60cfab9 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -186,13 +186,14 @@ cpu_v7_name:
  *	It is assumed that:
  *	- cache type register is implemented
  */
-__v7_setup:
+__v7_ca9mp_setup:
 #ifdef CONFIG_SMP
 	mrc	p15, 0, r0, c1, c0, 1
 	tst	r0, #(1 << 6)			@ SMP/nAMP mode enabled?
 	orreq	r0, r0, #(1 << 6) | (1 << 0)	@ Enable SMP/nAMP mode and
 	mcreq	p15, 0, r0, c1, c0, 1		@ TLB ops broadcasting
 #endif
+__v7_setup:
 	adr	r12, __v7_setup_stack		@ the local stack
 	stmia	r12, {r0-r5, r7, r9, r11, lr}
 	bl	v7_flush_dcache_all
@@ -323,6 +324,29 @@ cpu_elf_name:
 
 	.section ".proc.info.init", #alloc, #execinstr
 
+	.type   __v7_ca9mp_proc_info, #object
+__v7_ca9mp_proc_info:
+	.long	0x410fc090		@ Required ID value
+	.long	0xff0ffff0		@ Mask for ID
+	.long   PMD_TYPE_SECT | \
+		PMD_SECT_AP_WRITE | \
+		PMD_SECT_AP_READ | \
+		PMD_FLAGS
+	.long   PMD_TYPE_SECT | \
+		PMD_SECT_XN | \
+		PMD_SECT_AP_WRITE | \
+		PMD_SECT_AP_READ
+	b	__v7_ca9mp_setup
+	.long	cpu_arch_name
+	.long	cpu_elf_name
+	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
+	.long	cpu_v7_name
+	.long	v7_processor_functions
+	.long	v7wbi_tlb_fns
+	.long	v6_user_fns
+	.long	v7_cache_fns
+	.size	__v7_ca9mp_proc_info, . - __v7_ca9mp_proc_info
+
 	/*
 	 * Match any ARMv7 processor core.
 	 */
-- 
1.7.1
