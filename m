From: geoff@infradead.org (Geoff Levand)
Date: Thu, 19 Mar 2015 20:35:28 +0000
Subject: [PATCH 6/6] arm64/kexec: Add pr_devel output
In-Reply-To: <cover.1426793116.git.geoff@infradead.org>
References: <cover.1426793116.git.geoff@infradead.org>
Message-ID: <9d94104463ae6e3472526fb69e8111201c4a1fa7.1426793116.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To aid in debugging kexec problems or when adding new functionality to kexec add
a new routine kexec_image_info() and several inline pr_devel statements.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/kernel/machine_kexec.c | 64 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index f1387d0..7aa2fa2 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -24,6 +24,48 @@ extern unsigned long arm64_kexec_dtb_addr;
 extern unsigned long arm64_kexec_kimage_head;
 extern unsigned long arm64_kexec_kimage_start;
 
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
+		pr_devel("      segment[%lu]: %016lx - %016lx, %lx bytes, %lu pages%s\n",
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
 void machine_kexec_cleanup(struct kimage *image)
 {
 	/* Empty routine needed to avoid build errors. */
@@ -37,6 +79,7 @@ void machine_kexec_cleanup(struct kimage *image)
 int machine_kexec_prepare(struct kimage *image)
 {
 	arm64_kexec_kimage_start = image->start;
+	kexec_image_info(image);
 	return 0;
 }
 
@@ -91,6 +134,27 @@ void machine_kexec(struct kimage *image)
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
2.1.0
