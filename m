From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 26 Jul 2013 07:27:57 -0400
Subject: Location for a kind of GPIO bus driver
In-Reply-To: <20130726085623.GM9916@kw.sim.vm.gnt>
References: <20130723151834.GJ9916@kw.sim.vm.gnt>
 <20130724181924.GI19736@titan.lakedaemon.net>
 <20130725154932.GL9916@kw.sim.vm.gnt>
 <20130725160324.GJ23879@titan.lakedaemon.net>
 <20130726085623.GM9916@kw.sim.vm.gnt>
Message-ID: <20130726112757.GA29916@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 10:56:23AM +0200, Simon Guinot wrote:
> On Thu, Jul 25, 2013 at 12:03:24PM -0400, Jason Cooper wrote:
> > On Thu, Jul 25, 2013 at 05:49:32PM +0200, Simon Guinot wrote:
> > > On Wed, Jul 24, 2013 at 02:19:24PM -0400, Jason Cooper wrote:
> > > > On Tue, Jul 23, 2013 at 05:18:34PM +0200, Simon Guinot wrote:
> > > > > Hi,
> > > > > 
> > > > > I am currently working on converting the LED driver leds-netxbig to DT.
> > > > > Doing so, I am also considering to move the GPIO extension bus functions
> > > > > (which are currently parts of leds-netxbig) into a separate driver.
> > > > > 
> > > > > On the LaCie "Big Network" board family (netxbig), the LEDs are
> > > > > controlled by a CPLD. In turn, the CPLD can be configured (mostly the
> > > > > LEDs modes) through a kind of parallel GPIO bus, called GPIO extension
> > > > > bus. Two registers (address and data) are exposed. Each of them is made
> > > > > up of several GPIOs. An extra GPIO is used to notify the CPLD that the
> > > > > registers have been updated. The leds-netxbig driver uses some dedicated
> > > > > functions (prefixed by "gpio_ext_") to handle the GPIO bus extension.
> > > > > 
> > > > > On the latest "Big Network" boards, this bus is also used to enable the
> > > > > PM wakeup sources: the CPLD can be asked to keep powered some devices
> > > > > (as the RTC or the Ethernet PHY) while the board is down. I think it
> > > > > could be nice to expose this feature to the userland. That's why I am
> > > > > thinking about moving the GPIO extension bus support into a separate
> > > > > driver. The problem is that I can't find a proper location for a such
> > > > > driver. AFAIK, it doesn't fit with anything existing supported by Linux.
> > > > > Maybe I should consider drivers/bus ? Or even drivers/misc ?
> > > 
> > > Hi Jason,
> > > 
> > > Thanks for your answer.
> > > 
> > > > 
> > > > iiuc, the CPLD is more of gpio multiplexer/expander.  Have you seen
> > > > 
> > > >   66bcb58 arm: mvebu: enable gpio expander over i2c on Mirabox platform
> > > > 
> > > > ?  And the corresponding driver, drivers/gpio/gpio-pca953x.c?
> > > 
> > > All the drivers under drivers/gpio are registering some GPIO chips.
> > > It is a big difference with the LaCie "GPIO extension bus". This last
> > > is more an extension mechanism on the top of GPIOs already existing
> > > (eventually provided by a SoC or a Super-I/O on x86 boards). No new
> > > GPIOs are added. I think that the name "extension" is quite confusing.
> > 
> > Agreed.
> > 
> > > The idea behind this "bus" is to allow to configure a lot of LEDs (in
> > > various modes) using only few GPIOs and a CPLD (which is already
> > > available on the board for other purposes). This cheap solution allows
> > > precisely to save the cost of a GPIO expander :)
> > > 
> > > As an example, you can see the "GPIO extension bus" configuration for
> > > the Kirkwood "Big Network" boards in:
> > > arch/arm/mach-kirkwood/netxbig_v2-setup.c:132.
> > > 
> > > > 
> > > > I would try drivers/gpio.  If there are complaints, it should be trivial
> > > > to move it in a new version of the series.
> > > 
> > > Why not, as long it is clear that the resulting driver will not provide
> > > a GPIO chip but rather functions as a library.
> > 
> > right, but the end result of what the library would do is expose a
> > series of LEDs and PM 'virtual gpios'.  So, even though it's not a gpio
> > expander per-se, it's still filling that role.  Or am I still missing
> > something?
> 
> The library could expose a function allowing to set the address and data
> registers: gpio_ext_set_value(int addr, int value).
> 
> Actually, it is how it works inside leds-netxbig. Simply this function
> would be also accessible by other drivers.

hmmm, at this point I'm inclined to say "post the code RFC" :-)  We can
bikeshed it all day long, and not get any further.  And to answer your
original question, put the library under drivers/bus.  Maybe something
like lacie_gpio?

thx,

Jason.
