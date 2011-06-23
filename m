From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 23 Jun 2011 18:50:25 +0100
Subject: [PATCH v3 17/40] Subject: ARM: mm: proc-arm7tdmi: Use the new
	processor struct macros
In-Reply-To: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308851448-25139-18-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch also fixes a .size directive typo, which was causing a
reference to a nonexistent symbol.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-arm7tdmi.S |  216 ++++++++-----------------------------------
 1 files changed, 39 insertions(+), 177 deletions(-)

diff --git a/arch/arm/mm/proc-arm7tdmi.S b/arch/arm/mm/proc-arm7tdmi.S
index e4c165c..7e0e1fe 100644
--- a/arch/arm/mm/proc-arm7tdmi.S
+++ b/arch/arm/mm/proc-arm7tdmi.S
@@ -17,6 +17,8 @@
 #include <asm/pgtable.h>
 #include <asm/ptrace.h>
 
+#include "proc-macros.S"
+
 	.text
 /*
  * cpu_arm7tdmi_proc_init()
@@ -55,197 +57,57 @@ __arm7tdmi_setup:
 
 		__INITDATA
 
-/*
- * Purpose : Function pointers used to access above functions - all calls
- *	     come through these
- */
-		.type	arm7tdmi_processor_functions, #object
-ENTRY(arm7tdmi_processor_functions)
-		.word	v4t_late_abort
-		.word	legacy_pabort
-		.word	cpu_arm7tdmi_proc_init
-		.word	cpu_arm7tdmi_proc_fin
-		.word	cpu_arm7tdmi_reset
-		.word	cpu_arm7tdmi_do_idle
-		.word	cpu_arm7tdmi_dcache_clean_area
-		.word	cpu_arm7tdmi_switch_mm
-		.word	0		@ cpu_*_set_pte
-		.word	0
-		.word	0
-		.word	0
-		.size	arm7tdmi_processor_functions, . - arm7tdmi_processor_functions
+		@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
+		define_processor_functions arm7tdmi, dabort=v4t_late_abort, pabort=legacy_pabort, nommu=1
 
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
-		.type	cpu_arm7tdmi_name, #object
-cpu_arm7tdmi_name:
-		.asciz	"ARM7TDMI"
-		.size	cpu_arm7tdmi_name, . - cpu_arm7tdmi_name
-
-		.type	cpu_triscenda7_name, #object
-cpu_triscenda7_name:
-		.asciz	"Triscend-A7x"
-		.size	cpu_triscenda7_name, . - cpu_triscenda7_name
-
-		.type	cpu_at91_name, #object
-cpu_at91_name:
-		.asciz	"Atmel-AT91M40xxx"
-		.size	cpu_at91_name, . - cpu_at91_name
-
-		.type	cpu_s3c3410_name, #object
-cpu_s3c3410_name:
-		.asciz	"Samsung-S3C3410"
-		.size	cpu_s3c3410_name, . - cpu_s3c3410_name
-
-		.type	cpu_s3c44b0x_name, #object
-cpu_s3c44b0x_name:
-		.asciz	"Samsung-S3C44B0x"
-		.size	cpu_s3c44b0x_name, . - cpu_s3c44b0x_name
-
-		.type	cpu_s3c4510b, #object
-cpu_s3c4510b_name:
-		.asciz	"Samsung-S3C4510B"
-		.size	cpu_s3c4510b_name, . - cpu_s3c4510b_name
-
-		.type	cpu_s3c4530_name, #object
-cpu_s3c4530_name:
-		.asciz	"Samsung-S3C4530"
-		.size	cpu_s3c4530_name, . - cpu_s3c4530_name
-
-		.type	cpu_netarm_name, #object
-cpu_netarm_name:
-		.asciz	"NETARM"
-		.size	cpu_netarm_name, . - cpu_netarm_name
+		string	cpu_arch_name, "armv4t"
+		string	cpu_elf_name, "v4"
+		string	cpu_arm7tdmi_name, "ARM7TDMI"
+		string	cpu_triscenda7_name, "Triscend-A7x"
+		string	cpu_at91_name, "Atmel-AT91M40xxx"
+		string	cpu_s3c3410_name, "Samsung-S3C3410"
+		string	cpu_s3c44b0x_name, "Samsung-S3C44B0x"
+		string	cpu_s3c4510b_name, "Samsung-S3C4510B"
+		string	cpu_s3c4530_name, "Samsung-S3C4530"
+		string	cpu_netarm_name, "NETARM"
 
 		.align
 
 		.section ".proc.info.init", #alloc, #execinstr
 
