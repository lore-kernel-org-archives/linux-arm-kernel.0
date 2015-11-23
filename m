From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 23 Nov 2015 13:26:19 +0000
Subject: [PATCHv2 1/2] arm64: mm: detect bad __create_mapping uses
Message-ID: <1448285180-15389-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a caller of __create_mapping provides a PA and VA which have
different sub-page offsets, it is not clear which offset they expect to
apply to the mapping, and is indicative of a bad caller.

In some cases, the region we wish to map may validly have a sub-page
offset in the physical and virtual addresses. For example, EFI runtime
regions have 4K granularity, yet may be mapped by a 64K page kernel. So
long as the physical and virtual offsets are the same, the region will
be mapped at the expected VAs.

Disallow calls with differing sub-page offsets, and WARN when they are
encountered, so that we can detect and fix such cases.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Steve Capper <steve.capper@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Laura Abbott <labbott@fedoraproject.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/mmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

Since v1 [1]:
* Describe why we permit sub-page offsets.
* Fix Catalin's email address.
* Add acks.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/386930.html

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index abb66f8..2250d89 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -300,6 +300,13 @@ static void  __create_mapping(struct mm_struct *mm, pgd_t *pgd,
 {
 	unsigned long addr, length, end, next;
 
+	/*
+	 * If the virtual and physical address don't have the same offset
+	 * within a page, we cannot map the region as the caller expects.
+	 */
+	if (WARN_ON((phys ^ virt) & ~PAGE_MASK))
+		return;
+
 	addr = virt & PAGE_MASK;
 	length = PAGE_ALIGN(size + (virt & ~PAGE_MASK));
 
-- 
1.9.1
