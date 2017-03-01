From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 1 Mar 2017 09:56:18 -0800
Subject: [PATCH] hwmon: (scpi) Add slope and offset to SCP sensor readings
In-Reply-To: <87inntorz7.fsf@e105922-lin.cambridge.arm.com>
References: <20170301132028.25309-1-carlo@caione.org>
 <41f19cd3-5086-1da9-915a-8987cfc119f9@roeck-us.net>
 <CAL9uMOG5qEgyGTue=n7abbFROKGBpUrWDOPi5_bEDUWuiHEUKg@mail.gmail.com>
 <87inntorz7.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <20170301175618.GB15246@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 01, 2017 at 04:57:00PM +0000, Punit Agrawal wrote:
> Carlo Caione <carlo@endlessm.com> writes:
> 
> > On Wed, Mar 1, 2017 at 4:01 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> >> On 03/01/2017 05:20 AM, Carlo Caione wrote:
> >>>
> >>> From: Carlo Caione <carlo@endlessm.com>
> >>>
> >>> The temperature provided by the SCP sensors not always is expressed in
> >>> millicelsius, whereas this is required by the thermal framework. This is
> >>> for example the case for the Amlogic devices, where the SCP sensor
> >>> readings are expressed in degree (and not milli degree) Celsius.
> >>>
> >> Are you saying that SCPI does not specify or provide the units to be used
> >> when reading values, and thus effectively just reports a more or less
> >> random number ?
> >
> > AFAICT the standard does not specify the units to be used for the
> > values or a way to get that information. For the Amlogic case the SCP
> > returns the value of the temperature in degree celsius and I'm not
> > sure how common is that.
> 
> The standard does specify the units, but the way it is written seems to
> suggest that the units are part of the platform implementation rather
> than part of the standard [0].
> 
> [0] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0922g/CABBCJGH.html
> 

Wow, that is pretty well hidden. Table 3.87 doesn't specify units.
I agree, this appears to imply that the units are intentionally
platform specific. Unfortunately it doesn't specify the data format,
not even for the development platform, so I guess we'll have to
brace ourselves for inventive new data formats. 

> >
> > [cut]
> >>> -       *temp = value;
> >>> +       slope = thermal_zone_get_slope(zone->z);
> >>> +       offset = thermal_zone_get_offset(zone->z);
> >>
> >>
> >> This is conceptually wrong. The functions return -ENODEV if thermal is
> >> disabled.
> >> While a negative slope does not make sense, a negative offset does.
> >
> > Yeah, but in that case we would have already failed to register the
> > thermal zone at all in devm_thermal_zone_of_sensor_register().
> >
> 
> In addition to the thermal sub-subsystem, hwmon sysfs interface also
> expects temperature in millidegree Celsius. Ideally, any change should
> fix the reporting there as well. More below.
> 
> >> The code in the thermal subsystem does not clarify well how slope and offset
> >> are supposed to be used. Since coming from the thermal subsystem, one would
> >> think
> >> that the thermal subsystem would apply any corrections if they are supposed
> >> to be software correction values, but that does not appear to be the case,
> >> leaving it up to drivers to use or not use the provided values.
> >
> > Yes, this is my understanding also considering this comment here:
> > http://lxr.free-electrons.com/source/drivers/thermal/of-thermal.c#L1006
> >
> > So apparently the slope and offset values are left to be used by the
> > driver, that's why I was changing the temperature driver to use those
> > values.
> >
> >> This is kind of odd; the values are thermal subsystem attributes/properties,
> >> and one would think that they are to be used there unless they are supposed
> >> to be
> >> written into hardware. Given that, I'd rather wait for the API to be
> >> clarified
> >> instead of jumping into using it.
> >
> > Zhang, Eduardo (+CC)
> > can you clarify a bit this point?
> >
> 
> Another way to fix this would be to add optional properties to the scpi
> sensors binding and use them instead. This could then be used to fixup
> values reported to both thermal and hwmon.
> 

Yes, this would be much more appropriate.

Thanks,
Guenter
