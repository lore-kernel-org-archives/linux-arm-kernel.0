From: labbott@redhat.com (Laura Abbott)
Date: Tue,  1 May 2018 13:11:43 -0700
Subject: [PATCH] proc/kcore: Don't bounds check against address 0
In-Reply-To: <1039518799.26129578.1525185916272.JavaMail.zimbra@redhat.com>
Message-ID: <20180501201143.15121-1-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The existing kcore code checks for bad addresses against
__va(0) with the assumption that this is the lowest address
on the system. This may not hold true on some systems (e.g.
arm64) and produce overflows and crashes. Switch to using
other functions to validate the address range.

Tested-by: Dave Anderson <anderson@redhat.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
I took your previous comments as a tested by, please let me know if that
was wrong. This should probably just go through -mm. I don't think this
is necessary for stable but I can request it later if necessary.
---
 fs/proc/kcore.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index d1e82761de81..e64ecb9f2720 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -209,25 +209,34 @@ kclist_add_private(unsigned long pfn, unsigned long nr_pages, void *arg)
 {
 	struct list_head *head = (struct list_head *)arg;
 	struct kcore_list *ent;
+	struct page *p;
+
+	if (!pfn_valid(pfn))
+		return 1;
+
+	p = pfn_to_page(pfn);
+	if (!memmap_valid_within(pfn, p, page_zone(p)))
+		return 1;
 
 	ent = kmalloc(sizeof(*ent), GFP_KERNEL);
 	if (!ent)
 		return -ENOMEM;
-	ent->addr = (unsigned long)__va((pfn << PAGE_SHIFT));
+	ent->addr = (unsigned long)page_to_virt(p);
 	ent->size = nr_pages << PAGE_SHIFT;
 
-	/* Sanity check: Can happen in 32bit arch...maybe */
-	if (ent->addr < (unsigned long) __va(0))
+	if (!virt_addr_valid(ent->addr))
 		goto free_out;
 
 	/* cut not-mapped area. ....from ppc-32 code. */
 	if (ULONG_MAX - ent->addr < ent->size)
 		ent->size = ULONG_MAX - ent->addr;
 
-	/* cut when vmalloc() area is higher than direct-map area */
-	if (VMALLOC_START > (unsigned long)__va(0)) {
-		if (ent->addr > VMALLOC_START)
-			goto free_out;
+	/*
+	 * We've already checked virt_addr_valid so we know this address
+	 * is a valid pointer, therefore we can check against it to determine
+	 * if we need to trim
+	 */
+	if (VMALLOC_START > ent->addr) {
 		if (VMALLOC_START - ent->addr < ent->size)
 			ent->size = VMALLOC_START - ent->addr;
 	}
-- 
2.14.3
