From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Feb 2012 16:22:50 +0000
Subject: In many cases softlockup can not be reported after disabling
 IRQ for long time
In-Reply-To: <20120202155841.GO5650@redhat.com>
References: <CAOwKts8zS1rYA+Y4k-vb8YAaR=aFd1BwryhhWWnWLQyrYrNqyA@mail.gmail.com>
 <20120131154748.GA5650@redhat.com>
 <CAOwKts_dTvc4LiCZUXN9oYzty1pkDEn_VQwPKY=EoVzk0n6tFA@mail.gmail.com>
 <20120201145802.GF5650@redhat.com>
 <CAOwKts8S0EkUGcP3rYqZe+HdvyXD0+SR1f_3xWpu5FprKWuGhQ@mail.gmail.com>
 <20120202155841.GO5650@redhat.com>
Message-ID: <20120202162250.GE1275@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 10:58:41AM -0500, Don Zickus wrote:
> The only thing I can think of is that the clock/jiffies isn't updated
> until after the hrtimer is run.  I'm not sure if there is any guarantee
> for ordering once interrupts are enabled.
> 
> But that is just a guess.
> 
> I guess in theory, I would expect that when interrupts are enabled, the
> system would immediately jump into an IRQ context, update the
> clock/jiffies, then run all the other irq handlers like hrtimers, which
> would see the new time and do the right thing.  After everything is done,
> the system would return to your test code and re-enable preemption
> allowing the softlockup thread to run again.
> 
> I could be very wrong though. :-)

The first thing to confirm is whether disabling interrupts for 10s
results in the system losing proper track of time.  If it does, then
you've immediately found the problem.

So, what you need to do us to use /usr/bin/time to execute a userspace
command which causes your thread to simulate a soft-lockup.  If you
arrange for your soft-lockup to last for (eg) exactly 10 seconds, and
/usr/bin/time reports less than 10 seconds have passed, you've found
why the system can't report it.
