From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  5 Nov 2018 20:43:21 +0100
Subject: [PATCH v2 2/2] ARM: efi: add PE/COFF debug table to EFI header
In-Reply-To: <20181105194321.26657-1-ard.biesheuvel@linaro.org>
References: <20181105194321.26657-1-ard.biesheuvel@linaro.org>
Message-ID: <20181105194321.26657-3-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates the PE/COFF header to emit the absolute path to the
decompressor vmlinux ELF file into a so-called NB10 Codeview entry.

On DEBUG builds of EDK2 for ARM, this will result in output to be
printed as follows

  add-symbol-file /home/ard/linux-build-arm/arch/arm/boot/compressed/vmlinux 0x43889000

which can be consumed by GDB directly, and load the decompressor
ELF symbols at the correct offset in the UEFI address space. With
both the decompressor and the firmware's ELF symbols loaded, we can
do single step debugging of calls made from the EFI stub into the
firmware and back, which is *really* helpful when debugging the
handover from UEFI to the decompressor.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/boot/compressed/Makefile     |  4 ++
 arch/arm/boot/compressed/efi-header.S | 47 ++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 01bf2585a0fa..727584a7a602 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -202,3 +202,7 @@ AFLAGS_hyp-stub.o := -Wa,-march=armv7-a
 
 $(obj)/hyp-stub.S: $(srctree)/arch/$(SRCARCH)/kernel/hyp-stub.S
 	$(call cmd,shipped)
+
+ifeq ($(CONFIG_EFI)$(CONFIG_DEBUG_INFO),yy)
+AFLAGS_head.o += -DVMLINUX_PATH="\"$(realpath $(obj)/vmlinux)\""
+endif
diff --git a/arch/arm/boot/compressed/efi-header.S b/arch/arm/boot/compressed/efi-header.S
index c94a88ae834d..5c29b31e7080 100644
--- a/arch/arm/boot/compressed/efi-header.S
+++ b/arch/arm/boot/compressed/efi-header.S
@@ -98,6 +98,11 @@ extra_header_fields:
 		.quad	0				@ CertificationTable
 		.quad	0				@ BaseRelocationTable
 
+#ifdef CONFIG_DEBUG_INFO
+		.long	efi_debug_table - start		@ DebugTable
+		.long	efi_debug_table_size
+#endif
+
 section_table:
 		.ascii	".text\0\0\0"
 		.long	__pecoff_code_size		@ VirtualSize
@@ -127,6 +132,48 @@ section_table:
 
 		.set	section_count, (. - section_table) / 40
 
+#ifdef CONFIG_DEBUG_INFO
+		/*
+		 * The debug table is referenced via its Relative Virtual
+		 * Address (RVA), which is only defined for those parts of
+		 * the image that are covered by a section declaration. Since
+		 * this header is not covered by any section, the debug table
+		 * must be emitted elsewhere. So stick it in the .rodata
+		 * section instead.
+		 *
+		 * Note that the EFI debug entry itself may legally have a
+		 * zero RVA, which means we can simply put it right after the
+		 * section headers.
+		 */
+		.section	".rodata", #alloc
+
+		.align	2
+efi_debug_table:
+		// EFI_IMAGE_DEBUG_DIRECTORY_ENTRY
+		.long	0				@ Characteristics
+		.long	0				@ TimeDateStamp
+		.short	0				@ MajorVersion
+		.short	0				@ MinorVersion
+		.long	IMAGE_DEBUG_TYPE_CODEVIEW	@ Type
+		.long	efi_debug_entry_size		@ SizeOfData
+		.long	0				@ RVA
+		.long	efi_debug_entry - start		@ FileOffset
+
+		.set	efi_debug_table_size, . - efi_debug_table
+		.previous
+
+efi_debug_entry:
+		// EFI_IMAGE_DEBUG_CODEVIEW_NB10_ENTRY
+		.ascii	"NB10"				@ Signature
+		.long	0				@ Unknown
+		.long	0				@ Unknown2
+		.long	0				@ Unknown3
+
+		.asciz	VMLINUX_PATH
+
+		.set	efi_debug_entry_size, . - efi_debug_entry
+#endif
+
 		.align	12
 __efi_start:
 #endif
-- 
2.19.1
