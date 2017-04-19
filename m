From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Apr 2017 10:31:05 +0100
Subject: Panic in arch_hw_breakpoint_init() on Cortex-A9 (SPEAr1340)
In-Reply-To: <1492535481.28092.14.camel@v3.sk>
References: <1492512268.28092.8.camel@v3.sk>
 <20170418130326.GE17866@leverpostej>
 <1492535481.28092.14.camel@v3.sk>
Message-ID: <20170419093105.GD27829@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 07:11:21PM +0200, Lubomir Rintel wrote:
> On Tue, 2017-04-18 at 14:03 +0100, Mark Rutland wrote:
> > On Tue, Apr 18, 2017 at 12:44:28PM +0200, Lubomir Rintel wrote:
> > > I'm getting a crash that looks awfully lot like what ddc37832a1 [ARM:
> > > 8634/1: hw_breakpoint: blacklist Scorpion CPUs] aims to fix.
> > 
> > Just to check, have you successfully booted a kernel on this board
> > before? i.e. is this a new crash?
> 
> I've now checked, and it doesn't seem like it ever worked when
> PERF_EVENTS (and in turn HAVE_HW_BREAKPOINT) is enabled. The crash look
> the same up to 4.7; the previous versions also crash as soon as I
> enable the options but for some reason I don't get an oops on the
> console even with earlyprintk enabled (the machine reboots with panic=
> argument, so there's just possibly just something wrong with the
> console).

Ok. So this isn't a recent regression.

> > > My hardware doesn't use a Scorpion CPU though -- it uses a Cortex-A9
> > > (cpuid=0x412fc091).
> > > 
> > > [????0.157000] Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
> > > [????0.157000] Modules linked in:
> > > [????0.157000] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.11.0-0.rc3.git0.2.spear2.fc26.armv7hl #1
> > > [????0.157000] Hardware name: ST SPEAr1340 SoC with Flattened Device Tree
> > > [????0.157000] task: ef102b80 task.stack: ef0fa000
> > > [????0.157000] PC is at arch_hw_breakpoint_init+0x130/0x2a0
> > > [????0.157000] LR is at arch_hw_breakpoint_init+0x7c/0x2a0
> > > [????0.157000] pc : [<c0e0538c>]????lr : [<c0e052d8>]????psr: 60000013
> > 
> > It would be helpful to know which specific access that is.
> > 
> > Can you figure that out with addr2line, e.g.
> > 
> > ?$ addr2line -ife vmlinux c0e0538c
> 
> Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.11.0-rc7 #21
> Hardware name: ST SPEAr1340 SoC with Flattened Device Tree
> task: ef058000 task.stack: ef04c000
> PC is at arch_hw_breakpoint_init+0x9c/0x2a4
> LR is at arch_hw_breakpoint_init+0x84/0x2a4
> pc : [<c0905504>]????lr : [<c09054ec>]????psr: 60000013
> 
> $ addr2line -ife vmlinux c0905504
> core_has_os_save_restore
> /home/lkundrak/spear/linux/arch/arm/kernel/hw_breakpoint.c:920

That's a read of DBGOSLSR, which shouldn't UNDEF.

I suspect this is a result of Cortex-A9 erratum 764319, which causes
DBGOSLSR to unexpectedly behave as UNDEF when the external DBGSWENABLE
pin is wired to 0.

The official workaround is to ensure that the DBGSWENABLE pin is wired
to 1.

It might be possible to handle the trap and bail out, but it's not clear
to me if we can safely assume that other functionality is available.

Thanks,
Mark.
