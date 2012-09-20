From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Sep 2012 17:03:37 +0100
Subject: [RESEND PATCH 1/2] ARM: kexec: scan for dtb magic in segments
Message-ID: <1348157018-31059-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthew Leach <matthew.leach@arm.com>

This patch allows a dtb to be passed to a new kernel using the kexec
mechinism.

When loading segments from userspace, scan each segment's first four
bytes for the dtb magic. If this is found set the kexec_boot_atags
parameter to the relocate_kernel code to the phyical address of this
segment.

Reviewed-by: Simon Horman <horms@verge.net.au>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Matthew Leach <matthew.leach@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/machine_kexec.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index dfcdb9f..dee34ef 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <asm/pgtable.h>
+#include <linux/of_fdt.h>
 #include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
@@ -32,6 +33,24 @@ static atomic_t waiting_for_crash_ipi;
 
 int machine_kexec_prepare(struct kimage *image)
 {
+	struct kexec_segment *current_segment;
+	__be32 header;
+	int i, err;
+
+	/*
+	 * No segment at default ATAGs address. try to locate
+	 * a dtb using magic.
+	 */
+	for (i = 0; i < image->nr_segments; i++) {
+		current_segment = &image->segment[i];
+
+		err = get_user(header, (__be32*)current_segment->buf);
+		if (err)
+			return err;
+
+		if (be32_to_cpu(header) == OF_DT_HEADER)
+			kexec_boot_atags = current_segment->mem;
+	}
 	return 0;
 }
 
@@ -122,7 +141,9 @@ void machine_kexec(struct kimage *image)
 	kexec_start_address = image->start;
 	kexec_indirection_page = page_list;
 	kexec_mach_type = machine_arch_type;
-	kexec_boot_atags = image->start - KEXEC_ARM_ZIMAGE_OFFSET + KEXEC_ARM_ATAGS_OFFSET;
+	if (!kexec_boot_atags)
+		kexec_boot_atags = image->start - KEXEC_ARM_ZIMAGE_OFFSET + KEXEC_ARM_ATAGS_OFFSET;
+
 
 	/* copy our kernel relocation code to the control code page */
 	memcpy(reboot_code_buffer,
-- 
1.7.4.1
