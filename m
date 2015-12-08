From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Dec 2015 16:12:54 +0100
Subject: [PATCH 01/19] ASoC: da7218: avoid 64-bit compile warning
Message-ID: <3548574.qiC2AlzHH4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building the da7218 driver on a 64-bit architecture, we get
a harmless warning:

sound/soc/codecs/da7218.c: In function 'da7218_of_get_id':
sound/soc/codecs/da7218.c:2261:10: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]

This changes the code to use uintptr_t to ensure we have an integer
type of the same size as a pointer and won't get a warning on any
architecture.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 4d50934abd22 ("ASoC: da7218: Add da7218 codec driver")
---
 sound/soc/codecs/da7218.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
index 4fee7aeaadc7..eacde128c4d6 100644
--- a/sound/soc/codecs/da7218.c
+++ b/sound/soc/codecs/da7218.c
@@ -2258,7 +2258,7 @@ static inline int da7218_of_get_id(struct device *dev)
 	const struct of_device_id *id = of_match_device(da7218_of_match, dev);
 
 	if (id)
-		return (int) id->data;
+		return (uintptr_t)id->data;
 	else
 		return -EINVAL;
 }
-- 
2.1.0.rc2
