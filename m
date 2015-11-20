From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Nov 2015 15:35:24 +0000
Subject: [PATCH 2/2] arm64: mm: allow sections for unaligned bases
In-Reply-To: <1448033724-13846-1-git-send-email-mark.rutland@arm.com>
References: <1448033724-13846-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1448033724-13846-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Callees of __create_mapping may decide to create section mappings if
sufficient low bits of the physical and virtual addresses they were
passed are zero. While __create_mapping rounds the virtual base address
down, it does not similarly round the phyiscal base address down, and
hence non-zero bits in the physical address can prevent use of a section
mapping, even where a whole next-level table would be used instead.

Round down the physical base address in __create_mapping to enable all
callees to always create section mappings when such a mapping is
possible.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Laura Abbott <labbott@fedoraproject.org>
Cc: Steve Capper <steve.capper@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/mmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 3b06afa..6467d57 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -307,6 +307,7 @@ static void  __create_mapping(struct mm_struct *mm, pgd_t *pgd,
 	if (WARN_ON((phys ^ virt) & ~PAGE_MASK))
 		return;
 
+	phys &= PAGE_MASK;
 	addr = virt & PAGE_MASK;
 	length = PAGE_ALIGN(size + (virt & ~PAGE_MASK));
 
-- 
1.9.1
