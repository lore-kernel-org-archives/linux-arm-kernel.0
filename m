From: andreyknvl@google.com (Andrey Konovalov)
Date: Thu,  8 Nov 2018 15:36:13 +0100
Subject: [PATCH v8 6/8] fs, arm64: untag user address in copy_mount_options
In-Reply-To: <cover.1541687720.git.andreyknvl@google.com>
References: <cover.1541687720.git.andreyknvl@google.com>
Message-ID: <12fc6c9e4896b394800776c54b16b26e2003a9df.1541687720.git.andreyknvl@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In copy_mount_options a user address is being subtracted from TASK_SIZE.
If the address is lower than TASK_SIZE, the size is calculated to not
allow the exact_copy_from_user() call to cross TASK_SIZE boundary.
However if the address is tagged, then the size will be calculated
incorrectly.

Untag the address before subtracting.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 98d27da43304..1f1f998d15ed 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2674,7 +2674,7 @@ void *copy_mount_options(const void __user * data)
 	 * the remainder of the page.
 	 */
 	/* copy_from_user cannot cross TASK_SIZE ! */
-	size = TASK_SIZE - (unsigned long)data;
+	size = TASK_SIZE - (unsigned long)untagged_addr(data);
 	if (size > PAGE_SIZE)
 		size = PAGE_SIZE;
 
-- 
2.19.1.930.g4563a0d9d0-goog
