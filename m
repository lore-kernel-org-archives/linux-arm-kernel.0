From: miles.chen@mediatek.com (miles.chen at mediatek.com)
Date: Fri, 26 Oct 2018 02:34:41 +0800
Subject: [PATCH] mm/page_owner: use vmalloc instead of kmalloc
Message-ID: <1540492481-4144-1-git-send-email-miles.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Miles Chen <miles.chen@mediatek.com>

The kbuf used by page owner is allocated by kmalloc(),
which means it can use only normal memory and there might
be a "out of memory" issue when we're out of normal memory.

Use vmalloc() so we can also allocate kbuf from highmem
on 32bit kernel.

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 mm/page_owner.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index d80adfe702d3..7e6962adaa79 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/debugfs.h>
 #include <linux/mm.h>
-#include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/bootmem.h>
 #include <linux/stacktrace.h>
@@ -10,6 +9,7 @@
 #include <linux/migrate.h>
 #include <linux/stackdepot.h>
 #include <linux/seq_file.h>
+#include <linux/vmalloc.h>
 
 #include "internal.h"
 
@@ -351,7 +351,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 		.skip = 0
 	};
 
-	kbuf = kmalloc(count, GFP_KERNEL);
+	kbuf = vmalloc(count);
 	if (!kbuf)
 		return -ENOMEM;
 
@@ -397,11 +397,11 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 	if (copy_to_user(buf, kbuf, ret))
 		ret = -EFAULT;
 
-	kfree(kbuf);
+	vfree(kbuf);
 	return ret;
 
 err:
-	kfree(kbuf);
+	vfree(kbuf);
 	return -ENOMEM;
 }
 
-- 
2.18.0
