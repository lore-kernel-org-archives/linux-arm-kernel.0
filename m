From: ddaney.cavm@gmail.com (David Daney)
Date: Tue, 17 Nov 2015 16:04:53 -0800
Subject: [PATCH] arm64: Make smp_load_acquire() work with pointer to const
 argument.
Message-ID: <1447805093-8716-1-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

We are now getting this error when building:

.
.
.
  CC      init/do_mounts.o
In file included from include/linux/tcp.h:22:0,
                 from include/linux/ipv6.h:72,
                 from include/net/ipv6.h:16,
                 from include/linux/sunrpc/clnt.h:27,
                 from include/linux/nfs_fs.h:30,
                 from init/do_mounts.c:32:
include/net/sock.h: In function ?sk_state_load?:
include/net/sock.h:2238:2: error: read-only variable ?___p1? used as ?asm? output
  return smp_load_acquire(&sk->sk_state);
  ^
include/net/sock.h:2238:2: error: read-only variable ?___p1? used as ?asm? output
include/net/sock.h:2238:2: error: read-only variable ?___p1? used as ?asm? output
include/net/sock.h:2238:2: error: read-only variable ?___p1? used as ?asm? output
.
.
.

Fix the smp_load_acquire() implementation to discard the const
qualifier in the type of the temporary variable with some tricky
casting.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/arm64/include/asm/barrier.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 624f967..52eb9b9 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -64,7 +64,8 @@ do {									\
 
 #define smp_load_acquire(p)						\
 ({									\
-	typeof(*p) ___p1;						\
+	typeof((typeof(*p))(*p + 0)) ___p1;				\
+	compiletime_assert(sizeof(___p1) == sizeof(*p), "remove const"); \
 	compiletime_assert_atomic_type(*p);				\
 	switch (sizeof(*p)) {						\
 	case 1:								\
-- 
1.8.3.1
