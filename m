From: rmk@armlinux.org.uk (Russell King)
Date: Thu, 07 Jul 2016 15:01:19 +0100
Subject: [PATCH 1/2] arm: plug a zImage corner case
In-Reply-To: <20160707102003.GO1041@n2100.armlinux.org.uk>
References: <20160707102003.GO1041@n2100.armlinux.org.uk>
Message-ID: <E1bL9rj-0002Ow-6i@e0050434b2927.dyn.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a zImage is built with ARM_APPENDED_DTB enabled, the zImage will
look at the word following the zImage and check whether it contains
the DTB magic number.

Generally, kexec will clear the destination pages before copying the
zImage, but there is a corner case where the zImage is a multiple of
the page size, where the following page will not be touched.  Should
the first word in this page contain the DTB magic number, the data
following will be interpreted as a DTB image.

In order to make this bullet-proof, we must always initialise the word
following the zImage.  Arrange this by specifying the zImage memory
size one word bigger than the buffer size.

Signed-off-by: Russell King <rmk@armlinux.org.uk>
---
 kexec/arch/arm/kexec-zImage-arm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 9400d1f4..c8b90f96 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -343,6 +343,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	unsigned long base, kernel_base;
 	unsigned int atag_offset = 0x1000; /* 4k offset from memory start */
 	unsigned int extra_size = 0x8000; /* TEXT_OFFSET */
+	size_t kernel_mem_size;
 	const char *command_line;
 	char *modified_cmdline = NULL;
 	off_t command_line_len;
@@ -470,6 +471,12 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	}
 
 	/*
+	 * Always extend the zImage by four bytes to ensure that an appended
+	 * DTB image always sees an initialised value after _edata.
+	 */
+	kernel_mem_size = len + 4;
+
+	/*
 	 * If we are loading a dump capture kernel, we need to update kernel
 	 * command line and also add some additional segments.
 	 */
@@ -621,7 +628,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		            dtb_offset, dtb_length);
 	}
 
-	add_segment(info, buf, len, kernel_base, len);
+	add_segment(info, buf, len, kernel_base, kernel_mem_size);
 
 	info->entry = (void*)kernel_base;
 
-- 
1.9.1
