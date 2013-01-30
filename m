From: gang.chen@asianux.com (Chen Gang)
Date: Wed, 30 Jan 2013 12:13:53 +0800
Subject: [PATCH] ARM:kernel checking failure after call vmalloc
Message-ID: <51089E01.9020009@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


  need checking failure after call vmalloc.

  if fail:
    need return fail code (-ENOMEM, long will be signed cast to int)
    also need call etb_lock(t) to lock again.
    better to let vmalloc code above etb_writel(... ETBR_READADDR).


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/kernel/etm.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
index 9b6de8c..fbe51a3 100644
--- a/arch/arm/kernel/etm.c
+++ b/arch/arm/kernel/etm.c
@@ -287,14 +287,20 @@ static ssize_t etb_read(struct file *file, char __user *data,
 	etb_unlock(t);
 
 	total = etb_getdatalen(t);
+	length = min(total * 4, (int)len);
+
+	buf = vmalloc(length);
+	if (!buf) {
+		etb_lock(t);
+		length = -ENOMEM;
+		goto out;
+	}
+
 	if (total == t->etb_bufsz)
 		first = etb_readl(t, ETBR_WRITEADDR);
 
 	etb_writel(t, first, ETBR_READADDR);
 
-	length = min(total * 4, (int)len);
-	buf = vmalloc(length);
-
 	dev_dbg(t->dev, "ETB buffer length: %d\n", total);
 	dev_dbg(t->dev, "ETB status reg: %x\n", etb_readl(t, ETBR_STATUS));
 	for (i = 0; i < length / 4; i++)
-- 
1.7.10.4
