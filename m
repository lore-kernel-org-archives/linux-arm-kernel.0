From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  1 Feb 2016 23:02:48 +0100
Subject: [PATCH] mtd: map: fix .set_vpp() documentation
Message-ID: <1454364168-1342-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit 876fe76d793d03077eb61ba3afab4a383f46c554
"mtd: maps: physmap: Add reference counter to set_vpp()"
the comment in the header file is incorrect and misleading.
Fix it up.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Paul Parsons <lost.distance@yahoo.com>
Fixes: 876fe76d793d ("mtd: maps: physmap: Add reference counter to set_vpp()")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/linux/mtd/map.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/mtd/map.h b/include/linux/mtd/map.h
index 58f3ba709ade..5e0eb7ccabd4 100644
--- a/include/linux/mtd/map.h
+++ b/include/linux/mtd/map.h
@@ -240,8 +240,11 @@ struct map_info {
 	   If there is no cache to care about this can be set to NULL. */
 	void (*inval_cache)(struct map_info *, unsigned long, ssize_t);
 
-	/* set_vpp() must handle being reentered -- enable, enable, disable
-	   must leave it enabled. */
+	/* This will be called with 1 as parameter when the first map user
+	 * needs VPP, and called with 0 when the last user exits. The map
+	 * core maintains a reference counter, and assumes that VPP is a
+	 * global resource applying to all mapped flash chips on the system.
+	 */
 	void (*set_vpp)(struct map_info *, int);
 
 	unsigned long pfow_base;
-- 
2.4.3
