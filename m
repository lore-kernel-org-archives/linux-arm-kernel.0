From: shc_work@mail.ru (Alexander Shiyan)
Date: Fri, 7 Dec 2012 19:31:43 +0400
Subject: Question: Multiple board support is broken
Message-ID: <20121207193143.2d2029daf2041683bc7b2474@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Today I was tested multiple boards (not multiplatform) in the kernel
and found problems with booting. Exacly, if multiple boards defined
in. config, we can proceed to boot only the last (determined by mach number).
This problem is the result of a redefine "machine_arch_type" variable in
the mach-types.h more than once for each machine. As a result, we can not
use machine_is_xx () macros.
The following is an attempt to make mach-types.h generator simple and
solve this problem.

Please comment and show me if I think is wrong.
Thanks!

>From 7d4a967edb7bcb840d6d526b8de4a40d63a8ea82 Mon Sep 17 00:00:00 2001
From: Alexander Shiyan <shc_work@mail.ru>
Date: Fri, 7 Dec 2012 19:01:26 +0400
Subject: [PATCH] Simplify mach-types.h


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/compressed/misc.c |    5 ++---
 arch/arm/kernel/devtree.c       |    2 +-
 arch/arm/kernel/head-common.S   |    2 +-
 arch/arm/kernel/setup.c         |    4 ++--
 arch/arm/mach-pxa/em-x270.c     |    2 --
 arch/arm/mach-pxa/trizeps4.c    |    4 ++--
 arch/arm/tools/gen-mach-types   |   11 +----------
 7 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index df89983..86a2b0d 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -16,8 +16,6 @@
  *  This allows for a much quicker boot time.
  */
 
-unsigned int __machine_arch_type;
-
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>
 #include <linux/linkage.h>
@@ -112,6 +110,7 @@ unsigned char *output_data;
 
 unsigned long free_mem_ptr;
 unsigned long free_mem_end_ptr;
+unsigned int machine_arch_type;
 
 #ifndef arch_error
 #define arch_error(x)
@@ -146,7 +145,7 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 	output_data		= (unsigned char *)output_start;
 	free_mem_ptr		= free_mem_ptr_p;
 	free_mem_end_ptr	= free_mem_ptr_end_p;
-	__machine_arch_type	= arch_id;
+	machine_arch_type	= arch_id;
 
 	arch_decomp_setup();
 
diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 70f1bde..bbb9a02 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -232,7 +232,7 @@ struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
 
 	/* Change machine number to match the mdesc we're using */
-	__machine_arch_type = mdesc_best->nr;
+	machine_arch_type = mdesc_best->nr;
 
 	return mdesc_best;
 }
diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 2f560c5..6e02251 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -112,7 +112,7 @@ __mmap_switched_data:
 	.long	__bss_start			@ r6
 	.long	_end				@ r7
 	.long	processor_id			@ r4
-	.long	__machine_arch_type		@ r5
+	.long	machine_arch_type		@ r5
 	.long	__atags_pointer			@ r6
 #ifdef CONFIG_CPU_CP15
 	.long	cr_alignment			@ r7
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 86d1429..dc3c4b0 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -78,8 +78,8 @@ extern void setup_dma_zone(struct machine_desc *desc);
 
 unsigned int processor_id;
 EXPORT_SYMBOL(processor_id);
-unsigned int __machine_arch_type __read_mostly;
-EXPORT_SYMBOL(__machine_arch_type);
+unsigned int machine_arch_type __read_mostly;
+EXPORT_SYMBOL(machine_arch_type);
 unsigned int cacheid __read_mostly;
 EXPORT_SYMBOL(cacheid);
 
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 1b64114..939079a 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -1272,8 +1272,6 @@ static void __init em_x270_init(void)
 		em_x270_module_init();
 	else if (machine_is_exeda())
 		em_x270_exeda_init();
-	else
-		panic("Unsupported machine: %d\n", machine_arch_type);
 
 	em_x270_init_da9030();
 	em_x270_init_dm9000();
diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
index fbbcbed..7988e8b 100644
--- a/arch/arm/mach-pxa/trizeps4.c
+++ b/arch/arm/mach-pxa/trizeps4.c
@@ -544,11 +544,11 @@ static void __init trizeps4_map_io(void)
 
 	if ((__raw_readl(MSC0) & 0x8) && (__raw_readl(BOOT_DEF) & 0x1)) {
 		/* if flash is 16 bit wide its a Trizeps4 WL */
-		__machine_arch_type = MACH_TYPE_TRIZEPS4WL;
+		machine_arch_type = MACH_TYPE_TRIZEPS4WL;
 		trizeps4_flash_data[0].width = 2;
 	} else {
 		/* if flash is 32 bit wide its a Trizeps4 */
-		__machine_arch_type = MACH_TYPE_TRIZEPS4;
+		machine_arch_type = MACH_TYPE_TRIZEPS4;
 		trizeps4_flash_data[0].width = 4;
 	}
 }
diff --git a/arch/arm/tools/gen-mach-types b/arch/arm/tools/gen-mach-types
index 04fef71..d36642d 100644
--- a/arch/arm/tools/gen-mach-types
+++ b/arch/arm/tools/gen-mach-types
@@ -30,7 +30,7 @@ END	{
 	  printf("#define __ASM_ARM_MACH_TYPE_H\n\n");
 	  printf("#ifndef __ASSEMBLY__\n");
 	  printf("/* The type of machine we're running on */\n");
-	  printf("extern unsigned int __machine_arch_type;\n");
+	  printf("extern unsigned int machine_arch_type;\n");
 	  printf("#endif\n\n");
 
 	  printf("/* see arch/arm/kernel/arch.c for a description of these */\n");
@@ -43,12 +43,6 @@ END	{
 	  for (i = 0; i < nr; i++)
 	    if (num[i] ~ /..*/) {
 	      printf("#ifdef %s\n", config[i]);
-	      printf("# ifdef machine_arch_type\n");
-	      printf("#  undef machine_arch_type\n");
-	      printf("#  define machine_arch_type\t__machine_arch_type\n");
-	      printf("# else\n");
-	      printf("#  define machine_arch_type\t%s\n", mach_type[i]);
-	      printf("# endif\n");
 	      printf("# define %s()\t(machine_arch_type == %s)\n", machine_is[i], mach_type[i]);
 	      printf("#else\n");
 	      printf("# define %s()\t(0)\n", machine_is[i]);
@@ -65,8 +59,5 @@ END	{
 	      printf("#define %s()\t(0)\n", machine_is[i]);
 	    }
 
-	  printf("\n#ifndef machine_arch_type\n");
-	  printf("#define machine_arch_type\t__machine_arch_type\n");
-	  printf("#endif\n\n");
 	  printf("#endif\n");
 	}
-- 
1.7.8.6

-- 
Alexander Shiyan <shc_work@mail.ru>
