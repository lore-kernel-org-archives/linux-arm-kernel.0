From: icoolidge@google.com (Ian Coolidge)
Date: Thu, 29 Oct 2015 17:27:00 -0700
Subject: [PATCH] arm: spinlock: const qualify read-only functions.
In-Reply-To: <1446061495-38554-1-git-send-email-icoolidge@google.com>
References: <1446061495-38554-1-git-send-email-icoolidge@google.com>
Message-ID: <1446164820-16144-1-git-send-email-icoolidge@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows assert_spin_locked() to be used against
spinlocks that are const qualified.

For example:

struct instance_t {
	int data;
	spinlock_t lock;
};

/*
 * foo does not mutate instance.
 * foo must be called while the lock is held.
 */
int foo(const instance_t *instance) {
	assert_spin_locked(&instance->lock);

	/* Code that assumes the lock is held */

	return 0;
}

Signed-off-by: Ian Coolidge <icoolidge@google.com>
---
 arch/arm/include/asm/spinlock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
index 0fa4184..274ceb1 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -118,12 +118,12 @@ static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
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
