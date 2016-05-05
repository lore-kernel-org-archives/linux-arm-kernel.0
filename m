From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu,  5 May 2016 10:44:00 +0100
Subject: [PATCH 2/4] arm64: Implement pmdp_set_access_flags() for hardware
 AF/DBM
In-Reply-To: <1462441442-6996-1-git-send-email-catalin.marinas@arm.com>
References: <1462441442-6996-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1462441442-6996-3-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The update to the accessed or dirty states for block mappings must be
done atomically on hardware with support for automatic AF/DBM. The
ptep_set_access_flags() function has been fixed as part of commit
66dbd6e61a52 ("arm64: Implement ptep_set_access_flags() for hardware
AF/DBM"). This patch brings pmdp_set_access_flags() in line with the pte
counterpart.

Fixes: 2f4b829c625e ("arm64: Add support for hardware updates of the access and dirty pte bits")
Cc: <stable@vger.kernel.org> # 4.4.x: 66dbd6e61a52: arm64: Implement ptep_set_access_flags() for hardware AF/DBM
Cc: <stable@vger.kernel.org> # 4.3+
Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 5237331e97f4..bdfbaf96b426 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -553,6 +553,16 @@ extern int ptep_set_access_flags(struct vm_area_struct *vma,
 				 unsigned long address, pte_t *ptep,
 				 pte_t entry, int dirty);
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
+static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
+					unsigned long address, pmd_t *pmdp,
+					pmd_t entry, int dirty)
+{
+	return ptep_set_access_flags(vma, address, (pte_t *)pmdp, pmd_pte(entry), dirty);
+}
+#endif
+
 /*
  * Atomic pte/pmd modifications.
  */
