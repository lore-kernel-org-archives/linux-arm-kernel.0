From: geoff@infradead.org (Geoff Levand)
Date: Thu, 18 Aug 2016 18:21:02 +0000
Subject: [PATCH v4 3/3] arm64: Add support for binary image files
In-Reply-To: <cover.1471543843.git.geoff@infradead.org>
References: <cover.1471543843.git.geoff@infradead.org>
Message-ID: <7b17bc40e62e90fd92207d4385a0a99aec958d26.1471543843.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pratyush Anand <panand@redhat.com>

Signed-off-by: Pratyush Anand <panand@redhat.com>
[Reworked and cleaned up]
Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 kexec/arch/arm64/kexec-image-arm64.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/kexec/arch/arm64/kexec-image-arm64.c b/kexec/arch/arm64/kexec-image-arm64.c
index 42d2ea7..b77b63e 100644
--- a/kexec/arch/arm64/kexec-image-arm64.c
+++ b/kexec/arch/arm64/kexec-image-arm64.c
@@ -21,14 +21,35 @@ int image_arm64_probe(const char *kernel_buf, off_t kernel_size)
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
+	const struct arm64_image_header *h;
+	unsigned long image_base;
+
+	h = (const struct arm64_image_header *)(kernel_buf);
+
+	if (arm64_process_image_header(h))
+		return -1;
+
+	dbgprintf("%s: text_offset:   %016lx\n", __func__,
+		arm64_mem.text_offset);
+	dbgprintf("%s: image_size:    %016lx\n", __func__,
+		arm64_mem.image_size);
+	dbgprintf("%s: phys_offset:   %016lx\n", __func__,
+		arm64_mem.phys_offset);
+	dbgprintf("%s: PE format:     %s\n", __func__,
+		(arm64_header_check_pe_sig(h) ? "yes" : "no"));
+
+	image_base = get_phys_offset() + arm64_mem.text_offset;
+	
+	add_segment_phys_virt(info, kernel_buf, kernel_size, image_base,
+		arm64_mem.image_size, 0);
+
+	return arm64_load_other_segments(info, image_base);
 }
 
 void image_arm64_usage(void)
@@ -36,6 +57,4 @@ void image_arm64_usage(void)
 	printf(
 "     An ARM64 binary image, compressed or not, big or little endian.\n"
 "     Typically an Image, Image.gz or Image.lzma file.\n\n");
-	printf(
-"     ARM64 binary image files are currently NOT SUPPORTED.\n\n");
 }
-- 
2.7.4
