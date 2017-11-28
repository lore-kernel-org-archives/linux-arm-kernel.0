From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 28 Nov 2017 16:27:00 +0000
Subject: [PATCH] ARM: verify size of zImage
Message-ID: <E1eJiiq-0006k9-FE@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The linker can sometimes add additional sections to the zImage ELF file
which results in the zImage binary being larger than expected.  This
causes appended DT blobs to fail.

Verify that the zImage binary is the expected size, and fail the build
if this is not the case.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
As this patch is different, I've dropped Matthias' tested-by.  I'd
appreciate a replacement, thanks.  Also, I seem to remember that
Ard's toolchain was giving issues - maybe this alternative will
finally resolve them.

 arch/arm/boot/compressed/vmlinux.lds.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index e6bf6774c4bb..ed53ca9f482e 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -101,6 +101,12 @@ SECTIONS
    * this symbol allows further debug in the near future.
    */
   .image_end (NOLOAD) : {
+    /*
+     * EFI requires that the image is aligned to 512 bytes, and appended
+     * DTB requires that we know where the end of the image is.  Ensure
+     * that both are satisfied by ensuring that there are no additional
+     * sections emitted into the decompressor image.
+     */
     _edata_real = .;
   }
 
@@ -128,3 +134,4 @@ SECTIONS
   .stab.indexstr 0	: { *(.stab.indexstr) }
   .comment 0		: { *(.comment) }
 }
+ASSERT(_edata_real == _edata, "error: zImage file size is incorrect");
-- 
2.7.4
