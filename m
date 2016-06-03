From: will.deacon@arm.com (Will Deacon)
Date: Fri,  3 Jun 2016 19:02:05 +0100
Subject: [PATCH 2/2] arm64: spinlock: only wait for a single unlock in
 spin_unlock_wait
In-Reply-To: <1464976925-30525-1-git-send-email-will.deacon@arm.com>
References: <1464976925-30525-1-git-send-email-will.deacon@arm.com>
Message-ID: <1464976925-30525-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than wait until we observe the lock being free, we can also
return from spin_unlock_wait if we observe that the lock is now held
by somebody else, which implies that it was unlocked but we just missed
seeing it in that state.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/spinlock.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index 16f6913f7dbc..ad8d8e3d02d2 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -30,13 +30,19 @@ static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
 {
 	unsigned int tmp;
 	arch_spinlock_t lockval;
+	u32 owner = READ_ONCE(lock->owner) << 16;
 
 	asm volatile(
 "	sevl\n"
 "1:	wfe\n"
 "2:	ldaxr	%w0, %2\n"
+	/* Is the lock free? */
 "	eor	%w1, %w0, %w0, ror #16\n"
-"	cbnz	%w1, 1b\n"
+"	cbz	%w1, 3f\n"
+	/* Has there been a subsequent unlock->lock transition? */
+"	eor	%w1, %w3, %w0, lsl #16\n"
+"	cbz	%w1, 1b\n"
+"3:\n"
 	ARM64_LSE_ATOMIC_INSN(
 	/* LL/SC */
 "	stxr	%w1, %w0, %2\n"
@@ -45,7 +51,7 @@ static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
 "	nop\n"
 "	nop\n")
 	: "=&r" (lockval), "=&r" (tmp), "+Q" (*lock)
-	:
+	: "r" (owner)
 	: "memory");
 }
 
-- 
2.1.4
