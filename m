From: geoff@infradead.org (Geoff Levand)
Date: Tue, 24 Nov 2015 22:25:34 +0000
Subject: [PATCH v12 09/16] arm64/kexec: Add pr_devel output
In-Reply-To: <cover.1448403503.git.geoff@infradead.org>
References: <cover.1448403503.git.geoff@infradead.org>
Message-ID: <0e4d27286ec607b0c1f6e17b3034279c96d6b6a6.1448403503.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To aid in debugging kexec problems or when adding new functionality to kexec add
a new routine kexec_image_info() and several inline pr_devel statements.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/kernel/machine_kexec.c | 63 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 8b990b8..da28a26 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -25,6 +25,48 @@ extern const unsigned long arm64_relocate_new_kernel_size;
 
 static unsigned long kimage_start;
 
+/**
+ * kexec_is_dtb - Helper routine to check the device tree header signature.
+ */
+static bool kexec_is_dtb(const void *dtb)
+{
+	__be32 magic;
+
+	return get_user(magic, (__be32 *)dtb) ? false :
+		(be32_to_cpu(magic) == OF_DT_HEADER);
+}
+
+/**
+ * kexec_image_info - For debugging output.
+ */
+#define kexec_image_info(_i) _kexec_image_info(__func__, __LINE__, _i)
+static void _kexec_image_info(const char *func, int line,
+	const struct kimage *kimage)
+{
+	unsigned long i;
+
+#if !defined(DEBUG)
+	return;
+#endif
+	pr_devel("%s:%d:\n", func, line);
+	pr_devel("  kexec kimage info:\n");
+	pr_devel("    type:        %d\n", kimage->type);
+	pr_devel("    start:       %lx\n", kimage->start);
+	pr_devel("    head:        %lx\n", kimage->head);
+	pr_devel("    nr_segments: %lu\n", kimage->nr_segments);
+
+	for (i = 0; i < kimage->nr_segments; i++) {
+		pr_devel("      segment[%lu]: %016lx - %016lx, %lx bytes, %lu pages%s\n",
+			i,
+			kimage->segment[i].mem,
+			kimage->segment[i].mem + kimage->segment[i].memsz,
+			kimage->segment[i].memsz,
+			kimage->segment[i].memsz /  PAGE_SIZE,
+			(kexec_is_dtb(kimage->segment[i].buf) ?
+				", dtb segment" : ""));
+	}
+}
+
 void machine_kexec_cleanup(struct kimage *kimage)
 {
 	/* Empty routine needed to avoid build errors. */
@@ -38,6 +80,8 @@ void machine_kexec_cleanup(struct kimage *kimage)
 int machine_kexec_prepare(struct kimage *kimage)
 {
 	kimage_start = kimage->start;
+	kexec_image_info(kimage);
+
 	return 0;
 }
 
@@ -107,6 +151,25 @@ void machine_kexec(struct kimage *kimage)
 	reboot_code_buffer_phys = page_to_phys(kimage->control_code_page);
 	reboot_code_buffer = phys_to_virt(reboot_code_buffer_phys);
 
+	kexec_image_info(kimage);
+
+	pr_devel("%s:%d: control_code_page:        %p\n", __func__, __LINE__,
+		kimage->control_code_page);
+	pr_devel("%s:%d: reboot_code_buffer_phys:  %pa\n", __func__, __LINE__,
+		&reboot_code_buffer_phys);
+	pr_devel("%s:%d: reboot_code_buffer:       %p\n", __func__, __LINE__,
+		reboot_code_buffer);
+	pr_devel("%s:%d: relocate_new_kernel:      %p\n", __func__, __LINE__,
+		arm64_relocate_new_kernel);
+	pr_devel("%s:%d: relocate_new_kernel_size: 0x%lx(%lu) bytes\n",
+		__func__, __LINE__, arm64_relocate_new_kernel_size,
+		arm64_relocate_new_kernel_size);
+
+	pr_devel("%s:%d: kimage_head:              %lx\n", __func__, __LINE__,
+		kimage->head);
+	pr_devel("%s:%d: kimage_start:             %lx\n", __func__, __LINE__,
+		kimage_start);
+
 	/*
 	 * Copy arm64_relocate_new_kernel to the reboot_code_buffer for use
 	 * after the kernel is shut down.
-- 
2.5.0
