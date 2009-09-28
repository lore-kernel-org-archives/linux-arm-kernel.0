From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Sep 2009 21:03:26 +0100
Subject: [PATCH] Make MMCI driver compile without gpiolib
In-Reply-To: <63386a3d0909281200m1da30d22h4ea4fb72278941de@mail.gmail.com>
References: <1251276988-27882-1-git-send-email-linus.walleij@stericsson.com>
	<20090927153108.GA20093@n2100.arm.linux.org.uk>
	<63386a3d0909281200m1da30d22h4ea4fb72278941de@mail.gmail.com>
Message-ID: <20090928200326.GI10671@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2009 at 09:00:01PM +0200, Linus Walleij wrote:
> Hm thinking back at this:
> 
> 2009/9/27 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> 
> > The real problem is that U300 doesn't implement gpio_is_valid() -
> > which is part of the GPIO API and not specific to GPIOLIB.
> 
> None of the GPIO drivers in drivers/gpio implement gpio_is_valid()
> though they all select GPIOLIB which in turn selects GENERIC_GPIO.

include/asm-generic/gpio.h:

#ifdef CONFIG_GPIOLIB
...
/* Platforms may implement their GPIO interface with library code,
 * at a small performance cost for non-inlined operations and some
 * extra memory (for code and for per-GPIO table entries).
 *
 * While the GPIO programming interface defines valid GPIO numbers
 * to be in the range 0..MAX_INT, this library restricts them to the
 * smaller range 0..ARCH_NR_GPIOS-1.
 */

#ifndef ARCH_NR_GPIOS
#define ARCH_NR_GPIOS           256
#endif

static inline int gpio_is_valid(int number)
{
        /* only some non-negative numbers are valid */
        return ((unsigned)number) < ARCH_NR_GPIOS;
}

So, with gpiolib enabled, gpio_is_valid() is predefined assuming that
GPIOs between 0..ARCH_NR_GPIOS are valid.
