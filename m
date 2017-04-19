From: mka@chromium.org (Matthias Kaehlcke)
Date: Wed, 19 Apr 2017 14:22:11 -0700
Subject: [PATCH] arm64: prefetch: Change assembly to be compatible with gcc
 and clang
Message-ID: <20170419212211.95803-1-mka@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clang fails to build with the current code:

arch/arm64/include/asm/processor.h:172:15: error: invalid operand in
inline asm: 'prfm pldl1keep, ${0:a}'

Apparently clang does not support the 'a' modifier. Change the
constraint from 'p' ('An operand that is a valid memory address is
allowed') to 'Q' ('A memory address which uses a single base register
with no offset'), which works for both gcc and clang.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/include/asm/processor.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index c97b8bd2acba..bfdc82e924a5 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -165,21 +165,21 @@ extern struct task_struct *cpu_switch_to(struct task_struct *prev,
 #define ARCH_HAS_PREFETCH
 static inline void prefetch(const void *ptr)
 {
-	asm volatile("prfm pldl1keep, %a0\n" : : "p" (ptr));
+	asm volatile("prfm pldl1keep, %0\n" : : "Q" (ptr));
 }
 
 #define ARCH_HAS_PREFETCHW
 static inline void prefetchw(const void *ptr)
 {
-	asm volatile("prfm pstl1keep, %a0\n" : : "p" (ptr));
+	asm volatile("prfm pstl1keep, %0\n" : : "Q" (ptr));
 }
 
 #define ARCH_HAS_SPINLOCK_PREFETCH
 static inline void spin_lock_prefetch(const void *ptr)
 {
 	asm volatile(ARM64_LSE_ATOMIC_INSN(
-		     "prfm pstl1strm, %a0",
-		     "nop") : : "p" (ptr));
+		     "prfm pstl1strm, %0",
+		     "nop") : : "Q" (ptr));
 }
 
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
-- 
2.12.2.816.g2cccc81164-goog
