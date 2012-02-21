From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Feb 2012 13:02:27 +0000
Subject: [PATCH 1/2] Documentation/gpio.txt: Explain expected pinctrl
 interaction
In-Reply-To: <20120221124409.GL22562@n2100.arm.linux.org.uk>
References: <1329719263-18971-1-git-send-email-swarren@nvidia.com>
 <20120220073941.GC22562@n2100.arm.linux.org.uk>
 <CACRpkdbMFN3=XTSg1oE310eTHecrs6XaMz+DCNYJzwOg8JEEiQ@mail.gmail.com>
 <20120221110618.GJ22562@n2100.arm.linux.org.uk>
 <CACRpkdYzRu4VPKPgxuttuvSDCpfHjvBGGq1rFEDExv1PsoLG=w@mail.gmail.com>
 <20120221124409.GL22562@n2100.arm.linux.org.uk>
Message-ID: <20120221130227.GA26999@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2012 at 12:44:09PM +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 21, 2012 at 01:40:05PM +0100, Linus Walleij wrote:
> > Of course it assumes the SA1100 being converted to use pin control,
> > I looked at it a bit and it seems simple enough since the GAFR
> > register is a single "GPIO or something else"-switch for the GPIOs.
> > (It'd probably need the SA1100 to be a bit more strict in using
> > gpiolib in place for the direct assignments though, else the
> > abstractions get a bit pointless anyway.)
> 
> That's mostly happened through my recent set of 100 or so patches.
> There's a few areas where that's not quite as easy as it should be,
> but on the whole, it's mostly complete.
> 
> The other thing I forgot to mention, and I suspect it's particular to
> SA11x0, is that the GPDR must be set correctly according to the special
> function as well as GAFR.  So, if a special function involves driving
> a pin, the pin must be set as an output in GPDR.  Conversely, if the
> special function involves input only, the pin must be set as an input
> in GPDR.
> 
> So, on SA11x0, gpio and pin configuration are intimately linked.

I should have added - the only places which directly accesses one of the
GPDR/GPSR/GPCR registers are:

drivers/pcmcia/sa1100_shannon.c:        unsigned long levels = GPLR;
drivers/video/sa1100fb.c:           GPDR |= mask;
drivers/input/touchscreen/jornada720_ts.c:      if (GPLR & GPIO_GPIO(9)) {
drivers/input/touchscreen/h3600_ts_input.c:     int down = (GPLR & GPIO_BITSY_ACTION_BUTTON) ? 0 : 1;
drivers/input/touchscreen/h3600_ts_input.c:     int down = (GPLR & GPIO_BITSY_NPOWER_BUTTON) ? 0 : 1;

The shannon thing looks like a bug in my PCMCIA patch series - as soc_common
now deals with GPIOs itself (which I've now fixed.)

The sa1100fb thing is a case of what I described above (correctly
configuring the direction for the pins for the special function in use.)

The touchscreen stuff needs someone who knows that stuff to fix it -
I think the jornada folk have been around recently so maybe they can
look at their driver.

The h3600 ts stuff also looks fairly easy to convert to gpiolib if
someone has the time.  Again, maybe if there's an interested party
with a device that they could test, it could happen.

All other cases of direct GPDR/GPLR/GPSR/GPCR access are in platform
initialization code in arch/arm/mach-sa1100.  So, we're actually very
close to having sa11x0 fully converted to gpiolib.
