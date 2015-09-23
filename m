From: johan@kernel.org (Johan Hovold)
Date: Wed, 23 Sep 2015 15:20:51 -0700
Subject: [PATCH 5/6] gpiolib-sysfs: Show gpio-name in
 /sys/class/gpio/gpio*/name
In-Reply-To: <CACRpkdZCSwWUuhbe2+nrEPTRnqNGvJrrbZLDwy8fkHeEJDujUg@mail.gmail.com>
References: <1438680203-13432-1-git-send-email-mpa@pengutronix.de>
 <1438680203-13432-6-git-send-email-mpa@pengutronix.de>
 <CACRpkdZCSwWUuhbe2+nrEPTRnqNGvJrrbZLDwy8fkHeEJDujUg@mail.gmail.com>
Message-ID: <20150923222051.GD19608@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 10, 2015 at 11:50:16AM +0200, Linus Walleij wrote:
> On Tue, Aug 4, 2015 at 11:23 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> 
> > This patch adds a sysfs attribute 'name' to gpios that were exported. It
> > exposes the newly added name property of gpio descriptors.
> >
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> 
> This needs to also patch Documentation/ABI/testing/sysfs-gpio
> if we should go with it. It says this:
> 
>     /sys/class/gpio
>         /export ... asks the kernel to export a GPIO to userspace
>         /unexport ... to return a GPIO to the kernel
>         /gpioN ... for each exported GPIO #N
>             /value ... always readable, writes fail for input GPIOs
>             /direction ... r/w as: in, out (default low); write: high, low
>             /edge ... r/w as: none, falling, rising, both
> 
> Anyways I don't know if this is right, and that ABI doc is also lying.
> 
> Look at this in gpiolib-sysfs.c:
>
>         if (chip->names && chip->names[offset])
>                 ioname = chip->names[offset];
> 
>         dev = device_create_with_groups(&gpio_class, chip->dev,
>                                         MKDEV(0, 0), data, gpio_groups,
>                                         ioname ? ioname : "gpio%u",
>                                         desc_to_gpio(desc));
> 
> I.e. what the ABI doc say about the dirs being named "gpioN" is
> a plain lie, it can have a descriptive name as its directory  name
> under /sys/class/gpio/foo-line or so.
> 
> Since this already exist and is a flat namespace ... we should
> use that.
> 
> However it has the implication like I said before that two names
> cannot be the same. I think Johan's comment that they could
> be non-unique did not take into account the fact that two chips
> could use the same .names array (and that would already fail,
> by the way) so the .names in the struct gpio_chip *MUST* be
> unique as compared to all other names.

It's is unfortunate that we need to potentially maintain this forever,
but it does not mean that we should not allow non-unique names in DT
going forward.

> We *could* deprecate the old line naming mechanism (that create
> dirs named after the pin), and from here on only use gpioN and
> "name" in a separate file like this patch does. However that is
> not really OK either: we want to move away from the GPIO numbers
> and to descriptors and descriptive names, so I currently feel
> we should name the directories after the line instead, and
> require them to be unique.

We have already moved away from the numbers through the introduction of
descriptors. What remains to define is a sane userspace interface. Until
then, let the sysfs-interface be as cumbersome to use as it always has
rather than introducing more (intermediate) ABI to maintain.

Johan
