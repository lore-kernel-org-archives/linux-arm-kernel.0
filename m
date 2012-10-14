From: rabin@rab.in (Rabin Vincent)
Date: Sun, 14 Oct 2012 21:23:10 +0200
Subject: [PATCH 6/9] uprobes: flush cache after xol write
In-Reply-To: <1350242593-17761-1-git-send-email-rabin@rab.in>
References: <1350242593-17761-1-git-send-email-rabin@rab.in>
Message-ID: <1350242593-17761-6-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Flush the cache so that the instructions written to the XOL area are
visible.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 kernel/events/uprobes.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ca000a9..8c52f93 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1246,6 +1246,7 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe, unsigned long slot
 	offset = current->utask->xol_vaddr & ~PAGE_MASK;
 	vaddr = kmap_atomic(area->page);
 	arch_uprobe_xol_copy(&uprobe->arch, vaddr + offset);
+	flush_dcache_page(area->page);
 	kunmap_atomic(vaddr);
 
 	return current->utask->xol_vaddr;
-- 
1.7.9.5
