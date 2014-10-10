From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 10 Oct 2014 11:25:24 +0200
Subject: [PATCH] arm64/efi: set PE/COFF section alignment to 4 KB
Message-ID: <1412933124-13018-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Position independent AArch64 code needs to be linked and loaded at the same
relative offset from a 4 KB boundary, or adrp/add and adrp/ldr pairs will
not work correctly. (This is how PC relative symbol references with a 4 GB
reach are emitted)

We need to declare this in the PE/COFF header, otherwise the PE/COFF loader
may load the Image and invoke the stub at an offset which violates this rule.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 0a6e4f924df8..5e83e5b8a9de 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -159,7 +159,7 @@ optional_header:
 
 extra_header_fields:
 	.quad	0				// ImageBase
-	.long	0x20				// SectionAlignment
+	.long	0x1000				// SectionAlignment
 	.long	0x8				// FileAlignment
 	.short	0				// MajorOperatingSystemVersion
 	.short	0				// MinorOperatingSystemVersion
@@ -226,7 +226,7 @@ section_table:
 	.short	0		// NumberOfRelocations  (0 for executables)
 	.short	0		// NumberOfLineNumbers  (0 for executables)
 	.long	0xe0500020	// Characteristics (section flags)
-	.align 5
+	.align 12
 #endif
 
 ENTRY(stext)
-- 
1.8.3.2
