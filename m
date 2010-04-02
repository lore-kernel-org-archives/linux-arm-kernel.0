From: mbohan@codeaurora.org (Michael Bohan)
Date: Thu,  1 Apr 2010 17:20:49 -0700
Subject: [PATCH 3/3] arm: mm: Add alignment check for memory banks in FLATMEM
In-Reply-To: <1270167649-17824-2-git-send-email-mbohan@codeaurora.org>
References: <> <1270167649-17824-1-git-send-email-mbohan@codeaurora.org>
	<1270167649-17824-2-git-send-email-mbohan@codeaurora.org>
Message-ID: <1270167649-17824-3-git-send-email-mbohan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Bohan <mbohan@quicinc.com>

In FLATMEM configurations, the VM code assumes that memory bank
end addresses in a hole are MAX_ORDER_NR_PAGES aligned if
CONFIG_HOLES_IN_ZONE is not enabled. The crash scenarios are hard
to debug, so let's not proceed if we aren't configured right.

Change-Id: I1494d7bf124e4ec85996af9ae81b394a3322ec6b
Signed-off-by: Michael Bohan <mbohan@quicinc.com>
Signed-off-by: Michael Bohan <mbohan@codeaurora.org>
---
 arch/arm/mm/init.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index ab4890f..3fee7d4 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -254,6 +254,24 @@ static void __init bootmem_init_node(int node, struct meminfo *mi,
 	for_each_nodebank(i, mi, node) {
 		struct membank *bank = &mi->bank[i];
 
+#if defined(CONFIG_FLATMEM) && !defined(CONFIG_HOLES_IN_ZONE)
+		/*
+		 * The VM code assumes that hole end addresses are aligned if
+		 * CONFIG_HOLES_IN_ZONE is not enabled. This results in
+		 * panics since we free unused memmap entries on ARM.
+		 * This check shouldn't be necessary for the last bank's end
+		 * address, since the VM code accounts for the total zone size.
+		 */
+		if ((i < (mi->nr_banks - 1)) &&
+		    (bank_pfn_end(bank) & (MAX_ORDER_NR_PAGES - 1))) {
+			pr_err("Memory bank[%d] not aligned to 0x%x bytes.\n"
+			       "\tMake bank end address align with MAX_ORDER\n"
+			       "\tor enable option CONFIG_HOLES_IN_ZONE.\n",
+			       i, __pfn_to_phys(MAX_ORDER_NR_PAGES));
+			BUG();
+		}
+#endif
+
 		if (!bank->highmem)
 			map_memory_bank(bank);
 	}
-- 
1.6.2.3
