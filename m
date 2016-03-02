From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  2 Mar 2016 18:11:50 +0100
Subject: [PATCH 1/3] arm64: don't map TEXT_OFFSET bytes below the kernel if we
 can avoid it
In-Reply-To: <1456938712-11089-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456938712-11089-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1456938712-11089-2-git-send-email-ard.biesheuvel@linaro.org>
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
 arch/arm64/kernel/head.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 50c2134a4aaf..1d4ae36db0bb 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -393,12 +393,12 @@ __create_page_tables:
 	 * Map the kernel image (starting with PHYS_OFFSET).
 	 */
 	mov	x0, x26				// swapper_pg_dir
-	ldr	x5, =KIMAGE_VADDR
+	ldr	x5, =KIMAGE_VADDR + TEXT_OFFSET	// compile time virt addr of _text
 	add	x5, x5, x23			// add KASLR displacement
 	create_pgd_entry x0, x5, x3, x6
 	ldr	w6, kernel_img_size
 	add	x6, x6, x5
-	mov	x3, x24				// phys offset
+	adrp	x3, KERNEL_START		// runtime phys addr of _text
 	create_block_map x0, x7, x3, x5, x6
 
 	/*
@@ -415,7 +415,7 @@ __create_page_tables:
 ENDPROC(__create_page_tables)
 
 kernel_img_size:
-	.long	_end - (_head - TEXT_OFFSET)
+	.long	_end - _head
 	.ltorg
 
 /*
-- 
2.5.0
