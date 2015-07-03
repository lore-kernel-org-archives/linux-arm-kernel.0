From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 3 Jul 2015 11:23:12 +0200 (CEST)
Subject: Possible regression due to "tick: broadcast: Prevent livelock
 from event handler"
In-Reply-To: <CAMuHMdW_JxdN9Bb3aii2rcrgS2Jbvmj3PmyDE-9LjN18rfKTTw@mail.gmail.com>
References: <20150703024044.GB24695@verge.net.au>
 <CAMuHMdW_JxdN9Bb3aii2rcrgS2Jbvmj3PmyDE-9LjN18rfKTTw@mail.gmail.com>
Message-ID: <alpine.DEB.2.11.1507031041570.3916@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 3 Jul 2015, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Fri, Jul 3, 2015 at 4:40 AM, Simon Horman <horms@verge.net.au> wrote:
> > I have observed what appears to be a regression while testing next-20150702
> > which seems to be caused by 2951d5c031a3 ("tick: broadcast: Prevent
> > livelock from event handler").
> >
> > The problem manifests on the emev2/kzm9d board as per the boot log below.
> >
> > The problem manifests when booting using the shmobile_defconfig,
> > which uses multiplatform and enables all devices using DT.
> >
> > The problem does not appear to always manifest but anecdotally it
> > seems to manifest more often of late (yes, I know that is vague).
> 
> > hctosys: unable to open rtc device (rtc0)
> >
> > The boot hangs here.
> > The next line should be:
> >
> > smsc911x 20000000.ethernet eth0: SMSC911x/921x identified at 0xc8880000, IRQ: 33
> 
> As you can reproduce it, can you please try enabling lockdep debugging?

Just looking at the em_sti driver. It calls clk_prepare/unprepare from
interrupt disabled regions ...

But that's not the problem at hand I think. The above commit is moving
the call to the event handler on the local cpu out of the broadcast
lock region to prevent a live lock. The only real change is the
timing.

Before:

	bc_handler()
	  lock(bc_lock);
	  call_local_handler();
	  send_ipis();
	  reprogramm_bc_device();
	  unlock(bc_lock);

After:

	bc_handler()
	  lock(bc_lock);
	  send_ipis();
	  reprogramm_bc_device();
	  unlock(bc_lock);
	  call_local_handler();

As this runs in hard interrupt context with interrupts disabled, I
really cannot figure out how that makes a difference.

Can you add some debugging to figure out whether the broadcast timer
interrupt still fires?

Thanks,

	tglx
