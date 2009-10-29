From: dk-arm-linux@gmx.de (Dieter Kiermaier)
Date: Thu, 29 Oct 2009 10:50:34 +0200
Subject: marvell kirkwood / openrd-base kernel freeze on bootup with
	PICe->PCI bridge
In-Reply-To: <20091029093510.4e9a8dde@marrow.netinsight.se>
References: <200910290936.40397.dk-arm-linux@gmx.de>
	<20091029093510.4e9a8dde@marrow.netinsight.se>
Message-ID: <200910290950.34825.dk-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag 29 Oktober 2009 09:35:10 schrieb Simon Kagstrom:

Hi Simon,

> On Thu, 29 Oct 2009 10:36:40 +0200
> Dieter Kiermaier <dk-arm-linux@gmx.de> wrote:
> 
> > Uncompressing Linux............................................................................................................................................................ done.
> > 
> > The PCIe->PCI bridge is a Marvell 88SB2211 evaluation board and I expect it works well - at least it does in all other environments I've tested so far.
> 
> > Please can someone help me to track this down?
> > Some tips how to debug such a problem using openocd are very welcome, too!
> > I'm completely lost in space :(
> 
> Try attaching gdb to it, i.e.,
> 
> 	arm-unknown-linux-gnu-gdb vmlinux
> 
> and then connecting to openocd's GDB remote with
> 
> 	target remote localhost:3333
> 
> After that you can backtrace and examine stuff as you normally do with
> GDB. Remeber to start with nohlt when you use GDB, but I guess you're
> already doing that.

Yes I do.
Ok, sometimes things are more easy than one could think off :)

I've done what you told me:
(gdb) target remote localhost:3333
Remote debugging using localhost:3333
warning: shared library handler failed to enable breakpoint
__delay () at arch/arm/lib/delay.S:44
44                      subs    r0, r0, #1
Current language:  auto; currently asm
(gdb) bt
#0  __delay () at arch/arm/lib/delay.S:44
#1  0xc003b1f4 in panic (fmt=0xdf834000 "\002") at kernel/panic.c:138
#2  0xc003e0fc in do_exit (code=-545054720) at kernel/exit.c:902
#3  0xc002a054 in die (str=0xc042fb58 "", regs=0xdf835e10, err=40)
    at arch/arm/kernel/traps.c:274
#4  0xc002a11c in arm_notify_die (str=0xc040dc94 "Attempted to kill init!",
    regs=0xdf835bbc, info=0xdf835d78, err=3221397788, trap=0)
    at arch/arm/kernel/traps.c:286
#5  0xc002634c in do_DataAbort (addr=4276361468, fsr=40, regs=0xdf835e10)
    at arch/arm/mm/fault.c:524
#6  0xc037440c in __dabt_svc ()
Backtrace stopped: frame did not save the PC
(gdb) 

Could someone see the cause of my freeze?

Dieter



> 
> // Simon
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
