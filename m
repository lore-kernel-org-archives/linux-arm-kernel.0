From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 24 Sep 2010 10:21:24 +0100
Subject: [PATCH] mfd: regulator: max8998: BUCK1/2 control augmented by
	GPIO pins
In-Reply-To: <20100924110825.138ce87f@lmajewski.digital.local>
References: <1285078695-24753-1-git-send-email-l.majewski@samsung.com>
	<20100921150107.GA32476@sirena.org.uk>
	<20100924110825.138ce87f@lmajewski.digital.local>
Message-ID: <20100924092123.GG32112@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 24, 2010 at 11:08:25AM +0200, Lukasz Majewski wrote:

> Unfortunately there is problem with this distinction and use of
> gpio_is_valid.

> The gpio_is_valid is simply defined as  

> return ((unsigned)number) < ARCH_NR_GPIOS;

> For which 0 is also a valid GPIO.

I understand that on some platforms it is actually a valid GPIO.

> One workaround for this is to check explicitly the condition:
> pdata->buck1_set1 != 0 , but this is neither elegant nor it prevents
> the situation when on some architecture GPIO 0 is valid.

The standard check is gpio_is_valid() with the GPIO set to -1 if it's
not valid.

> is the replacement algorithm. I think that circular buffer
> implementation would be a feasible solution for 4/2 bytes elements
> array.

> With more extended functionality, when more voltage levels would be
> available, more sophisticated approach (like LRU) may be used.

The problem here is that this is going to be pretty pessimal if the
system is using more than four different voltages; you get no advantage
at all from the preprogramming.
