From: geoff@infradead.org (Geoff Levand)
Date: Wed, 21 Sep 2016 18:14:25 +0000
Subject: [PATCH v6 3/3] arm64: Add support for binary image files
In-Reply-To: <cover.1474481332.git.geoff@infradead.org>
References: <cover.1474481332.git.geoff@infradead.org>
Message-ID: <a9f1fafd7c248d33768177438742b90bc4338202.1474481332.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pratyush Anand <panand@redhat.com>

Signed-off-by: Pratyush Anand <panand@redhat.com>
[Reworked and cleaned up]
Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 kexec/arch/arm64/kexec-image-arm64.c | 49 ++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/kexec/arch/arm64/kexec-image-arm64.c b/kexec/arch/arm64/kexec-image-arm64.c
index 42d2ea7..960ed96 100644
--- a/kexec/arch/arm64/kexec-image-arm64.c
+++ b/kexec/arch/arm64/kexec-image-arm64.c
@@ -3,7 +3,9 @@
  */
 
 #define _GNU_SOURCE
+
 #include "kexec-arm64.h"
+#include <limits.h>
 
 int image_arm64_probe(const char *kernel_buf, off_t kernel_size)
 {
@@ -21,14 +23,53 @@ int image_arm64_probe(const char *kernel_buf, off_t kernel_size)
 		return -1;
 	}
 
-	fprintf(stderr, "kexec: ARM64 binary image files are currently NOT SUPPORTED.\n");
-	return -1;
+	return 0;
 }
 
 int image_arm64_load(int argc, char **argv, const char *kernel_buf,
 	off_t kernel_size, struct kexec_info *info)
 {
-	return -1;
+	const struct arm64_image_header *header;
+	unsigned long kernel_segment;
+	int result;
+
+	header = (const struct arm64_image_header *)(kernel_buf);
+
+	if (arm64_process_image_header(header))
+		return -1;
+
+        kernel_segment = arm64_locate_kernel_segment(info);
+
+        if (kernel_segment == ULONG_MAX) {
+                dbgprintf("%s: Kernel segment is not allocated\n", __func__);
+                result = -EFAILED;
+                goto exit;
+        }
+
+	dbgprintf("%s: kernel_segment: %016lx\n", __func__, kernel_segment);
+	dbgprintf("%s: text_offset:    %016lx\n", __func__,
+		arm64_mem.text_offset);
+	dbgprintf("%s: image_size:     %016lx\n", __func__,
+		arm64_mem.image_size);
+	dbgprintf("%s: phys_offset:    %016lx\n", __func__,
+		arm64_mem.phys_offset);
+	dbgprintf("%s: vp_offset:      %016lx\n", __func__,
+		arm64_mem.vp_offset);
+	dbgprintf("%s: PE format:      %s\n", __func__,
+		(arm64_header_check_pe_sig(header) ? "yes" : "no"));
+
+	/* load the kernel */
+	add_segment_phys_virt(info, kernel_buf, kernel_size,
+			kernel_segment + arm64_mem.text_offset,
+			arm64_mem.image_size, 0);
+
+	result = arm64_load_other_segments(info, kernel_segment
+		+ arm64_mem.text_offset);
+
+exit:
+        if (result)
+                fprintf(stderr, "kexec: load failed.\n");
+        return result;
 }
 
 void image_arm64_usage(void)
@@ -36,6 +77,4 @@ void image_arm64_usage(void)
 	printf(
 "     An ARM64 binary image, compressed or not, big or little endian.\n"
 "     Typically an Image, Image.gz or Image.lzma file.\n\n");
-	printf(
-"     ARM64 binary image files are currently NOT SUPPORTED.\n\n");
 }
-- 
2.7.4
