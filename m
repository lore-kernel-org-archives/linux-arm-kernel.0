From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 04 Sep 2012 17:41:02 +0100
Subject: [PATCH 02/11] misc: Versatile Express config bus infrastructure
In-Reply-To: <201209041245.39464.arnd@arndb.de>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
 <201209032117.35677.arnd@arndb.de> <1346759601.2605.68.camel@hornet>
 <201209041245.39464.arnd@arndb.de>
Message-ID: <1346776862.20599.42.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-09-04 at 13:45 +0100, Arnd Bergmann wrote:
> We're adding drivers/bus in v3.7, I already have another bus driver in
> the arm-soc tree.
> 
> The reset code can probably just go to arch/arm/mach-vexpress though,
> we do the same for the reset code on all other platforms.

Hm, ok, let's make it so. Of course the question is what will the arm64
use, but I'll ignore it for the moment.

> > So it's all about clocks, that must be available really early. The
> > particular problem I faced was the amba_probe() trying to enable
> > apb_pclk of each device and failing...
> > 
> > Now, during the clock registration the device model is not initialized
> > yet, so I can't do normal devices registration. I've stolen some ideas
> > from the early platform bus code...
> 
> Maybe you can change amba_probe() to provide a -EPROBE_DEFER return
> code to the caller when the clock is not yet there, it should then
> just come back later.

Hm. I'm honestly a little bit afraid to propose that, but I'll see how
would this work.

> > > > +struct bus_type vexpress_config_bus_type = {
> > > > +	.name = "vexpress-config",
> > > > +	.match = vexpress_config_match,
> > > > +};
> > > 
> > > What is the reason for having a separate bus_type here?
> > > Is this a discoverable bus? If it is, why do you need a
> > > device tree binding for the child devices?
> > 
> > It is not a discoverable bus, but the devices are very different from
> > the "normal" platform devices and have specific read/write interface, so
> > it seemed to me that a separate bus would make sense. And I didn't want
> > to reinvent the wheel with my own "device/driver model".
> 
> Not introducing a different way to do devices is good, but I don't think
> that using something else than platform devices buys you much. If it's not
> discoverable, this driver does not look all that different from an MFD
> (which is based on platform devices).

Generally you seem to suggest using the MFD "micro-framework" instead...
(quite frankly I wasn't aware of its existence till now_. Ok, I'll try
to use it instead of a custom bus. I have some doubts (eg. not quite
sure what to do with the resources and "reg" properties), but I'll give
it a go.

> A new bus type is typically used only for cases where you have multiple
> different bus drivers and multiple different device drivers, and want a
> bus layer to proxy between them. 

I'm not sure what do you mean by "bus driver", but to my mind the buses
are just a way of binding devices and their drivers of a particular
variety. And the VE config bus is of a very specific variety indeed :-)

> > > What is the purpose of this lookup? Can't you make the child devices get
> > > probed by the compatible value?
> > 
> > Ok, there are two reasons for this table existence:
> > 
> > 1. vexpress_config_of_populate() below - I need a comprehensive list of
> > compatible values to be able to search the tree and create respective
> > devices.
> 
> I don't see why you need this list. Just call of_platform_populate or a
> copy of that. It does not require the compatible values of the devices,
> just the one for the parent.

... but of course it only creates platform devices. So as long as 

> > 2. Non-DT static devices - I need something to be able to match a driver
> > with a device, and the "functions list" seemed appropriate.
> 
> How important is this case really, given that the driver has never been
> supported and that the non-DT case is going away soon?

The non-DT code used to use v2m_cfg_write() calls to do
restart/power_off and to control video output. So I felt obliged to
provide the same functionality.

> > Em, I'm not sure what do you mean... The idea is shamelessly stolen from
> > of_irq_init() and of_clk_init()...
> 
> But those are not buses, they are infrastructure that is used across
> buses. The regular way to do this is to register a driver for your
> parent node and then just iterate over the children, in the way that
> we do for e.g. i2c or spi buses.

Ok, I see what you mean, although this is a slightly different case than
SPI - there's no single master and straight hierarchy of the devices...
To use the I2C analogy - it would be hard to describe a multi-master I2C
segment (where one slave can be accessed by more than one master) with
the current framework and bindings. And this is roughly the VE case - a
device can be accessed through more than one bridge, and the way the
transactions are routed can be quite convoluted
(CPU->motherboard->IOFPGA->bridge->IOFPGA->motherboard
micro->daugtherboard micro->device).

Anyway, I'll see what can be simplified here.

Cheers!

Pawe?
