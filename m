From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  5 Feb 2014 19:55:45 +0000
Subject: [PATCH v3 05/11] ARM: LPAE: provide an IPA capable pmd_addr_end
In-Reply-To: <1391630151-7875-1-git-send-email-marc.zyngier@arm.com>
References: <1391630151-7875-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1391630151-7875-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default pmd_addr_end macro uses an unsigned long to represent
the VA. When used with KVM and stage-2 translation, the VA is
actually an IPA, which is up to 40 bits. This also affect the
SMMU driver, which also deals with stage-2 translation.

Instead, provide an implementation that can cope with larger VAs
by using a u64 instead. This version will overload the default
one provided in include/asm-generic/pgtable.h.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/pgtable-3level.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 03243f7..594867b 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -262,6 +262,11 @@ static inline int has_transparent_hugepage(void)
 	return 1;
 }
 
+#define pmd_addr_end(addr, end)						\
+({	u64 __boundary = ((addr) + PMD_SIZE) & PMD_MASK;		\
+	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
+})
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_PGTABLE_3LEVEL_H */
-- 
1.8.3.4
