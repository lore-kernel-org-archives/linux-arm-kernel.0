From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Jul 2013 09:45:43 -0600
Subject: [PATCH v8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <20130716041056.GA30067@S2101-09.ap.freescale.net>
References: <1369904940-716-1-git-send-email-p.zabel@pengutronix.de>
 <20130716015038.GD28375@S2101-09.ap.freescale.net>
 <51E4BF98.8030604@wwwdotorg.org>
 <20130716041056.GA30067@S2101-09.ap.freescale.net>
Message-ID: <51E56AA7.7020103@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2013 10:10 PM, Shawn Guo wrote:
> On Mon, Jul 15, 2013 at 09:35:52PM -0600, Stephen Warren wrote:
>>> It's a little bit late to register gpio-reset driver at module_init
>>> time, because gpio-reset provides reset control via gpio for other
>>> devices which are mostly probed at module_init time too.  And it
>>> becomes even worse, when the gpio comes from IO expander on I2C bus,
>>> e.g. pca953x.  In that case, gpio-reset needs to be ready before I2C
>>> bus driver which is generally ready at subsys_initcall time.  Let's
>>> register gpio-reset driver in arch_initcall() to have it ready early
>>> enough.
>>
>> There's no need for the reset driver to be registered before its users;
>> the users of the reset GPIO will simply have their probe deferred until
>> the reset controller is available, and then everything will work out
>> just fine.
>>
>>> The defer probe mechanism is not used here, because a reset controller
>>> driver should be reasonably registered early than other devices.  More
>>> importantly, defer probe doe not help in some nasty cases, e.g. the
>>> gpio-pca953x device itself needs a reset from gpio-reset driver to start
>>> working.
>>
>> That should work fine with deferred probe.
> 
> I should probably rework the commit log.  But I do not see a problem
> to register gpio-reset driver a little bit earlier. 

Registering the driver earlier won't cause any bugs. However, it's not
the correct approach.

Deferred probe /is/ the approach for assuring correct dependencies
between drivers. It works and should be used. There are not enough
initcall levels to play games using initcalls and solve all the issues,
and the ordering requirements vary board-to-board. Deferred probe at
runtime handles this without having to manually place all the drivers
into specific initcall levels, and dynamically adjusts to board
differences, since it all happens automatically at run-time.

Consider a SoC that has:

* An external PMIC, which the CPU has to communicate with to enable
power to all SoC components outside the CPU and a single I2C instance
dedicated to communicating with the PMIC.
* An on-SoC reset controller (for on-SoC) modules that resets other
on-SoC I2C controllers
* An on-SoC I2C controller which communicates with a GPIO expander
* One of the GPIOs on that expander is the reset GPIO for some other
device connected by I2C

What initcall levels are you going to use for all the drivers
(PM-related I2C, PMIC, on-SoC reset controller, secondary I2C
controller, GPIO expander IC, GPIO-reset "device", the final device
affected by the GPIO reset controller).

Now wonder whether that same order is going to be suitable for every
single other board. That's quite unlikely...

 On the other hand,
> if we reply on deferred probe, many drivers probe could be deferred.
> For example, on my system, the gpio-pca953x on I2C bus works as a GPIO
> controller and provides resets to many board level components.
> Deferring probe of gpio-pca953x on I2C bus means every single probe of
> all these components gets deferred.  IMO, this situation should be
> reasonably avoided.

Yes, deferred probe will happen. If we want to solve that, I believe we
need a more generic solution specifically targeted at that, rather that
playing games with initcalls.

(It'd be nice if each DT node declared all its resources in a way the DT
core could parse them and determine the dependency graph itself, without
having to write code in all drivers to extract that information from DT.
This would need a standardized resource representation in DT, and as
such would mean throwing out all the bindings and starting again...
Perhaps some parallel set of properties could be invented to hint at the
order, but still fall back to deferred probe where that information was
missing or inaccurate.)
