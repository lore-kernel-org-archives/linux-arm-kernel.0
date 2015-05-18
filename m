From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 18 May 2015 11:44:33 -0700
Subject: [PATCH 11/15] thermal: thermal: Add support for hardware-tracked
 trip points
In-Reply-To: <20150518120944.GQ6325@pengutronix.de>
References: <1431507163-19933-1-git-send-email-s.hauer@pengutronix.de>
 <1431507163-19933-12-git-send-email-s.hauer@pengutronix.de>
 <5559ABAA.6040001@kapsi.fi> <20150518120944.GQ6325@pengutronix.de>
Message-ID: <20150518184433.GS11598@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 02:09:44PM +0200, Sascha Hauer wrote:
> On Mon, May 18, 2015 at 12:06:50PM +0300, Mikko Perttunen wrote:
> > One interesting thing I noticed was that at least the bang-bang
> > governor only acts if the temperature is properly smaller than (trip
> > temp - hysteresis). So perhaps we should specify the non-tripping
> > range as [low, high)? Or we could change bang-bang.
> 
> I wonder how we can protect against such off-by-one errors anyway.
> Generally a hardware might operate on raw values rather than directly
> in temperature values in ?C. This means a driver for this must have
> celsius_to_raw and raw_to_celsius conversion functions. Now it can
> happen that due to rounding errors celsius_to_raw(Tcrit) returns a raw
> value that when converted back to celsius is different from the
> original value in ?C. This would mean the hardware triggers an interrupt
> for a trip point and the thermal core does not react because get_temp
> actually returns a different temperature than previously programmed as
> interrupt trigger. This way we would lose hot (or cold) events.

This also highlights another fact: there's a race between interrupt
generation and temperature reading (->get_temp()). I would expect any
hardware interrupt thermal sensor would also have a latched temperature
reading to correspond with it, and there would be no guarantee that this
latched temperature will match the polled reading seen once you reach
thermal_zone_device_update(). So a hardware driver might report a
thermal update, but the temperature reported to the core won't
necessarily match what interrupt was meant for.

I have a patch that adds a thermal_zone_device_update_temp() API, so
drivers can report the temperature along with the interrupt
notification. (Such a patch also helps so that the driver can choose to
round down on cold events and up on hot events, resolving your rounding
issue too.)

Brian
