From: mbohan@codeaurora.org (Michael Bohan)
Date: Mon,  7 Jun 2010 15:40:05 -0700
Subject: [PATCH][RESEND] arm: mm: Don't free prohibited memmap entries
Message-ID: <1275950405-1437-1-git-send-email-mbohan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VM subsystem assumes that there are valid memmap entries to
the bank end aligned to MAX_ORDER_NR_PAGES. It will try and read
these page structs, and so we cannot free any memmap entries that
it may inspect.

Signed-off-by: Michael Bohan <mbohan@codeaurora.org>
---
 arch/arm/mm/init.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 1ba6cf5..233bcfd 100644
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
