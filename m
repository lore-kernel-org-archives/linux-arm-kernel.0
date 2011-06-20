From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Jun 2011 10:34:48 +0200
Subject: Problems with semaphores, mutexes, and atomic?
In-Reply-To: <BANLkTi=U29mWX0E2+8iQqEzDkycDeXS6nA@mail.gmail.com>
References: <BANLkTikwGgrK0FFiee1a8PvDicJa-bUedg@mail.gmail.com>
	<201106201003.06717.arnd@arndb.de>
	<BANLkTi=U29mWX0E2+8iQqEzDkycDeXS6nA@mail.gmail.com>
Message-ID: <201106201034.48753.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 June 2011 10:21:27 Dave Hylands wrote:

> >> DEFINE_SEMAPHORE( thread_wait );
> >
> > DEFINE_SEMAPHORE needs another argument, your code won't compile.
> 
> As far as I can tell, DEFINE_SEMAPHORE takes exactly one argument (I
> checked 2.6.36.3 and 2.6.39)
> http://lxr.linux.no/linux+v2.6.36.3/include/linux/semaphore.h#L29
> 
> My code compiles just fine (no errors, no warnings).

Ah, sorry about that, yes. sema_init() takes two arguments, and I got
confused because hardly anything uses DEFINE_SEMAPHORE these days
as we're removing all semaphores from the kernel in order to deprecate
the API.

> > You should basically never use semaphores anyway.
> 
> The purpose was to test if semaphores were in fact atomic. Semaphores
> have their uses, and I agree, the test code doesn't demonstrate the
> best way to increment a counter, but that's not the intention of the
> test code.

They are atomic. Further inspection of your code shows that your
semaphore never sleeps, because you only ever down() it once.

> > In order to wait
> > for a kthread to finish, use kthread_stop(). Do not use a semaphore
> > when you want a mutex.
> 
> That doesn't make sense. I don't want to stop the child thread, I want
> to wait until it's finished.

But in your example, the kthread doesn't ever check kthread_should_stop(),
so kthread_stop is not stopping it at all, it just waits for it to complete.
This simple example (where the kthread doesn't stop) would be better
served by a work queue (schedule_work) than a kthread, however.

> If I were to put checks in the loop with calls to kthread_should_stop,
> then calling kthread_stop would make the thread stop early, which is
> not what I'm trying to do. What I wanted was something equivalent to
> pthread_join in user space, and the kthread_api doesn't appear to
> offer any function with that functionality.

That is what is commonly called a completion. You initialize it
before you hand off code to the other thread and then call
complete() in the other thread, but wait_for_completion() in the
waiter. This is of course what kthread_stop does internally,
besides setting the should_stop variable(). You might argue
that it would be good to also have a kthread_wait() function that
does the same as kthread_stop() without setting that bit.

Feel free to submit a patch for that if you can identify a few
drivers that would benefit from that interface.

> I don't see how you could use a mutex to achieve the same thing.
> 
> I agree that kthread_stop would have worked in this particular
> instance, but I really consider that to be a misuse of the function,
> and it certainly wouldn't work in the general case.

Using a semaphore instead of a completion is also a misuse ;-)

	Arnd
