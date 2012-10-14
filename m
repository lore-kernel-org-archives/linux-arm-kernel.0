From: rabin@rab.in (Rabin Vincent)
Date: Sun, 14 Oct 2012 21:23:06 +0200
Subject: [PATCH 2/9] uprobes: check for single step support
In-Reply-To: <1350242593-17761-1-git-send-email-rabin@rab.in>
References: <1350242593-17761-1-git-send-email-rabin@rab.in>
Message-ID: <1350242593-17761-2-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check for single step support before calling user_enable_single_step(),
since user_enable_single_step() just BUG()s if support does not exist.
Needed by ARM.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 kernel/events/uprobes.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 98256bc..db4e3ab 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1450,7 +1450,8 @@ static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *is_swbp)
 
 void __weak arch_uprobe_enable_step(struct arch_uprobe *arch)
 {
-	user_enable_single_step(current);
+	if (arch_has_single_step())
+		user_enable_single_step(current);
 }
 
 void __weak arch_uprobe_disable_step(struct arch_uprobe *arch)
-- 
1.7.9.5
