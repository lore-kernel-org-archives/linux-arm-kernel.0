From: james.morse@arm.com (James Morse)
Date: Fri,  2 Dec 2016 14:49:09 +0000
Subject: [PATCH 2/2] arm64: hibernate: report nomap regions as being pfn_nosave
In-Reply-To: <20161202144909.18405-1-james.morse@arm.com>
References: <20161202144909.18405-1-james.morse@arm.com>
Message-ID: <20161202144909.18405-3-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pfn_valid() needs to be changed so that all struct pages in a numa
node have the same node-id. Currently 'nomap' pages are skipped, and
retain their pre-numa node-ids, which leads to a later BUG_ON().

Once this change happens, hibernate's code code will try and
save/restore the nomap pages.

Add the memblock nomap regions to the ranges reported as being
'pfn_nosave' to the hibernate core code. This only works if all
pages in the nomap region are also marked with PG_reserved.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/hibernate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index d55a7b09959b..9e901658a123 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -17,6 +17,7 @@
 #define pr_fmt(x) "hibernate: " x
 #include <linux/cpu.h>
 #include <linux/kvm_host.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/pm.h>
 #include <linux/sched.h>
@@ -105,7 +106,10 @@ int pfn_is_nosave(unsigned long pfn)
 	unsigned long nosave_begin_pfn = virt_to_pfn(&__nosave_begin);
 	unsigned long nosave_end_pfn = virt_to_pfn(&__nosave_end - 1);
 
-	return (pfn >= nosave_begin_pfn) && (pfn <= nosave_end_pfn);
+	if ((pfn >= nosave_begin_pfn) && (pfn <= nosave_end_pfn))
+		return 1;
+
+	return !memblock_is_map_memory(pfn << PAGE_SHIFT);
 }
 
 void notrace save_processor_state(void)
-- 
2.10.1
