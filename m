From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 15 Apr 2011 03:16:16 +0200
Subject: Status of arch/arm in linux-next
In-Reply-To: <20110414094447.GA1611@n2100.arm.linux.org.uk>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
Message-ID: <BANLkTikVfdVQuR_nJZnra7Bo=CQgOfS5Zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/14 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> This morning, I looked at linux-next to find out how arch/arm is doing
> for the next merge window.
>
> $ git diff -C --cumulative v2.6.39-rc1... arch/arm
> (...)
> ? 7.6% arch/arm/mach-ux500/include/mach/
> ?46.1% arch/arm/mach-ux500/
> (...)
> Please take a moment to consider how Linus will react to this at the
> next merge window.

This instance of Linus feels guilty for that...

Since ~50% of it is ux500 that I usually merge through your tree,
I suspect you're simply not going to pull it so then half of the problem
is gone already :-D

Anyway, the bulk of that is a PRCMU driver, similar to the stuff
in arch/arm/mach-omap2/prcm*. So let's think about what we can
do about it.

Since this is a one-off kind of thing, a singleton driver that controls
power, reset and some GPIO on the chip. I contemplate moving the
stuff to either:

drivers/misc/ux500/*
include/linux/misc/ux500/*

or:

drivers/platform/arm/ux500/*
include/linux/platform/arm/ux500/*

Are any of these generally speaking good ideas?

Either place outside arch/arm/* is fine with me, creating something like
drivers/prcmu/* would be a bit thick since the hardware basically does
not look like anything else.

The basic problem it's reflecting is that ARM does not have something
like ACPI, that's basically what the driver is doing, and since every
vendor does their own HW thingy it's not like it's easily consolidated.

In the meantime I'm working on migrating GPIO drivers from mach-u300
and plat-nomadik into drivers/gpio so I will hopefully provide some negative
stats.

Yours,
Linus Walleij
