From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 17 Jul 2013 14:11:18 -0600
Subject: preempted dup_mm misses TLB invalidate
In-Reply-To: <20130717200137.GT24642@n2100.arm.linux.org.uk>
References: <51E43D2B.9090709@nvidia.com>
 <20130717192746.GE16496@MacBook-Pro.local> <51E6F60D.6060804@wwwdotorg.org>
 <20130717200137.GT24642@n2100.arm.linux.org.uk>
Message-ID: <51E6FA66.7060001@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17/2013 02:01 PM, Russell King - ARM Linux wrote:
> On Wed, Jul 17, 2013 at 01:52:45PM -0600, Stephen Warren wrote:
>> Hmmm. That sounds like a plausible explanation, but I'm not convinced
>> it's true.
>>
>> I would guess that the only way to prevent threads of an application
>> from writing to its memory while a fork() happens in another thread is
>> to prevent those threads from running at all; almost any code is going
>> to do some writes e.g. to the stack at least. That would imply the
>> kernel must prevent the scheduling of the other threads, not the
>> user-space application.
>>
>> I quickly searched and couldn't see anything that agreed with your
>> statement about this being a user-space bug. There are plenty of
>> articles pointing out potential problems if a threaded app forks, but I
>> didn't see anything that said it's no legal. I also note that pthreads
>> explicitly specifies what happens if a threaded app forks (just the
>> thread calling fork is duplicated into the child process), what
>> functions can be called after a fork ("async-safe" functions), and the
>> function pthread_at_fork() exists, all of which tend to imply that
>> forking-and-threading can be legally used together.
> 
> Yes, everything which you've said above is true, but if you read the
> discussions on pthread_atfork(), you'll see that the whole notion that
> you can somehow synchronize state for a fork() is a complete dead loss -
> and pthread_atfork() is a pile of trash.
> 
> Semaphores must be released in the same thread as the thread which
> acquired them.  If you take a semaphore in the pre-fork handler, and
> release it in the parent post-fork handler, you can't legally release
> it in the child post-fork handler because the child didn't acquire it!
> 
> What that means is that you can't be holding any semaphores when a
> thread forks.  Remember that a thread ends up with a complete copy of
> the VM space, semaphores and all in whatever state they were in _all_
> the threads the moment when the fork happened.
> 
> Really, the only legal thing for a threaded process to do with fork()
> is to immediately follow it with exec*() without doing anything else
> with any pthread state (or any function which touches any pthread
> state).  That much must work correctly - and if it doesn't, then we
> definitely have a bug.

Yes, there are definitely issues mixing threads and forking.

But I think the issue that Nickolas reported can be reproduced by a
threaded application doing nothing but fork() followed by an exec() in
the child, assuming that another thread in the parent process touches
memory (e.g. stack) between the "fork()" and exec() in the child, which
seems pretty likely unless the kernel itself prevents it.
