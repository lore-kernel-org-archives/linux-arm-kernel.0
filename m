From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 16 Mar 2016 11:38:51 +0100
Subject: [linux-sunxi] Re: [PATCH 0/4] Add AXP209 GPIO driver
In-Reply-To: <CACRpkdZUJsqCG=dd9XdwxaAHxEHXgrZncH+DqtPYta4a30v87w@mail.gmail.com>
References: <1457520614-32239-1-git-send-email-maxime.ripard@free-electrons.com>
 <56E0146E.6050102@redhat.com> <20160309152822.GQ8418@lukather>
 <56E044C1.7080300@redhat.com>
 <CACRpkdZUJsqCG=dd9XdwxaAHxEHXgrZncH+DqtPYta4a30v87w@mail.gmail.com>
Message-ID: <56E937BB.5020706@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 16-03-16 11:10, Linus Walleij wrote:
> On Wed, Mar 9, 2016 at 4:44 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>>> On Wed, Mar 09, 2016 at 01:17:50PM +0100, Hans de Goede wrote:
>
>>> Eventually, yes, it needs both. But they don't even have to be the
>>> same driver, since they provide two different features. The only
>>> reason we have that construct in the pio case is because they share
>>> the same address space, but in the AXP case, the regmap and our mfd
>>> take care of that already.
>>
>> Hmm, so your suggesting to have mfd instantiate 2 platform devices
>> for this, a gpio and a pinctrl device, each with their own
>> driver. Yes that would work, but I'm a bit worried about the 2
>> racing or some such since they both will end up touching
>> bit 0-2 of register 0x90 / 0x92, more-over since they are both
>> touching the exact same bits I've the feeling that this really
>> should be one driver.
>
> We can put the driver in drivers/pinctrl/pinctrl-axp209.c from day
> one, add in comments stating that it only implements GPIO
> for now and that the GPIO portion must call
> pinctrl_request_gpio() and the pin controller must implement
> .gpio_request_enable() the day it is added so the GPIOs do
> not conflict with other use of the pins.
>
> Requireing a huge slew of upfront code is a bit hard on simple
> drivers I think.
>
> Also we have the solution in drivers/mfd/stmpe.c that just add
> a simple mux code when pins on mixsigs or simple expanders
> can just mux some two-three different functions, then I think
> pin control may be a bit too thick overhead. (Not sure where
> the limit is though.)

I actually found out this weekend, that we already have
a problem here. Regulator on/off is implemented as
2 mux settings, just like gpio high/low/input are mux settings:

On the axp209 the gpio pin mux bit table looks like this:

000: low output
001: output (3.3V)
010: universal input function
011: low noise LDO5
100: ADC input
1XX: floating

And on the axp221 / axp223:

000: output low
001: output high (3.3V)
010: input
011: LDOIO0 off
100: LDOIO0 on
1XX: floating

Note the LDOIO0 off / LDOIO0 on being 2 different mux
settings, and then existing axp20x regulator driver for
LD05 / LDOIO0 actually already implements regulator on / off
by changing the mux for both axp209 and axp22x.

This results in the following potentially happening.

0) kernel boots

1) The gpio driver is in use for these pins, sets the pin
to say output low

2) kernel is ready to start init, calls the regulators
subsys late_init call, which disables any unused regulators,
this results in the mux getting set to 7 (axp209) resp
4 (axp22x), and the gpio is no longer driven low as
the intend of the driver using the pin was.

So we really need either some coordination here, or a way
to tell the regulator-driver to not register ldo5 / ldoio#
at all, so that the regulator-core won't try to turn them
off changing the mux.

I've submitted a patch series this weekend which allows
putting "status = disabled" in regulator child-dts-nodes, which
will then result in not registering a regulator at all,
which would fix that. But that series has not received any
feedback yet...

Regards,

Hans
