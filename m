From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 5 Aug 2012 01:46:25 +0200
Subject: Sharing resources between several drivers.
In-Reply-To: <201207291419.52526.arnd@arndb.de>
References: <CACKLOr2enmsVqQnJ8JZJJd3z3gGKDKwj74PnWKEk6SwSN=ZoJw@mail.gmail.com>
 <201207291419.52526.arnd@arndb.de>
Message-ID: <CACRpkda8Y1oDP0oQSYH2e5qT=VPGXMop-_FWUS9-XjL3b=WE_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 29, 2012 at 4:19 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 27 July 2012, javier Martin wrote:
>>
>> What is the right way to request the same memory region from two
>> different drivers? Moreover, how can we guarantee that there won't be
>> any conflicts when accessing these shared resources?
>
> I think the method that Linus Walleij usually recomments for dealing with
> this is to create a combined gpio+pinctrl driver that lives in
> drivers/pinctrl but registers to gpiolib as well.

Yepps.

> Have a look at drivers/pinctrl/pinctrl-nomadik.c for an example of this.

What this and many other drivers run into is the problem of mappings
between GPIOs and pin controller ranges (GPIO ranges).

Currently these are registered by the pin controller and may need
access to the struct gpio_chip which creates an "interesting"
probe order problem. But it can be solved (in not-so-elegant ways).

Long term we want to turn this upside down and have the GPIO
driver portion register it's ranges to the pin controller instead,
using local range GPIO numbers.

Yours,
Linus Walleij
