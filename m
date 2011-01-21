From: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 21 Jan 2011 00:23:23 -0800
Subject: [PATCH] change acquire/release_console_sem() to
	console_lock/unlock()
In-Reply-To: <AANLkTinN2+pNGk1hwrcMhH5qDNZK=Egrw7P6c-cdJTmH@mail.gmail.com>
References: <1295539104-13210-1-git-send-email-torbenh@gmx.de>
	<20110120163448.GA30588@suse.de> <20110120165502.GA10832@siel.b>
	<20110120123507.ac89c034.akpm@linux-foundation.org>
	<AANLkTinN2+pNGk1hwrcMhH5qDNZK=Egrw7P6c-cdJTmH@mail.gmail.com>
Message-ID: <20110121002323.e9cbf9ae.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Jan 2011 09:10:06 +0100 Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> include/linux/mutex.h:
> 
> /*
>  * NOTE: mutex_trylock() follows the spin_trylock() convention,
>  *       not the down_trylock() convention!
>  *
>  * Returns 1 if the mutex has been acquired successfully, and 0 on contention.
>  */
> extern int mutex_trylock(struct mutex *lock);
> 
> So that's why the return value was inverted (when treating it as a boolean).
> I can understand that.
> 
> However:
> 
> +/**
> + * console_trylock - try to lock the console system for exclusive use.
> + *
> + * Tried to acquire a lock which guarantees that the caller has
> + * exclusive access to the console system and the console_drivers list.
> + *
> + * returns -1 on success, and 0 on failure to acquire the lock.
> + */
> +int console_trylock(void)
> 
> So this one returns -1 on success, not 1? Why?

Yup.  All callers just test for non-zero, so...

--- a/kernel/printk.c~change-acquire-release_console_sem-to-console_lock-unlock-fix-2
+++ a/kernel/printk.c
@@ -1058,7 +1058,7 @@ EXPORT_SYMBOL(console_lock);
  * Tried to acquire a lock which guarantees that the caller has
  * exclusive access to the console system and the console_drivers list.
  *
- * returns -1 on success, and 0 on failure to acquire the lock.
+ * returns 1 on success, and 0 on failure to acquire the lock.
  */
 int console_trylock(void)
 {
@@ -1070,7 +1070,7 @@ int console_trylock(void)
 	}
 	console_locked = 1;
 	console_may_schedule = 0;
-	return -1;
+	return 1;
 }
 EXPORT_SYMBOL(console_trylock);
 
_
