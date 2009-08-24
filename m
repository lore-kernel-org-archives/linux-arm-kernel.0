From: marco.hoefle@nanotronic.ch (hoefle marco)
Date: Mon, 24 Aug 2009 12:53:24 +0200
Subject: i.MX35 Kernel without ARM EABI support  cannot execute init
In-Reply-To: <20090824101739.GH29655@pengutronix.de>
References: <1250865435.17931.20.camel@wks02-lin.nanotronic.local>
	<20090824101739.GH29655@pengutronix.de>
Message-ID: <1251111204.4782.138.camel@wks02-lin.nanotronic.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Marco,
> 
> On Fri, Aug 21, 2009 at 04:37:15PM +0200, hoefle marco wrote:
> > right now we have two ARM boards and two embedded linux distributions
> > (Emdebian and OSELAS). The CPUs are PXA270 and Freescale i.MX35. The
> > aim is to have emdebian on both boards.
> 
> Why? :-)

Because the aim is to have one linux distribution for all projects
(independent from the CPU). Also the emdebian package administration is
quite handy and identical to the "PC Debian".

> 
> > When trying to boot the i.MX35 Kernel (with ARM EABI or without, the
> > kernel panic remains exactly the same) using the emdebian rootfs I get
> > this:
> >
> > Kernel panic - not syncing: Attempted to kill init!
> > Backtrace:
> > [<c0026430>] (dump_backtrace+0x0/0x10c) from [<c02515dc>] (dump_stack
> > +0x18/0x1c)
> >  r7:c7817f54 r6:c7813c40 r5:c7813c40 r4:00000004
> > [<c02515c4>] (dump_stack+0x0/0x1c) from [<c025161c>] (panic+0x3c/0x110)
> > [<c02515e0>] (panic+0x0/0x110) from [<c0034a14>] (do_exit+0x6c/0x5b8)
> >  r3:c0301bd4 r2:c7813c40 r1:c7817d14 r0:c02b478a
> > [<c00349a8>] (do_exit+0x0/0x5b8) from [<c0034fe0>] (do_group_exit
> > +0x80/0xb4)
> > [<c0034f60>] (do_group_exit+0x0/0xb4) from [<c003ea60>]
> > (get_signal_to_deliver+0x2c0/0x2f0)
> >  r4:00000004
> > [<c003e7a0>] (get_signal_to_deliver+0x0/0x2f0) from [<c0024ecc>]
> > (do_signal+0x58/0x4e4)
> > [<c0024e74>] (do_signal+0x0/0x4e4) from [<c0025384>] (do_notify_resume
> > +0x2c/0x30)
> > [<c0025358>] (do_notify_resume+0x0/0x30) from [<c0022dac>] (work_pending
> > +0x1c/0x20)
> >
> > The PXA270 kernel (same settings except ARM system type and ARM EABI
> > disabled) boots the emdebian root file-system successfully.
> >
> > The i.MX35 Kernel boots with ARM EABI support the OSELAS file-system.
> > Both Kernels are version 2.6.30.4 and were compiled with the same
> > arm-linux-gnu-gcc compiler.
> >
> > >From my understanding it should be possible to use the same root
> > file-system on both CPUs.
> >
> > Has anybody an idea why this is not working?
> 
> Are you sure your toolchains generate the right code for your CPUs? If
> you want to have root fs for both, PXA270 and i.MX35, you probably need
> an ARMv4 Toolchain. Unfortunately, your "arm-linux-gnu-gcc" compiler
> name doesn't suggest anything about what code this compiler generates.
If I compile the kernel with the debian "arm-linux-gnu-gcc" compiler and the kernel has enabled ARM EABI
the OSELAS root filesystem still boots.

The emdebian Busybox was also compiled with that compiler. I don't see a
reason why this Kernel panic occurs. 

> If you use the OSELAS.BSP from Phytec which was made for the i.MX35, it
> was probably made with an ARM1136EJ-S compiler and builds optimized code
> for that CPU.
> 
> However, within PTXdist / OSELAS.BSP one can build either specialized
> platforms for each of the CPUs (which basically means that you get a
> separate set of ipkg archives for each cpu) or use a "least common"
> v4t toolchain.
> 
> rsc
