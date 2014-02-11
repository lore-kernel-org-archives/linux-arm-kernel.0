From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 11 Feb 2014 18:45:11 +0100
Subject: [PATCH v2 0/4] tty/serial: Add helpers to use GPIOs to control modem
 lines
Message-ID: <1392140715-15295-1-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USART controller on sam9x5 chips (and also all AT91/SAMA5 chips
but at91rm9200) are not capable of handling DTR/DSR/DCD/RI signal.
Moreover, even if the controller can handle CTS/RTS, the dedicated
CTS/RTS pins are already muxed for other peripherals (LCDC/EMAC/MMC).

So this patchset adds the possibility to control those lines via GPIO,
as it is done for RTS in the patch "switch atmel serial to use gpiolib"

As it was suggested by Alexander Shiyan, I made that available for
every board.

This is based on 3.14-rc2 + Linus Walleij/Nicolas Ferre's patch:
 354e57f3a0a2 ARM/serial: at91: switch atmel serial to use gpiolib
(in Uwe's tree git://git.pengutronix.de/git/ukl/linux.git dropmachtimexh )
and Philipp Zabel's patch:
gpiolib: make gpiod_direction_output take a logical value, add gpiod_direction_output_raw
(there won't be a merge conflict if this last patch is not present, the
gpios will "just" be on the wrong direction.)
 
Tested on at91sam9g35, with a null modem cable between 2 serial ports,
one with CTS/RTS controlled by the USART controller, the other via GPIO,
full duplex transfers.
Did some tests also with null modem cables on a PC.

Updates from v2:
	- Instead of controlling modem signal only on atmel board, the
	code is now available for every board.
	- The active low flag from device tree is now used.

Richard Genoud (4):
  tty/serial: Add GPIOLIB helpers for controlling modem lines
  tty/serial: at91: use dev_err instead of printk
  tty/serial: at91: remove unused open/close hooks
  tty/serial: at91: use mctrl_gpio helpers

 .../devicetree/bindings/serial/atmel-usart.txt     |  12 +-
 Documentation/serial/driver                        |  21 ++
 arch/arm/mach-at91/at91rm9200_devices.c            |  25 ++
 arch/arm/mach-at91/at91sam9260_devices.c           |  35 +++
 arch/arm/mach-at91/at91sam9261_devices.c           |  20 ++
 arch/arm/mach-at91/at91sam9263_devices.c           |  20 ++
 arch/arm/mach-at91/at91sam9g45_devices.c           |  25 ++
 arch/arm/mach-at91/at91sam9rl_devices.c            |  25 ++
 drivers/tty/serial/Kconfig                         |   4 +
 drivers/tty/serial/Makefile                        |   3 +
 drivers/tty/serial/atmel_serial.c                  | 313 +++++++++++++++++----
 drivers/tty/serial/serial_mctrl_gpio.c             | 113 ++++++++
 drivers/tty/serial/serial_mctrl_gpio.h             |  56 ++++
 include/linux/platform_data/atmel.h                |   5 +
 14 files changed, 615 insertions(+), 62 deletions(-)
 create mode 100644 drivers/tty/serial/serial_mctrl_gpio.c
 create mode 100644 drivers/tty/serial/serial_mctrl_gpio.h

-- 
1.8.5
