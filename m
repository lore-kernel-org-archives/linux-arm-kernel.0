From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Mar 2012 21:00:20 +0000
Subject: [PATCH 8/8] ARM: tegra: HACK: remove set_irq_flags() from driver
In-Reply-To: <201203012038.28062.arnd@arndb.de>
References: <1330630010-11241-1-git-send-email-alan@signal11.us>
 <1330630010-11241-9-git-send-email-alan@signal11.us>
 <74CDBE0F657A3D45AFBB94109FB122FF17BE86173C@HQMAIL01.nvidia.com>
 <201203012038.28062.arnd@arndb.de>
Message-ID: <20120301210020.GC19274@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2012 at 08:38:27PM +0000, Arnd Bergmann wrote:
> On Thursday 01 March 2012, Stephen Warren wrote:
> > 
> > Alan Ott wrote at Thursday, March 01, 2012 12:27 PM:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > The driver should not call set_irq_flags itself, and
> > 
> > Probably true in this case.
> > 
> > > cannot do this from a loadable module.
> > 
> > I hope that's not true; grep'ing the entire of drivers/ shows a bunch
> > of drivers calling this function, and many look like they'd be reasonable
> > as module.
> 
> The drivers that I can see using it are for the most part implementing
> irq controllers by themselves, which is different from merely using an
> interrupt.
> 
> There are three exceptions today:
> 
> arnd at klappe2:~/linux-arm$ git grep -l set_irq_flags  drivers/ | xargs grep -L irq_chip
> drivers/tty/serial/serial_ks8695.c

Setting NOAUTOEN should be done elsewhere (in platform code.)  Better
still, fixing genirq to allow request_irq() to permit the interrupt
to be requested *without enabling it* would be a step forwards.  I
thought my original ARM IRQ code did that.

> drivers/tty/serial/sirfsoc_uart.c

Same issue, so same comments.

> drivers/usb/host/ehci-tegra.c

This one should not be there.  Having drivers mark IRQs as being
requestable when the whole point of the flag is to stop request_irq()
being used on non-initialized interrupts is just plain stupid.

> > From what little I understand of this, any irq_chip is going to call
> > that function after setting up any child/cascaded IRQs, and I assume
> > that irq_chips can be in modules.
> 
> But the function is not exported. I guess if we want to allow
> irq_chips in loadable modules, we could export it, but I don't see
> how it could ever have worked so far.

genirq does not permit flow handlers in modules - I suspect that's
because it's pretty hard to remove them safely from the system without
a lot of effort.  Certainly, a whole bunch of genirq functions which
are required to implement external flow handlers etc aren't exported.
