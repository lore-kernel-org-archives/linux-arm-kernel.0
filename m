From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 30 Mar 2016 17:43:07 +0200
Subject: [PATCH v2 2/4] arm64: move early boot code to the .init segment
In-Reply-To: <1459352589-28721-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1459352589-28721-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1459352589-28721-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apart from the arm64/linux and EFI header data structures, there is nothing
in the .head.text section that must reside at the beginning of the Image.
So let's move it to the .init section where it belongs.

Note that this involves some minor tweaking of the EFI header, primarily
because the address of 'stext' no longer coincides with the start of the
.text section. It also requires a couple of relocated symbol references
to be slightly rewritten or their definition moved to the linker script.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/efi-entry.S |  2 +-
 arch/arm64/kernel/head.S      | 32 +++++++++-----------
 arch/arm64/kernel/image.h     |  4 +++
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/kernel/efi-entry.S b/arch/arm64/kernel/efi-entry.S
index cae3112f7791..e88c064b845c 100644
--- a/arch/arm64/kernel/efi-entry.S
+++ b/arch/arm64/kernel/efi-entry.S
@@ -62,7 +62,7 @@ ENTRY(entry)
 	 */
 	mov	x20, x0		// DTB address
 	ldr	x0, [sp, #16]	// relocated _text address
-	movz	x21, #:abs_g0:stext_offset
+	ldr	w21, =stext_offset
 	add	x21, x0, x21
 
 	/*
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 4203d5f257bc..b43417618847 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -102,8 +102,6 @@ _head:
 #endif
 
 #ifdef CONFIG_EFI
-	.globl	__efistub_stext_offset
-	.set	__efistub_stext_offset, stext - _head
 	.align 3
 pe_header:
 	.ascii	"PE"
@@ -123,11 +121,11 @@ optional_header:
 	.short	0x20b				// PE32+ format
 	.byte	0x02				// MajorLinkerVersion
 	.byte	0x14				// MinorLinkerVersion
-	.long	_end - stext			// SizeOfCode
+	.long	_end - efi_header_end		// SizeOfCode
 	.long	0				// SizeOfInitializedData
 	.long	0				// SizeOfUninitializedData
 	.long	__efistub_entry - _head		// AddressOfEntryPoint
-	.long	__efistub_stext_offset		// BaseOfCode
+	.long	efi_header_end - _head		// BaseOfCode
 
 extra_header_fields:
 	.quad	0				// ImageBase
@@ -144,7 +142,7 @@ extra_header_fields:
 	.long	_end - _head			// SizeOfImage
 
 	// Everything before the kernel image is considered part of the header
-	.long	__efistub_stext_offset		// SizeOfHeaders
+	.long	efi_header_end - _head		// SizeOfHeaders
 	.long	0				// CheckSum
 	.short	0xa				// Subsystem (EFI application)
 	.short	0				// DllCharacteristics
@@ -188,10 +186,10 @@ section_table:
 	.byte	0
 	.byte	0
 	.byte	0        		// end of 0 padding of section name
-	.long	_end - stext		// VirtualSize
-	.long	__efistub_stext_offset	// VirtualAddress
-	.long	_edata - stext		// SizeOfRawData
-	.long	__efistub_stext_offset	// PointerToRawData
+	.long	_end - efi_header_end	// VirtualSize
+	.long	efi_header_end - _head	// VirtualAddress
+	.long	_edata - efi_header_end	// SizeOfRawData
+	.long	efi_header_end - _head	// PointerToRawData
 
 	.long	0		// PointerToRelocations (0 for executables)
 	.long	0		// PointerToLineNumbers (0 for executables)
@@ -200,15 +198,18 @@ section_table:
 	.long	0xe0500020	// Characteristics (section flags)
 
 	/*
-	 * EFI will load stext onwards at the 4k section alignment
+	 * EFI will load .text onwards at the 4k section alignment
 	 * described in the PE/COFF header. To ensure that instruction
 	 * sequences using an adrp and a :lo12: immediate will function
-	 * correctly at this alignment, we must ensure that stext is
+	 * correctly at this alignment, we must ensure that .text is
 	 * placed at a 4k boundary in the Image to begin with.
 	 */
 	.align 12
+efi_header_end:
 #endif
 
+	__INIT
+
 ENTRY(stext)
 	bl	preserve_boot_args
 	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
@@ -223,12 +224,12 @@ ENTRY(stext)
 	 * the TCR will have been set.
 	 */
 	ldr	x27, 0f				// address to jump to after
-						// MMU has been enabled
+	neg	x27, x27			// MMU has been enabled
 	adr_l	lr, __enable_mmu		// return (PIC) address
 	b	__cpu_setup			// initialise processor
 ENDPROC(stext)
 	.align	3
-0:	.quad	__mmap_switched - (_head - TEXT_OFFSET) + KIMAGE_VADDR
+0:	.quad	(_text - TEXT_OFFSET) - __mmap_switched - KIMAGE_VADDR
 
 /*
  * Preserve the arguments passed by the bootloader in x0 .. x3
@@ -397,7 +398,7 @@ __create_page_tables:
 	ldr	x5, =KIMAGE_VADDR
 	add	x5, x5, x23			// add KASLR displacement
 	create_pgd_entry x0, x5, x3, x6
-	ldr	w6, kernel_img_size
+	ldr	w6, =kernel_img_size
 	add	x6, x6, x5
 	mov	x3, x24				// phys offset
 	create_block_map x0, x7, x3, x5, x6
@@ -414,9 +415,6 @@ __create_page_tables:
 
 	ret	x28
 ENDPROC(__create_page_tables)
-
-kernel_img_size:
-	.long	_end - (_head - TEXT_OFFSET)
 	.ltorg
 
 /*
diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
index 5e360ce88f10..4fd72da646a3 100644
--- a/arch/arm64/kernel/image.h
+++ b/arch/arm64/kernel/image.h
@@ -71,8 +71,12 @@
 	DEFINE_IMAGE_LE64(_kernel_offset_le, TEXT_OFFSET);	\
 	DEFINE_IMAGE_LE64(_kernel_flags_le, __HEAD_FLAGS);
 
+kernel_img_size = _end - (_text - TEXT_OFFSET);
+
 #ifdef CONFIG_EFI
 
+__efistub_stext_offset = stext - _text;
+
 /*
  * Prevent the symbol aliases below from being emitted into the kallsyms
  * table, by forcing them to be absolute symbols (which are conveniently
-- 
2.5.0
