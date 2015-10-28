From: icoolidge@google.com (Ian Coolidge)
Date: Wed, 28 Oct 2015 12:44:54 -0700
Subject: [PATCH] arm: spinlock: const qualify read-only functions
Message-ID: <1446061495-38554-1-git-send-email-icoolidge@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows assert_spin_locked() to be used against
spinlocks that are const qualified.

Signed-off-by: Ian Coolidge <icoolidge@google.com>
---
 arch/arm/include/asm/spinlock.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
index 0fa4184..3512d2d 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -113,17 +113,17 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
 	dsb_sev();
 }
 
-static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
+static inline int arch_spin_value_unlocked(const arch_spinlock_t lock)
 {
 	return lock.tickets.owner == lock.tickets.next;
 }
 
-static inline int arch_spin_is_locked(arch_spinlock_t *lock)
+static inline int arch_spin_is_locked(const arch_spinlock_t *lock)
 {
 	return !arch_spin_value_unlocked(READ_ONCE(*lock));
 }
 
-static inline int arch_spin_is_contended(arch_spinlock_t *lock)
+static inline int arch_spin_is_contended(const arch_spinlock_t *lock)
 {
 	struct __raw_tickets tickets = READ_ONCE(lock->tickets);
 	return (tickets.next - tickets.owner) > 1;
-- 
2.6.0.rc2.230.g3dd15c0
