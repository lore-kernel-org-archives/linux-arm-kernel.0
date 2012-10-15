From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 Oct 2012 22:30:15 +0200
Subject: [PATCH RFC 2/6 v3] gpio: Add sysfs support to block GPIO API
In-Reply-To: <20121015181928.GB27923@kroah.com>
References: <1350069085-13283-1-git-send-email-stigge@antcom.de>
 <1350069085-13283-3-git-send-email-stigge@antcom.de>
 <20121015180702.GA12801@game.jcrosoft.org>
 <20121015181928.GB27923@kroah.com>
Message-ID: <CACRpkdZmg4+7Zjm2UJktt1uKvytUW3uaYtKz0nJvLeM2MMSV-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I really request Grant to comment on this...too.

On Mon, Oct 15, 2012 at 8:19 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Oct 15, 2012 at 08:07:02PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> On 21:11 Fri 12 Oct     , Roland Stigge wrote:
>> > This patch adds sysfs support to the block GPIO API.
>> >
>> > Signed-off-by: Roland Stigge <stigge@antcom.de>
>> >
>> > ---
>> >  Documentation/ABI/testing/sysfs-gpio |    6
>> >  drivers/gpio/gpiolib.c               |  226 ++++++++++++++++++++++++++++++++++-
>> >  include/asm-generic/gpio.h           |   11 +
>> >  include/linux/gpio.h                 |   13 ++
>> >  4 files changed, 254 insertions(+), 2 deletions(-)
>> I really don't like this sysfs we need to add a specific device with ioctl
>
> Why?

I don't like it either, basically because the GPIO sysfs is not
entirely sound.

Another patch that is circulating concerns edge triggers and similar,
and it appear that some parts of the GPIO sysfs is for example
redefining and exporting IRQchip properties like trigger edge
in sysfs, while the settings of the irqchip actually used by the driver
is not reflected in the other direction. So you can *set* these things
by writing in the GPIO sysfs, but never trust what you *read* from
there. And you can set what edges an IRQ will trigger on a certain
GPIO, and the way to handle the IRQs from usespace is to poll
on a value. This is not really documented but well ...

Part of me just want to delete that, but I can't because it's now
an ABI.

The "devices" that the sysfs files are tied to are not real devices,
instead the code look like this: whenever a gpio is exported to
sysfs, the code calls (drivers/gpio/gpiolib.c):

    dev = device_create(&gpio_class, desc->chip->dev, MKDEV(0, 0),
                    desc, ioname ? ioname : "gpio%u", gpio);

Mock device just to get a sysfs opening. And once device for
every GPIO with no hierarchical correspondence to anything
in the system.

The thing is that struct gpio_chip is not a device at all, it's something
else.

This inconsistency in the GPIO sysfs implementation make me
fear adding new stuff to it. The other problems need fixing first.

The reason an ioctl() IMO is better suited to do the job is that
it can properly represent a multiple-value operation on several
GPIOs at the same time in a struct, and it can conversely inform
userspace about which GPIOs may be a block of signals that
can be fired simultaneously instead of going to string parsing
and binary values in sysfs which look like worse hacks to me.

The last thing I'm a bit softer on though. Mainly I fear of this
sysfs ABI growing into a beast.

It was all merged prior to Grant becoming maintainer and
me becoming co-maintainer of it, so this is legacy business.

Sadly the main creator of this ABI is David Brownell who is
not able to respond nor maintain it from where he is now. But
we need to think hard about what we shall do with this particular
piece of legacy. Some of the stuff was added by Daniel
Gl?ckner so requesting advice from him.

Daniel: are you interested in helping us fixing the GPIOlib
sysfs ABI and kernel internals? I'm a bit afraid of it.

Yours,
Linus Walleij
