From: will.deacon@arm.com (Will Deacon)
Date: Wed, 18 Nov 2015 10:13:08 +0000
Subject: [PATCH] arm64: barriers: fix smp_load_acquire to work with const
 arguments
Message-ID: <1447841588-28470-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A newly introduced function in include/net/sock.h passes a const
argument to smp_load_acquire:

  static inline int sk_state_load(const struct sock *sk)
  {
	return smp_load_acquire(&sk->sk_state);
  }

This cause an allmodconfig build failure, since our underlying
load-acquire implementation does not handle const types correctly:

  include/net/sock.h: In function 'sk_state_load':
  ./arch/arm64/include/asm/barrier.h:71:3: error: read-only variable '___p1' used as 'asm' output
     asm volatile ("ldarb %w0, %1"    \

This patch fixes the problem by reusing the trick in READ_ONCE that
loads via a non-const member of an anonymous union. This has the
advantage of allowing us to use smp_load_acquire on packed structures
(e.g. arch_spinlock_t) as well as primitive types.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Daney <david.daney@cavium.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: David Daney <david.daney@cavium.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/barrier.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 624f9679f4b0..9622eb48f894 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -64,27 +64,31 @@ do {									\
 
 #define smp_load_acquire(p)						\
 ({									\
-	typeof(*p) ___p1;						\
+	union { typeof(*p) __val; char __c[1]; } __u;			\
 	compiletime_assert_atomic_type(*p);				\
 	switch (sizeof(*p)) {						\
 	case 1:								\
 		asm volatile ("ldarb %w0, %1"				\
-			: "=r" (___p1) : "Q" (*p) : "memory");		\
+			: "=r" (*(__u8 *)__u.__c)			\
+			: "Q" (*p) : "memory");				\
 		break;							\
 	case 2:								\
 		asm volatile ("ldarh %w0, %1"				\
-			: "=r" (___p1) : "Q" (*p) : "memory");		\
+			: "=r" (*(__u16 *)__u.__c)			\
+			: "Q" (*p) : "memory");				\
 		break;							\
 	case 4:								\
 		asm volatile ("ldar %w0, %1"				\
-			: "=r" (___p1) : "Q" (*p) : "memory");		\
+			: "=r" (*(__u32 *)__u.__c)			\
+			: "Q" (*p) : "memory");				\
 		break;							\
 	case 8:								\
 		asm volatile ("ldar %0, %1"				\
-			: "=r" (___p1) : "Q" (*p) : "memory");		\
+			: "=r" (*(__u64 *)__u.__c)			\
+			: "Q" (*p) : "memory");				\
 		break;							\
 	}								\
-	___p1;								\
+	__u.__val;							\
 })
 
 #define read_barrier_depends()		do { } while(0)
-- 
2.1.4
