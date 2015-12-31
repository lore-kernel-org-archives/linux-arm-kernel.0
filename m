From: mst@redhat.com (Michael S. Tsirkin)
Date: Thu, 31 Dec 2015 21:08:46 +0200
Subject: [PATCH v2 23/32] sh: define __smp_xxx, fix smp_store_mb for !SMP
In-Reply-To: <1451572003-2440-1-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
Message-ID: <1451572003-2440-24-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sh variant of smp_store_mb() calls xchg() on !SMP which is stronger than
implied by both the name and the documentation.

define __smp_store_mb instead: code in asm-generic/barrier.h
will then define smp_store_mb correctly depending on
CONFIG_SMP.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/include/asm/barrier.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/barrier.h b/arch/sh/include/asm/barrier.h
index bf91037..f887c64 100644
--- a/arch/sh/include/asm/barrier.h
+++ b/arch/sh/include/asm/barrier.h
@@ -32,7 +32,8 @@
 #define ctrl_barrier()	__asm__ __volatile__ ("nop;nop;nop;nop;nop;nop;nop;nop")
 #endif
 
-#define smp_store_mb(var, value) do { (void)xchg(&var, value); } while (0)
+#define __smp_store_mb(var, value) do { (void)xchg(&var, value); } while (0)
+#define smp_store_mb(var, value) __smp_store_mb(var, value)
 
 #include <asm-generic/barrier.h>
 
-- 
MST
