From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Nov 2010 17:40:26 +0000
Subject: [PATCH v3 17/20] ARM: LPAE: mark memory banks with start > ULONG_MAX
	as highmem
In-Reply-To: <1289842829-3027-1-git-send-email-catalin.marinas@arm.com>
References: <1289842829-3027-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1289842829-3027-18-git-send-email-catalin.marinas@arm.com>
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
index 5e035e0..794ca48 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -785,7 +785,8 @@ static void __init sanity_check_meminfo(void)
 
 #ifdef CONFIG_HIGHMEM
 		if (__va(bank->start) > vmalloc_min ||
-		    __va(bank->start) < (void *)PAGE_OFFSET)
+		    __va(bank->start) < (void *)PAGE_OFFSET ||
+		    bank->start > ULONG_MAX)
 			highmem = 1;
 
 		bank->highmem = highmem;
@@ -794,7 +795,7 @@ static void __init sanity_check_meminfo(void)
 		 * Split those memory banks which are partially overlapping
 		 * the vmalloc area greatly simplifying things later.
 		 */
-		if (__va(bank->start) < vmalloc_min &&
+		if (!highmem && __va(bank->start) < vmalloc_min &&
 		    bank->size > vmalloc_min - __va(bank->start)) {
 			if (meminfo.nr_banks >= NR_BANKS) {
 				printk(KERN_CRIT "NR_BANKS too low, "
