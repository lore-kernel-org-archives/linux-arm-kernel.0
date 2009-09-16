From: jamessteward@optusnet.com.au (James)
Date: Thu, 17 Sep 2009 08:54:44 +1000
Subject: [arm-gnu] Problems with pthread on ARM/PXA270
In-Reply-To: <200909160926.02036.schindele@nentec.de>
References: <200909160926.02036.schindele@nentec.de>
Message-ID: <1253141684.6443.27.camel@Ubuntu-Desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2009-09-16 at 09:26 +0200, Juergen Schindele wrote:
> we tried to implement a thread based software on our PXA270 based platform but
> we had trouble with pthreads. So i modyfied a tiny progam to test. This little progam creates
> 10 threads and each thread does print something (an index an a pointer to itself). 
> 
> On my PC with Suse 11.0 Linux (kernel 2.6.27) this works fine as supposed to.
> Each thread has his turn and print his own values.
> 
> But on our pxa270 platform the thread switch does not (or really rarely) happen
> and only one thread is printing always the same values. So i suppose thread
> switching is not working!
> 
> Any hints or experiences are welcome !!!

I'm not a very thread aware programmer so please don't shoot me, but I
was wondering, why would a thread give up control after printing its
values?  Your program has them doing a tight loop with no sleep, or
yield.

I added a usleep(1) just after the printf("Thread...."), and the results
on my Linux Ubuntu-Desktop 2.6.24-24-generic #1 SMP Tue Aug 18 17:04:53
UTC 2009 i686 GNU/Linux are much better, but still not one message per
thread.  I changed the usleep to a sched_yield() and got still better
results, but still not what I'd expect from RR.

So what does it look like on your Suse box?  Do you get one message per
thread in turn?  I.e.
Thread 0 is [...]
Thread 1 is [...]
Thread 2 is [...]
Thread 3 is [...]
etc.?

Or do you get, say, 100 messages from thread 0, then 100 from thread 1,
etc.?

Are you running with superuser privileges?  My manpage tells me that
SCHED_RR is only available if run with superuser privileges.

Out of curiosity, I got rid of the printf in the thread, and added a
global array of ints, as in int counter[NUM_THREADS];  Then made the
threads increment their counter each loop, and got the main while loop
to print the counter values.

Without a sched_yield() or usleep() in the thread loop, the values
increase at a phenomenal rate.  With a sched_yield() the values increase
at about 1/100th the speed.

I once had some interesting problems running a program with just two
threads, one doing I/O to an ISA bus, the other handling a socket
interface, on a dual core machine.  To get more predictable performance,
I ended up building a single threaded program and using select for the
whole lot, thereby implementing my own scheduling policy, effectively.

In any case, I think there's more going on with threads than meets the
eye.  IMHO, they're evil, and should be left for Bill's programmers, who
are sadly bound to using them due to the lack of better ways on that
platform ;-)

Regards,
James.
