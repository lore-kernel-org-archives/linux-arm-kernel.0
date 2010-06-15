From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 15 Jun 2010 11:27:25 -0700
Subject: [PATCH 2/2] arm: mm: Don't free prohibited memmap entries
In-Reply-To: <1276626445-20316-1-git-send-email-dwalker@codeaurora.org>
References: <1276626445-20316-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1276626445-20316-3-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Bohan <mbohan@codeaurora.org>

The VM subsystem assumes that there are valid memmap entries to
the bank end aligned to MAX_ORDER_NR_PAGES. It will try and read
these page structs, and so we cannot free any memmap entries that
it may inspect.

Signed-off-by: Michael Bohan <mbohan@codeaurora.org>
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/mm/init.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index f6a9994..e18c7ce 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -495,28 +495,27 @@ static void __init free_unused_memmap_node(int node, struct meminfo *mi)
 	unsigned int i;
 
 	/*
-	 * [FIXME] This relies on each bank being in address order.  This
-	 * may not be the case, especially if the user has provided the
-	 * information on the command line.
+	 * This relies on each bank being in address order.
+	 * The banks are sorted previously in bootmem_init().
 	 */
 	for_each_nodebank(i, mi, node) {
 		struct membank *bank = &mi->bank[i];
 
 		bank_start = bank_pfn_start(bank);
-		if (bank_start < prev_bank_end) {
-			printk(KERN_ERR "MEM: unordered memory banks.  "
-				"Not freeing memmap.\n");
-			break;
-		}
 
 		/*
 		 * If we had a previous bank, and there is a space
 		 * between the current bank and the previous, free it.
 		 */
-		if (prev_bank_end && prev_bank_end != bank_start)
+		if (prev_bank_end && prev_bank_end < bank_start)
 			free_memmap(node, prev_bank_end, bank_start);
 
-		prev_bank_end = bank_pfn_end(bank);
+		/*
+		 * Align up here since the VM subsystem insists that the
+		 * memmap entries are valid from the bank end aligned to
+		 * MAX_ORDER_NR_PAGES.
+		 */
+		prev_bank_end = ALIGN(bank_pfn_end(bank), MAX_ORDER_NR_PAGES);
 	}
 }
 
-- 
1.7.1
