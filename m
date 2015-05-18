From: tony@atomide.com (Tony Lindgren)
Date: Mon, 18 May 2015 13:37:27 -0700
Subject: [PATCH] ARM: dts: am335x-bone* enable pmic-shutdown-controller
In-Reply-To: <D3CA3985-8C25-4B0C-A3DF-A3E2AF8450BD@konsulko.com>
References: <20150513144846.GC6605@localhost>
 <CAALWOA-hkgrMi+OeNrmwaVpdEfNadFn0R-QbpXi9LU-4sbakJQ@mail.gmail.com>
 <20150518152108.GE10274@atomide.com>
 <CAOCHtYgwyQy+hQE2PeUd+7U9wNygVOUuAb-VSh_9K5y7zFHEWA@mail.gmail.com>
 <20150518162936.GF10274@atomide.com>
 <CAOCHtYjtziBwfSMGPRrQ7rfDEf_dC=7rPytQUxVXy8bSp-8NNw@mail.gmail.com>
 <20150518170354.GG10274@atomide.com>
 <7ECB47C4-812D-4465-82EE-56796B987011@konsulko.com>
 <20150518181455.GH10274@atomide.com>
 <D3CA3985-8C25-4B0C-A3DF-A3E2AF8450BD@konsulko.com>
Message-ID: <20150518203727.GI10274@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pantelis Antoniou <pantelis.antoniou@konsulko.com> [150518 11:19]:
> Hi Tony,
> 
> > On May 18, 2015, at 21:14 , Tony Lindgren <tony@atomide.com> wrote:
> > 
> > * Pantelis Antoniou <pantelis.antoniou@konsulko.com> [150518 11:02]:
> >> Hi Tony,
> >> 
> >>> On May 18, 2015, at 20:03 , Tony Lindgren <tony@atomide.com> wrote:
> >>> 
> >>> * Robert Nelson <robertcnelson@gmail.com> [150518 09:51]:
> >>>> On Mon, May 18, 2015 at 11:29 AM, Tony Lindgren <tony@atomide.com> wrote:
> >>>>> * Robert Nelson <robertcnelson@gmail.com> [150518 09:15]:
> >>>>>> On Mon, May 18, 2015 at 10:21 AM, Tony Lindgren <tony@atomide.com> wrote:
> >>>>>> 
> >>>>>> All the rev information is in the board's eeprom:
> >>>>>> 
> >>>>>> hexdump -e '8/1 "%c"' /sys/bus/i2c/devices/0-0050/eeprom -s 12 -n 4
> >>>>>> 
> >>>>>> Rev A5B
> >>>>>> 0A5B
> >>>>>> 
> >>>>>> Rev C
> >>>>>> 000C
> >>>>>> 
> >>>>>> Just another default qwerk to add to Pantelis' bone_capemgr. ;)
> >>>>> 
> >>>>> It seems we should not even instantiate some devices on BBB
> >>>>> until the EEPROM is parsed.. So maybe something like this:
> >>>>> 
> >>>>> 1. The problem devices are initially set with status = "disabled"
> >>>>>  in the dts
> >>>>> 
> >>>>> 2. We set up drivers/*/bbb-eeprom.c that parses the board
> >>>>>  revision at module_init time, and then flips the selected
> >>>>>  devices to have status = "enabled" and populates the revision
> >>>>>  info based on the eeprom and SoC revision passed in pdata.
> >>>>>  Then those devices get their struct device created and
> >>>>>  probed, but at a much later time.
> >>>>> 
> >>>>> So rather than trying to init all that early, let's just
> >>>>> init them much later when we have the proper I2C driver
> >>>>> running?
> >>>> 
> >>>> I see that working just fine.  We (beagleboard.org) enforce the eeprom
> >>>> data, as all the official images require a proper baseboard eeprom.
> >>> 
> >>> OK
> >>> 
> >>>> We just have to be very careful to limit the scope, otherwise we will
> >>>> end up with Pantelis' rejected capebus from the v3.2.x days...
> >>> 
> >>> Naturally I was thinking #2 above would use Pantelis' code for
> >>> CONFIG_OF_OVERLAY in mainline. But instead of the earlier patches,
> >>> we can make things happen much later on to avoid the detect of
> >>> EEPROM early on.
> >> 
> >> Already been taken care of:
> >> 
> >> https://lkml.org/lkml/2015/2/18/258
> >> 
> >> The patchset works, but it still needs some review eyeballs.
> >> There might be a rename to variants or something.
> >> 
> >> You were part of that thread too :)
> > 
> > Right, and what I mean with #2 above is that we can make this all
> > into a regular drivers/* device driver with no need for the
> > early hacks in your series in arch/arm/mach-omap2/am33xx-dt-quirks.c.
> > 
> 
> It?s going to be tough. This is touching the pmic that needs to be 
> initialized early since a whole bunch of drivers depend on it.

With the $subject driver we just need to have have RTC driver not
probe until the the EEPROM is parsed in the drivers/foo/bbb-eeprom.c
driver and the RTC overlay is initialized. Or what's the issue
you're talking about?

But in any case, let's not merge a copy of the I2C driver into
arch/arm/mach-omap2/am33xx-dt-quirks.c. We can do all this with
drivers/foo/bbb-eeprom.c that's just a regular device driver.
 
> >> I think it?s best if we go this path instead of twiddling with the
> >> status properties manually. Conceptually the idea is similar to
> >> the detection of the white/black, with the added joy of revision
> >> detection.
> > 
> > If some device drivers depend on the I2C EEPROM, we should not
> > create the struct device entry for those until the I2C EEPROM
> > driver has parsed the EEPROM. And there's no need to do that
> > early, we want to do everything as late as possible. That way
> > we have real debug console available in most cases.
> > 
> 
> FWIW the first patch used an early platform device, but that made things
> even more complicated.

No need to do any early platform devices, we just need to delay
the creation of struct device for the problem drivers.

Regards,

Tony
