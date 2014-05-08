From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  8 May 2014 15:52:14 +0200
Subject: [PATCH 1/8] usb/gadget: s3c2410_udc: don't use pr_debug return value
In-Reply-To: <1399557141-1346645-1-git-send-email-arnd@arndb.de>
References: <1399557141-1346645-1-git-send-email-arnd@arndb.de>
Message-ID: <1399557141-1346645-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pr_debug() may be defined as "do { } while (0)" in some configurations,
which means one cannot rely on the return value to be available.

In the dprintk function in this driver, we can work around the
resulting build error trivially by returning the length that
this function already knows and ignoring the return value of
pr_debug.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-samsung-soc at vger.kernel.org
---
 drivers/usb/gadget/s3c2410_udc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/s3c2410_udc.c b/drivers/usb/gadget/s3c2410_udc.c
index dd9678f..7987aa0 100644
--- a/drivers/usb/gadget/s3c2410_udc.c
+++ b/drivers/usb/gadget/s3c2410_udc.c
@@ -117,7 +117,8 @@ static int dprintk(int level, const char *fmt, ...)
 			sizeof(printk_buf)-len, fmt, args);
 	va_end(args);
 
-	return pr_debug("%s", printk_buf);
+	pr_debug("%s", printk_buf);
+	return len;
 }
 #else
 static int dprintk(int level, const char *fmt, ...)
-- 
1.8.3.2
