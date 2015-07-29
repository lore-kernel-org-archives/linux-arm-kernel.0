From: horms@verge.net.au (Simon Horman)
Date: Wed, 29 Jul 2015 11:23:48 +0900
Subject: Possible regression due to "tick: broadcast: Prevent livelock
 from event handler"
In-Reply-To: <alpine.DEB.2.11.1507031640060.3916@nanos>
References: <20150703024044.GB24695@verge.net.au>
 <20150703105441.GF1521@katana>
 <alpine.DEB.2.11.1507031511180.3916@nanos>
 <20150703133245.GA19284@katana>
 <alpine.DEB.2.11.1507031612410.3916@nanos>
 <20150703143703.GB19284@katana>
 <alpine.DEB.2.11.1507031640060.3916@nanos>
Message-ID: <20150729022348.GA13360@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Fri, Jul 03, 2015 at 04:53:49PM +0200, Thomas Gleixner wrote:
> On Fri, 3 Jul 2015, Wolfram Sang wrote:
> > > So this is a single core machine and uses the em_sti timer w/o the
> > > broadcast nonsense. In Simons case it looks like em_sti is used as
> > > broadcast device.
> > 
> > We use the same board. Just my kernel has SMP=n.
> > 
> > > Though the issues you see in the highres=n case might be the same as
> > > the ones Simon is observing.
> > 
> > I hope so. One good thing about the issue I see is that it is 100%
> > reproducable.
> > 
> > > So in that nohz=y highres=n case, does adding idle=poll on the command
> > > line fix the issue?
> > 
> > Nope, still hangs.
> 
> Ok. So it's unrelated to deep idle states. Any chance of poking with
> JTAG at the frozen box? If not, are there GPIOs which you could use to
> monitor certain state?

Sorry for the delay, it has taken me a while to secure a JTAG.

I now have one hooked up to my emev2/kzm9d board; though I must
confess I am not at all experienced in driving it.

As far as I can tell, and to be quite honest I would not be at all
surprised if I am mistaken, the CPUs are sitting here:

pc: 0xC001F7E8, which corresponds to cpu_v7_do_idle

Hooking up GDB I see:

#0  cpu_v7_do_idle () at arch/arm/mm/proc-v7.S:74
#1  0xc0010734 in arch_cpu_idle () at arch/arm/kernel/process.c:72
#2  0xc04c406c in schedule_preempt_disabled () at kernel/sched/core.c:3115
#3  0xc0055130 in cpu_idle_loop () at kernel/sched/idle.c:279
#4  cpu_startup_entry (state=CPUHP_OFFLINE) at kernel/sched/idle.c:301
#5  0xc04bf440 in rest_init () at init/main.c:412
#6  0xc061bc6c in start_kernel () at init/main.c:683
#7  0x4000807c in ?? ()


I am using the renesas-devel-20150729-v4.2-rc4 tag of the my renesas tree
which, as the name suggests, is based on v4.2-rc4.
