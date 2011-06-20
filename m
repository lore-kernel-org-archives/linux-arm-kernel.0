From: dhylands@gmail.com (Dave Hylands)
Date: Mon, 20 Jun 2011 01:21:27 -0700
Subject: Problems with semaphores, mutexes, and atomic?
In-Reply-To: <201106201003.06717.arnd@arndb.de>
References: <BANLkTikwGgrK0FFiee1a8PvDicJa-bUedg@mail.gmail.com>
	<BANLkTimDcPWOwEMxdZdPyJdYx7KLGZn2wg@mail.gmail.com>
	<BANLkTimwzhucvub7ZXymxt2H5xVq=MYPvw@mail.gmail.com>
	<201106201003.06717.arnd@arndb.de>
Message-ID: <BANLkTi=U29mWX0E2+8iQqEzDkycDeXS6nA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Jun 20, 2011 at 1:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 20 June 2011 09:44:16 Dave Hylands wrote:
>> On Mon, Jun 20, 2011 at 12:20 AM, saeed bishara <saeed.bishara@gmail.com> wrote:
>> > On Mon, Jun 20, 2011 at 9:39 AM, Dave Hylands <dhylands@gmail.com> wrote:
>> >> Hi,
>> >>
>> >> I wrote a small test module to test semaphores, mutexes and atomic
>> >> increments, and I've tested it with CONFIG_SMP=y with 1 and 2
>> >> processors and with CONFIG_SMP disabled.
>> >>
>> >> My test code can be found here:
>> >> http://svn.hylands.org/linux/test-mutex/test-mutex.c
>> >> (it's about 133 lines long).
>> > yout code is not complete, the DEFINE_SEMAPHORE and DEFINE_SEMAPHORE
>> > definitions are missing
>>
>> I don't follow. Line 7 & 8 has
>>
>> DEFINE_MUTEX( lock );
>> DEFINE_SEMAPHORE( sem_lock );
>>
>> and line 19 has
>>
>> DEFINE_SEMAPHORE( thread_wait );
>
> DEFINE_SEMAPHORE needs another argument, your code won't compile.

As far as I can tell, DEFINE_SEMAPHORE takes exactly one argument (I
checked 2.6.36.3 and 2.6.39)
http://lxr.linux.no/linux+v2.6.36.3/include/linux/semaphore.h#L29

My code compiles just fine (no errors, no warnings).

> You should basically never use semaphores anyway.

The purpose was to test if semaphores were in fact atomic. Semaphores
have their uses, and I agree, the test code doesn't demonstrate the
best way to increment a counter, but that's not the intention of the
test code.

> In order to wait
> for a kthread to finish, use kthread_stop(). Do not use a semaphore
> when you want a mutex.

That doesn't make sense. I don't want to stop the child thread, I want
to wait until it's finished.

If I were to put checks in the loop with calls to kthread_should_stop,
then calling kthread_stop would make the thread stop early, which is
not what I'm trying to do. What I wanted was something equivalent to
pthread_join in user space, and the kthread_api doesn't appear to
offer any function with that functionality.

I don't see how you could use a mutex to achieve the same thing.

I agree that kthread_stop would have worked in this particular
instance, but I really consider that to be a misuse of the function,
and it certainly wouldn't work in the general case.

-- 
Dave Hylands
Shuswap, BC, Canada
http://www.davehylands.com
