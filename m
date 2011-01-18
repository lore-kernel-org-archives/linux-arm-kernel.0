From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 18 Jan 2011 22:11:16 +0100
Subject: [PATCH] ux500: add a few AB8500 regulator consumers
In-Reply-To: <20110117153303.GK21113@opensource.wolfsonmicro.com>
References: <1295269491-12107-1-git-send-email-linus.walleij@stericsson.com>
	<20110117132745.GA21113@opensource.wolfsonmicro.com>
	<AANLkTi=gsmiGFF31Si71LQBAZqpZZcxMDOK6e3xAyZV7@mail.gmail.com>
	<20110117153303.GK21113@opensource.wolfsonmicro.com>
Message-ID: <AANLkTins3Xgz+83cNJsoUY=KKfBdzWpMs7KFX05DpNfp@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/17 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Mon, Jan 17, 2011 at 03:11:04PM +0100, Linus Walleij wrote:
>> 2011/1/17 Mark Brown <broonie@opensource.wolfsonmicro.com>:
>
>> >> + ? ? {
>> >> + ? ? ? ? ? ? .supply = "ab8500-gpadc",
>> >> + ? ? },
>
>> > I suspect there's a device for the ab8500?
>
>> This is not the AB8500 actually, but a subdevice (MFD cell) for it
>> that creates its own platform device and is separately powered.
>> (Though using in-chip wiring I presume.)
>
> It may be more sane to just have the subdevices use the core struct
> device for requests for legibility.

I'm not sure I'm following, so help me out...

I sort of like the detail I get in sysfs for the regulators, for
example I can see in

/sys/devices/platform/ab8500-i2c.0/ab8500-regulator.0/regulator/regulator.3
sdi0-vmmc -> ../../../../../sdi0

Aha so sdi0 is using this regulator.

If all AB8500 subdevices were to ask for regulators using the
core device there would be just one big entry pointing
to the ab8500-i2c.0 entry in this case, and a huge usecount,
which is not helpful IMO. I like the detail.

We have scripts extracting that info as well.

Therefore I prefer to register each consumer to the
subdevice...

BTW I also checked that this one line is not internal
to the AB8500, it's an external pin, which is then connected
back to one of the regulators provided by the same chip,
but could as well be some other regulator.

Yours,
Linus Walleij
