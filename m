From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 1 Mar 2017 12:04:44 -0800
Subject: [PATCH] hwmon: (scpi) Add slope and offset to SCP sensor readings
In-Reply-To: <CAOQ7t2Y1=fL9a4A_gPtvrrWR_uOOP_gGT-61Q+1B39t2gRJBmw@mail.gmail.com>
References: <20170301132028.25309-1-carlo@caione.org>
 <41f19cd3-5086-1da9-915a-8987cfc119f9@roeck-us.net>
 <CAL9uMOG5qEgyGTue=n7abbFROKGBpUrWDOPi5_bEDUWuiHEUKg@mail.gmail.com>
 <87inntorz7.fsf@e105922-lin.cambridge.arm.com>
 <20170301175618.GB15246@roeck-us.net>
 <CAOQ7t2Y1=fL9a4A_gPtvrrWR_uOOP_gGT-61Q+1B39t2gRJBmw@mail.gmail.com>
Message-ID: <20170301200444.GB20160@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 01, 2017 at 07:45:50PM +0100, Carlo Caione wrote:
> On Wed, Mar 1, 2017 at 6:56 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Wed, Mar 01, 2017 at 04:57:00PM +0000, Punit Agrawal wrote:
> 
> >> Another way to fix this would be to add optional properties to the scpi
> >> sensors binding and use them instead. This could then be used to fixup
> >> values reported to both thermal and hwmon.
> >>
> >
> > Yes, this would be much more appropriate.
> 
> What about something like:
> 
> sensor-coefficients = <x1 y1 z1>,
>                                   <x2 y2 z2>,
>                                   ...;

As mentioned before, I don't think 'slope' and 'offset' are well enough
defined, so I would rather not use that approach.

I don't know if there are DT examples on how to specify a translation
from an arbitrary value to well-defined units; we could use that
if it exists. Otherwise, we might just go with a combination of
sensor class and the unit scale used for that sensor class.
A simple approach might be something like
    scpi,sensor-scale =	// pick preferred property name 
	<0 1000>,
	<1 1000>,
	<2 1000>,
	<3 1000000>,
	<4 1000000>;
or even simpler
	scpi,sensor-scale = <1000, 1000, 1000, 1000000, 1000000>;
since the class index is really redundant.

This would describe the units for the Juno ARM development platform.

In your case, that would be something like
	scpi,sensor-scale = <1, 1000, 1000, 1000000, 1000000>;
assuming that the other units are as expected (which may not be the case). 

Guenter
