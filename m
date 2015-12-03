From: peda@axentia.se (Peter Rosin)
Date: Thu, 3 Dec 2015 21:37:51 +0000
Subject: Domain faults when CONFIG_CPU_SW_DOMAIN_PAN is enabled
In-Reply-To: <20151203172708.GT8644@n2100.arm.linux.org.uk>
References: <1267b061b66c4d1fa8af1955825bc97a@EMAIL.axentia.se>
 <20151203110041.GK8644@n2100.arm.linux.org.uk>
 <f7774151e4a849e682ae5a607a98140b@EMAIL.axentia.se>
 <20151203115143.GM8644@n2100.arm.linux.org.uk>
 <533b0f1f264e42e78b94bbff9570fb50@EMAIL.axentia.se>
 <20151203133727.GN8644@n2100.arm.linux.org.uk>
 <94580382ca344ae2b64f66fb778c6ff7@EMAIL.axentia.se>
 <20151203164118.GR8644@n2100.arm.linux.org.uk>
 <20151203172708.GT8644@n2100.arm.linux.org.uk>
Message-ID: <45b615420548463ebd1d582bc5da2eff@EMAIL.axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote:
> On Thu, Dec 03, 2015 at 04:41:18PM +0000, Russell King - ARM Linux wrote:
> > On Thu, Dec 03, 2015 at 04:12:06PM +0000, Peter Rosin wrote:
> > > * uaccess_with_memcpy.c:__copy_to_user() has a mode in which it copies
> > >   "non-atomically" (if faulthandler_disabled() returns 0). If a fault
> > >   happens during __copy_to_user, what prevents some other thread from
> > >   clobbering DACR?
> > 
> > See the second point above.  Moreover, if we sleep in down_read(),
> > then __switch_to() reads the current DACR value and saves it in the
> > thread information, and will restore that value when resuming the
> > thread - even if the thread has been migrated to a different CPU.
> 
> I thought this was correct, but it isn't - that's what my original solution
> did, but I think when Will reviewed it, we decided it wasn't necessary -
> and it isn't necessary for every single case with the exception of this
> one.  This is exactly what's going wrong: the down_read() in these paths
> calls into the scheduler, which switches away.  When we come back, the
> DACR value is reset by the other thread to 0x51.
> 
> There's a few ways to solve this:
> 
> 1. Make the thread switching code save and restore the DACR register as
>    it would do for domains.  This imposes an overhead on every single
>    context switch whether or not we happen to be in this _single_
>    troublesome code.  (Patch attached - as there's several, I'm attaching
>    them.)
> 
> 2. Add additional code to the uaccess-with-memcpy stuff to reset the
>    DACR value prior to using memcpy() or memset().  (Patch attached.)

I took both patches for a quick spin (a dozen boots and one hour uptime
after that for each patch) and no incidents. I have not gathered data,
but the crash on boot feels like it's quite a bit above 50% when there
is a problem so this feels good (I used 5 clean reboots when I bisected
and that worked).

Reported-by: Peter Rosin <peda@axentia.se>
Tested-by: Peter Rosin <peda@axentia.se>

(and please don't forget to cc stable)

> 3. Make uaccess-with-memcpy depend on !CPU_SW_DOMAINS_PAN (suggested by
>    Will)
> 
> 4. Delete the uaccess-with-memcpy code (also suggested by Will.)
> 
> I think the best thing I can do is say... "Discuss amongst yourselves" :)

I have no personal preference on what should be done, I only had
copy_to_user_memcpy enabled since that was what Atmel fed me.

Cheers,
Peter
