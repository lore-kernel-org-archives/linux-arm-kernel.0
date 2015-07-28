From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 28 Jul 2015 10:31:06 +0100
Subject: [PATCH] arm64: mm: mark create_mapping as __init
Message-ID: <1438075866-15483-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently create_mapping is marked with __ref, apparently because it
refers to early_alloc. However, create_mapping has no logic to prevent
erroneous use of early_alloc after it has been freed, and is only ever
called by __init functions anyway. Thus the __ref marker is misleading
and unnecessary.

Instead, this patch marks create_mapping as __init, resulting in
warnings if it is used from a a non __init functions, and allowing its
memory to be reclaimed.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 63012fe..9211b85 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -267,7 +267,7 @@ static void *late_alloc(unsigned long size)
 	return ptr;
 }
 
-static void __ref create_mapping(phys_addr_t phys, unsigned long virt,
+static void __init create_mapping(phys_addr_t phys, unsigned long virt,
 				  phys_addr_t size, pgprot_t prot)
 {
 	if (virt < VMALLOC_START) {
-- 
1.9.1
