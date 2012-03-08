From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 8 Mar 2012 14:27:01 -0700
Subject: [PATCH 06/14] ARM: kirkwood: convert uart0 to devicetree.
In-Reply-To: <201203072113.04369.arnd@arndb.de>
References: <cover.1331090356.git.jason@lakedaemon.net>
 <201203071831.31738.arnd@arndb.de>
 <20120307192723.GE5050@titan.lakedaemon.net>
 <201203072113.04369.arnd@arndb.de>
Message-ID: <20120308212701.GB16533@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2012 at 09:13:04PM +0000, Arnd Bergmann wrote:
> On Wednesday 07 March 2012, Jason wrote:
> > Grrr.  Now I'm getting frustrated.  I'm trying to boot without
> > earlyprintk.  Evidently, something is wrong with the above, because the
> > device boots all the way up (blinky lights come on), but I get no
> > messages after the usual "Uncompressing Linux... done, booting the
> > kernel."
> > 
> > Here's my most recent attempt:
> > 
> >         serial at f1012000 {
> >                 device_type = "serial";
> >                 compatible = "ns16550a";
> >                 reg = <0xf1012000 0x100>; /*phys addr*/
> >                 virt-reg = <0xfed12000>;  /*virt addr*/
> >                 reg-shift = <2>;
> >                 reg-io-width = <1>;
> >                 interrupts = <33>;
> >                 current-speed = <115200>;
> >                 interrupt-parent = <&intc>;
> >                 clock-frequency = <200000000>;
> >         };
> > 
> > I've looked at what is done in the powerpc dt's, but, no luck.  When
> > earlyprintk is enabled, I see no error messages, just:
> > 
> > bootconsole [earlycon0] enabled
> > debug: skip boot console de-registration.
> > ...
> > Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
> > 
> > Any pointers?
> 
> My first guess was that clock-frequency is wrong, but it seems that
> this one actually is correct, at least it's the same thing that
> the platform code sets.
> 
> You should never need to pass the virtual address to a device,
> most of all because it cannot be known to the device tree at all.
> The of_serial driver (you did enable that one in Kconfig, right?)

Ugh.  Someone really needs to step up and kill the of_serial driver.  All that
stuff belongs in the core 16550 driver.

g.
