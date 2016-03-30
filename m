From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 30 Mar 2016 14:25:48 +0200
Subject: [PATCH v2 3/3] Revert "arm64: account for sparsemem section alignment
 when choosing vmemmap offset"
In-Reply-To: <1459340748-14975-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1459340748-14975-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1459340748-14975-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 36e5cd6b897e17d03008f81e075625d8e43e52d0, since the
section alignment is now guaranteed by construction when choosing the
value of memstart_addr.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/pgtable.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 989fef16d461..aa6106ac050c 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -32,14 +32,13 @@
  * VMALLOC_END: extends to the available space below vmmemmap, PCI I/O space,
  *	fixed mappings and modules
  */
-#define VMEMMAP_SIZE		ALIGN((1UL << (VA_BITS - PAGE_SHIFT)) * sizeof(struct page), PUD_SIZE)
+#define VMEMMAP_SIZE		ALIGN((1UL << (VA_BITS - PAGE_SHIFT - 1)) * sizeof(struct page), PUD_SIZE)
 
 #define VMALLOC_START		(MODULES_END)
 #define VMALLOC_END		(PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - SZ_64K)
 
 #define VMEMMAP_START		(VMALLOC_END + SZ_64K)
-#define vmemmap			((struct page *)VMEMMAP_START - \
-				 SECTION_ALIGN_DOWN(memstart_addr >> PAGE_SHIFT))
+#define vmemmap			((struct page *)VMEMMAP_START - (memstart_addr >> PAGE_SHIFT))
 
 #define FIRST_USER_ADDRESS	0UL
 
-- 
2.5.0
