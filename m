From: rmk@armlinux.org.uk (Russell King)
Date: Thu, 07 Jul 2016 15:01:24 +0100
Subject: [PATCH 2/2] arm: use zImage size from header
In-Reply-To: <20160707102003.GO1041@n2100.armlinux.org.uk>
References: <20160707102003.GO1041@n2100.armlinux.org.uk>
Message-ID: <E1bL9ro-0002P2-Cr@e0050434b2927.dyn.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We do not support zImage with an appended DTB as we need to supply our
own DTB to the kernel, and an appended DTB will override any that we
try to supply.  To ensure that we do not load an appended DTB, clamp
the kernel size to the size specified in the zImage header.

Signed-off-by: Russell King <rmk@armlinux.org.uk>
---
 kexec/arch/arm/kexec-zImage-arm.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index c8b90f96..7f02b931 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -28,6 +28,14 @@ off_t initrd_base = 0, initrd_size = 0;
 unsigned int kexec_arm_image_size = 0;
 unsigned long long user_page_offset = (-1ULL);
 
+struct zimage_header {
+	uint32_t instr[9];
+	uint32_t magic;
+#define ZIMAGE_MAGIC cpu_to_le32(0x016f2818)
+	uint32_t start;
+	uint32_t end;
+};
+
 struct android_image {
 	char magic[8];
 	uint32_t kernel_size;
@@ -435,6 +443,34 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	if (dtb_file)
 		dtb_buf = slurp_file(dtb_file, &dtb_length);
 
+	if (len > 0x34) {
+		const struct zimage_header *hdr;
+		off_t size;
+
+		hdr = (const struct zimage_header *)buf;
+
+		dbgprintf("zImage header: 0x%08x 0x%08x 0x%08x\n",
+			  hdr->magic, hdr->start, hdr->end);
+
+		if (hdr->magic == ZIMAGE_MAGIC) {
+			size = le32_to_cpu(hdr->end) - le32_to_cpu(hdr->start);
+
+			dbgprintf("zImage size 0x%llx, file size 0x%llx\n",
+				  (unsigned long long)size,
+				  (unsigned long long)len);
+
+			if (size > len) {
+				fprintf(stderr,
+					"zImage is truncated - file 0x%llx vs header 0x%llx\n",
+					(unsigned long long)len,
+					(unsigned long long)size);
+				return -1;
+			}
+			if (size < len)
+				len = size;
+		}
+	}
+
 	/* Handle android images, 2048 is the minimum page size */
 	if (len > 2048 && !strncmp(buf, "ANDROID!", 8)) {
 		const struct android_image *aimg = (const void *)buf;
-- 
1.9.1
