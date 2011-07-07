From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  7 Jul 2011 15:27:31 +0100
Subject: [PATCH v4 24/40] ARM: mm: proc-arm9tdmi: Use the new processor struct
	macros
In-Reply-To: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
References: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1310048867-14172-25-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-arm9tdmi.S |   78 ++++++++++---------------------------------
 1 files changed, 18 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mm/proc-arm9tdmi.S b/arch/arm/mm/proc-arm9tdmi.S
index 546b54d..2120f9e 100644
--- a/arch/arm/mm/proc-arm9tdmi.S
+++ b/arch/arm/mm/proc-arm9tdmi.S
@@ -17,6 +17,8 @@
 #include <asm/pgtable.h>
 #include <asm/ptrace.h>
 
+#include "proc-macros.S"
+
 	.text
 /*
  * cpu_arm9tdmi_proc_init()
@@ -55,82 +57,38 @@ __arm9tdmi_setup:
 
 		__INITDATA
 
-/*
- * Purpose : Function pointers used to access above functions - all calls
- *	     come through these
- */
-		.type	arm9tdmi_processor_functions, #object
-ENTRY(arm9tdmi_processor_functions)
-		.word	nommu_early_abort
-		.word	legacy_pabort
-		.word	cpu_arm9tdmi_proc_init
-		.word	cpu_arm9tdmi_proc_fin
-		.word	cpu_arm9tdmi_reset
-		.word	cpu_arm9tdmi_do_idle
-		.word	cpu_arm9tdmi_dcache_clean_area
-		.word	cpu_arm9tdmi_switch_mm
-		.word	0		@ cpu_*_set_pte
-		.word	0
-		.word	0
-		.word	0
-		.size	arm9tdmi_processor_functions, . - arm9tdmi_processor_functions
+		@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
+		define_processor_functions arm9tdmi, dabort=nommu_early_abort, pabort=legacy_pabort, nommu=1
 
 		.section ".rodata"
 
-		.type	cpu_arch_name, #object
-cpu_arch_name:
-		.asciz	"armv4t"
-		.size	cpu_arch_name, . - cpu_arch_name
-
-		.type	cpu_elf_name, #object
-cpu_elf_name:
-		.asciz	"v4"
-		.size	cpu_elf_name, . - cpu_elf_name
-
-		.type	cpu_arm9tdmi_name, #object
-cpu_arm9tdmi_name:
-		.asciz	"ARM9TDMI"
-		.size	cpu_arm9tdmi_name, . - cpu_arm9tdmi_name
-
-		.type	cpu_p2001_name, #object
-cpu_p2001_name:
-		.asciz	"P2001"
-		.size	cpu_p2001_name, . - cpu_p2001_name
+		string	cpu_arch_name, "armv4t"
+		string	cpu_elf_name, "v4"
+		string	cpu_arm9tdmi_name, "ARM9TDMI"
+		string	cpu_p2001_name, "P2001"
 
 		.align
 
 		.section ".proc.info.init", #alloc, #execinstr
 
-		.type	__arm9tdmi_proc_info, #object
-__arm9tdmi_proc_info:
-		.long	0x41009900
-		.long	0xfff8ff00
+.macro arm9tdmi_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req
+		.type	__\name\()_proc_info, #object
+__\name\()_proc_info:
+		.long	\cpu_val
+		.long	\cpu_mask
 		.long	0
 		.long	0
 		b	__arm9tdmi_setup
 		.long	cpu_arch_name
 		.long	cpu_elf_name
 		.long	HWCAP_SWP | HWCAP_THUMB | HWCAP_26BIT
-		.long	cpu_arm9tdmi_name
+		.long	\cpu_name
 		.long	arm9tdmi_processor_functions
 		.long	0
 		.long	0
 		.long	v4_cache_fns
-		.size	__arm9tdmi_proc_info, . - __arm9tdmi_proc_info
+		.size	__\name\()_proc_info, . - __\name\()_proc_info
+.endm
 
-		.type	__p2001_proc_info, #object
-__p2001_proc_info:
-		.long	0x41029000
-		.long	0xffffffff
-		.long	0
-		.long	0
-		b	__arm9tdmi_setup
-		.long	cpu_arch_name
-		.long	cpu_elf_name
-		.long	HWCAP_SWP | HWCAP_THUMB | HWCAP_26BIT
-		.long	cpu_p2001_name
-		.long	arm9tdmi_processor_functions
-		.long	0
-		.long	0
-		.long	v4_cache_fns
-		.size	__p2001_proc_info, . - __p2001_proc_info
+	arm9tdmi_proc_info arm9tdmi, 0x41009900, 0xfff8ff00, cpu_arm9tdmi_name
+	arm9tdmi_proc_info p2001, 0x41029000, 0xffffffff, cpu_p2001_name
-- 
1.7.4.1
