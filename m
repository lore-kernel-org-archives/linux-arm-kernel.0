From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jan 2011 15:11:04 +0100
Subject: [PATCH] ux500: add a few AB8500 regulator consumers
In-Reply-To: <20110117132745.GA21113@opensource.wolfsonmicro.com>
References: <1295269491-12107-1-git-send-email-linus.walleij@stericsson.com>
	<20110117132745.GA21113@opensource.wolfsonmicro.com>
Message-ID: <AANLkTi=gsmiGFF31Si71LQBAZqpZZcxMDOK6e3xAyZV7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/17 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Mon, Jan 17, 2011 at 02:04:51PM +0100, Linus Walleij wrote:
>
>> +static struct regulator_consumer_supply ab8500_vaux1_consumers[] = {
>> + ? ? {
>> + ? ? ? ? ? ? .dev = NULL,
>> + ? ? ? ? ? ? .supply = "v-display",
>> + ? ? },
>
> Your use of NULL where there's no device in this patch is somewhat
> erratic.

Yes, you're right, hm, I'll assign this to the MCDE (Multi-Channel
Display Engine) instead.

Right, Robert/Jimmy?

>> + ? ? {
>> + ? ? ? ? ? ? .dev_name = "bh1780",
>> + ? ? ? ? ? ? .supply = "v-als",
>> + ? ? },
>
> This supply name (like many of the others) looks a bit odd, it's an
> unusual idiom. ?Indeed, looking at (first hit in Google):

I'll change it for "vcc", the driver in drivers/misc/bh1780gli.c
does not yet utilize regulators so now the authors of that driver
need to look into requesting "vcc".

Lee, can you look into adding optional regulator support for
BH1780GLI, and then use "vcc" for power supply...

>> +static struct regulator_consumer_supply ab8500_vtvout_consumers[] = {
>> + ? ? {
>> + ? ? ? ? ? ? .supply = "v-tvout",
>> + ? ? },
>> + ? ? {
>> + ? ? ? ? ? ? .supply = "ab8500-gpadc",
>> + ? ? },
>
> I suspect there's a device for the ab8500?

This is not the AB8500 actually, but a subdevice (MFD cell) for it
that creates its own platform device and is separately powered.
(Though using in-chip wiring I presume.)

Ther driver is public but not mainlined:
http://git.linaro.org/gitweb?p=bsp/st-ericsson/linux-2.6.35-ux500.git;a=blob;f=drivers/misc/ab8500_gpadc.c;h=d27ccce90466f21e961975bf3868f9e0614545cf;hb=HEAD

I think the proper thing to add is .dev_name = "ab8500-gpadc.0".
The name of the supply is "vddadc" on the datasheet so
I'll change to this.

http://git.linaro.org/gitweb?p=bsp/st-ericsson/linux-2.6.35-ux500.git;a=blob;f=drivers/misc/ab8500_gpadc.c;h=d27ccce90466f21e961975bf3868f9e0614545cf;hb=HEAD

Yours,
Linus Walleij
