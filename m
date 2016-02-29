From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Feb 2016 10:33:58 +0100
Subject: [PATCH] crypto/async_pq: use __free_page() instead of put_page()
Message-ID: <1456738445-876239-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The addition of tracepoints to the page reference tracking had an
unfortunate side-effect in at least one driver that calls put_page
from its exit function, resulting in a link error:

`.exit.text' referenced in section `__jump_table' of crypto/built-in.o: defined in discarded section `.exit.text' of crypto/built-in.o

>From a cursory look at that this driver, it seems that it may be
doing the wrong thing here anyway, as the page gets allocated
using 'alloc_page()', and should be freed using '__free_page()'
rather than 'put_page()'.

With this patch, I no longer get any other build errors from the
page_ref patch, so hopefully we can assume that it's always wrong
to call any of those functions from __exit code, and that no other
driver does it.

Fixes: 0f80830dd044 ("mm/page_ref: add tracepoint to track down page reference manipulation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 crypto/async_tx/async_pq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/async_tx/async_pq.c b/crypto/async_tx/async_pq.c
index c0748bbd4c08..08b3ac68952b 100644
--- a/crypto/async_tx/async_pq.c
+++ b/crypto/async_tx/async_pq.c
@@ -444,7 +444,7 @@ static int __init async_pq_init(void)
 
 static void __exit async_pq_exit(void)
 {
-	put_page(pq_scribble_page);
+	__free_page(pq_scribble_page);
 }
 
 module_init(async_pq_init);
-- 
2.7.0
