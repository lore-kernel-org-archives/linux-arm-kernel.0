From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 16 Jul 2018 12:30:07 +0100
Subject: [PATCHv4 02/12] atomics/x86: reduce arch_cmpxchg64*() instrumentation
In-Reply-To: <20180716113017.3909-1-mark.rutland@arm.com>
References: <20180716113017.3909-1-mark.rutland@arm.com>
Message-ID: <20180716113017.3909-3-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently x86's arch_cmpxchg64() and arch_cmpxchg64_local() are
instrumented twice, as they call into instrumented atomics rather than
their arch_ equivalents.

A call to cmpxchg64() results in:

  cmpxchg64()
    kasan_check_write()
    arch_cmpxchg64()
      cmpxchg()
        kasan_check_write()
        arch_cmpxchg()

Let's fix this up and call the arch_ equivalents, resulting in:

  cmpxchg64()
    kasan_check_write()
    arch_cmpxchg64()
      arch_cmpxchg()

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/cmpxchg_64.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cmpxchg_64.h b/arch/x86/include/asm/cmpxchg_64.h
index bfca3b346c74..072e5459fe2f 100644
--- a/arch/x86/include/asm/cmpxchg_64.h
+++ b/arch/x86/include/asm/cmpxchg_64.h
@@ -10,13 +10,13 @@ static inline void set_64bit(volatile u64 *ptr, u64 val)
 #define arch_cmpxchg64(ptr, o, n)					\
 ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg((ptr), (o), (n));					\
+	arch_cmpxchg((ptr), (o), (n));					\
 })
 
 #define arch_cmpxchg64_local(ptr, o, n)					\
 ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg_local((ptr), (o), (n));					\
+	arch_cmpxchg_local((ptr), (o), (n));				\
 })
 
 #define system_has_cmpxchg_double() boot_cpu_has(X86_FEATURE_CX16)
-- 
2.11.0
