From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 30 May 2017 18:36:46 +0000
Subject: [PATCH 6/7] arm: compressed: put zImage header and EFI header in
 dedicated section
In-Reply-To: <20170530183647.28557-1-ard.biesheuvel@linaro.org>
References: <20170530183647.28557-1-ard.biesheuvel@linaro.org>
Message-ID: <20170530183647.28557-7-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To align the PE/COFF and the ELF headers of the decompressor binary, put
the zImage header and the EFI header in a separate .start section, and
emit it at the start of the Image. This change is necessary for UEFI
based debug tooling to be able to use the vmlinux ELF binary, since it
gets confused if the PE/COFF .text section and the ELF .text section live
at different offsets.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/boot/compressed/efi-header.S  | 1 +
 arch/arm/boot/compressed/vmlinux.lds.S | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/efi-header.S b/arch/arm/boot/compressed/efi-header.S
index 3b1d95f43f2b..a0567ed366c6 100644
--- a/arch/arm/boot/compressed/efi-header.S
+++ b/arch/arm/boot/compressed/efi-header.S
@@ -126,5 +126,6 @@ section_table:
 
 	.align	12
 __efi_start:
+	.text
 #endif
 	.endm
diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index dfcc2baa0077..aa0ee9b5affe 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -39,9 +39,11 @@ SECTIONS
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
2.9.3
