From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 Mar 2016 11:10:21 +0100
Subject: [linux-sunxi] Re: [PATCH 0/4] Add AXP209 GPIO driver
In-Reply-To: <56E044C1.7080300@redhat.com>
References: <1457520614-32239-1-git-send-email-maxime.ripard@free-electrons.com>
 <56E0146E.6050102@redhat.com> <20160309152822.GQ8418@lukather>
 <56E044C1.7080300@redhat.com>
Message-ID: <CACRpkdZUJsqCG=dd9XdwxaAHxEHXgrZncH+DqtPYta4a30v87w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 9, 2016 at 4:44 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> On Wed, Mar 09, 2016 at 01:17:50PM +0100, Hans de Goede wrote:

>> Eventually, yes, it needs both. But they don't even have to be the
>> same driver, since they provide two different features. The only
>> reason we have that construct in the pio case is because they share
>> the same address space, but in the AXP case, the regmap and our mfd
>> take care of that already.
>
> Hmm, so your suggesting to have mfd instantiate 2 platform devices
> for this, a gpio and a pinctrl device, each with their own
> driver. Yes that would work, but I'm a bit worried about the 2
> racing or some such since they both will end up touching
> bit 0-2 of register 0x90 / 0x92, more-over since they are both
> touching the exact same bits I've the feeling that this really
> should be one driver.

We can put the driver in drivers/pinctrl/pinctrl-axp209.c from day
one, add in comments stating that it only implements GPIO
for now and that the GPIO portion must call
pinctrl_request_gpio() and the pin controller must implement
.gpio_request_enable() the day it is added so the GPIOs do
not conflict with other use of the pins.

Requireing a huge slew of upfront code is a bit hard on simple
drivers I think.

Also we have the solution in drivers/mfd/stmpe.c that just add
a simple mux code when pins on mixsigs or simple expanders
can just mux some two-three different functions, then I think
pin control may be a bit too thick overhead. (Not sure where
the limit is though.)

Yours,
Linus Walleij
