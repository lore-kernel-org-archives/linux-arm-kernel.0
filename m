From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 29 Aug 2016 09:49:13 +0200
Subject: [RFC PATCH v2 0/7] AC97 device/driver model revamp
In-Reply-To: <20160824113953.GF22076@sirena.org.uk> (Mark Brown's message of
 "Wed, 24 Aug 2016 12:39:53 +0100")
References: <1464380819-19075-1-git-send-email-robert.jarzmik@free.fr>
 <87twebphh4.fsf@belgarion.home> <20160824113953.GF22076@sirena.org.uk>
Message-ID: <87mvjwdngm.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@kernel.org> writes:

> On Tue, Aug 23, 2016 at 06:39:35PM +0200, Robert Jarzmik wrote:
>
>> In the old ac97 bus, the match function was always returning "true", and the
>> driver did probe. With this new implementation, the ac97 is discovered and
>> sound/soc/codecs/wm9713.c#wm9713_ac97_probe() is called. I don't export
>> ac97_bus_type (nor want to do it), and only _one_ device is created upon
>> discovery, while the wm97xx-core.c would benefic a second ac97 device.
>
>> I'm wondering how to work around this :
>>  - either I add a wm97xx-ts ac97 device in wm9713_ac97_probe()
>>  - or I add a platform device in wm9713_ac97_probe() and add a new
>>    platform_driver in wm97xx-core ...
>>  - or something smarter
>
> That device really should be a MFD.
>
>> What's behind this question is : should I keep to my initial solution of 1 ac97
>> device discovered is bound on the ac97 to _at most_ 1 ac97 driver, or is there a
>> know smart way to have several drivers for one device (that sounds a bit heretic
>> regarding my understanding of the device/driver model but who knows ...) ?
>
> MFDs are how we do multiple drivers per device.

Ok Mark, I took the bait and implemented it in
https://github.com/rjarzmik/linux/commits/work/ac97, and more specifically in :
  https://github.com/rjarzmik/linux/commit/4689ab3085b6e3959c873b4aa6dc4bc94ca5fd5c
  https://github.com/rjarzmik/linux/commit/152d57d535070871e401fab512b9babdcda9a545
  https://github.com/rjarzmik/linux/commit/903569ff077d1ea992dfc69d2f3014ce0d10fa99

I didn't send the patches for review yet as I face another kind of problem.
I converted wm9713 to an mfd device :
 - with a core in drivers/mfd
 - a codec in drivers/sound/soc/codec
 - a touchscreen in drivers/input/touchscreen
 - a battery in drivers/power/

The remaining problem is the lack of possibility to "customize" through
platform_data, which impact wm97xx_battery.c.
The reason of this is that :
 - the core in driver/mfd is "autoprobed" by the ac97 discovery mecanism
   As such, it has no platform data
 - the battery in drivers/power/wm97xx_battery.c will have its device spawned
   from the core and any platform data from it.

As you probably know wm97xx_battery needs platform data to be properly set up,
and unless I add a special "glue" in the ac97 device to provide this data I see
no other option. Would you think of something better ?

Actually the wm97xx could be even further improved by "offering" an ADC API the
battery driver could be bound to and consume just as regulators are, but that's
probably not worth it for only one old driver.

I'll post the serie within this week.

-- 
Robert
