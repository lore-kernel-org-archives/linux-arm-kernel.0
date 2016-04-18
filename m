From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 18 Apr 2016 17:09:46 +0200
Subject: [PATCH 6/8] arm64: don't map TEXT_OFFSET bytes below the kernel if we
 can avoid it
In-Reply-To: <1460992188-23295-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1460992188-23295-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1460992188-23295-7-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For historical reasons, the kernel Image must be loaded into physical
memory at a 512 KB offset above a 2 MB aligned base address. The region
between the base address and the start of the kernel Image has no
significance to the kernel itself, but it is currently mapped explicitly
into the early kernel VMA range for all translation granules.

In some cases (i.e., 4 KB granule), this is unavoidable, due to the 2 MB
granularity of the early kernel mappings. However, in other cases, e.g.,
when running with larger page sizes, or in the future, with more granular
KASLR, there is no reason to map it explicitly like we do currently.

So update the logic so that the region is mapped only if that happens as
a side effect of rounding the start address of the kernel to swapper block
size, and leave it unmapped otherwise.

Since the symbol kernel_img_size now simply resolves to the memory
footprint of the kernel Image, we can drop its definition from image.h
and opencode its calculation.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S  | 9 +++++----
 arch/arm64/kernel/image.h | 2 --
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index dae9cabaadf5..c5e5edca6897 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -393,12 +393,13 @@ __create_page_tables:
 	 * Map the kernel image (starting with PHYS_OFFSET).
 	 */
 	mov	x0, x26				// swapper_pg_dir
-	mov_q	x5, KIMAGE_VADDR
+	mov_q	x5, KIMAGE_VADDR + TEXT_OFFSET	// compile time __va(_text)
 	add	x5, x5, x23			// add KASLR displacement
 	create_pgd_entry x0, x5, x3, x6
-	ldr	w6, =kernel_img_size
-	add	x6, x6, x5
-	mov	x3, x24				// phys offset
+	adrp	x6, _end			// runtime __pa(_end)
+	adrp	x3, _text			// runtime __pa(_text)
+	sub	x6, x6, x3			// _end - _text
+	add	x6, x6, x5			// runtime __va(_end)
 	create_block_map x0, x7, x3, x5, x6
 
 	/*
diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
index 4fd72da646a3..86d444f9c2c1 100644
--- a/arch/arm64/kernel/image.h
+++ b/arch/arm64/kernel/image.h
@@ -71,8 +71,6 @@
 	DEFINE_IMAGE_LE64(_kernel_offset_le, TEXT_OFFSET);	\
 	DEFINE_IMAGE_LE64(_kernel_flags_le, __HEAD_FLAGS);
 
-kernel_img_size = _end - (_text - TEXT_OFFSET);
-
 #ifdef CONFIG_EFI
 
 __efistub_stext_offset = stext - _text;
-- 
2.5.0
