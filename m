From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue,  6 Dec 2016 11:53:11 -0800
Subject: [PATCH 2/3] ARM: Utilize __pa_symbol in lieu of __pa
In-Reply-To: <20161206195312.22354-1-f.fainelli@gmail.com>
References: <1480445729-27130-1-git-send-email-labbott@redhat.com>
 <20161206195312.22354-1-f.fainelli@gmail.com>
Message-ID: <20161206195312.22354-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unfold pmd_populate_kernel() to make us use __pa_symbol() instead of
__pa(), pre-requisite to turning on CONFIG_DEBUG_VIRTUAL.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 18ef688a796e..ab7e82085df9 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -394,7 +394,7 @@ void __init early_fixmap_init(void)
 		     != FIXADDR_TOP >> PMD_SHIFT);
 
 	pmd = fixmap_pmd(FIXADDR_TOP);
-	pmd_populate_kernel(&init_mm, pmd, bm_pte);
+	__pmd_populate(pmd, __pa_symbol(bm_pte), _PAGE_KERNEL_TABLE);
 
 	pte_offset_fixmap = pte_offset_early_fixmap;
 }
-- 
2.9.3
