From: rafael.tinoco@linaro.org (Rafael David Tinoco)
Date: Wed, 24 Oct 2018 22:27:45 -0300
Subject: [PATCH 2/2] mm/zsmalloc.c: fix zsmalloc ARM LPAE support
In-Reply-To: <20181025012745.20884-1-rafael.tinoco@linaro.org>
References: <20181025012745.20884-1-rafael.tinoco@linaro.org>
Message-ID: <20181025012745.20884-2-rafael.tinoco@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 02390b87a945 ("mm/zsmalloc: Prepare to variable
MAX_PHYSMEM_BITS"), an architecture has to define this value in order to
guarantee that zsmalloc will be able to encode and decode the obj value
properly.

Similar to that change, this one sets the value for ARM LPAE, fixing a
possible null-ptr-deref in zs_map_object() when using ARM LPAE and
HIGHMEM pages located above the 4GB watermark.

Link: https://bugs.linaro.org/show_bug.cgi?id=3765#c17
Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 arch/arm/include/asm/pgtable-3level-types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/pgtable-3level-types.h b/arch/arm/include/asm/pgtable-3level-types.h
index 921aa30259c4..bd4994f98700 100644
--- a/arch/arm/include/asm/pgtable-3level-types.h
+++ b/arch/arm/include/asm/pgtable-3level-types.h
@@ -67,4 +67,6 @@ typedef pteval_t pgprot_t;
 
 #endif	/* STRICT_MM_TYPECHECKS */
 
+#define MAX_POSSIBLE_PHYSMEM_BITS	36
+
 #endif	/* _ASM_PGTABLE_3LEVEL_TYPES_H */
-- 
2.19.1
