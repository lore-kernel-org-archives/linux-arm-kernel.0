From: dhylands@gmail.com (Dave Hylands)
Date: Mon, 20 Jun 2011 02:07:31 -0700
Subject: Problems with semaphores, mutexes, and atomic?
In-Reply-To: <201106201034.48753.arnd@arndb.de>
References: <BANLkTikwGgrK0FFiee1a8PvDicJa-bUedg@mail.gmail.com>
	<201106201003.06717.arnd@arndb.de>
	<BANLkTi=U29mWX0E2+8iQqEzDkycDeXS6nA@mail.gmail.com>
	<201106201034.48753.arnd@arndb.de>
Message-ID: <BANLkTinLv_5QJjLbbHuXez=w88wY082Zww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Jun 20, 2011 at 1:34 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 20 June 2011 10:21:27 Dave Hylands wrote:
...snip...
>> The purpose was to test if semaphores were in fact atomic. Semaphores
>> have their uses, and I agree, the test code doesn't demonstrate the
>> best way to increment a counter, but that's not the intention of the
>> test code.
>
> They are atomic. Further inspection of your code shows that your
> semaphore never sleeps, because you only ever down() it once.

So I was using the "implement a mutex using a semaphore". Since there
are upto 100 threads running, some of them will sleep on the down. The
real issues was discovered by Russell. I was missing a down on the
thread_wait, since DEFINE_SEMAPHORE initializes the semaphore with a
count of 1, which my code wasn't compensating for.

>> > In order to wait
>> > for a kthread to finish, use kthread_stop(). Do not use a semaphore
>> > when you want a mutex.
>>
>> That doesn't make sense. I don't want to stop the child thread, I want
>> to wait until it's finished.
>
> But in your example, the kthread doesn't ever check kthread_should_stop(),
> so kthread_stop is not stopping it at all, it just waits for it to complete.
> This simple example (where the kthread doesn't stop) would be better
> served by a work queue (schedule_work) than a kthread, however.
>
>> If I were to put checks in the loop with calls to kthread_should_stop,
>> then calling kthread_stop would make the thread stop early, which is
>> not what I'm trying to do. What I wanted was something equivalent to
>> pthread_join in user space, and the kthread_api doesn't appear to
>> offer any function with that functionality.
>
> That is what is commonly called a completion. You initialize it
> before you hand off code to the other thread and then call
> complete() in the other thread, but wait_for_completion() in the
> waiter. This is of course what kthread_stop does internally,
> besides setting the should_stop variable(). You might argue
> that it would be good to also have a kthread_wait() function that
> does the same as kthread_stop() without setting that bit.

So in order to use completions, I would have had to create one
completion per thread, whereas using a semaphore, I only had to create
one semaphore period.

> Feel free to submit a patch for that if you can identify a few
> drivers that would benefit from that interface.

Right now, I don't have any examples, and even my example was
contrived, as it was just to write some test code to verify that
nothing funny was going on.

>> I don't see how you could use a mutex to achieve the same thing.
>>
>> I agree that kthread_stop would have worked in this particular
>> instance, but I really consider that to be a misuse of the function,
>> and it certainly wouldn't work in the general case.
>
> Using a semaphore instead of a completion is also a misuse ;-)

Yeah - I could agree with that. When I wrote the code, using
completions never really occurred to me, even though that's what I
normally use when waiting for something like a DMA to finish.

I'm happy to discover it was a bug in my test code and not a bug in
the kernel. I apologize for wasting everybody's time.

-- 
Dave Hylands
Shuswap, BC, Canada
http://www.davehylands.com
