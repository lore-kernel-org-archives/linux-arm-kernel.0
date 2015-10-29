From: icoolidge@google.com (Ian Coolidge)
Date: Wed, 28 Oct 2015 17:47:45 -0700
Subject: [PATCH] arm64: spinlock: const qualify read-only functions
In-Reply-To: <1446079665-25366-1-git-send-email-icoolidge@google.com>
References: <1446079665-25366-1-git-send-email-icoolidge@google.com>
Message-ID: <1446079665-25366-2-git-send-email-icoolidge@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows assert_spin_locked() to be used against
spinlocks that are const qualified.

Signed-off-by: Ian Coolidge <icoolidge@google.com>
---
 arch/arm64/include/asm/spinlock.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index c85e96d..72a7f33 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -122,17 +122,17 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
 	: "memory");
 }
 
-static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
+static inline int arch_spin_value_unlocked(const arch_spinlock_t lock)
 {
 	return lock.owner == lock.next;
 }
 
-static inline int arch_spin_is_locked(arch_spinlock_t *lock)
+static inline int arch_spin_is_locked(const arch_spinlock_t *lock)
 {
 	return !arch_spin_value_unlocked(READ_ONCE(*lock));
 }
 
-static inline int arch_spin_is_contended(arch_spinlock_t *lock)
+static inline int arch_spin_is_contended(const arch_spinlock_t *lock)
 {
 	arch_spinlock_t lockval = READ_ONCE(*lock);
 	return (lockval.next - lockval.owner) > 1;
-- 
2.6.0.rc2.230.g3dd15c0
