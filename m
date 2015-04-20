From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Mon, 20 Apr 2015 18:45:53 +0300
Subject: [PATCH] arm64: Implement 1-,2- byte smp_load_acquire and
 smp_store_release
Message-ID: <1429544753-4120-1-git-send-email-a.ryabinin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 47933ad41a86 ("arch: Introduce smp_load_acquire(), smp_store_release()")
allowed only 4- and 8-byte smp_load_acquire, smp_store_release.
So 1- and 2-byte cases weren't implemented in arm64.
Later commit 536fa402221f ("compiler: Allow 1- and 2-byte smp_load_acquire()
				and smp_store_release()")
allowed to use 1 and 2 byte smp_load_acquire and smp_store_release
by adjusting the definition of __native_word().
However, 1-,2- byte cases in arm64 version left unimplemented.

Commit 8053871d0f7f ("smp: Fix smp_call_function_single_async() locking")
started to use smp_load_acquire() to load 2-bytes csd->flags.
That crashes arm64 kernel during the boot.

Implement 1,2 byte cases in arm64's  smp_load_acquire()
and smp_store_release() to fix this.

Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
---
 arch/arm64/include/asm/barrier.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index a5abb00..71f19c4 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -65,6 +65,14 @@ do {									\
 do {									\
 	compiletime_assert_atomic_type(*p);				\
 	switch (sizeof(*p)) {						\
+	case 1:								\
+		asm volatile ("stlrb %w1, %0"				\
+				: "=Q" (*p) : "r" (v) : "memory");	\
+		break;							\
+	case 2:								\
+		asm volatile ("stlrh %w1, %0"				\
+				: "=Q" (*p) : "r" (v) : "memory");	\
+		break;							\
 	case 4:								\
 		asm volatile ("stlr %w1, %0"				\
 				: "=Q" (*p) : "r" (v) : "memory");	\
@@ -81,6 +89,14 @@ do {									\
 	typeof(*p) ___p1;						\
 	compiletime_assert_atomic_type(*p);				\
 	switch (sizeof(*p)) {						\
+	case 1:								\
+		asm volatile ("ldarb %w0, %1"				\
+			: "=r" (___p1) : "Q" (*p) : "memory");		\
+		break;							\
+	case 2:								\
+		asm volatile ("ldarh %w0, %1"				\
+			: "=r" (___p1) : "Q" (*p) : "memory");		\
+		break;							\
 	case 4:								\
 		asm volatile ("ldar %w0, %1"				\
 			: "=r" (___p1) : "Q" (*p) : "memory");		\
-- 
2.3.5
