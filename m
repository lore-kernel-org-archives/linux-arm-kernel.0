From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Thu, 11 Sep 2014 16:19:49 +0800
Subject: [PATCH] regmap:change struct regmap's internal locks as union
Message-ID: <35FD53F367049845BC99AC72306C23D103CDBFBFB01A@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch change struct regmap->mutex and struct regmap->spinlock
as an union, because these 2 members are only used one of them,
we change it to shrink the struct size.

Signed-off-by: Yalin Wang <yalin.wang@sonymobile.com>
---
 drivers/base/regmap/internal.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index bfc90b8..0da5865 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -49,8 +49,10 @@ struct regmap_async {
 };
 
 struct regmap {
-	struct mutex mutex;
-	spinlock_t spinlock;
+	union {
+		struct mutex mutex;
+		spinlock_t spinlock;
+	};
 	unsigned long spinlock_flags;
 	regmap_lock lock;
 	regmap_unlock unlock;
-- 
2.1.0
