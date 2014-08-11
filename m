From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Aug 2014 10:43:39 +0200
Subject: [PATCH 4/4] gpio: pca953x: Add DT binding for reset gpio
In-Reply-To: <1407507094.3354.11.camel@paszta.hi.pengutronix.de>
References: <1406618686-22385-1-git-send-email-mpa@pengutronix.de>
 <1406618686-22385-5-git-send-email-mpa@pengutronix.de>
 <CACRpkdY0TqVH1tJR1H89S5hvdJUboQdVtNvZnL3NeWit4f+amw@mail.gmail.com>
 <1407507094.3354.11.camel@paszta.hi.pengutronix.de>
Message-ID: <CACRpkdY1x41=b_q83fejkTHXGG8GYDFNRUXdt=1AR_R4N18Rwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 8, 2014 at 4:11 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Am Freitag, den 08.08.2014, 15:14 +0200 schrieb Linus Walleij:
>> On Tue, Jul 29, 2014 at 9:24 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
>>
>> > The pca953x has a negated reset input. This patch adds a DT binding for
>> > the reset gpio and resets the chip when it is probed. This will reset
>> > the device and leave the gpio in the correct state so reset is not
>> > triggered.
>> >
>> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
>>
>> Why on earth should this be in the GPIO driver?
>>
>> The driver should be in drivers/reset/reset-gpio.c and you
>> should provide a separate driver for it.
>
> I still think we should keep using the reset-gpios binding for simple
> cases like this; I see no reason to add a separate device to the device
> tree for a single GPIO.

In any case you have to propose something generic that
happens in drivers/gpio/gpiolib.c at the end of the
gpiochip_add() function, because this will likely appear in
many other systems.

The binding should also be generic in
Documentation/devicetree/bindings/gpio/gpio.txt
not for just this driver.

>> As it happens, Houcheng Lin has already proposed such a
>> driver:
>> http://marc.info/?l=linux-kernel&m=140309916607115&w=2
>
> That is a different issue, as there the device does not appear on the
> bus until the reset is released.

You're just looking at the patch description. Look at what the
driver does.

I wrote this reply to the patch:
http://marc.info/?l=linux-kernel&m=140480593524472&w=2

With a delay of zero, the reset will be released
immediately, by the use of a helper OF node and this driver
from the reset subsystem. It's nice, generic code that solves
a generic problem of deasserting GPIO lines for
some reset.

Yours,
Linus Walleij
