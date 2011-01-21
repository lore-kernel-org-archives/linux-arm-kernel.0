From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 21 Jan 2011 09:10:06 +0100
Subject: [PATCH] change acquire/release_console_sem() to
	console_lock/unlock()
In-Reply-To: <20110120123507.ac89c034.akpm@linux-foundation.org>
References: <1295539104-13210-1-git-send-email-torbenh@gmx.de>
	<20110120163448.GA30588@suse.de> <20110120165502.GA10832@siel.b>
	<20110120123507.ac89c034.akpm@linux-foundation.org>
Message-ID: <AANLkTinN2+pNGk1hwrcMhH5qDNZK=Egrw7P6c-cdJTmH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 21:35, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Thu, 20 Jan 2011 17:55:02 +0100
> torbenh <torbenh@gmx.de> wrote:
>
>> On Thu, Jan 20, 2011 at 08:34:48AM -0800, Greg KH wrote:
>> > On Thu, Jan 20, 2011 at 04:58:13PM +0100, Torben Hohn wrote:
>> > > the -rt patches change the console_semaphore to console_mutex.
>> > > so a quite large chunk of the patches changes all
>> > > acquire/release_console_sem() to acquire/release_console_mutex()
>> >
>> > Why not just change the functionality of the existing function to be a
>> > mutex in the rt patches, instead of having to rename it everywhere?
>>
>> i hope that Thomas already did this in his upcoming -rt series.
>>
>> >
>> > > this commit makes things use more neutral function names
>> > > which dont make implications about the underlying lock.
>> > >
>> > > the only real change is the return value of console_trylock
>> > > which is inverted from try_acquire_console_sem()
>> > >
>> > > Signed-off-by: Torben Hohn <torbenh@gmx.de>
>> > > CC: Thomas Gleixner <tglx@tglx.de>
>> >
>> > I don't mind this rename, but is it really going to help anything out?
>> > What's the odds of the -rt portion of this patch ever making it to
>> > mainline?
>>
>> the -rt portion only changes the semaphore to a mutex.
>> since the console_sem is used with mutex semantics, i dont see any
>> reason, not to merge that portion too.
>>
>> i am just trying to shrink the -rt patch to make it more maintanable :)
>>
>
> Yeah, I think it's a better name and if we can indeed switch that
> semaphore to a mutex then that's a good thing to do.

include/linux/mutex.h:

/*
 * NOTE: mutex_trylock() follows the spin_trylock() convention,
 *       not the down_trylock() convention!
 *
 * Returns 1 if the mutex has been acquired successfully, and 0 on contention.
 */
extern int mutex_trylock(struct mutex *lock);

So that's why the return value was inverted (when treating it as a boolean).
I can understand that.

However:

+/**
+ * console_trylock - try to lock the console system for exclusive use.
+ *
+ * Tried to acquire a lock which guarantees that the caller has
+ * exclusive access to the console system and the console_drivers list.
+ *
+ * returns -1 on success, and 0 on failure to acquire the lock.
+ */
+int console_trylock(void)

So this one returns -1 on success, not 1? Why?

Gr{oetje,eeting}s,

? ? ? ? ? ? ? ? ? ? ? ? Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
? ? ? ? ? ? ? ? ? ? ? ? ? ?? ?? -- Linus Torvalds
