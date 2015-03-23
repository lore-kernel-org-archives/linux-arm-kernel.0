From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 23 Mar 2015 16:36:56 +0100
Subject: [PATCH 4/4] arm64: align PHYS_OFFSET to block size
In-Reply-To: <1427125016-3873-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1427125016-3873-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1427125016-3873-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This aligns PHYS_OFFSET down to an alignment that allows system
RAM to be mapped using the largest blocks available, i.e., 1 GB
blocks on 4 KB pages or 512 MB blocks on 64 KB pages.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 16134608eecf..fd8434753372 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -49,13 +49,15 @@
 #ifdef CONFIG_ARM64_64K_PAGES
 #define BLOCK_SHIFT	PAGE_SHIFT
 #define BLOCK_SIZE	PAGE_SIZE
-#define TABLE_SHIFT	PMD_SHIFT
 #else
 #define BLOCK_SHIFT	SECTION_SHIFT
 #define BLOCK_SIZE	SECTION_SIZE
-#define TABLE_SHIFT	PUD_SHIFT
 #endif
 
+#define TABLE_SHIFT	(BLOCK_SHIFT + PAGE_SHIFT - 3)
+#define TABLE_SIZE	(1 << TABLE_SHIFT)
+#define TABLE_MASK	(~(TABLE_SIZE - 1))
+
 #define KERNEL_START	_text
 #define KERNEL_END	_end
 
@@ -237,7 +239,10 @@ ENTRY(stext)
 	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
 
 	adrp	x24, __PHYS_OFFSET
-	mov	x23, #KIMAGE_OFFSET
+	and	x23, x24, #~TABLE_MASK		// image offset
+	and	x24, x24, #TABLE_MASK		// PHYS_OFFSET
+	mov	x0, #KIMAGE_OFFSET
+	add	x23, x23, x0
 
 	bl	set_cpu_boot_mode_flag
 	bl	__create_page_tables		// x25=TTBR0, x26=TTBR1
-- 
1.8.3.2
