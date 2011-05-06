From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Fri, 06 May 2011 16:15:25 +0100
Subject: [RFC] What is the preferred way to share ADC unit between hwmon
	and input(ts) drivers?
In-Reply-To: <20110506142316.GP23729@opensource.wolfsonmicro.com>
References: <4DB4C252.30005@emcraft.com> <20110425110230.GD4768@sirena.org.uk>
	<4DC3FB15.5090307@cam.ac.uk>
	<1304691206.2256.55.camel@team-embedded-2>
	<20110506142316.GP23729@opensource.wolfsonmicro.com>
Message-ID: <4DC4108D.6020601@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/11 15:23, Mark Brown wrote:
> On Fri, May 06, 2011 at 04:13:26PM +0200, Ithamar R. Adema wrote:
> 
>> Would it be worth considering generalizing the model that s3c uses[1]
>> for adc? I've reused that for at least two other platforms already,
>> though not mainlined (yet).
> 
>> It could make for a good /drivers/adc/ base IMHO. Any opinions?
> 
> I'd have expected that this stuff should be able to fit into IIO and
> that it would be able to be used by in-kernel users.
To my mind this is just like any other bit of hardware used by drivers
in different subsystems. Fits in MFD as far as I am concerned (and there
are several parts doing this ls drivers/mfd/*adc*).
Take the jz4740-adc.c file.  That provides adc reading to a touchscreen
a battery monitor and hwmon driver.  Any thing else is just reinventing
the wheel...

We can add in kernel hooks to IIO (would be easy enough -
for low rate stuff). I'd be happy to accept patches for this (it's not
a priority for any current active developers as far as I know).
However, that's silly if all you want is to pass it directly to input and hwmon.
Just write a driver that registers both interfaces directly.
If one of the adc channels needs stuff from IIO, add that as well.

IIO does have a (prototype) bridge to input, but that's done via userspace
is there to handle people doing unusual things with sensors typically used
for very different purposes (using 500 dolar IMU as a joystick for example).
We could do this in kernel, but that involves adding some logic at the
back end of the high data rate paths and hence would rather not...

Jonathan
