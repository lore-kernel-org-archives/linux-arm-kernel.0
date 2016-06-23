From: geoff@infradead.org (Geoff Levand)
Date: Thu, 23 Jun 2016 17:54:48 +0000
Subject: [PATCH v20 06/14] arm64/kexec: Add pr_debug output
In-Reply-To: <cover.1466702804.git.geoff@infradead.org>
References: <cover.1466702804.git.geoff@infradead.org>
Message-ID: <45a4ed930e8b2b5ef99baa31cdf2450d1c09279f.1466702804.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To aid in debugging kexec problems or when adding new functionality to
kexec add a new routine kexec_image_info() and several inline pr_debug
statements.

Signed-off-by: Geoff Levand <geoff@infradead.org>
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/machine_kexec.c | 42 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index e2904c4..945ce32 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -24,6 +24,32 @@ extern const unsigned long arm64_relocate_new_kernel_size;
 
 static unsigned long kimage_start;
 
+/**
+ * kexec_image_info - For debugging output.
+ */
+#define kexec_image_info(_i) _kexec_image_info(__func__, __LINE__, _i)
+static void _kexec_image_info(const char *func, int line,
+	const struct kimage *kimage)
+{
+	unsigned long i;
+
+	pr_debug("%s:%d:\n", func, line);
+	pr_debug("  kexec kimage info:\n");
+	pr_debug("    type:        %d\n", kimage->type);
+	pr_debug("    start:       %lx\n", kimage->start);
+	pr_debug("    head:        %lx\n", kimage->head);
+	pr_debug("    nr_segments: %lu\n", kimage->nr_segments);
+
+	for (i = 0; i < kimage->nr_segments; i++) {
+		pr_debug("      segment[%lu]: %016lx - %016lx, 0x%lx bytes, %lu pages\n",
+			i,
+			kimage->segment[i].mem,
+			kimage->segment[i].mem + kimage->segment[i].memsz,
+			kimage->segment[i].memsz,
+			kimage->segment[i].memsz /  PAGE_SIZE);
+	}
+}
+
 void machine_kexec_cleanup(struct kimage *kimage)
 {
 	/* Empty routine needed to avoid build errors. */
@@ -40,6 +66,8 @@ int machine_kexec_prepare(struct kimage *kimage)
 {
 	kimage_start = kimage->start;
 
+	kexec_image_info(kimage);
+
 	if (kimage->type != KEXEC_TYPE_CRASH) {
 		if (cpus_are_stuck_in_kernel()) {
 			pr_err("Can't kexec: failed CPUs are stuck in the kernel.\n");
@@ -140,6 +168,20 @@ void machine_kexec(struct kimage *kimage)
 	reboot_code_buffer_phys = page_to_phys(kimage->control_code_page);
 	reboot_code_buffer = phys_to_virt(reboot_code_buffer_phys);
 
+	kexec_image_info(kimage);
+
+	pr_debug("%s:%d: control_code_page:        %p\n", __func__, __LINE__,
+		kimage->control_code_page);
+	pr_debug("%s:%d: reboot_code_buffer_phys:  %pa\n", __func__, __LINE__,
+		&reboot_code_buffer_phys);
+	pr_debug("%s:%d: reboot_code_buffer:       %p\n", __func__, __LINE__,
+		reboot_code_buffer);
+	pr_debug("%s:%d: relocate_new_kernel:      %p\n", __func__, __LINE__,
+		arm64_relocate_new_kernel);
+	pr_debug("%s:%d: relocate_new_kernel_size: 0x%lx(%lu) bytes\n",
+		__func__, __LINE__, arm64_relocate_new_kernel_size,
+		arm64_relocate_new_kernel_size);
+
 	/*
 	 * Copy arm64_relocate_new_kernel to the reboot_code_buffer for use
 	 * after the kernel is shut down.
-- 
2.5.0
