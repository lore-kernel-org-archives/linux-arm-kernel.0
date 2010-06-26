From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sat, 26 Jun 2010 19:37:20 +0200
Subject: [PATCH] MMC: remove regulator refcount fiddling in mmc core
In-Reply-To: <20100625112232.GA21217@opensource.wolfsonmicro.com>
References: <1277392337-27627-1-git-send-email-linus.walleij@stericsson.com>
	<20100625112232.GA21217@opensource.wolfsonmicro.com>
Message-ID: <AANLkTikiPByvzfbj-gwfyozWb5MMJXSWuINFbrLdcwtU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/25 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Thu, Jun 24, 2010 at 05:12:17PM +0200, Linus Walleij wrote:
>
>> Currently the mmc_regulator_set_ocr() fiddles with the regulator
>> refcount by selectively calling regulator_[enable|disable]
>> depending on the state of the regulator. This will confuse the
>> reference count if case the regulator is for example shared with
>> other MMC slots or user for other stuff than the MMC card.
>
>> Push regulator_[enable|disable] out into the MMC host drivers
>> and remove this from the MMC core so the reference count can be
>> trusted.
>
> So, the feedback from folks at the time this was originally written was
> that the MMC code was unable to cope with sharing regulators since it
> really needs to be able to set specific voltages. ?This needn't be a
> showstopper since people can force a single voltage in the constraints
> but it does need to be considered here.

Well hm, that's not strictly true. If you only provide one standard
voltage ONLY in your OCR mask, i.e. MMC_VDD_* then you can use
the same regulator for two or more MMC cards.

Further that's a perfectly reasonable thing to do if you have e.g.
two embedded eMMC cards and you know which voltage they like
to operate on ... so share the same regulator, why not. The above
assumption comes from a slot-based world.

Another argument is that a function named
mmc_regulator_set_ocr() shouldn't be enabling/disabling regulators
anyway because it's hopeless to read the code, and the other
functions in mmc/core.c only deals with voltages, not on/off:ing.
(Maybe it's just me who have a hard time reading code like that.)

Yours,
Linus Walleij
