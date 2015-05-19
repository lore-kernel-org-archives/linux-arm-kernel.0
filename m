From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 19 May 2015 15:58:27 +0200
Subject: [PATCH 11/15] thermal: thermal: Add support for hardware-tracked
 trip points
In-Reply-To: <20150518120944.GQ6325@pengutronix.de>
References: <1431507163-19933-1-git-send-email-s.hauer@pengutronix.de>
 <1431507163-19933-12-git-send-email-s.hauer@pengutronix.de>
 <5559ABAA.6040001@kapsi.fi> <20150518120944.GQ6325@pengutronix.de>
Message-ID: <20150519135827.GF6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 02:09:44PM +0200, Sascha Hauer wrote:
> Hi Mikko,
> 
> On Mon, May 18, 2015 at 12:06:50PM +0300, Mikko Perttunen wrote:
> > > +	for (i = 0; i < tz->trips; i++) {
> > > +		int trip_low;
> > > +
> > > +		tz->ops->get_trip_temp(tz, i, &trip_temp);
> > > +		tz->ops->get_trip_hyst(tz, i, &hysteresis);
> > > +
> > > +		trip_low = trip_temp - hysteresis;
> > > +
> > > +		if (trip_low < temp && trip_low > low)
> > > +			low = trip_low;
> > > +
> > > +		if (trip_temp > temp && trip_temp < high)
> > > +			high = trip_temp;
> > > +	}
> > > +
> > > +	tz->prev_low_trip = low;
> > > +	tz->prev_high_trip = high;
> > > +
> > > +	dev_dbg(&tz->device, "new temperature boundaries: %d < x < %d\n",
> > > +			low, high);
> > > +
> > > +	tz->ops->set_trips(tz, low, high);
> > 
> > This should probably do something if set_trips returns an error
> > code; at least an error message, perhaps enable polling? I'm not
> > exactly sure what safety features the thermal framework has in
> > general if errors happen..
> 
> Currently a thermal zone has the passive_delay and polling_delay
> variables. If these are nonzero the thermal core will always poll. A
> purely interrupt driven thermal zone would set these values to zero.
> In this case the thermal core has no basis for polling, so we would
> have to make up polling intervals when set_trips fails. Another
> possibility would be to interpret the *_delay variables as 'when
> set_trips is available, do not poll. When something goes wrong, use
> *_delay as polling intervals'
> 
> > 
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

As a simple example we could imagine a 12bit adc which has:

u32 mcelsius_to_raw(int temp)
{
	return temp / 30;
}

int raw_to_mcelsius(u32 raw)
{
	return temp * 30;
}

Now if the thermal framework requests an interrupt at 77000mC we
would program a raw value of 77000 / 30 = 2566.666667, due to integer
rounding we would program 2566. Now when the interrupt is triggered with
this exact raw value we would convert it back to 2566 * 30 = 76980. The
thermal framework would realize that this is below the threshold, do
nothing and go back to sleep.
I am beginning to think that implementing interrupts like this is not a
good idea, at least I found no convenient way out of this situation.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
