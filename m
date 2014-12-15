From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Mon, 15 Dec 2014 16:05:50 +0800
Subject: [PATCH] regmap:change spinlock_flags into the union
In-Reply-To: <35FD53F367049845BC99AC72306C23D103CDBFBFB01A@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103CDBFBFB01A@CNBJMBX05.corpusers.net>
Message-ID: <35FD53F367049845BC99AC72306C23D103EDAF89E148@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch move struct regmap.spinlock_flags into the union of
spinlock, so that we can shrink struct regmap size.

Signed-off-by: Yalin Wang <yalin.wang@sonymobile.com>
---
 drivers/base/regmap/internal.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 0da5865..8e94584 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -51,9 +51,11 @@ struct regmap_async {
 struct regmap {
 	union {
 		struct mutex mutex;
-		spinlock_t spinlock;
+		struct {
+			spinlock_t spinlock;
+			unsigned long spinlock_flags;
+		};
 	};
-	unsigned long spinlock_flags;
 	regmap_lock lock;
 	regmap_unlock unlock;
 	void *lock_arg; /* This is passed to lock/unlock functions */
-- 
2.1.3
