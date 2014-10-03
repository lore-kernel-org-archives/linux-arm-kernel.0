From: geoff@infradead.org (Geoff Levand)
Date: Fri, 03 Oct 2014 23:12:24 +0000
Subject: [PATCH 8/8] arm64/kexec: Add pr_devel output
In-Reply-To: <cover.1412376956.git.geoff@infradead.org>
References: <cover.1412376956.git.geoff@infradead.org>
Message-ID: <e122ed3a1b2afbaf69baf2c7cf354f7e557c5851.1412376956.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To aid in debugging kexec problems or when adding new functionality to kexec add
a new routine kexec_image_info() and several inline pr_devel statements.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/kernel/machine_kexec.c | 56 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 95bc8d9..1306d33 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -37,6 +37,39 @@ static bool kexec_is_dtb(const void *dtb)
 }
 
 /**
+ * kexec_image_info - For debugging output.
+ */
+
+#define kexec_image_info(_i) _kexec_image_info(__func__, __LINE__, _i)
+static void _kexec_image_info(const char *func, int line,
+	const struct kimage *image)
+{
+	unsigned long i;
+
+#if !defined(DEBUG)
+	return;
+#endif
+	pr_devel("%s:%d:\n", func, line);
+	pr_devel("  kexec image info:\n");
+	pr_devel("    type:        %d\n", image->type);
+	pr_devel("    start:       %lx\n", image->start);
+	pr_devel("    head:        %lx\n", image->head);
+	pr_devel("    nr_segments: %lu\n", image->nr_segments);
+
+	for (i = 0; i < image->nr_segments; i++) {
+		pr_devel("      segment[%lu]: %016lx - %016lx, "
+			"%lx bytes, %lu pages%s\n",
+			i,
+			image->segment[i].mem,
+			image->segment[i].mem + image->segment[i].memsz,
+			image->segment[i].memsz,
+			image->segment[i].memsz /  PAGE_SIZE,
+			(kexec_is_dtb(image->segment[i].buf) ?
+				", dtb segment" : ""));
+	}
+}
+
+/**
  * kexec_find_dtb_seg - Helper routine to find the dtb segment.
  */
 
@@ -74,6 +107,8 @@ int machine_kexec_prepare(struct kimage *image)
 	arm64_kexec_dtb_addr = dtb_seg ? dtb_seg->mem : 0;
 	arm64_kexec_kimage_start = image->start;
 
+	kexec_image_info(image);
+
 	return 0;
 }
 
@@ -130,6 +165,27 @@ void machine_kexec(struct kimage *image)
 	reboot_code_buffer_phys = page_to_phys(image->control_code_page);
 	reboot_code_buffer = phys_to_virt(reboot_code_buffer_phys);
 
+	kexec_image_info(image);
+
+	pr_devel("%s:%d: control_code_page:        %p\n", __func__, __LINE__,
+		image->control_code_page);
+	pr_devel("%s:%d: reboot_code_buffer_phys:  %pa\n", __func__, __LINE__,
+		&reboot_code_buffer_phys);
+	pr_devel("%s:%d: reboot_code_buffer:       %p\n", __func__, __LINE__,
+		reboot_code_buffer);
+	pr_devel("%s:%d: relocate_new_kernel:      %p\n", __func__, __LINE__,
+		relocate_new_kernel);
+	pr_devel("%s:%d: relocate_new_kernel_size: 0x%lx(%lu) bytes\n",
+		__func__, __LINE__, relocate_new_kernel_size,
+		relocate_new_kernel_size);
+
+	pr_devel("%s:%d: kexec_dtb_addr:           %lx\n", __func__, __LINE__,
+		arm64_kexec_dtb_addr);
+	pr_devel("%s:%d: kexec_kimage_head:        %lx\n", __func__, __LINE__,
+		arm64_kexec_kimage_head);
+	pr_devel("%s:%d: kexec_kimage_start:       %lx\n", __func__, __LINE__,
+		arm64_kexec_kimage_start);
+
 	/*
 	 * Copy relocate_new_kernel to the reboot_code_buffer for use
 	 * after the kernel is shut down.
-- 
1.9.1
