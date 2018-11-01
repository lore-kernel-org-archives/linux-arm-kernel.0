From: miles.chen@mediatek.com (miles.chen at mediatek.com)
Date: Fri, 2 Nov 2018 01:00:07 +0800
Subject: [PATCH v4] mm/page_owner: clamp read count to PAGE_SIZE
Message-ID: <1541091607-27402-1-git-send-email-miles.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Miles Chen <miles.chen@mediatek.com>

The page owner read might allocate a large size of memory with
a large read count. Allocation fails can easily occur when doing
high order allocations.

Clamp buffer size to PAGE_SIZE to avoid arbitrary size allocation
and avoid allocation fails due to high order allocation.

Change since v3:
  - remove the change in kvmalloc
  - keep kmalloc in page_owner.c

Change since v2:
  - improve kvmalloc, allow sub page allocations fallback to
    vmalloc when CONFIG_HIGHMEM=y

Change since v1:
  - use kvmalloc()
  - clamp buffer size to PAGE_SIZE

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
Cc: Joe Perches <joe@perches.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>
---
 mm/page_owner.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 87bc0dfdb52b..b83f295e4eca 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -351,6 +351,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 		.skip = 0
 	};
 
+	count = count > PAGE_SIZE ? PAGE_SIZE : count;
 	kbuf = kmalloc(count, GFP_KERNEL);
 	if (!kbuf)
 		return -ENOMEM;
-- 
2.18.0
