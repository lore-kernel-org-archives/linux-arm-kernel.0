From: mst@redhat.com (Michael S. Tsirkin)
Date: Thu, 31 Dec 2015 21:09:01 +0200
Subject: [PATCH v2 25/32] tile: define __smp_xxx
In-Reply-To: <1451572003-2440-1-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
Message-ID: <1451572003-2440-26-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This defines __smp_xxx barriers for tile,
for use by virtualization.

Some smp_xxx barriers are removed as they are
defined correctly by asm-generic/barriers.h

Note: for 32 bit, keep smp_mb__after_atomic around since it's faster
than the generic implementation.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/tile/include/asm/barrier.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/tile/include/asm/barrier.h b/arch/tile/include/asm/barrier.h
index 96a42ae..d552228 100644
--- a/arch/tile/include/asm/barrier.h
+++ b/arch/tile/include/asm/barrier.h
@@ -79,11 +79,12 @@ mb_incoherent(void)
  * But after the word is updated, the routine issues an "mf" before returning,
  * and since it's a function call, we don't even need a compiler barrier.
  */
-#define smp_mb__before_atomic()	smp_mb()
-#define smp_mb__after_atomic()	do { } while (0)
+#define __smp_mb__before_atomic()	__smp_mb()
+#define __smp_mb__after_atomic()	do { } while (0)
+#define smp_mb__after_atomic()	__smp_mb__after_atomic()
 #else /* 64 bit */
-#define smp_mb__before_atomic()	smp_mb()
-#define smp_mb__after_atomic()	smp_mb()
+#define __smp_mb__before_atomic()	__smp_mb()
+#define __smp_mb__after_atomic()	__smp_mb()
 #endif
 
 #include <asm-generic/barrier.h>
-- 
MST
