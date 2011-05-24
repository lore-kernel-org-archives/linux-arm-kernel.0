From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 24 May 2011 22:39:22 +0100
Subject: [PATCH v6 16/18] ARM: LPAE: mark memory banks with start > ULONG_MAX
	as highmem
In-Reply-To: <1306273164-18217-1-git-send-email-catalin.marinas@arm.com>
References: <1306273164-18217-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1306273164-18217-17-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

Memory banks living outside of the 32-bit physical address
space do not have a 1:1 pa <-> va mapping and therefore the
__va macro may wrap.

This patch ensures that such banks are marked as highmem so
that the Kernel doesn't try to split them up when it sees that
the wrapped virtual address overlaps the vmalloc space.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/mmu.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 139beb7..749475e 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -792,7 +792,8 @@ static void __init sanity_check_meminfo(void)
 		*bank = meminfo.bank[i];
 
 #ifdef CONFIG_HIGHMEM
-		if (__va(bank->start) >= vmalloc_min ||
+		if (bank->start > ULONG_MAX ||
+		    __va(bank->start) >= vmalloc_min ||
 		    __va(bank->start) < (void *)PAGE_OFFSET)
 			highmem = 1;
 
@@ -802,7 +803,7 @@ static void __init sanity_check_meminfo(void)
 		 * Split those memory banks which are partially overlapping
 		 * the vmalloc area greatly simplifying things later.
 		 */
-		if (__va(bank->start) < vmalloc_min &&
+		if (!highmem && __va(bank->start) < vmalloc_min &&
 		    bank->size > vmalloc_min - __va(bank->start)) {
 			if (meminfo.nr_banks >= NR_BANKS) {
 				printk(KERN_CRIT "NR_BANKS too low, "
