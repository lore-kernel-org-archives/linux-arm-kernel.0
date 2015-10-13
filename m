From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Oct 2015 22:30:08 +0200
Subject: [PATCH] mutex: make mutex_lock_nested an inline function
Message-ID: <11282238.AHmyWliPRj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The second argument of the mutex_lock_nested() helper is only
evaluated if CONFIG_DEBUG_LOCK_ALLOC is set. Otherwise we
get this build warning for the new regulator_lock_supply
function:

drivers/regulator/core.c: In function 'regulator_lock_supply':
drivers/regulator/core.c:142:6: warning: unused variable 'i' [-Wunused-variable]

To avoid the warning, this patch changes the definition of
mutex_lock_nested() to be static inline function rather than
a macro, which tells gcc that the variable is potentially
used.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 9f01cd4a915 ("regulator: core: introduce function to lock regulators and its supplies")
---
Second try, this time fixing the root of the problem rather than the code
that triggered it, as suggested by Mark Brown.

I guess this means the fix should now probably go through Ingo's sched-locking
branch or through Andrew's mm patches. The warning currently only shows
up in Linux-next because of Mark's regulator branch that is destined for 4.4,
so it's not needed for 4.3 but also harmless.

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 2cb7531e7d7a..9494dafd7a9c 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -158,7 +158,10 @@ extern void mutex_lock(struct mutex *lock);
 extern int __must_check mutex_lock_interruptible(struct mutex *lock);
 extern int __must_check mutex_lock_killable(struct mutex *lock);
 
-# define mutex_lock_nested(lock, subclass) mutex_lock(lock)
+static inline void mutex_lock_nested(struct mutex *lock, unsigned int subclass)
+{
+	return mutex_lock(lock);
+}
 # define mutex_lock_interruptible_nested(lock, subclass) mutex_lock_interruptible(lock)
 # define mutex_lock_killable_nested(lock, subclass) mutex_lock_killable(lock)
 # define mutex_lock_nest_lock(lock, nest_lock) mutex_lock(lock)
