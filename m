From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  9 Dec 2015 12:44:36 +0000
Subject: [RFC PATCH 01/20] arm64: mm: remove pointless PAGE_MASKing
In-Reply-To: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
References: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1449665095-20774-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As pgd_offset{,_k} shift the input address by PGDIR_SHIFT, the sub-page
bits will always be shifted out. There is no need to apply PAGE_MASK
before this.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Laura Abbott <labbott@fedoraproject.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 873e363..7dfb4a9 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -280,7 +280,7 @@ static void __init create_mapping(phys_addr_t phys, unsigned long virt,
 			&phys, virt);
 		return;
 	}
-	__create_mapping(&init_mm, pgd_offset_k(virt & PAGE_MASK), phys, virt,
+	__create_mapping(&init_mm, pgd_offset_k(virt), phys, virt,
 			 size, prot, early_alloc);
 }
 
@@ -301,7 +301,7 @@ static void create_mapping_late(phys_addr_t phys, unsigned long virt,
 		return;
 	}
 
-	return __create_mapping(&init_mm, pgd_offset_k(virt & PAGE_MASK),
+	return __create_mapping(&init_mm, pgd_offset_k(virt),
 				phys, virt, size, prot, late_alloc);
 }
 
-- 
1.9.1
