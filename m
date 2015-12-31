From: mst@redhat.com (Michael S. Tsirkin)
Date: Thu, 31 Dec 2015 21:09:47 +0200
Subject: [PATCH v2 31/32] sh: support a 2-byte smp_store_mb
In-Reply-To: <1451572003-2440-1-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
Message-ID: <1451572003-2440-32-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the moment, xchg on sh only supports 4 and 1 byte values, so using it
from smp_store_mb means attempts to store a 2 byte value using this
macro fail.

And happens to be exactly what virtio drivers want to do.

Check size and fall back to a slower, but safe, WRITE_ONCE+smp_mb.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/sh/include/asm/barrier.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/barrier.h b/arch/sh/include/asm/barrier.h
index f887c64..0cc5735 100644
--- a/arch/sh/include/asm/barrier.h
+++ b/arch/sh/include/asm/barrier.h
@@ -32,7 +32,15 @@
 #define ctrl_barrier()	__asm__ __volatile__ ("nop;nop;nop;nop;nop;nop;nop;nop")
 #endif
 
-#define __smp_store_mb(var, value) do { (void)xchg(&var, value); } while (0)
+#define __smp_store_mb(var, value) do { \
+	if (sizeof(var) != 4 && sizeof(var) != 1) { \
+		 WRITE_ONCE(var, value); \
+		__smp_mb(); \
+	} else { \
+		(void)xchg(&var, value);  \
+	} \
+} while (0)
+
 #define smp_store_mb(var, value) __smp_store_mb(var, value)
 
 #include <asm-generic/barrier.h>
-- 
MST
