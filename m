From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Jun 2011 16:57:54 +0200
Subject: [PATCH] mach-ixp4xx: fix build error
In-Reply-To: <20110615132943.GA14917@riccoc20.at.omicron.at>
References: <1308127390-30563-1-git-send-email-linus.walleij@stericsson.com>
	<20110615132943.GA14917@riccoc20.at.omicron.at>
Message-ID: <BANLkTikov-4dJZQNFq9R2xaySZ22r=jcww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2011 at 3:29 PM, Richard Cochran
<richardcochran@gmail.com> wrote:
> On Wed, Jun 15, 2011 at 10:43:10AM +0200, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> The introduction of clocksource_mmio_init() broke ixp4xx due to
>> a surplus ampersand - IXP4XX_OSTS is already a pointe to I/O
>> space.
>
> The fix you suggest will not work on big endian ixp. See

Yeah! I see. Sorry for missing it, I was just looking over the broken
kisskb items.

> ? http://lists.arm.linux.org.uk/lurker/message/20110530.084307.f960f906.en.html

You do this:

+static cycle_t ixp4xx_clocksource_read(struct clocksource *c)
+{
+    return *IXP4XX_OSTS;
+}

Which is essentially __raw_readl(IXP4XX_OSTS) to get the timer in current
endianness, is it not? So please use __raw_readl() for that if I'm right.

Thanks,
Linus Walleij
