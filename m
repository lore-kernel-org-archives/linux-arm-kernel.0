From: minchan@kernel.org (Minchan Kim)
Date: Mon, 20 Oct 2014 19:12:02 +0900
Subject: [PATCH v17 5/7] arm: add pmd_mkclean for THP
In-Reply-To: <1413799924-17946-1-git-send-email-minchan@kernel.org>
References: <1413799924-17946-1-git-send-email-minchan@kernel.org>
Message-ID: <1413799924-17946-6-git-send-email-minchan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MADV_FREE needs pmd_dirty and pmd_mkclean for detecting recent
overwrite of the contents since MADV_FREE syscall is called for
THP page.

This patch adds pmd_mkclean for THP page MADV_FREE support.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Steve Capper <steve.capper@linaro.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 arch/arm/include/asm/pgtable-3level.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index a31ecdad4b59..54dc91486c16 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -249,6 +249,7 @@ PMD_BIT_FUNC(mkold,	&= ~PMD_SECT_AF);
 PMD_BIT_FUNC(mksplitting, |= L_PMD_SECT_SPLITTING);
 PMD_BIT_FUNC(mkwrite,   &= ~L_PMD_SECT_RDONLY);
 PMD_BIT_FUNC(mkdirty,   |= L_PMD_SECT_DIRTY);
+PMD_BIT_FUNC(mkclean,   &= ~L_PMD_SECT_DIRTY);
 PMD_BIT_FUNC(mkyoung,   |= PMD_SECT_AF);
 
 #define pmd_mkhuge(pmd)		(__pmd(pmd_val(pmd) & ~PMD_TABLE_BIT))
-- 
2.0.0
