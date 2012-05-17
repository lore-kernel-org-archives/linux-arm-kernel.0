From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 17 May 2012 15:35:01 +0800
Subject: =?UTF-8?q?=5BPATCH=200/2=5D=20Fix=20basic=5Fmmio=5Fgpio=20shadow=20initialization?=
Message-ID: <1337240103-4756-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I recently ran into a problem with gpio-generic driver on mxs platform.
It turns out it's the exactly same problem that Lothar had run into
on imx/mxc platform, which was fixed up in gpio-mxc driver as below.

commit fb1492186276ba52d99b58121b8a9a87f20cc9f3
Author: Lothar Wa?mann <LW@KARO-electronics.de>
Date:   Thu Jul 7 14:50:16 2011 +0200

    gpio/mxc: add missing initialization of basic_mmio_gpio shadow variables

    The bgpio_init() function does not initialise the shadow register for
    the GPIO direction register. Thus, when configuring the first GPIO with
    gpio_set_direction() all other GPIOs of the same bank will be
    configured as inputs. Since the bgpio layer cannot know whether the
    register is readable, the initialisation should be done by the caller
    of bgpio_init().

    Also, the 'data' shadow variable that is used inside basic_mmio_gpio
    to cache the current value of the GPIO_DR register is initialised from
    the GPIO_PSR register within bgpio_init(). Thus when setting the
    output value of a certain GPIO, the other GPIO outputs of the same
    bank will be set or cleared depending on the pin state of the GPIO
    inputs during bgpio_init().

I think it's a problem of gpio-generic rather than platform specific
driver, so I'm coming up this series to have the problem fixed in
gpio-generic driver itself and then removes the fixup in gpio-mxc.
Thus, other platform gpio drivers based on gpio-generic do not have to
suffer from the same problem and fix it up in individually over and
over again.

Per suggestion from Lothar, I'm copying the maintainers of those
platform gpio drivers using gpio-generic to inform the default behavior
changing on gpio-generic.  Please let me know if anyone gets impacted
by the changes.

Regards,
Shawn

Shawn Guo (2):
  gpio/generic: initialize basic_mmio_gpio shadow variables properly
  gpio/mxc: remove basic_mmio_gpio shadow fixup

 drivers/gpio/gpio-generic.c |    4 ++++
 drivers/gpio/gpio-mxc.c     |    2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
1.7.5.4
