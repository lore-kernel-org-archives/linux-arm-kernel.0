From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Nov 2012 21:00:56 +0000
Subject: ARM: idle sleep time for hotplugged cpu
In-Reply-To: <509971F4.4060604@codeaurora.org>
References: <50973842.9010708@codeaurora.org>
 <20121105091533.GB28327@n2100.arm.linux.org.uk>
 <509971F4.4060604@codeaurora.org>
Message-ID: <20121106210056.GC32398@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2012 at 12:24:20PM -0800, Steve Muckle wrote:
> On 11/05/12 01:15, Russell King - ARM Linux wrote:
> > On Mon, Nov 05, 2012 at 09:23:38AM +0530, Taniya Das wrote:
> >> I was looking at the arch/arm/process.c:cpu_die, I was wondering why we
> >> do not exit from NOHZ for a hotplugged/offline cpu?
> > 
> > Offlined CPUs are not supposed to just 'return' from cpu_die(), and
> > in actual fact they can't.
> 
> Although an offline CPU will not come back into the idle thread by
> returning from cpu_die(), I believe the question about exiting nohz mode
> before cpu_die() still stands.

Well, that depends on the design of all that.  I don't know that, but
what I do know is we're doing exactly the same as x86 which I presume
is correct.

> >From arch/arm/process.c:cpu_idle() it appears a CPU could enter
> pm_idle() for a while (in nohz mode), then execute the inner loop again
> and call cpu_die(). Is there the potential for cpu idle time accounting
> to get messed up here by not exiting nohz mode prior to the cpu dying,
> so that missed ticks from nohz are properly accounted for?

Why does the idle time matter if the CPU has been taken offline?

In any case, I think this is a question for the CPU idle people; it's not
a feature that I've ever knowingly used or have any interest in using at
the moment.
