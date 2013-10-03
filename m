From: will.deacon@arm.com (Will Deacon)
Date: Thu,  3 Oct 2013 19:17:34 +0100
Subject: [PATCH v2 3/3] ARM: lockref: add support for lockless lockrefs using
 cmpxchg64
In-Reply-To: <1380824254-22337-1-git-send-email-will.deacon@arm.com>
References: <1380824254-22337-1-git-send-email-will.deacon@arm.com>
Message-ID: <1380824254-22337-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our spinlocks are only 32-bit (2x16-bit tickets) and, on processors
with 64-bit atomic instructions, cmpxchg64 makes use of the double-word
exclusive accessors.

This patch wires up the cmpxchg-based lockless lockref implementation
for ARM.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig                | 1 +
 arch/arm/include/asm/spinlock.h | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c1c551e..22700fd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -5,6 +5,7 @@ config ARM
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_CUSTOM_GPIO_H
+	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_EXTABLE_SORT if MMU
 	select CLONE_BACKWARDS
diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
index 4f2c280..ed6c229 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -127,10 +127,14 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
 	dsb_sev();
 }
 
+static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
+{
+	return lock.tickets.owner == lock.tickets.next;
+}
+
 static inline int arch_spin_is_locked(arch_spinlock_t *lock)
 {
-	struct __raw_tickets tickets = ACCESS_ONCE(lock->tickets);
-	return tickets.owner != tickets.next;
+	return !arch_spin_value_unlocked(ACCESS_ONCE(*lock));
 }
 
 static inline int arch_spin_is_contended(arch_spinlock_t *lock)
-- 
1.8.2.2
