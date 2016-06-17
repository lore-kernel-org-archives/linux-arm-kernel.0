From: rmk@armlinux.org.uk (Russell King)
Date: Fri, 17 Jun 2016 20:44:42 +0100
Subject: [PATCH 2/2] arm: fix kernel image size
In-Reply-To: <20160617194405.GN1041@n2100.armlinux.org.uk>
References: <20160617194405.GN1041@n2100.armlinux.org.uk>
Message-ID: <E1bDzh4-0006a4-7p@e0050434b2927.dyn.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we want to assume that the compressed image will expand by a maximum
of 4x, we actually need to reserve 5x the space, since we need to keep
a copy of the compessed image around while decompressing.

Signed-off-by: Russell King <rmk@armlinux.org.uk>
---
 kexec/arch/arm/kexec-zImage-arm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 297b7fd8..9400d1f4 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -526,8 +526,10 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		initrd_base = kernel_base + _ALIGN(kexec_arm_image_size, getpagesize());
 	} else {
 		/* Otherwise, assume the maximum kernel compression ratio
-		 * is 4, and just to be safe, place ramdisk after that */
-		initrd_base = kernel_base + _ALIGN(len * 4, getpagesize());
+		 * is 4, and just to be safe, place ramdisk after that.
+		 * Note that we must include space for the compressed
+		 * image here as well. */
+		initrd_base = kernel_base + _ALIGN(len * 5, getpagesize());
 	}
 
 	if (use_atags) {
-- 
1.9.1
