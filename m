From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Oct 2010 21:45:30 +0200
Subject: [PATCH] serial: DCC(JTAG) serial and console emulation support
In-Reply-To: <1286993315.28336.10.camel@c-dwalke-linux.qualcomm.com>
References: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
	<201010131944.54135.arnd@arndb.de>
	<1286993315.28336.10.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <201010132145.30550.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 October 2010 20:08:35 Daniel Walker wrote:
> On Wed, 2010-10-13 at 19:44 +0200, Arnd Bergmann wrote:
> > On Wednesday 13 October 2010 18:17:03 Daniel Walker wrote:
> > > > I think you would be much better off making it a "hvc" driver, where
> > > > you just need to provide a read character and write character function
> > > > and an optional interrupt handler but otherwise have the common hvc
> > > > code take care of polling the hardware and talking to the tty layer.
> > > 
> > > I don't know what the "hvc" driver is "Hypervisor Virtual Console"
> > > maybe?
> > 
> > Yes, it originally was used only on hypervisors that had simple
> > read/write type consoles, but has now turned into a generic facility
> > that is used by a number of consoles that don't look like classic
> > serial ports.
> > 
> > > Can you give any sort of example driver which does what you
> > > suggesting?
> > 
> > Look at drivers/char/hvc_tile.c for the simplest case or
> > drivers/char/hvc_vio.c for one that uses interrupts.
> 
> I found it independently actually .. It looks like there's at least two
> problems. This jtag driver has a status register which flags when RX is
> available, and TX is possible. I'm not sure this status register fits
> into the model.

I think that is how they all work. The read/write functions simply return
the number of characters transferred, which may be zero if the output
is busy or the input is empty.

> The other thing is that we have a ttyJ registered for
> this driver, and it would be nice to use that over something like ttyHVC
> (I'm not sure if that name is correct, just a guess).

It's hvc0, but I don't see this as a problem because the driver was never
upstream before -- you don't really get to complain about compatibility
with out-of-tree code :-)

Seriously, I don't think you need it, but if you really do, we can probably
find a way to work around this by changing the base hvc driver.

	Arnd
