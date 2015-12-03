From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 03 Dec 2015 13:28:12 -0500 (EST)
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
Message-ID: <alpine.LFD.2.20.1512031318580.7560@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Dec 2015, Russell King - ARM Linux wrote:

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
> 
> 3. Make uaccess-with-memcpy depend on !CPU_SW_DOMAINS_PAN (suggested by
>    Will)
> 
> 4. Delete the uaccess-with-memcpy code (also suggested by Will.)
> 
> I think the best thing I can do is say... "Discuss amongst yourselves" :)

Personally, I'd advocate for #2 or #4.  Prior commit 0f64b247e6 I was 
already leaning towards #4.

So if some people are still relying on uaccess-with-memcpy and #2 fixes 
it then it's all good.  I'd suggest surrounding the DACR accesses with 
#ifdef CONFIG_CPU_SW_DOMAIN_PAN in the final patch.


Nicolas
