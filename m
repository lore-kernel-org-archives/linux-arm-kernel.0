From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 24 Jul 2013 14:19:24 -0400
Subject: Location for a kind of GPIO bus driver
In-Reply-To: <20130723151834.GJ9916@kw.sim.vm.gnt>
References: <20130723151834.GJ9916@kw.sim.vm.gnt>
Message-ID: <20130724181924.GI19736@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 05:18:34PM +0200, Simon Guinot wrote:
> Hi,
> 
> I am currently working on converting the LED driver leds-netxbig to DT.
> Doing so, I am also considering to move the GPIO extension bus functions
> (which are currently parts of leds-netxbig) into a separate driver.
> 
> On the LaCie "Big Network" board family (netxbig), the LEDs are
> controlled by a CPLD. In turn, the CPLD can be configured (mostly the
> LEDs modes) through a kind of parallel GPIO bus, called GPIO extension
> bus. Two registers (address and data) are exposed. Each of them is made
> up of several GPIOs. An extra GPIO is used to notify the CPLD that the
> registers have been updated. The leds-netxbig driver uses some dedicated
> functions (prefixed by "gpio_ext_") to handle the GPIO bus extension.
> 
> On the latest "Big Network" boards, this bus is also used to enable the
> PM wakeup sources: the CPLD can be asked to keep powered some devices
> (as the RTC or the Ethernet PHY) while the board is down. I think it
> could be nice to expose this feature to the userland. That's why I am
> thinking about moving the GPIO extension bus support into a separate
> driver. The problem is that I can't find a proper location for a such
> driver. AFAIK, it doesn't fit with anything existing supported by Linux.
> Maybe I should consider drivers/bus ? Or even drivers/misc ?

iiuc, the CPLD is more of gpio multiplexer/expander.  Have you seen

  66bcb58 arm: mvebu: enable gpio expander over i2c on Mirabox platform

?  And the corresponding driver, drivers/gpio/gpio-pca953x.c?

I would try drivers/gpio.  If there are complaints, it should be trivial
to move it in a new version of the series.

Is there any reason why the new capabilities in the "Big Network" boards
couldn't be covered by gpio-regulator?

thx,

Jason.
