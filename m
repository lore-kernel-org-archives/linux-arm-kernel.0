From: andy@warmcat.com (Andy Green)
Date: Wed, 24 Mar 2010 11:27:32 +0000
Subject: Device probe order (i2c regulator vs. platform device)
In-Reply-To: <20100324110820.GA5831@opensource.wolfsonmicro.com>
References: <E4D3F24EA6C9E54F817833EAE0D912AC09C80E05C7@bssrvexch01.BS.local>	<20100324102144.GA21935@rakim.wolfsonmicro.main>	<005401cacb41$821d46f0$8657d4d0$%szyprowski@samsung.com>
	<20100324110820.GA5831@opensource.wolfsonmicro.com>
Message-ID: <4BA9F724.8070901@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/24/10 11:08, Somebody in the thread at some point said:
> On Wed, Mar 24, 2010 at 12:02:30PM +0100, Marek Szyprowski wrote:
>
>> Ok, I get this idea, but this requires to move the i2c bus initialization
>> also to subsys_initcall. We use generic i2c-gpio driver. I suspect there
>> might be some unpredicted consequences on some other systems if we push
>> the patch that changes it init to subsys_initcall. I have no idea if the
>> gpiolib calls are available on all systems during the subsys_initcall.
>
> It's been OK for other I2C controllers.  GPIOs are another thing I'd
> expect to see available early since they're in a similar position where
> lots of other devices end up needing them in their probe so it'd seem
> surprising if there were a problem with bringing it up early.

You're missing the point.

On any board with a PMU if you look at the schematic you will see most 
of the assets on the board are totally dependent on the PMU power 
arrangements.

Take for example the SD card socket with its own regulator from the PMU.

In Linux reasonably enough MMC is not related to I2C at all in the 
default case.  Therefore during suspend, nothing stops I2C child suspend 
completing before the MMC stack suspend completes.

In that case, MMC commands designed to put the card to idle nicely ping 
off a dead card because its power is gone already.  And that is an 
uncontrolled race that varied suspend by suspend according to the phase 
of the moon.

The dependency of the SD slot on the PMU is not notional, it's totally 
real in hardware.

The solution is to make explicit the device hierarchy relationship using 
the parent member of struct device.  On a typical board, it means most 
of your devices are children on the PMU -- and that reflects the reality.

To do that, you need a post-PMU-probe callback into the machine file, or 
some even nicer API arrangement you're in a good position to invent :-)

-Andy
