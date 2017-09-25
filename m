From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 25 Sep 2017 19:11:51 +0100
Subject: [PATCH] ARM: decompressor:add additional table to compressed kernel
Message-ID: <E1dwXrD-0002DU-C6@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an additional extendable table to the compressed kernel so that we
can provide further information to boot loaders regarding the properties
of the image contained within.

When the kernel is configured to produce an EFI binary, one of the EFI
tables starts at a fixed offset of 0x3c into the image.  Luckily, there
are two words available after our zImage header to be able to place
additional information.  Since the data here is indeterminant, we need
to mark the presence of new information with a magic number, and we use
the second word to point (via an offset) to a new table.

The new table uses a tagged-list approach, just like the old ATAG system
(allowing some re-use of those structures) to add information for boot
loaders.  This allows additional information to be added without needing
major revisions of the interface.  Users who do not understand the
information will not recognise the tag, and will skip over it.

Our only entry in this table give sthe size of the decompressed kernel
(which is stored, unaligned, at the end of the compressed data) and the
decompressed kernel's BSS size.  Both of these are necessary for kexec
to be able to properly locate the initrd and dtb within memory for both
the normal case and the panic case.  In the panic case, we want to
locate the images as closely together as possible.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/compressed/head.S        |  2 ++
 arch/arm/boot/compressed/vmlinux.lds.S | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 6e3a9e21436e..cce05a866945 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -139,6 +139,8 @@
 		.word	_magic_start	@ absolute load/run zImage address
 		.word	_magic_end	@ zImage end address
 		.word	0x04030201	@ endianness flag
+		.word	0x45454545	@ another magic number to indicate
+		.word	_magic_table	@ additional data table
 
 		__EFI_HEADER
 1:
diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index 81c493156ce8..76b0330f65c4 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -44,6 +44,15 @@ SECTIONS
     *(.glue_7t)
     *(.glue_7)
   }
+  .table : ALIGN(4) {
+    _table_start = .;
+    LONG(ZIMAGE_MAGIC(2))
+    LONG(ZIMAGE_MAGIC(0x5a534c4b))
+    LONG(ZIMAGE_MAGIC(__piggy_size_addr - _start))
+    LONG(ZIMAGE_MAGIC(_kernel_bss_size))
+    LONG(0)
+    _table_end = .;
+  }
   .rodata : {
     *(.rodata)
     *(.rodata.*)
@@ -57,6 +66,7 @@ SECTIONS
   }
   .piggydata : {
     *(.piggydata)
+    __piggy_size_addr = . - 4;
   }
 
   . = ALIGN(4);
@@ -75,6 +85,7 @@ SECTIONS
   _magic_sig = ZIMAGE_MAGIC(0x016f2818);
   _magic_start = ZIMAGE_MAGIC(_start);
   _magic_end = ZIMAGE_MAGIC(_edata);
+  _magic_table = ZIMAGE_MAGIC(_table_start - _start);
 
   . = BSS_START;
   __bss_start = .;
-- 
2.7.4
