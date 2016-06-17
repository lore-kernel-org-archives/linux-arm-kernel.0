From: rmk@armlinux.org.uk (Russell King)
Date: Fri, 17 Jun 2016 20:44:37 +0100
Subject: [PATCH 1/2] arm: take account of TEXT_OFFSET for subsequent images
In-Reply-To: <20160617194405.GN1041@n2100.armlinux.org.uk>
References: <20160617194405.GN1041@n2100.armlinux.org.uk>
Message-ID: <E1bDzgz-0006Zy-1g@e0050434b2927.dyn.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM kexec code was not taking account of the 32k text offset when
applying the size(s) of the kernel image.  We need to take account of
this so when we decide to place the initrd at 4x the compressed image
length, it is appropriately placed.

Signed-off-by: Russell King <rmk@armlinux.org.uk>
---
 kexec/arch/arm/kexec-zImage-arm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index aab0c861..297b7fd8 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -340,7 +340,7 @@ static int setup_dtb_prop(char **bufp, off_t *sizep, int parentoffset,
 int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info)
 {
-	unsigned long base;
+	unsigned long base, kernel_base;
 	unsigned int atag_offset = 0x1000; /* 4k offset from memory start */
 	unsigned int extra_size = 0x8000; /* TEXT_OFFSET */
 	const char *command_line;
@@ -517,15 +517,17 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	if (base == ULONG_MAX)
 		return -1;
 
+	kernel_base = base + extra_size;
+
 	if (kexec_arm_image_size) {
 		/* If the image size was passed as command line argument,
 		 * use that value for determining the address for initrd,
 		 * atags and dtb images. page-align the given length.*/
-		initrd_base = base + _ALIGN(kexec_arm_image_size, getpagesize());
+		initrd_base = kernel_base + _ALIGN(kexec_arm_image_size, getpagesize());
 	} else {
 		/* Otherwise, assume the maximum kernel compression ratio
 		 * is 4, and just to be safe, place ramdisk after that */
-		initrd_base = base + _ALIGN(len * 4, getpagesize());
+		initrd_base = kernel_base + _ALIGN(len * 4, getpagesize());
 	}
 
 	if (use_atags) {
@@ -617,9 +619,9 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		            dtb_offset, dtb_length);
 	}
 
-	add_segment(info, buf, len, base + extra_size, len);
+	add_segment(info, buf, len, kernel_base, len);
 
-	info->entry = (void*)base + extra_size;
+	info->entry = (void*)kernel_base;
 
 	return 0;
 }
-- 
1.9.1
