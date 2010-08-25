From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Tue, 24 Aug 2010 21:57:32 -0700
Subject: [PATCH 03/24] arm: mm: add proc info for ScorpionMP
In-Reply-To: <1282712273-344-1-git-send-email-johlstei@codeaurora.org>
References: <1282712273-344-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <1282712273-344-4-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Walker <dwalker@codeaurora.org>

ScorpionMP does not have the SMP/nAMP and TLB ops broadcasting bits in
ACTLR.

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>
---
 arch/arm/mm/proc-v7.S |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 7aaf88a..98fd7e5 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -196,6 +196,7 @@ __v7_setup:
 	orreq	r0, r0, #(1 << 6) | (1 << 0)	@ Enable SMP/nAMP mode and
 	mcreq	p15, 0, r0, c1, c0, 1		@ TLB ops broadcasting
 #endif
+__v7_msm_setup:
 	adr	r12, __v7_setup_stack		@ the local stack
 	stmia	r12, {r0-r5, r7, r9, r11, lr}
 	bl	v7_flush_dcache_all
@@ -326,6 +327,29 @@ cpu_elf_name:
 
 	.section ".proc.info.init", #alloc, #execinstr
 
+	.type   __v7_msm_proc_info, #object
+__v7_msm_proc_info:
+	.long	0x510f0000		@ Required ID value
+	.long	0xff0f0000		@ Mask for ID
+	.long   PMD_TYPE_SECT | \
+		PMD_SECT_AP_WRITE | \
+		PMD_SECT_AP_READ | \
+		PMD_FLAGS
+	.long   PMD_TYPE_SECT | \
+		PMD_SECT_XN | \
+		PMD_SECT_AP_WRITE | \
+		PMD_SECT_AP_READ
+	b	__v7_msm_setup
+	.long	cpu_arch_name
+	.long	cpu_elf_name
+	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
+	.long	cpu_v7_name
+	.long	v7_processor_functions
+	.long	v7wbi_tlb_fns
+	.long	v6_user_fns
+	.long	v7_cache_fns
+	.size	__v7_msm_proc_info, . - __v7_msm_proc_info
+
 	/*
 	 * Match any ARMv7 processor core.
 	 */
-- 
1.7.2.1

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
