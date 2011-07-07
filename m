From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  7 Jul 2011 15:27:23 +0100
Subject: [PATCH v4 16/40] ARM: mm: proc-arm740: Use the new processor struct
	macros
In-Reply-To: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
References: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1310048867-14172-17-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-arm740.S |   42 +++++++-----------------------------------
 1 files changed, 7 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mm/proc-arm740.S b/arch/arm/mm/proc-arm740.S
index 6f9d12e..4506be3 100644
--- a/arch/arm/mm/proc-arm740.S
+++ b/arch/arm/mm/proc-arm740.S
@@ -17,6 +17,8 @@
 #include <asm/pgtable.h>
 #include <asm/ptrace.h>
 
+#include "proc-macros.S"
+
 	.text
 /*
  * cpu_arm740_proc_init()
@@ -115,42 +117,14 @@ __arm740_setup:
 
 	__INITDATA
 
-/*
- * Purpose : Function pointers used to access above functions - all calls
- *	     come through these
- */
-	.type	arm740_processor_functions, #object
-ENTRY(arm740_processor_functions)
-	.word	v4t_late_abort
-	.word	legacy_pabort
-	.word	cpu_arm740_proc_init
-	.word	cpu_arm740_proc_fin
-	.word	cpu_arm740_reset
-	.word   cpu_arm740_do_idle
-	.word	cpu_arm740_dcache_clean_area
-	.word	cpu_arm740_switch_mm
-	.word	0			@ cpu_*_set_pte
-	.word	0
-	.word	0
-	.word	0
-	.size	arm740_processor_functions, . - arm740_processor_functions
+	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
+	define_processor_functions arm740, dabort=v4t_late_abort, pabort=legacy_pabort, nommu=1
 
 	.section ".rodata"
 
-	.type	cpu_arch_name, #object
-cpu_arch_name:
-	.asciz	"armv4"
-	.size	cpu_arch_name, . - cpu_arch_name
-
-	.type	cpu_elf_name, #object
-cpu_elf_name:
-	.asciz	"v4"
-	.size	cpu_elf_name, . - cpu_elf_name
-
-	.type	cpu_arm740_name, #object
-cpu_arm740_name:
-	.ascii	"ARM740T"
-	.size	cpu_arm740_name, . - cpu_arm740_name
+	string	cpu_arch_name, "armv4"
+	string	cpu_elf_name, "v4"
+	string	cpu_arm740_name, "ARM740T"
 
 	.align
 
@@ -170,5 +144,3 @@ __arm740_proc_info:
 	.long	0
 	.long	v3_cache_fns			@ cache model
 	.size	__arm740_proc_info, . - __arm740_proc_info
-
-
-- 
1.7.4.1
