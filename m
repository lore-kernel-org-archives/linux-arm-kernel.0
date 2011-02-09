From: dima@android.com (Dima Zavin)
Date: Wed,  9 Feb 2011 14:36:13 -0800
Subject: [PATCH] ARM: mm: don't free memmap entries in the middle of a
	MAX_ORDER_NR_PAGES block
Message-ID: <1297290973-32267-1-git-send-email-dima@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some machines, nodes do not always start on MAX_ORDER_NR_PAGES
boundaries. The rest of the VM assumes that pages within a
MAX_ORDER_NR_PAGES range always have valid memmap entries. So,
we round down the bank_start in free_unused_memmap to ensure that
there are valid page structs for all pages within a MAX_ORDER_NR_PAGES
block of pages.

Signed-off-by: Dima Zavin <dima@android.com>
---
 arch/arm/mm/init.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index cddd684..1290fbe 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -424,7 +424,8 @@ static void __init free_unused_memmap(struct meminfo *mi)
 	for_each_bank(i, mi) {
 		struct membank *bank = &mi->bank[i];
 
-		bank_start = bank_pfn_start(bank);
+		bank_start = round_down(bank_pfn_start(bank),
+					MAX_ORDER_NR_PAGES);
 
 		/*
 		 * If we had a previous bank, and there is a space
-- 
1.7.3.1
