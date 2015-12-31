From: mst@redhat.com (Michael S. Tsirkin)
Date: Thu, 31 Dec 2015 21:05:58 +0200
Subject: [PATCH v2 02/32] asm-generic: guard smp_store_release/load_acquire
In-Reply-To: <1451572003-2440-1-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
Message-ID: <1451572003-2440-3-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow architectures to override smp_store_release
and smp_load_acquire by guarding the defines
in asm-generic/barrier.h with ifndef directives.

This is in preparation to reusing asm-generic/barrier.h
on architectures which have their own definition
of these macros.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/barrier.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 0f45f93..987b2e0 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -104,13 +104,16 @@
 #define smp_mb__after_atomic()	smp_mb()
 #endif
 
+#ifndef smp_store_release
 #define smp_store_release(p, v)						\
 do {									\
 	compiletime_assert_atomic_type(*p);				\
 	smp_mb();							\
 	WRITE_ONCE(*p, v);						\
 } while (0)
+#endif
 
+#ifndef smp_load_acquire
 #define smp_load_acquire(p)						\
 ({									\
 	typeof(*p) ___p1 = READ_ONCE(*p);				\
@@ -118,6 +121,7 @@ do {									\
 	smp_mb();							\
 	___p1;								\
 })
+#endif
 
 #endif /* !__ASSEMBLY__ */
 #endif /* __ASM_GENERIC_BARRIER_H */
-- 
MST
