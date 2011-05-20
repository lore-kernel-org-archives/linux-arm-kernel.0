From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 20 May 2011 14:39:28 +0100
Subject: [PATCH v3 1/2] arm: Convert v7 proc infos into a common macro
In-Reply-To: <1305892312.17656.72.camel@hornet.cambridge.arm.com>
References: <1305892312.17656.72.camel@hornet.cambridge.arm.com>
Message-ID: <1305898769-10462-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As most of the proc info content is common across all v7
processors, this patch converts existing A9 and generic v7
descriptions into a macro (allowing extra flags in future).

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/mm/proc-v7.S |   67 +++++++++++++++++-------------------------------
 1 files changed, 24 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index babfba0..e5087aa 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -436,33 +436,36 @@ cpu_elf_name:
 
 	.section ".proc.info.init", #alloc, #execinstr
 
-	.type   __v7_ca9mp_proc_info, #object
-__v7_ca9mp_proc_info:
-	.long	0x410fc090		@ Required ID value
-	.long	0xff0ffff0		@ Mask for ID
-	ALT_SMP(.long \
-		PMD_TYPE_SECT | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ | \
-		PMD_FLAGS_SMP)
-	ALT_UP(.long \
-		PMD_TYPE_SECT | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ | \
-		PMD_FLAGS_UP)
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_XN | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	W(b)	__v7_ca9mp_setup
+	/*
+	 * Standard v7 proc info content
+	 */
+.macro __v7_proc initfunc, mm_mmuflags = 0, io_mmuflags = 0, hwcaps = 0
+	ALT_SMP(.long	PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AP_READ | \
+			PMD_FLAGS_SMP | \mm_mmuflags)
+	ALT_UP(.long	PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AP_READ | \
+			PMD_FLAGS_UP | \mm_mmuflags)
+	.long	PMD_TYPE_SECT | PMD_SECT_XN | PMD_SECT_AP_WRITE | \
+		PMD_SECT_AP_READ | \io_mmuflags
+	W(b)	\initfunc
 	.long	cpu_arch_name
 	.long	cpu_elf_name
-	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP|HWCAP_TLS
+	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB | HWCAP_FAST_MULT | \
+		HWCAP_EDSP | HWCAP_TLS | \hwcaps
 	.long	cpu_v7_name
 	.long	v7_processor_functions
 	.long	v7wbi_tlb_fns
 	.long	v6_user_fns
 	.long	v7_cache_fns
+.endm
+
+	/*
+	 * ARM Ltd. Cortex A9 processor.
+	 */
+	.type   __v7_ca9mp_proc_info, #object
+__v7_ca9mp_proc_info:
+	.long	0x410fc090
+	.long	0xff0ffff0
+	__v7_proc __v7_ca9mp_setup
 	.size	__v7_ca9mp_proc_info, . - __v7_ca9mp_proc_info
 
 	/*
@@ -472,27 +475,5 @@ __v7_ca9mp_proc_info:
 __v7_proc_info:
 	.long	0x000f0000		@ Required ID value
 	.long	0x000f0000		@ Mask for ID
-	ALT_SMP(.long \
-		PMD_TYPE_SECT | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ | \
-		PMD_FLAGS_SMP)
-	ALT_UP(.long \
-		PMD_TYPE_SECT | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ | \
-		PMD_FLAGS_UP)
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_XN | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	W(b)	__v7_setup
-	.long	cpu_arch_name
-	.long	cpu_elf_name
-	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP|HWCAP_TLS
-	.long	cpu_v7_name
-	.long	v7_processor_functions
-	.long	v7wbi_tlb_fns
-	.long	v6_user_fns
-	.long	v7_cache_fns
+	__v7_proc __v7_setup
 	.size	__v7_proc_info, . - __v7_proc_info
-- 
1.6.3.3
