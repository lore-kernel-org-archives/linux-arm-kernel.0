From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Thu, 14 Dec 2017 15:21:31 +0100
Subject: [RFC PATCH 0/7] gpiolib: add bias support
Message-ID: <20171214142138.23008-1-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is an attempt to add the bias configuration to the gpiolib since
I want and need to enable the pinmuxing strict mode to get an error if
I request a GPIO which is used by a peripheral.

I have not monitored the gpio mailing list for a while. Sorry I may have
missed some discussions about this topic. In this case, let me know which
threads I should read.

I have a memory of a discussion about the pinmux strict mode and the
constraints related to it. Several pin controllers can mux a pin as a GPIO
or as a peripheral. Doing both is not possible, so the strict mode may or
must be enabled. Unfortunately, to perform the pin configuration of the GPIO,
such as the bias (pull up, pull down, disabled), we have to declare this pin
in the pinmuxing. Doing this leads to a conflict when the device requests the
GPIO. The owner of the pin is the device which requested the pinmuxing whereas
the owner of the GPIO is the pin controller.

To solve this, there are two solutions:
- fix this owner mismatching. The owner of the GPIO must be the requester. It's
not difficult to solve this issue if we add the requester as a parameter when
the GPIO is requested but it impacts a lot of code.
- allow the gpiolib to set the pin configuration. I think the main issue
was code duplication. Since I have seen the introduction of
gpiochip_generic_config(), gpiod_set_debounce(), I suppose it's the way to go.

I have not introduced a gpiod_set_bias() because I think the only place to
setup this is in the device tree. It's useless to setup a bias pull up if there
is an external pull up on the board.

Ludovic Desroches (7):
  gpio: of: use the BIT macro for of_gpio_flags
  gpio: gpiolib: split the gpiod_configure_flags function
  gpio: gpiolib: save GPIO flags in of_get_named_gpiod_flags
  gpio: gpiolib: add bias support
  pinctrl: at91-pio4: allow the gpiolib to set pin configuration
  pinctrl: at91-pio4: use strict mode if explicitly requested
  ARM: dts: remove gpio from pinmux

 .../bindings/pinctrl/atmel,at91-pio4-pinctrl.txt   |  4 ++
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        | 45 ++----------
 drivers/gpio/gpiolib-of.c                          | 11 +++
 drivers/gpio/gpiolib.c                             | 81 ++++++++++++++++------
 drivers/gpio/gpiolib.h                             | 10 ++-
 drivers/pinctrl/pinctrl-at91-pio4.c                | 26 ++++++-
 include/dt-bindings/gpio/gpio.h                    |  9 +++
 include/linux/gpio/machine.h                       |  3 +
 include/linux/of_gpio.h                            | 12 ++--
 9 files changed, 134 insertions(+), 67 deletions(-)

-- 
2.12.2
