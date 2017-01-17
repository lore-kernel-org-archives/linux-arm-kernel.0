From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 17 Jan 2017 16:10:57 +0000
Subject: [PATCH 2/3] arm64: efi-entry.S: avoid open-coded adr_l
In-Reply-To: <1484669458-31713-1-git-send-email-mark.rutland@arm.com>
References: <1484669458-31713-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1484669458-31713-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some places in the kernel open-code sequences using ADRP for a symbol
another instruction using a :lo12: relocation for that same symbol.
These sequences are easy to get wrong, and more painful to read than is
necessary. For these reasons, it is preferable to use the
{adr,ldr,str}_l macros for these cases.

This patch makes use of these in efi-entry.S, removing open-coded
sequences using adrp.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/efi-entry.S | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/efi-entry.S b/arch/arm64/kernel/efi-entry.S
index e88c064..4e6ad35 100644
--- a/arch/arm64/kernel/efi-entry.S
+++ b/arch/arm64/kernel/efi-entry.S
@@ -46,8 +46,7 @@ ENTRY(entry)
 	 *                         efi_system_table_t *sys_table,
 	 *                         unsigned long *image_addr) ;
 	 */
-	adrp	x8, _text
-	add	x8, x8, #:lo12:_text
+	adr_l	x8, _text
 	add	x2, sp, 16
 	str	x8, [x2]
 	bl	efi_entry
@@ -68,10 +67,8 @@ ENTRY(entry)
 	/*
 	 * Calculate size of the kernel Image (same for original and copy).
 	 */
-	adrp	x1, _text
-	add	x1, x1, #:lo12:_text
-	adrp	x2, _edata
-	add	x2, x2, #:lo12:_edata
+	adr_l	x1, _text
+	adr_l	x2, _edata
 	sub	x1, x2, x1
 
 	/*
-- 
1.9.1
