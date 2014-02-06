From: steve.capper@linaro.org (Steve Capper)
Date: Thu,  6 Feb 2014 14:16:11 +0000
Subject: [PATCH 3/3] arm64: mm: Correct definition of pmd_mknotpresent
In-Reply-To: <1391696171-8922-1-git-send-email-steve.capper@linaro.org>
References: <1391696171-8922-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1391696171-8922-4-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pmd_mknotpresent currently creates a faulting pmd by clearing the valid
bit. Unfortunately pmd_present(.) will report such pmds as being
present!

This patch re-defines pmd_mknotpresent such that __pmd(0) is returned
instead.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm64/include/asm/pgtable.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index a5d5832..5d266e4 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -291,8 +291,7 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 
 static inline pmd_t pmd_mknotpresent(pmd_t pmd)
 {
-	pmd_val(pmd) &= ~PMD_TYPE_MASK;
-	return pmd;
+	return __pmd(0);
 }
 
 #define pmd_mkhuge(pmd)		(__pmd(pmd_val(pmd) & ~PMD_TABLE_BIT))
-- 
1.8.1.4
