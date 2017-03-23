From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 23 Mar 2017 19:00:51 +0000
Subject: [PATCH v3 8/8] arm64: efi: split Image code and data into separate
 PE/COFF sections
In-Reply-To: <20170323190051.14882-1-ard.biesheuvel@linaro.org>
References: <20170323190051.14882-1-ard.biesheuvel@linaro.org>
Message-ID: <20170323190051.14882-9-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To prevent unintended modifications to the kernel text (malicious or
otherwise) while running the EFI stub, describe the kernel image as
two separate sections: a .text section with read-execute permissions,
covering .text, .rodata and .init.text, and a .data section with
read-write permissions, covering .init.data, .data and .bss.

This relies on the firmware to actually take the section permission
flags into account, but this is something that is currently being
implemented in EDK2, which means we will likely start seeing it in
the wild between one and two years from now.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/efi-header.S  | 23 +++++++++++++++-----
 arch/arm64/kernel/vmlinux.lds.S |  2 ++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/efi-header.S b/arch/arm64/kernel/efi-header.S
index 7637226ea9ca..613fc3000677 100644
--- a/arch/arm64/kernel/efi-header.S
+++ b/arch/arm64/kernel/efi-header.S
@@ -27,8 +27,8 @@ optional_header:
 	.short	PE_OPT_MAGIC_PE32PLUS			// PE32+ format
 	.byte	0x02					// MajorLinkerVersion
 	.byte	0x14					// MinorLinkerVersion
-	.long	_end - efi_header_end			// SizeOfCode
-	.long	0					// SizeOfInitializedData
+	.long	__initdata_begin - efi_header_end	// SizeOfCode
+	.long	__pecoff_data_size			// SizeOfInitializedData
 	.long	0					// SizeOfUninitializedData
 	.long	__efistub_entry - _head			// AddressOfEntryPoint
 	.long	efi_header_end - _head			// BaseOfCode
@@ -74,9 +74,9 @@ extra_header_fields:
 	// Section table
 section_table:
 	.ascii	".text\0\0\0"
-	.long	_end - efi_header_end			// VirtualSize
+	.long	__initdata_begin - efi_header_end	// VirtualSize
 	.long	efi_header_end - _head			// VirtualAddress
-	.long	_edata - efi_header_end			// SizeOfRawData
+	.long	__initdata_begin - efi_header_end	// SizeOfRawData
 	.long	efi_header_end - _head			// PointerToRawData
 
 	.long	0					// PointerToRelocations
@@ -84,7 +84,20 @@ section_table:
 	.short	0					// NumberOfRelocations
 	.short	0					// NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_CODE | \
-		IMAGE_SCN_MEM_EXECUTE | \
+		IMAGE_SCN_MEM_READ | \
+		IMAGE_SCN_MEM_EXECUTE			// Characteristics
+
+	.ascii	".data\0\0\0"
+	.long	__pecoff_data_size			// VirtualSize
+	.long	__initdata_begin - _head		// VirtualAddress
+	.long	__pecoff_data_rawsize			// SizeOfRawData
+	.long	__initdata_begin - _head		// PointerToRawData
+
+	.long	0					// PointerToRelocations
+	.long	0					// PointerToLineNumbers
+	.short	0					// NumberOfRelocations
+	.short	0					// NumberOfLineNumbers
+	.long	IMAGE_SCN_CNT_INITIALIZED_DATA | \
 		IMAGE_SCN_MEM_READ | \
 		IMAGE_SCN_MEM_WRITE			// Characteristics
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 2c93d259046c..987a00ee446c 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -213,6 +213,7 @@ SECTIONS
 	}
 
 	PECOFF_EDATA_PADDING
+	__pecoff_data_rawsize = ABSOLUTE(. - __initdata_begin);
 	_edata = .;
 
 	BSS_SECTION(0, 0, 0)
@@ -228,6 +229,7 @@ SECTIONS
 	. += RESERVED_TTBR0_SIZE;
 #endif
 
+	__pecoff_data_size = ABSOLUTE(. - __initdata_begin);
 	_end = .;
 
 	STABS_DEBUG
-- 
2.9.3
