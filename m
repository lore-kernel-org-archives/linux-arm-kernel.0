From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Mar 2018 10:43:02 +0000
Subject: issue with kexec/kdump on imx6ull
In-Reply-To: <20180320100427.GA21933@arthur-bzh>
References: <20180320100427.GA21933@arthur-bzh>
Message-ID: <20180320104302.GG2743@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2018 at 11:04:27AM +0100, Arthur LAMBERT wrote:
> Hi,
> 
> I am trying to use kexec/kdump on imx6ull evaluation kit without success.
> kernel : git://git.freescale.com/imx/linux-imx.git
> kernel tag : rel_imx_4.9.x_1.0.0_ga
> defconfig : imx_v7
> device tree :  imx6ull-14x14-evk

The wrong patch was merged into kexec-tools, breaking ARM support for
kexec.  I think I pointed this out to the kexec-tools maintainers after
it had already taken ages to get the patches merged, but never received
any response, so I now no longer care about the allegedly maintained
kexec-tools, sorry.

I've been considering putting a working git tree on git.armlinux.org.uk
to replace the "official" kexec-tools.

The patch which fixes the mis-merge is below:

8<=====
From: Russell King <rmk@armlinux.org.uk>
Subject: [PATCH] ARM: read kernel size from zImage

Signed-off-by: Russell King <rmk@armlinux.org.uk>
---
 kexec/arch/arm/kexec-zImage-arm.c | 106 ++++++++++++++++++++++++++------------
 1 file changed, 74 insertions(+), 32 deletions(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index a8c40cb6cd6a..76a0b5b66745 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -355,6 +355,34 @@ static int setup_dtb_prop(char **bufp, off_t *sizep, int parentoffset,
 	return 0;
 }
 
+static const struct zimage_tag *find_extension_tag(const char *buf, off_t len,
+	uint32_t tag_id)
+{
+	const struct zimage_header *hdr = (const struct zimage_header *)buf;
+	const struct zimage_tag *tag;
+	uint32_t offset, size;
+	uint32_t max = len - sizeof(struct tag_header);
+
+	if (len < sizeof(*hdr) ||
+            hdr->magic != ZIMAGE_MAGIC ||
+	    hdr->magic2 != ZIMAGE_MAGIC2)
+		return NULL;
+
+	for (offset = hdr->extension_tag_offset;
+	     (tag = (void *)(buf + offset)) != NULL &&
+	      offset < max &&
+	      (size = le32_to_cpu(byte_size(tag))) != 0 &&
+	      offset + size < len;
+	     offset += size) {
+		dbgprintf("  offset 0x%08x tag 0x%08x size %u\n",
+			  offset, le32_to_cpu(tag->hdr.tag), size);
+		if (tag->hdr.tag == tag_id)
+			return tag;
+	}
+
+	return NULL;
+}
+
 int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info)
 {
@@ -362,6 +390,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	unsigned long base, kernel_base;
 	unsigned int atag_offset = 0x1000; /* 4k offset from memory start */
 	unsigned int extra_size = 0x8000; /* TEXT_OFFSET */
+	const struct zimage_tag *tag;
 	size_t kernel_mem_size;
 	const char *command_line;
 	char *modified_cmdline = NULL;
@@ -480,35 +509,6 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 			if (size < len)
 				len = size;
 		}
-
-		/* Do we have an extension table? */
-		if (hdr->magic2 == ZIMAGE_MAGIC2 && !kexec_arm_image_size) {
-			uint32_t offset = hdr->extension_tag_offset;
-			uint32_t max = len - sizeof(struct tag_header);
-			struct zimage_tag *tag;
-
-			dbgprintf("zImage has tags\n");
-
-			for (offset = hdr->extension_tag_offset;
-			     (tag = (void *)(buf + offset)) != NULL &&
-			     offset < max && byte_size(tag) &&
-				offset + byte_size(tag) < len;
-			     offset += byte_size(tag)) {
-				dbgprintf("  offset 0x%08x tag 0x%08x size %u\n",
-					  offset, tag->hdr.tag, byte_size(tag));
-				if (tag->hdr.tag == ZIMAGE_TAG_KRNL_SIZE) {
-					uint32_t *p = (void *)buf +
-						tag->u.krnl_size.size_ptr;
-
-					kexec_arm_image_size =
-						get_unaligned(p) +
-						tag->u.krnl_size.bss_size;
-				}
-			}
-
-			dbgprintf("kernel image size: 0x%08x\n",
-				  kexec_arm_image_size);
-		}
 	}
 
 	/* Handle android images, 2048 is the minimum page size */
@@ -553,9 +553,40 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	kernel_mem_size = len + 4;
 
 	/*
-	 * If the user didn't specify the size of the image, assume the
-	 * maximum kernel compression ratio is 4.  Note that we must
-	 * include space for the compressed image here as well.
+	 * Check for a kernel size extension, and set or validate the
+	 * image size.  This is the total space needed to avoid the
+	 * boot kernel BSS, so other data (such as initrd) does not get
+	 * overwritten.
+	 */
+	tag = find_extension_tag(buf, len, ZIMAGE_TAG_KRNL_SIZE);
+	if (tag) {
+		uint32_t *p = (void *)buf + le32_to_cpu(tag->u.krnl_size.size_ptr);
+		uint32_t edata_size = le32_to_cpu(get_unaligned(p));
+		uint32_t bss_size = le32_to_cpu(tag->u.krnl_size.bss_size);
+		uint32_t kernel_size = edata_size + bss_size;
+
+		/*
+		 * While decompressing, the zImage is placed past _edata
+		 * of the decompressed kernel.  Ensure we account for that.
+		 */
+		if (kernel_size < edata_size + len)
+			kernel_size = edata_size + len;
+
+		if (kexec_arm_image_size == 0)
+			kexec_arm_image_size = kernel_size;
+		else if (kexec_arm_image_size < kernel_size) {
+			fprintf(stderr,
+				"Kernel size is too small, increasing to 0x%lx\n",
+				(unsigned long)kernel_size);
+			kexec_arm_image_size = kernel_size;
+		}
+	}
+
+	/*
+	 * If the user didn't specify the size of the image, and we don't
+	 * have the extension tables, assume the maximum kernel compression
+	 * ratio is 4.  Note that we must include space for the compressed
+	 * image here as well.
 	 */
 	if (!kexec_arm_image_size)
 		kexec_arm_image_size = len * 5;
@@ -617,6 +648,10 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	 */
 	initrd_base = kernel_base + _ALIGN(kexec_arm_image_size, page_size);
 
+	dbgprintf("%-6s: address=0x%08lx size=0x%08lx\n", "Kernel",
+		  (unsigned long)kernel_base,
+		  (unsigned long)kexec_arm_image_size);
+
 	if (ramdisk_buf) {
 		/*
 		 * Find a hole to place the initrd. The crash kernel use
@@ -630,6 +665,10 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 				return -1;
 		}
 
+		dbgprintf("%-6s: address=0x%08lx size=0x%08lx\n", "Initrd",
+			  (unsigned long)initrd_base,
+			  (unsigned long)initrd_size);
+
 		add_segment(info, ramdisk_buf, initrd_size, initrd_base,
 			    initrd_size);
 	}
@@ -708,6 +747,9 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 				return -1;
 		}
 
+		dbgprintf("%-6s: address=0x%08lx size=0x%08lx\n", "DT",
+			  (unsigned long)dtb_offset, (unsigned long)dtb_length);
+
 		add_segment(info, dtb_buf, dtb_length, dtb_offset, dtb_length);
 	}
 
-- 
2.7.4


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync@8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
