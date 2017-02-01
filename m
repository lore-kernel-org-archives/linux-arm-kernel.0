From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  1 Feb 2017 17:22:25 +0100
Subject: [PATCH] staging: bcm2835-audio: fix empty-body warning
Message-ID: <20170201162338.2190573-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc-7 warns about debug statements being left out here:

drivers/staging/bcm2835-audio/bcm2835-vchiq.c: In function 'bcm2835_audio_set_ctls':
drivers/staging/bcm2835-audio/bcm2835-vchiq.c:572:54: error: suggest braces around empty body in an 'else' statement [-Werror=empty-body]

It's better to use no_printk(), which has the added advantage of checking
the format strings.

Fixes: 23b028c871e1 ("staging: bcm2835-audio: initial staging submission")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/bcm2835-audio/bcm2835-vchiq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/bcm2835-audio/bcm2835-vchiq.c
index e8fd9c79bcfc..b1f86240b32f 100644
--- a/drivers/staging/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/bcm2835-audio/bcm2835-vchiq.c
@@ -50,9 +50,9 @@
 #define LOG_DBG( fmt, arg... )   pr_info( "%s:%d " fmt, __func__, __LINE__, ##arg)
 #else
 #define LOG_ERR( fmt, arg... )   pr_err( "%s:%d " fmt, __func__, __LINE__, ##arg)
-#define LOG_WARN( fmt, arg... )
-#define LOG_INFO( fmt, arg... )
-#define LOG_DBG( fmt, arg... )
+#define LOG_WARN( fmt, arg... )	 no_printk(fmt, ##arg)
+#define LOG_INFO( fmt, arg... )	 no_printk(fmt, ##arg)
+#define LOG_DBG( fmt, arg... )	 no_printk(fmt, ##arg)
 #endif
 
 struct bcm2835_audio_instance {
-- 
2.9.0
