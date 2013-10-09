From: will.deacon@arm.com (Will Deacon)
Date: Wed,  9 Oct 2013 15:54:27 +0100
Subject: [PATCH 2/3] arm64: lockref: add support for lockless lockrefs using
 cmpxchg
In-Reply-To: <1381330468-32625-1-git-send-email-will.deacon@arm.com>
References: <1381330468-32625-1-git-send-email-will.deacon@arm.com>
Message-ID: <1381330468-32625-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our spinlocks are only 32-bit (2x16-bit tickets) and our cmpxchg can
deal with 8-bytes (as one would hope!).

This patch wires up the cmpxchg-based lockless lockref implementation
for arm64.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig                | 1 +
 arch/arm64/include/asm/spinlock.h | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c044548..9e8233b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1,6 +1,7 @@
 config ARM64
 	def_bool y
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
+	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select ARCH_WANT_FRAME_POINTERS
diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index 525dd53..3d5cf06 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -92,10 +92,14 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
 	: "memory");
 }
 
+static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
+{
+	return lock.owner == lock.next;
+}
+
 static inline int arch_spin_is_locked(arch_spinlock_t *lock)
 {
-	arch_spinlock_t lockval = ACCESS_ONCE(*lock);
-	return lockval.owner != lockval.next;
+	return !arch_spin_value_unlocked(ACCESS_ONCE(*lock));
 }
 
 static inline int arch_spin_is_contended(arch_spinlock_t *lock)
-- 
1.8.2.2
