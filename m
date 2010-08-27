From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 27 Aug 2010 12:53:10 -0700
Subject: [PATCH 03/24] arm: mm: add proc info for ScorpionMP
In-Reply-To: <1282927746.26355.74.camel@e102109-lin.cambridge.arm.com>
References: <1282926826.5075.21.camel@m0nster>
	<1282927746.26355.74.camel@e102109-lin.cambridge.arm.com>
Message-ID: <1282938790.5075.25.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-08-27 at 17:49 +0100, Catalin Marinas wrote:

> > So your saying it makes more sense to change the msm entry into the
> > default entry, and make the current default into the
> > ARM11MPCore/Cortex-A9 entry?
> 
> So my opinion is to not add any specific msm code but make the
> __v7_setup skip the ACTLR bit setting. Then add an entry for Cortex-A9
> to set those bits.
> 

how about this? Naming is of course flexible ..


ScorpionMP does not have the SMP/nAMP and TLB ops broadcasting bits in
ACTLR. These bits are only used on ARM11MPCore and Cortex-A9 from arm.
This patch just makes it so no other arm core ends up getting these
bits set.

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>

---
 arch/arm/mm/proc-v7.S |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 7aaf88a..e1b5492 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -189,13 +189,14 @@ cpu_v7_name:
  *	It is assumed that:
  *	- cache type register is implemented
  */
-__v7_setup:
+__v7_armmp_setup:
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
@@ -326,6 +327,29 @@ cpu_elf_name:
 
 	.section ".proc.info.init", #alloc, #execinstr
 
+	.type   __v7_armmp_proc_info, #object
+__v7_armmp_proc_info:
+	.long	0x410f0000		@ Required ID value
+	.long	0xff0f0000		@ Mask for ID
+	.long   PMD_TYPE_SECT | \
+		PMD_SECT_AP_WRITE | \
+		PMD_SECT_AP_READ | \
+		PMD_FLAGS
+	.long   PMD_TYPE_SECT | \
+		PMD_SECT_XN | \
+		PMD_SECT_AP_WRITE | \
+		PMD_SECT_AP_READ
+	b	__v7_armmp_setup
+	.long	cpu_arch_name
+	.long	cpu_elf_name
+	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
+	.long	cpu_v7_name
+	.long	v7_processor_functions
+	.long	v7wbi_tlb_fns
+	.long	v6_user_fns
+	.long	v7_cache_fns
+	.size	__v7_armmp_proc_info, . - __v7_armmp_proc_info
+
 	/*
 	 * Match any ARMv7 processor core.
 	 */
-- 
1.7.0.4



-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
