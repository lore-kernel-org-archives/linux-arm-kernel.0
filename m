From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  5 Nov 2018 19:44:37 +0100
Subject: [PATCH 5/6] ARM: compressed: put zImage header and EFI header in
 dedicated section
In-Reply-To: <20181105184438.19494-1-ard.biesheuvel@linaro.org>
References: <20181105184438.19494-1-ard.biesheuvel@linaro.org>
Message-ID: <20181105184438.19494-6-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To align the PE/COFF and the ELF headers of the decompressor binary, put
the zImage header and the EFI header in a separate .start section, and
emit it at the start of the Image. This change is necessary for UEFI
based debug tooling to be able to use the vmlinux ELF binary, since it
gets confused if the PE/COFF .text section and the ELF .text section live
at different offsets.

With this change, we also stop relying on the code to flow from one
section to the next simply because the order in which the linker emits
the sections happens to be what we expect.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/boot/compressed/head.S        | 6 +++---
 arch/arm/boot/compressed/vmlinux.lds.S | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 55c227077207..e3c43fdb6371 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -176,6 +176,8 @@ start:
 		.word	_magic_table	@ additional data table
 
 		__EFI_HEADER
+
+		.text
 1:
  ARM_BE8(	setend	be		)	@ go BE8 if compiled for BE8
  AR_CLASS(	mrs	r9, cpsr	)
@@ -209,10 +211,8 @@ not_angel:
 
 		/*
 		 * some architecture specific code can be inserted
-		 * by the linker here, but it should preserve r7, r8, and r9.
+		 * here, but it should preserve r7, r8, and r9.
 		 */
-
-		.text
 #ifdef CONFIG_PXA_SHARPSL_DETECT_MACH_ID
 		bl	__SharpSL_start
 #endif
diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index 2b963d8e76dd..ad9921490034 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -34,9 +34,11 @@ SECTIONS
   . = TEXT_START;
   _text = .;
 
-  .text : {
+  .start : {
     _start = .;
     *(.start)
+  }
+  .text : {
     *(.text)
     *(.text.*)
     *(.fixup)
-- 
2.19.1
