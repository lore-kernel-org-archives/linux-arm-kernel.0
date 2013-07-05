From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 5 Jul 2013 15:19:57 +0200 (CEST)
Subject: hrtimer: one more expiry time overflow check in hrtimer_interrupt
In-Reply-To: <51D6B300.20804@renesas.com>
References: <51B6D4C4.9080400@renesas.com>
 <alpine.DEB.2.02.1306281416080.4013@ionos.tec.linutronix.de>
 <51D6B300.20804@renesas.com>
Message-ID: <alpine.DEB.2.02.1307051516050.32106@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Jul 2013, Shinya Kuribayashi wrote:
> On 6/28/2013 9:22 PM, Thomas Gleixner wrote:
> >> On the other hand, we have another call site of tick_program_event() at
> >> the bottom of hrtimer_interrupt().  The warning this time is triggered
> >> there, so we need to apply the same fix to it.
> > 
> > Well, the problem is that you are just papering over the underlying
> > issue of 32bit systems not being prepared for the year 2038 issue.
> > 
> > Just blindly silencing the warning is not going to make the system
> > survive 2038 in any sane way. All timespec/val related time functions
> > dealing with the clock realtime domain are simply broken in 2038 on
> > 32bit, so it does not matter whether a warning triggers or not.
> 
> You're right.  With this patch applied, the hrtimer_interrupt /looks/
> back to normal, but /proc/timer_list still show that "expires at [in
> negative range]":
> 
>     active timers:
>      #0: tick_cpu_sched, tick_sched_timer, S:01
>      # expires at 50812500000-50812500000 nsecs [in -165398341280 to -165398341280 nsecs]
> 
> This shouldn't happen and something weird is still going on.

I told you :)
 
> > We really need to tackle the underlying problem and not bandaiding a
> > known to be broken system.
> 
> Agreed, but a little bit hard task for me.  This is 100% reproducible,
> so I can help debug / verification.  Please let me know, if necessary.

That will take some time. It's quite a huge change all over the
place. We are aware of that fact and we have ideas how to fix it, but
that won't happen in the near future as we need to discuss the user
space visible changes as well. But we have started to discuss possible
solutions, so this will be solved way before 1.1.2038 :)

Thanks,

	tglx
