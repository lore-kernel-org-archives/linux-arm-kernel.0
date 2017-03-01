From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 1 Mar 2017 09:46:10 -0800
Subject: [PATCH] hwmon: (scpi) Add slope and offset to SCP sensor readings
In-Reply-To: <CAL9uMOG5qEgyGTue=n7abbFROKGBpUrWDOPi5_bEDUWuiHEUKg@mail.gmail.com>
References: <20170301132028.25309-1-carlo@caione.org>
 <41f19cd3-5086-1da9-915a-8987cfc119f9@roeck-us.net>
 <CAL9uMOG5qEgyGTue=n7abbFROKGBpUrWDOPi5_bEDUWuiHEUKg@mail.gmail.com>
Message-ID: <20170301174610.GA15246@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 01, 2017 at 05:16:36PM +0100, Carlo Caione wrote:
> On Wed, Mar 1, 2017 at 4:01 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On 03/01/2017 05:20 AM, Carlo Caione wrote:
> >>
> >> From: Carlo Caione <carlo@endlessm.com>
> >>
> >> The temperature provided by the SCP sensors not always is expressed in
> >> millicelsius, whereas this is required by the thermal framework. This is
> >> for example the case for the Amlogic devices, where the SCP sensor
> >> readings are expressed in degree (and not milli degree) Celsius.
> >>
> > Are you saying that SCPI does not specify or provide the units to be used
> > when reading values, and thus effectively just reports a more or less
> > random number ?
> 
> AFAICT the standard does not specify the units to be used for the
> values or a way to get that information. For the Amlogic case the SCP
> returns the value of the temperature in degree celsius and I'm not
> sure how common is that.
> 
> [cut]
> >> -       *temp = value;
> >> +       slope = thermal_zone_get_slope(zone->z);
> >> +       offset = thermal_zone_get_offset(zone->z);
> >
> >
> > This is conceptually wrong. The functions return -ENODEV if thermal is
> > disabled.
> > While a negative slope does not make sense, a negative offset does.
> 
> Yeah, but in that case we would have already failed to register the
> thermal zone at all in devm_thermal_zone_of_sensor_register().
> 
So a return value of -19 eigher means that the offset/slope is -19 or that the
thermal subsystem is disabled. What does a return value of -17 mean ? How does
one distinguish the two ? Either the functions return negative error codes or
they don't. Or at least I think that is how it should be.

How do you know in which order to apply slope and offset ? In other words,
how do you know that the offset is scaled and not the raw offset ?

> > The code in the thermal subsystem does not clarify well how slope and offset
> > are supposed to be used. Since coming from the thermal subsystem, one would
> > think
> > that the thermal subsystem would apply any corrections if they are supposed
> > to be software correction values, but that does not appear to be the case,
> > leaving it up to drivers to use or not use the provided values.
> 
> Yes, this is my understanding also considering this comment here:
> http://lxr.free-electrons.com/source/drivers/thermal/of-thermal.c#L1006
> 
> So apparently the slope and offset values are left to be used by the
> driver, that's why I was changing the temperature driver to use those
> values.
> 

The driver author is left wondering how to use those values. The thermal
API specifies that temperatures shall be reported as absolute values in
milli-degrees C. It doesn't specify if and how the driver should or may
use slope and offset as provided by the thermal subsystem to correct its
readings. It doesn't specify what to do if the driver has other means
to correct slope and/or offset internally (such as the lm90 driver,
or the ntc_thermistor driver), or what to do if the provided values don't
fit what hardware provides. It thus adds a lot of ambiguity which will
need to be clarified before the API can be used.

> > This is kind of odd; the values are thermal subsystem attributes/properties,
> > and one would think that they are to be used there unless they are supposed
> > to be
> > written into hardware. Given that, I'd rather wait for the API to be
> > clarified
> > instead of jumping into using it.
> 
> Zhang, Eduardo (+CC)
> can you clarify a bit this point?
> 
> > There are secondary problems with this approach; other drivers such as lm90
> > which
> > support the thermal subsystem have their own means to specify and use the
> > offset
> > (since it needs to be programmed into the chip registers).
> 
> I fail to see how this is related to my patch. If no coefficient is
> defined in the thermal zone node in the DT the framework sets slope=1
> and offset=0, so in the hwmon driver nothing changes.
> 
If temperature units are not well defined in SCPI, I have to assume
that other units are not well defined either. You only provide a thermal
subsystem specific solution for the problem, and you don't solve the problem
for the driver itself. On top of that, the solution is incomplete -
it assumes that the raw units may have to be scaled upward, never downward,
and it assumes that the scaling factor is an integer multiple of the raw
value. Given all that, I'd prefer a more comprehensive solution which
also works for the next hardware which decides to report temperatures
in mico-degrees C (or maybe in multiples of 2.5 mC), and voltages/currents
with some arbitrary resolution.

Browsing through the SCPI specification, it looks like you are right;
sensors are defined to return a 64-bit value, but it isn't even specified
if the returned value is signed or unsigned (or floating point, for that
matter), much less its units. I hope I am wrong, but if that is the case,
we'll need a much more comprehensive solution, one that is tied to
'arm,scpi-sensors' and not to the thermal subsystem.

Thanks,
Guenter

> > Also, this would only solve the problem for temperatures and does not
> > address
> > the generic problem (ie voltage and current values).
> 
> This problem is specific for the interaction between the hwmon SCPI
> driver and the thermal subsystem. Look for example at the board I'm
> working with one single thermal zone using the temperature data coming
> from SCP:
> 
> scpi_sensors: sensors {
>     compatible = "arm,scpi-sensors";
>     #thermal-sensor-cells = <1>;
> };
> 
> thermal-zones {
>     soc_thermal {
>         thermal-sensors = <&scpi_sensors 0>;
>         coefficients = <1000 0>;
> 
>         trips {
>             control: trip-point at 1 {
>                 temperature = <80000>;
>                 hysteresis = <1000>;
>                 type = "passive";
>             };
>         };
> 
>         cooling-maps {
>             cpufreq_cooling_map {
>                 trip = <&control>;
>                 cooling-device = <&cpus THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>             };
>         };
>     };
> };
> 
> trip points are defined in milli degree Celsius while the temperature
> returned by the scpi_sensors node is in degree Celsius. Without using
> the coefficients property and my changes how can I make the cooling
> map working fine?
> 
> Thanks,
> 
> -- 
> Carlo Caione  |  +39.340.80.30.096  |  Endless
> --
> To unsubscribe from this list: send the line "unsubscribe linux-hwmon" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
