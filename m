From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sat, 28 Aug 2010 16:48:58 +0200
Subject: [PATCH] mmc: move regulator handling to core
In-Reply-To: <20100827190306.GB20407@void.printf.net>
References: <1259844390-10541-1-git-send-email-daniel@caiaq.de>
	<20100827190306.GB20407@void.printf.net>
Message-ID: <AANLkTi=20KrUy334JRmMYwK7rbaVYrYCqW-BHZYGPrwT@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/27 Chris Ball <cjb@laptop.org>:

> Looks like this patch got dropped because of the missing modifications
> to arch/arm/mach-omap2/mmc-twl4030.c. ?Are we still interested in the
> patch otherwise, and can anyone help with that?

Actually just before the summer I submitted something not quite similar:
I moved all regulator handling *out* of the MMC core because I didn't
trust the way reference counting was being handled.

There is something very disturbing about this code from
regulator/core/core.c mmc_regulator_set_ocr():

enabled = regulator_is_enabled(supply);
if (enabled < 0)
	return enabled;

if (...) {
	(...)
	voltage = regulator_get_voltage(supply);
	if (voltage < 0)
		result = voltage;
	else if (voltage < min_uV || voltage > max_uV)
		result = regulator_set_voltage(supply, min_uV, max_uV);
	else
		result = 0;

	if (result == 0 && !enabled)
		result = regulator_enable(supply);
} else if (enabled) {
	result = regulator_disable(supply);
}

I didn't realize until today where the problem is: if you have
two hosts on the same regulator this does not handle
concurrency correctly. There is no lock taken between reading
the enabled status and acting on it later in the code.

So it looks to me like it is possible for one slot to enable the
regulator and race with another slot which disables it at the
same time and end up with the regulator disabled :-(

My solution would still be to move the enable/disable out
of the core, so I need to follow up on that.

This old patch however, goes in the opposite direction,
moving it all into the core. If you do this, please fix the
concurrency issue also...

Yours,
Linus Walleij
