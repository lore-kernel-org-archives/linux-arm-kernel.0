From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  3 Mar 2016 19:44:14 +0100
Subject: [PATCH v2 1/3] arm64: don't map TEXT_OFFSET bytes below the kernel if
 we can avoid it
In-Reply-To: <1457030656-29584-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1457030656-29584-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1457030656-29584-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For historical reasons, there is a 512 KB hole called TEXT_OFFSET below
the kernel image in memory. Since this hole is part of the kernel footprint
in the early mapping when running with 4 KB pages, we cannot avoid mapping
it, but in other cases, e.g., when running with larger page sizes, or in
the future, with more granular KASLR, there is no reason to map it explicitly
like we do currently.

So update the logic so that the hole is mapped only if it occurs as a result
of rounding the start address of the kernel to swapper block size, and leave
it unmapped otherwise.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S  | 4 ++--
 arch/arm64/kernel/image.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index af522c853b7f..ca8ba19df786 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -394,12 +394,12 @@ __create_page_tables:
 	 * Map the kernel image (starting with PHYS_OFFSET).
 	 */
 	mov	x0, x26				// swapper_pg_dir
-	ldr	x5, =KIMAGE_VADDR
+	ldr	x5, =KIMAGE_VADDR + TEXT_OFFSET	// compile time virt addr of _text
 	add	x5, x5, x23			// add KASLR displacement
 	create_pgd_entry x0, x5, x3, x6
 	ldr	w6, =kernel_img_size
 	add	x6, x6, x5
-	mov	x3, x24				// phys offset
+	adrp	x3, KERNEL_START		// runtime phys addr of _text
 	create_block_map x0, x7, x3, x5, x6
 
 	/*
diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
index 5ff892f40a0a..803dc57acd72 100644
--- a/arch/arm64/kernel/image.h
+++ b/arch/arm64/kernel/image.h
@@ -71,7 +71,7 @@
 	DEFINE_IMAGE_LE64(_kernel_offset_le, TEXT_OFFSET);	\
 	DEFINE_IMAGE_LE64(_kernel_flags_le, __HEAD_FLAGS);
 
-kernel_img_size = _end - (_text - TEXT_OFFSET);
+kernel_img_size = _end - _text;
 
 #ifdef CONFIG_EFI
 
-- 
2.5.0
