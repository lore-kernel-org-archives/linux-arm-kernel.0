From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Mar 2011 10:46:48 -0000
Subject: Single-stepping ARMv7 with KDB...
In-Reply-To: <AANLkTim3uhH-LwM=-cx7CjRvCKSt3doeo9BiPXjFAYd0@mail.gmail.com>
References: <AANLkTimBAm-Eaordw-KSPnEycQYz2z4QM+Dc5nauLFxh@mail.gmail.com>	<766766263404232078@unknownmsgid>	<AANLkTikL0KUdY5Ggv1BRfRQiwxyd9B6ooMXT2rPoVAxA@mail.gmail.com>	<8808174326287130926@unknownmsgid>
	<AANLkTim3uhH-LwM=-cx7CjRvCKSt3doeo9BiPXjFAYd0@mail.gmail.com>
Message-ID: <002e01cbe947$9ca32b00$d5e98100$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > At the moment monitor mode is enabled all of the time, so you might
> > want to add a thread flag when a thread is using hardware debugging
> > resources. You can check that on return to userspace and enable monitor
> > mode only then (I'm not sure about your ABT trick, need to check the
> > docs). There will still be places in the hardware breakpoint code where
> > we need monitor mode enabled so you'll need to bank any mismatch
> > breakpoints over these regions of code and disable monitor mode before
> > reinstalling them again.
> >
> 
> I had an ugly proof-of-concept that worked on a Cortex A9 (more or
> less...as long as you didn't step on clrex/strex or used Thumb code).
> I guess I mostly thought people would be averse to adding
> exit-through-ABT code, but there isn't really a better way to
> otherwise be able to step through most of the Linux kernel from KDB
> (that I am aware of), and it would be conditionally compiled if KDB
> support is enabled.

Yes, the ABT stuff is fairly horrible. It also won't work for v6 cores,
which we do support in the hw-breakpoint layer.
 
> If you look on Cortex A9 TRM (10.3.3), the SP [2:1] field in the BRC
> register let's you condition the breakpoint for either USR/SVC/SYS,
> SVC/SYS, USR or 'any'. 'any' is not  usable outside of halting mode
> for single-stepping purposes, so USR/SVC/SYS it is, and it's not so
> bad - you lose the ability to trace the little bit of exception code
> that runs before switching to SVC, as well as FIQ handlers, but I feel
> that's pretty minor.
> 
> > Note that enabling monitor mode is pretty error prone and might not
> > even be possible on your CPU so the failure path needs to be graceful.
> 
> Toggling it is not a good idea, then, especially since you still want
> other active break/watch-points to trigger, so I would just reserve a
> BRC/BRV pair if KDB was compiled in and bank the values...

I'm not sure. Toggling does offer some advantages if you only do it on
entry/exit from a debug exception (there's already some code to disable
preemption here). You can also use the thread flag to make sure we only
do the horrible ABT trick if the task we are returning to is indeed being
debugged.

However, I'm not convinced this is worth the hassle...

Will
