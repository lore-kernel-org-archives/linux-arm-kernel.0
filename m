From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 12 Oct 2016 12:23:45 +0100
Subject: [PATCH v3 5/5] arm64: mm: round memstart_addr to contiguous PUD/PMD
 size
In-Reply-To: <1476271425-19401-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1476271425-19401-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1476271425-19401-6-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Given that contiguous PUDs/PMDs allow the linear region to be mapped more
efficiently, ensure that the relative alignment between the linear virtual
and physical mappings of system RAM are equal modulo the contiguous PUD
size (or contiguous PMD size, for 16k/64k granule size).

Note that this reduces the KASLR randomization of the linear range by
PUD_SHIFT (or PMD_SHIFT) bits.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/kernel-pgtable.h | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 7e51d1b57c0c..71dbd9e1e809 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -83,16 +83,13 @@
 /*
  * To make optimal use of block mappings when laying out the linear
  * mapping, round down the base of physical memory to a size that can
- * be mapped efficiently, i.e., either PUD_SIZE (4k granule) or PMD_SIZE
- * (64k granule), or a multiple that can be mapped using contiguous bits
- * in the page tables: 32 * PMD_SIZE (16k granule)
+ * be mapped efficiently, i.e., either CONT_PUD_SIZE (4k granule) or
+ * CONT_PMD_SIZE (16k/64k granules)
  */
 #if defined(CONFIG_ARM64_4K_PAGES)
-#define ARM64_MEMSTART_SHIFT		PUD_SHIFT
-#elif defined(CONFIG_ARM64_16K_PAGES)
-#define ARM64_MEMSTART_SHIFT		(PMD_SHIFT + 5)
+#define ARM64_MEMSTART_SHIFT		(PUD_SHIFT + CONT_PUD_SHIFT)
 #else
-#define ARM64_MEMSTART_SHIFT		PMD_SHIFT
+#define ARM64_MEMSTART_SHIFT		(PMD_SHIFT + CONT_PMD_SHIFT)
 #endif
 
 /*
-- 
2.7.4
