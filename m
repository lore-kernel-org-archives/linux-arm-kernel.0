From: Nikolay.Borisov@arm.com (Nikolay Borisov)
Date: Mon, 28 Apr 2014 10:31:47 +0100
Subject: [PATCH 3/3] ARM: kexec: Use .struct to describe relocate_new_kernel
 parameter layout
In-Reply-To: <1398677507-6687-1-git-send-email-Nikolay.Borisov@arm.com>
References: <1398677507-6687-1-git-send-email-Nikolay.Borisov@arm.com>
Message-ID: <1398677507-6687-4-git-send-email-Nikolay.Borisov@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we no longer require poking into the kernel's section there is no need to
allocate space for 4 longs (16 bytes). So use a .struct directive which would
just place the labels at the correct offset but won't allocate space in the
kernel for them (saves 16 bytes!)

Signed-off-by: Nikolay Borisov <Nikolay.Borisov@arm.com>
---
 arch/arm/kernel/machine_kexec.c   | 26 ++++++++++-------------
 arch/arm/kernel/relocate_kernel.S | 44 ++++++++++++++++++---------------------
 2 files changed, 31 insertions(+), 39 deletions(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index ee55e2e..7c0e4a2 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -22,10 +22,10 @@
 extern void relocate_new_kernel(void);
 extern const unsigned int relocate_new_kernel_size;
 
-extern const unsigned long kexec_start_address;
-extern const unsigned long kexec_indirection_page;
-extern const unsigned long kexec_mach_type;
-extern const unsigned long kexec_boot_atags;
+extern const unsigned long kexec_start_address_offset;
+extern const unsigned long kexec_indirection_page_offset;
+extern const unsigned long kexec_mach_type_offset;
+extern const unsigned long kexec_boot_atags_offset;
 
 static atomic_t waiting_for_crash_ipi;
 
@@ -153,25 +153,21 @@ void (*kexec_reinit)(void);
 static void patch_boot_parameters(char *copied_template, struct kimage *image) {
 
 	unsigned long page_list = image->head & PAGE_MASK;
-	uintptr_t base = (uintptr_t)relocate_new_kernel & ~(uintptr_t)1;
-	uintptr_t start_addr_offset = (uintptr_t)&kexec_start_address - base;
-	uintptr_t indir_page_offset = (uintptr_t)&kexec_indirection_page - base;
-	uintptr_t mach_type_offset = (uintptr_t)&kexec_mach_type - base;
-	uintptr_t boot_atags_offset = (uintptr_t)&kexec_boot_atags - base;
 
+#define get_offset(sym) ((uintptr_t)&(sym) + relocate_new_kernel_size)
 #define patch_value(offset,res) \
-	*(unsigned long *)(copied_template + (offset)) = (res)
+	*(unsigned long *)(copied_template + get_offset(offset)) = (res)
 
-	patch_value(start_addr_offset, image->start);
-	patch_value(indir_page_offset, page_list);
-	patch_value(mach_type_offset, machine_arch_type);
+	patch_value(kexec_start_address_offset, image->start);
+	patch_value(kexec_indirection_page_offset, page_list);
+	patch_value(kexec_mach_type_offset, machine_arch_type);
 
 	if (!dt_mem)
-		patch_value(boot_atags_offset, image->start -
+		patch_value(kexec_boot_atags_offset, image->start -
 				 KEXEC_ARM_ZIMAGE_OFFSET +
 				 KEXEC_ARM_ATAGS_OFFSET);
 	else
-		patch_value(boot_atags_offset, dt_mem);
+		patch_value(kexec_boot_atags_offset, dt_mem);
 }
 
 void machine_kexec(struct kimage *image)
diff --git a/arch/arm/kernel/relocate_kernel.S b/arch/arm/kernel/relocate_kernel.S
index a8eb0e0..fbb22a7 100644
--- a/arch/arm/kernel/relocate_kernel.S
+++ b/arch/arm/kernel/relocate_kernel.S
@@ -12,8 +12,8 @@
 
 ENTRY(relocate_new_kernel)
 
-	ldr	r0,kexec_indirection_page
-	ldr	r1,kexec_start_address
+	ldr	r0,kexec_indirection_page_offset + relocate_new_kernel_size
+	ldr	r1,kexec_start_address_offset + relocate_new_kernel_size
 
 	/*
 	 * If there is no indirection page (we are doing crashdumps)
@@ -60,36 +60,32 @@ ENTRY(relocate_new_kernel)
 	/* Jump to relocated kernel */
 	mov lr,r1
 	mov r0,#0
-	ldr r1,kexec_mach_type
-	ldr r2,kexec_boot_atags
+	ldr r1,kexec_mach_type_offset + relocate_new_kernel_size
+	ldr r2,kexec_boot_atags_offset + relocate_new_kernel_size
  ARM(	mov pc, lr	)
  THUMB(	bx lr		)
 
-	.align
-
-	.globl kexec_start_address
-kexec_start_address:
-	.long	0x0
-
-	.globl kexec_indirection_page
-kexec_indirection_page:
-	.long	0x0
-
-	.globl kexec_mach_type
-kexec_mach_type:
-	.long	0x0
-
-	/* phy addr of the atags for the new kernel */
-	.globl kexec_boot_atags
-kexec_boot_atags:
-	.long	0x0
 
 ENDPROC(relocate_new_kernel)
 
-relocate_new_kernel_end:
+
 
 	.globl relocate_new_kernel_size
 relocate_new_kernel_size:
-	.long relocate_new_kernel_end - relocate_new_kernel
+	.long . - relocate_new_kernel
+
+	.align
+	
+	.struct 4 /* offsets are from relocate_new_kernel_size */
+ 
+	.macro parameter name /* declare space for a word-sized parameter */
+	.globl \name
+	\name:	.long 0
+	.endm
+ 
+parameter kexec_start_address_offset
+parameter kexec_indirection_page_offset
+parameter kexec_mach_type_offset
+parameter kexec_boot_atags_offset
 
 
-- 
1.8.1.5
