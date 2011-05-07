From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 7 May 2011 20:11:00 +0200
Subject: [RFC] What is the preferred way to share ADC unit between hwmon
	and input(ts) drivers?
In-Reply-To: <4DB4C252.30005@emcraft.com>
References: <4DB4C252.30005@emcraft.com>
Message-ID: <BANLkTikOjdAjbo+qcKoH_uqpb4YikbHxzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/25 Ilya Yanok <yanok@emcraft.com>:

> So, to add both input and hwmon drivers we need to serialize the
> register accesses.(...) Should we use a multi-function device driver
> for this

Yes. Use MFD. We use MFD for say drivers/mfd/ab3100-core.c and
what is does is essentially serialize the I2C read/writes using a
mutex, it spawnd MFD cell children for say drivers/regulator/ab3100.c

In your case spawn a foo-hwmon and foo-input MFD cell from your
MFD driver core.

> or just some platform-specific code (as S3C does)?

And where are you going to put that? Into arch/arm/mach-* where
Linus (the other one) is already upset with the prevalence of
driver code not being factored to share common infrastructure?

Yours,
Linus Walleij
