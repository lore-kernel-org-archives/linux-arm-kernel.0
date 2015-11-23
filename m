From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 23 Nov 2015 13:26:20 +0000
Subject: [PATCHv2 2/2] arm64: mm: allow sections for unaligned bases
In-Reply-To: <1448285180-15389-1-git-send-email-mark.rutland@arm.com>
References: <1448285180-15389-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1448285180-15389-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Callees of __create_mapping may decide to create section mappings if
sufficient low bits of the physical and virtual addresses they were
passed are zero. While __create_mapping rounds the virtual base address
down, it does not similarly round the physical base address down, and
hence non-zero bits in the physical address can prevent use of a section
mapping, even where a whole next-level table would be used instead.

Round down the physical base address in __create_mapping to enable all
callees to always create section mappings when such a mapping is
possible.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Steve Capper <steve.capper@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Laura Abbott <labbott@fedoraproject.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/mmu.c | 1 +
 1 file changed, 1 insertion(+)

Since v1 [1]:
* No changes to patch.
* Add acks.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/386931.html

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 2250d89..c22a717 100644
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
