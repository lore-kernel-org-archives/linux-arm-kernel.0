From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 16 Jul 2018 12:30:08 +0100
Subject: [PATCHv4 03/12] atomics: simplify cmpxchg() instrumentation
In-Reply-To: <20180716113017.3909-1-mark.rutland@arm.com>
References: <20180716113017.3909-1-mark.rutland@arm.com>
Message-ID: <20180716113017.3909-4-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we define some fairly verbose wrappers for the cmpxchg()
family so that we can pass a pointer and size into kasan_check_write().

The wrappers duplicate the size-switching logic necessary in arch code,
and only work for scalar types. On some architectures, (cmp)xchg are
used on non-scalar types, and thus the instrumented wrappers need to be
able to handle this.

We could take the type-punning logic from {READ,WRITE}_ONCE(), but this
makes the wrappers even more verbose, and requires several local
variables in the macros.

Instead, let's simplify the wrappers into simple macros which:

* snapshot the pointer into a single local variable, called __ai_ptr to
  avoid conflicts with variables in the scope of the caller.

* call kasan_check_write() on __ai_ptr.

* invoke the relevant arch_*() function, passing the original arguments,
  bar __ai_ptr being substituted for ptr.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/asm-generic/atomic-instrumented.h | 100 +++++-------------------------
 1 file changed, 15 insertions(+), 85 deletions(-)

diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index 3c64e95d5ed0..c7c3e4cdd942 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -408,109 +408,39 @@ static __always_inline bool atomic64_add_negative(s64 i, atomic64_t *v)
 }
 #endif
 
-static __always_inline unsigned long
-cmpxchg_size(volatile void *ptr, unsigned long old, unsigned long new, int size)
-{
-	kasan_check_write(ptr, size);
-	switch (size) {
-	case 1:
-		return arch_cmpxchg((u8 *)ptr, (u8)old, (u8)new);
-	case 2:
-		return arch_cmpxchg((u16 *)ptr, (u16)old, (u16)new);
-	case 4:
-		return arch_cmpxchg((u32 *)ptr, (u32)old, (u32)new);
-	case 8:
-		BUILD_BUG_ON(sizeof(unsigned long) != 8);
-		return arch_cmpxchg((u64 *)ptr, (u64)old, (u64)new);
-	}
-	BUILD_BUG();
-	return 0;
-}
-
 #define cmpxchg(ptr, old, new)						\
 ({									\
-	((__typeof__(*(ptr)))cmpxchg_size((ptr), (unsigned long)(old),	\
-		(unsigned long)(new), sizeof(*(ptr))));			\
+	typeof(ptr) __ai_ptr = (ptr);					\
+	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));			\
+	arch_cmpxchg(__ai_ptr, (old), (new));				\
 })
 
-static __always_inline unsigned long
-sync_cmpxchg_size(volatile void *ptr, unsigned long old, unsigned long new,
-		  int size)
-{
-	kasan_check_write(ptr, size);
-	switch (size) {
-	case 1:
-		return arch_sync_cmpxchg((u8 *)ptr, (u8)old, (u8)new);
-	case 2:
-		return arch_sync_cmpxchg((u16 *)ptr, (u16)old, (u16)new);
-	case 4:
-		return arch_sync_cmpxchg((u32 *)ptr, (u32)old, (u32)new);
-	case 8:
-		BUILD_BUG_ON(sizeof(unsigned long) != 8);
-		return arch_sync_cmpxchg((u64 *)ptr, (u64)old, (u64)new);
-	}
-	BUILD_BUG();
-	return 0;
-}
-
 #define sync_cmpxchg(ptr, old, new)					\
 ({									\
-	((__typeof__(*(ptr)))sync_cmpxchg_size((ptr),			\
-		(unsigned long)(old), (unsigned long)(new),		\
-		sizeof(*(ptr))));					\
+	typeof(ptr) __ai_ptr = (ptr);					\
+	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));			\
+	arch_sync_cmpxchg(__ai_ptr, (old), (new));			\
 })
 
-static __always_inline unsigned long
-cmpxchg_local_size(volatile void *ptr, unsigned long old, unsigned long new,
-		   int size)
-{
-	kasan_check_write(ptr, size);
-	switch (size) {
-	case 1:
-		return arch_cmpxchg_local((u8 *)ptr, (u8)old, (u8)new);
-	case 2:
-		return arch_cmpxchg_local((u16 *)ptr, (u16)old, (u16)new);
-	case 4:
-		return arch_cmpxchg_local((u32 *)ptr, (u32)old, (u32)new);
-	case 8:
-		BUILD_BUG_ON(sizeof(unsigned long) != 8);
-		return arch_cmpxchg_local((u64 *)ptr, (u64)old, (u64)new);
-	}
-	BUILD_BUG();
-	return 0;
-}
-
 #define cmpxchg_local(ptr, old, new)					\
 ({									\
-	((__typeof__(*(ptr)))cmpxchg_local_size((ptr),			\
-		(unsigned long)(old), (unsigned long)(new),		\
-		sizeof(*(ptr))));					\
+	typeof(ptr) __ai_ptr = (ptr);					\
+	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));			\
+	arch_cmpxchg_local(__ai_ptr, (old), (new));			\
 })
 
-static __always_inline u64
-cmpxchg64_size(volatile u64 *ptr, u64 old, u64 new)
-{
-	kasan_check_write(ptr, sizeof(*ptr));
-	return arch_cmpxchg64(ptr, old, new);
-}
-
 #define cmpxchg64(ptr, old, new)					\
 ({									\
-	((__typeof__(*(ptr)))cmpxchg64_size((ptr), (u64)(old),		\
-		(u64)(new)));						\
+	typeof(ptr) __ai_ptr = (ptr);					\
+	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));			\
+	arch_cmpxchg64(__ai_ptr, (old), (new));				\
 })
 
-static __always_inline u64
-cmpxchg64_local_size(volatile u64 *ptr, u64 old, u64 new)
-{
-	kasan_check_write(ptr, sizeof(*ptr));
-	return arch_cmpxchg64_local(ptr, old, new);
-}
-
 #define cmpxchg64_local(ptr, old, new)					\
 ({									\
-	((__typeof__(*(ptr)))cmpxchg64_local_size((ptr), (u64)(old),	\
-		(u64)(new)));						\
+	typeof(ptr) __ai_ptr = (ptr);					\
+	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));			\
+	arch_cmpxchg64_local(__ai_ptr, (old), (new));			\
 })
 
 /*
-- 
2.11.0
