From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  5 Nov 2018 20:43:20 +0100
Subject: [PATCH v2 1/2] ARM: compressed: put zImage header and EFI header in
 dedicated section
In-Reply-To: <20181105194321.26657-1-ard.biesheuvel@linaro.org>
References: <20181105194321.26657-1-ard.biesheuvel@linaro.org>
Message-ID: <20181105194321.26657-2-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To align the PE/COFF and the ELF headers of the decompressor binary, put
the zImage header and the EFI header in a separate .header section, and
emit it at the start of the Image. This change is necessary for UEFI
based debug tooling to be able to use the vmlinux ELF binary, since it
gets confused if the PE/COFF .text section and the ELF .text section live
at different offsets.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/boot/compressed/head.S        | 4 +++-
 arch/arm/boot/compressed/vmlinux.lds.S | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 6c7ccb428c07..261128840596 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -143,7 +143,7 @@
 #endif
 		.endm
 
-		.section ".start", #alloc, #execinstr
+		.section ".header", #alloc, #execinstr
 /*
  * sort out different calling conventions
  */
@@ -176,6 +176,8 @@ start:
 		.word	_magic_table	@ additional data table
 
 		__EFI_HEADER
+
+		.section ".start", #alloc, #execinstr
 1:
  ARM_BE8(	setend	be		)	@ go BE8 if compiled for BE8
  AR_CLASS(	mrs	r9, cpsr	)
diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index 2b963d8e76dd..94738ca5405a 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -34,8 +34,11 @@ SECTIONS
   . = TEXT_START;
   _text = .;
 
-  .text : {
+  .header : {
     _start = .;
+    *(.header)
+  }
+  .text : {
     *(.start)
     *(.text)
     *(.text.*)
-- 
2.19.1
