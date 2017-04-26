From: chunhui.li@mediatek.com (Chunhui Li)
Date: Wed, 26 Apr 2017 11:08:59 +0800
Subject: [PATCH] fs: seq_buf_alloc use vmalloc for high order allocations
Message-ID: <20170426030859.15420-1-chunhui.li@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "chunhui.li" <chunhui.li@mediatek.com>

Hi Sirs,

I sent this patch on 2017.4.5 but got no response, could you please check it? 
Maybe you have concern about the patch, your comments and suggestions are welcome!  

Best Regards

For high order allocations, use vmalloc() to reduce physically
contiguous memory consumption and avoid memory fragmentation issues

Signed-off-by: chunhui.li <chunhui.li@mediatek.com>
---
 fs/seq_file.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index ca69fb9..4527e79 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -26,19 +26,17 @@ static void seq_set_overflow(struct seq_file *m)
 static void *seq_buf_alloc(unsigned long size)
 {
 	void *buf;
-	gfp_t gfp = GFP_KERNEL;
 
 	/*
-	 * For high order allocations, use __GFP_NORETRY to avoid oom-killing -
-	 * it's better to fall back to vmalloc() than to kill things.  For small
-	 * allocations, just use GFP_KERNEL which will oom kill, thus no need
-	 * for vmalloc fallback.
-	 */
+	 * For high order allocations, use vmalloc() to reduce physically
+	 * contiguous memory usage and avoid memory fragmentation issue.
+	 * For small allocations, just use GFP_KERNEL
+	 * which will oom kill, thus no need for vmalloc fallback.
+	 */
 	if (size > PAGE_SIZE)
-		gfp |= __GFP_NORETRY | __GFP_NOWARN;
-	buf = kmalloc(size, gfp);
-	if (!buf && size > PAGE_SIZE)
 		buf = vmalloc(size);
+	else
+		buf = kmalloc(size, GFP_KERNEL);
 	return buf;
 }
 
-- 
2.9.2
