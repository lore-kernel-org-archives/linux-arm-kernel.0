From: afenkart@gmail.com (Andreas Fenkart)
Date: Sat, 14 Nov 2015 00:37:35 +0100
Subject: [PATCH] ARM: kexec: backup the machine id reported by boot loader
Message-ID: <1447457855-11099-1-git-send-email-afenkart@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Starting a non-devicetree kernel via kexec from a devicetree kernel,
fails since the machine id as received from the bootloader has been
overwritten.

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 arch/arm/include/asm/setup.h    | 1 +
 arch/arm/kernel/machine_kexec.c | 4 ++--
 arch/arm/kernel/setup.c         | 5 +++++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
index e0adb9f..a26165b 100644
--- a/arch/arm/include/asm/setup.h
+++ b/arch/arm/include/asm/setup.h
@@ -16,6 +16,7 @@
 
 #include <uapi/asm/setup.h>
 
+extern unsigned int __machine_arch_type_bootloader;
 
 #define __tag __used __attribute__((__section__(".taglist.init")))
 #define __tagtable(tag, fn) \
diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 8bf3b7c..d602b6f 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -15,7 +15,7 @@
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 #include <asm/fncpy.h>
-#include <asm/mach-types.h>
+#include <asm/setup.h>
 #include <asm/smp_plat.h>
 #include <asm/system_misc.h>
 
@@ -168,7 +168,7 @@ void machine_kexec(struct kimage *image)
 	set_kernel_text_rw();
 	kexec_start_address = image->start;
 	kexec_indirection_page = page_list;
-	kexec_mach_type = machine_arch_type;
+	kexec_mach_type = __machine_arch_type_bootloader;
 	kexec_boot_atags = dt_mem ?: image->start - KEXEC_ARM_ZIMAGE_OFFSET
 				     + KEXEC_ARM_ATAGS_OFFSET;
 
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 6c777e9..8314e76 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -83,6 +83,8 @@ extern void setup_dma_zone(const struct machine_desc *desc);
 
 unsigned int processor_id;
 EXPORT_SYMBOL(processor_id);
+unsigned int __machine_arch_type_bootloader __read_mostly;
+EXPORT_SYMBOL(__machine_arch_type_bootloader);
 unsigned int __machine_arch_type __read_mostly;
 EXPORT_SYMBOL(__machine_arch_type);
 unsigned int cacheid __read_mostly;
@@ -914,6 +916,9 @@ void __init setup_arch(char **cmdline_p)
 {
 	const struct machine_desc *mdesc;
 
+	/* save machine type as received by the boot loader */
+	__machine_arch_type_bootloader = __machine_arch_type;
+
 	setup_processor();
 	mdesc = setup_machine_fdt(__atags_pointer);
 	if (!mdesc)
-- 
2.6.1
