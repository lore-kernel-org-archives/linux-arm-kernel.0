From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 17 May 2011 17:49:16 +0100
Subject: [PATCH] arm: Add Cortex A5 proc_info
Message-ID: <1305650956-20997-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds processor info for Cortex A5 (MPCore).

Sadly it's just a clone of A9, but it's impossible to simply
extend the ID mask to cover all ARM Ltd. originating v7
implementations as A15 have slightly different SCU
initialization procedure.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/mm/proc-v7.S |   43 +++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index babfba0..5808d14 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -270,11 +270,15 @@ cpu_resume_l1_flags:
  *	Harvard cache control instructions insead of the unified cache
  *	control instructions.
  *
- *	This should be able to cover all ARMv7 cores.
+ *	This should be able to cover all ARMv7 cores. Some MPCore
+ *	implementations require additional code when SMP is to be
+ *	enabled to activate Snoop Control Unit - this is done prior
+ *	to the __v7_setup.
  *
  *	It is assumed that:
  *	- cache type register is implemented
  */
+__v7_ca5mp_setup:
 __v7_ca9mp_setup:
 #ifdef CONFIG_SMP
 	ALT_SMP(mrc	p15, 0, r0, c1, c0, 1)
@@ -436,6 +440,41 @@ cpu_elf_name:
 
 	.section ".proc.info.init", #alloc, #execinstr
 
+	/*
+	 * Match Cortex A5 MPcore
+	 */
+	.type   __v7_ca5mp_proc_info, #object
+__v7_ca5mp_proc_info:
+	.long	0x410fc050		@ Required ID value
+	.long	0xff0ffff0		@ Mask for ID
+	ALT_SMP(.long \
+		PMD_TYPE_SECT | \
+		PMD_SECT_AP_WRITE | \
+		PMD_SECT_AP_READ | \
+		PMD_FLAGS_SMP)
+	ALT_UP(.long \
+		PMD_TYPE_SECT | \
+		PMD_SECT_AP_WRITE | \
+		PMD_SECT_AP_READ | \
+		PMD_FLAGS_UP)
+	.long   PMD_TYPE_SECT | \
+		PMD_SECT_XN | \
+		PMD_SECT_AP_WRITE | \
+		PMD_SECT_AP_READ
+	W(b)	__v7_ca5mp_setup
+	.long	cpu_arch_name
+	.long	cpu_elf_name
+	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP|HWCAP_TLS
+	.long	cpu_v7_name
+	.long	v7_processor_functions
+	.long	v7wbi_tlb_fns
+	.long	v6_user_fns
+	.long	v7_cache_fns
+	.size	__v7_ca5mp_proc_info, . - __v7_ca5mp_proc_info
+
+	/*
+	 * Match Cortex A9 MPcore
+	 */
 	.type   __v7_ca9mp_proc_info, #object
 __v7_ca9mp_proc_info:
 	.long	0x410fc090		@ Required ID value
@@ -466,7 +505,7 @@ __v7_ca9mp_proc_info:
 	.size	__v7_ca9mp_proc_info, . - __v7_ca9mp_proc_info
 
 	/*
-	 * Match any ARMv7 processor core.
+	 * Match any other ARMv7 processor core.
 	 */
 	.type	__v7_proc_info, #object
 __v7_proc_info:
-- 
1.6.3.3
