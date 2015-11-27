From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Nov 2015 14:58:37 +0100
Subject: [PATCH] mm, page_owner: only track migration if enabled
Message-ID: <3209032.Njpu4mxStH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added code to print page ownership in dump_page fails
to link when CONFIG_MIGRATION is disabled:

mm/built-in.o: In function `print_page_owner':
frame_vector.c:(.text+0x72358): undefined reference to `migrate_reason_names'

This changes the two users of migrate_reason_names to first check
CONFIG_MIGRATION, which avoids the error.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: cf7ec391dae4 ("mm, page_owner: dump page owner info from dump_page()")
---
Found on yesterday's linux-next with ARM randconfig builds. The patch
that introduced this is currently in Andrews tree.

If you don't already have a fix, please apply this one on top, or fold
it into the original commit.

diff --git a/mm/page_owner.c b/mm/page_owner.c
index a81cfa0c13c3..4033542c3f5a 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -170,7 +170,8 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 	if (ret >= count)
 		goto err;
 
-	if (page_ext->last_migrate_reason != -1) {
+	if (IS_ENABLED(CONFIG_MIGRATION) &&
+	    page_ext->last_migrate_reason != -1) {
 		ret += snprintf(kbuf + ret, count - ret,
 			"Page has been migrated, last migrate reason: %s\n",
 			migrate_reason_names[page_ext->last_migrate_reason]);
@@ -213,7 +214,8 @@ void __dump_page_owner(struct page *page)
 	dump_gfpflag_names(gfp_mask);
 	print_stack_trace(&trace, 0);
 
-	if (page_ext->last_migrate_reason != -1)
+	if (IS_ENABLED(CONFIG_MIGRATION) &&
+	    page_ext->last_migrate_reason != -1)
 		pr_alert("page has been migrated, last migrate reason: %s\n",
 			migrate_reason_names[page_ext->last_migrate_reason]);
 }
