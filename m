From: will.deacon@arm.com (Will Deacon)
Date: Wed,  8 Jun 2016 17:25:38 +0100
Subject: [PATCH v2 2/3] arm64: spinlock: fix spin_unlock_wait for LSE atomics
In-Reply-To: <1465403139-21054-1-git-send-email-will.deacon@arm.com>
References: <1465403139-21054-1-git-send-email-will.deacon@arm.com>
Message-ID: <1465403139-21054-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit d86b8da04dfa ("arm64: spinlock: serialise spin_unlock_wait against
concurrent lockers") fixed spin_unlock_wait for LL/SC-based atomics under
the premise that the LSE atomics (in particular, the LDADDA instruction)
are indivisible.

Unfortunately, these instructions are only indivisible when used with the
-AL (full ordering) suffix and, consequently, the same issue can
theoretically be observed with LSE atomics, where a later (in program
order) load can be speculated before the write portion of the atomic
operation.

This patch fixes the issue by performing a CAS of the lock once we've
established that it's unlocked, in much the same way as the LL/SC code.

Fixes: d86b8da04dfa ("arm64: spinlock: serialise spin_unlock_wait against concurrent lockers")
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/spinlock.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index aac64d55cb22..d5c894253e73 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -43,13 +43,17 @@ static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
 "2:	ldaxr	%w0, %2\n"
 "	eor	%w1, %w0, %w0, ror #16\n"
 "	cbnz	%w1, 1b\n"
+	/* Serialise against any concurrent lockers */
 	ARM64_LSE_ATOMIC_INSN(
 	/* LL/SC */
 "	stxr	%w1, %w0, %2\n"
-"	cbnz	%w1, 2b\n", /* Serialise against any concurrent lockers */
-	/* LSE atomics */
 "	nop\n"
-"	nop\n")
+"	nop\n",
+	/* LSE atomics */
+"	mov	%w1, %w0\n"
+"	cas	%w0, %w0, %2\n"
+"	eor	%w1, %w1, %w0\n")
+"	cbnz	%w1, 2b\n"
 	: "=&r" (lockval), "=&r" (tmp), "+Q" (*lock)
 	:
 	: "memory");
-- 
2.1.4
