From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 19 May 2011 16:56:39 +0800
Subject: [PATCH 02/10] mach-u300: rewrite gpio driver, move to drivers/gpio
In-Reply-To: <1303910002-3333-1-git-send-email-linus.walleij@stericsson.com>
References: <1303910002-3333-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110519085638.GA26816@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2011 at 03:13:22PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This rewrites the U300 GPIO driver using gpiolib and the irq_chip
> abstractions, makes it runtime-configured rather than compile-time,
> and moves it to the drivers/gpio subsystem where it belongs,
> depopulating the ARM tree of one more driver.
> 
> Cc: Jonas Aaberg <jonas.aberg@stericsson.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

I start working on moving mxs gpio (arch/arm/mach-mxs/gpio.c) into
driver/gpio, and I see the possibility to go a different approach
from U300 one posted here.

The common thing between these two hardwares is there are several
gpio ports implemented in one memory region. And it seems no problem
to treat all these gpio ports as one gpio chip, and we can use
platform data to specify port number, and calculate base address of
each port with shifting start address.  But I do not think this
approach is able to scale comparing to the one that we treat each
port as an independent gpio chip.

Looking at mxc gpio driver, we will see those gpio ports lay at the
discrete memory regions.  One port one chip approach works for both
cases, since sharing one memory region is just a special case of one
port one region case.  And most importantly, it will make gpio driver
clean and easy to see the common pattern among different gpio drivers.

-- 
Regards,
Shawn
