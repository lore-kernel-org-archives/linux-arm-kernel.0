From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 7 Mar 2012 21:05:15 +0100
Subject: [PATCH 06/14] ARM: kirkwood: convert uart0 to devicetree.
In-Reply-To: <20120307192723.GE5050@titan.lakedaemon.net>
References: <cover.1331090356.git.jason@lakedaemon.net>
 <80fb8cef577eee14364e95009f7a590fd9056ee3.1331090356.git.jason@lakedaemon.net>
 <201203071831.31738.arnd@arndb.de>
 <20120307192723.GE5050@titan.lakedaemon.net>
Message-ID: <20120307200515.GC18513@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2012 at 02:27:23PM -0500, Jason wrote:
> On Wed, Mar 07, 2012 at 06:31:31PM +0000, Arnd Bergmann wrote:
> > On Wednesday 07 March 2012, Jason Cooper wrote:
> > > +       serial at f1012000 {
> > > +               compatible = "ns16550a";
> > > +               reg = <0xf1012000 0xff>;
> > > +               reg-shift = <2>;
> > > +               interrupts = <33>;
> > > +               clock-frequency = <200000000>;
> > > +       };
> > 
> > I just noticed that the length here should be inclusive, i.e. 0x100 not 0xff.
> > This is different from the way we define resources in Linux.
> 
> Grrr.  Now I'm getting frustrated.  I'm trying to boot without
> earlyprintk.  Evidently, something is wrong with the above, because the
> device boots all the way up (blinky lights come on), but I get no
> messages after the usual "Uncompressing Linux... done, booting the
> kernel."

Hi Jason

What do you see in /proc/iomem?

You should expect:

f1012000-f10120ff : serial8250.0
  f1012000-f101201f : serial
f1012100-f10121ff : serial8250.1
  f1012100-f101211f : serial

or probably just the first, if your device only has one serial port.

How about /proc/interrupts?

 33:        195  orion_irq  serial


Anything like this in dmesg?

[   17.189397] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[   17.210023] serial8250.0: ttyS0 at MMIO 0xf1012000 (irq = 33) is a 16550A
[   17.624748] console [ttyS0] enabled
[   17.648555] serial8250.1: ttyS1 at MMIO 0xf1012100 (irq = 34) is a 16550A

Comparing your system to the above might help you track down which
property is wrong.

	 Andrew
