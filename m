From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Jul 2014 15:52:02 +0200
Subject: [[RFC PATCH]] gpio: gpio-mxc: make sure gpio is input when
 request IRQ
In-Reply-To: <53D252F5.2060601@tqsc.de>
References: <1405518664-31313-1-git-send-email-list-09_linux_arm@tqsc.de>
 <20140722062803.GA21229@dragon> <53CE107A.1000000@tqsc.de>
 <20140722074257.GC21229@dragon>
 <CACRpkdYxOv+k2Sazm83sA=LwKUv5yMzag44A=Ez8pNQHRO3V6A@mail.gmail.com>
 <53D0C008.70305@tqsc.de>
 <CACRpkdarH_-2uW55C5bAUxM1ESgSb6tJAWc4UqEoWr8uc_kQRQ@mail.gmail.com>
 <53D252F5.2060601@tqsc.de>
Message-ID: <CACRpkdZckrmsG+mOKoZWVH=QqyV0FmDsqUMkbbyi2YJiGFZ5dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 2:52 PM, Markus Niebel
<list-09_linux_arm@tqsc.de> wrote:
> Am 25.07.2014 13:38, wrote Linus Walleij:

>> I don't know if it'd be a good idea to loop over all gpios in a new
>> irqchip and fetch the direction just to get the flags right, so far
>> we haven't done that and I don't know what the usecase would be.
>
> I've came to a situation where it would have been helpful to know - bootloader
> configured a pin as output and linux tried to configure the pin as IRQ input.
> *YES I KNOW THIS IS NOT CORRECT* but it took some time to see, what happened.

Hm, maybe we should call gpiod_get_direction() first in
gpio_lock_as_irq(), so we check the hardware and know there that the
flag is correctly set here?

>> If we need that we should do it in gpiolib for all drivers don't you
>> think?
>
> A pragmatic / lean solution would be to deny the IRQ configuration when
> seeing the pin configured as output in hardware and print out an error
> on the gpio driver level.

I guess that is what I'm suggesting, not sure if I follow
correctly.

Yours,
Linus Walleij