-		.type	__arm7tdmi_proc_info, #object
-__arm7tdmi_proc_info:
-		.long	0x41007700
-		.long	0xfff8ff00
-		.long	0
-		.long	0
-		b	__arm7tdmi_setup
-		.long	cpu_arch_name
-		.long	cpu_elf_name
-		.long	HWCAP_SWP | HWCAP_26BIT
-		.long	cpu_arm7tdmi_name
-		.long	arm7tdmi_processor_functions
-		.long	0
-		.long	0
-		.long	v4_cache_fns
-		.size	__arm7tdmi_proc_info, . - __arm7dmi_proc_info
-
-		.type	__triscenda7_proc_info, #object
-__triscenda7_proc_info:
-		.long	0x0001d2ff
-		.long	0x0001ffff
-		.long	0
-		.long	0
-		b	__arm7tdmi_setup
-		.long	cpu_arch_name
-		.long	cpu_elf_name
-		.long	HWCAP_SWP | HWCAP_THUMB | HWCAP_26BIT
-		.long	cpu_triscenda7_name
-		.long	arm7tdmi_processor_functions
-		.long	0
-		.long	0
-		.long	v4_cache_fns
-		.size	__triscenda7_proc_info, . - __triscenda7_proc_info
-
-		.type	__at91_proc_info, #object
-__at91_proc_info:
-		.long	0x14000040
-		.long	0xfff000e0
-		.long	0
-		.long	0
-		b	__arm7tdmi_setup
-		.long	cpu_arch_name
-		.long	cpu_elf_name
-		.long	HWCAP_SWP | HWCAP_THUMB | HWCAP_26BIT
-		.long	cpu_at91_name
-		.long	arm7tdmi_processor_functions
-		.long	0
-		.long	0
-		.long	v4_cache_fns
-		.size	__at91_proc_info, . - __at91_proc_info
-
-		.type	__s3c4510b_proc_info, #object
-__s3c4510b_proc_info:
-		.long	0x36365000
-		.long	0xfffff000
-		.long	0
-		.long	0
-		b	__arm7tdmi_setup
-		.long	cpu_arch_name
-		.long	cpu_elf_name
-		.long	HWCAP_SWP | HWCAP_THUMB | HWCAP_26BIT
-		.long	cpu_s3c4510b_name
-		.long	arm7tdmi_processor_functions
-		.long	0
-		.long	0
-		.long	v4_cache_fns
-		.size	__s3c4510b_proc_info, . - __s3c4510b_proc_info
-
-		.type	__s3c4530_proc_info, #object
-__s3c4530_proc_info:
-		.long	0x4c000000
-		.long	0xfff000e0
-		.long	0
-		.long	0
-		b	__arm7tdmi_setup
-		.long	cpu_arch_name
-		.long	cpu_elf_name
-		.long	HWCAP_SWP | HWCAP_THUMB | HWCAP_26BIT
-		.long	cpu_s3c4530_name
-		.long	arm7tdmi_processor_functions
-		.long	0
-		.long	0
-		.long	v4_cache_fns
-		.size	__s3c4530_proc_info, . - __s3c4530_proc_info
-
-		.type	__s3c3410_proc_info, #object
-__s3c3410_proc_info:
-		.long	0x34100000
-		.long	0xffff0000
-		.long	0
-		.long	0
-		b	__arm7tdmi_setup
-		.long	cpu_arch_name
-		.long	cpu_elf_name
-		.long	HWCAP_SWP | HWCAP_THUMB | HWCAP_26BIT
-		.long	cpu_s3c3410_name
-		.long	arm7tdmi_processor_functions
-		.long	0
-		.long	0
-		.long	v4_cache_fns
-		.size	__s3c3410_proc_info, . - __s3c3410_proc_info
-
-		.type	__s3c44b0x_proc_info, #object
-__s3c44b0x_proc_info:
-		.long	0x44b00000
-		.long	0xffff0000
+.macro arm7tdmi_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, \
+	extra_hwcaps=0
+		.type	__\name\()_proc_info, #object
+__\name\()_proc_info:
+		.long	\cpu_val
+		.long	\cpu_mask
 		.long	0
 		.long	0
 		b	__arm7tdmi_setup
 		.long	cpu_arch_name
 		.long	cpu_elf_name
-		.long	HWCAP_SWP | HWCAP_THUMB | HWCAP_26BIT
-		.long	cpu_s3c44b0x_name
+		.long	HWCAP_SWP | HWCAP_26BIT | ( \extra_hwcaps )
+		.long	\cpu_name
 		.long	arm7tdmi_processor_functions
 		.long	0
 		.long	0
 		.long	v4_cache_fns
-		.size	__s3c44b0x_proc_info, . - __s3c44b0x_proc_info
+		.size	__\name\()_proc_info, . - __\name\()_proc_info
+.endm
+
+		arm7tdmi_proc_info arm7tdmi, 0x41007700, 0xfff8ff00, \
+			cpu_arm7tdmi_name
+		arm7tdmi_proc_info triscenda7, 0x0001d2ff, 0x0001ffff, \
+			cpu_triscenda7_name, extra_hwcaps=HWCAP_THUMB
+		arm7tdmi_proc_info at91, 0x14000040, 0xfff000e0, \
+			cpu_at91_name, extra_hwcaps=HWCAP_THUMB
+		arm7tdmi_proc_info s3c4510b, 0x36365000, 0xfffff000, \
+			cpu_s3c4510b_name, extra_hwcaps=HWCAP_THUMB
+		arm7tdmi_proc_info s3c4530, 0x4c000000, 0xfff000e0, \
+			cpu_s3c4530_name, extra_hwcaps=HWCAP_THUMB
+		arm7tdmi_proc_info s3c3410, 0x34100000, 0xffff0000, \
+			cpu_s3c3410_name, extra_hwcaps=HWCAP_THUMB
+		arm7tdmi_proc_info s3c44b0x, 0x44b00000, 0xffff0000, \
+			cpu_s3c44b0x_name, extra_hwcaps=HWCAP_THUMB
-- 
1.7.4.1
