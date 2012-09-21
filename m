From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 21 Sep 2012 16:22:51 +0200
Subject: [RFC PATCH 0/6] pinctrl: samsung: Convert the driver to use per-bank
 GPIO and interrupt specifiers
Message-ID: <1348237377-21299-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a continuation of work focused on improving the pinctrl-samsung
driver.

First part on which this one depends:
[RFC 0/6] pinctrl: samsung: Remove static platform-specific data
http://article.gmane.org/gmane.linux.kernel.samsung-soc/12759

This series attempts to simplify usage of the driver and fix several
problems of current implementation, in particular:

  - Simplifies GPIO pin specification in device tree by using pin
    namespace local to pin bank instead of local to pin controller, e.g.

    	gpios = <&gpj0 3 0>;

    instead of

	gpios = <&pinctrl0 115 0>;

  - Simplifies GPIO interrupt specification in device tree by using
    namespace local to pin bank (and equal to GPIO namespace), e.g.

    	interrupt-parent = <&gpj0>;
	interrupts = <3 0>;

    instead of

	interrupt-parent = <&pinctrl0>;
	interrupts = <115 0>;

  - Simplifies internal GPIO pin to bank translation thanks to
    correspondence of particular GPIO chips to pin banks. This allows
    to remove the (costly in case of GPIO bit-banging drivers) lookup
    over all banks to find the one that the pin is from.

Any comments are welcome.

To do:
  - Bindings documentation
  - Per-bank interrupt specifiers for wake-up interrupts
  - Configuration of pins used as wake-up interrupts to EINT function

Tomasz Figa (6):
  pinctrl: samsung: Hold OF node of pin bank in bank struct
  pinctrl: samsung: Hold pointer to driver data in bank struct
  pinctrl: exynos: Use one IRQ domain per pin bank
  pinctrl: samsung: Do not pass gpio_chip to pin_to_reg_bank
  pinctrl: samsung: Use one GPIO chip per pin bank
  ARM: dts: exynos4210: Update pin bank nodes to reflect per-bank GPIO
    chips and IRQ domains

 arch/arm/boot/dts/exynos4210-pinctrl-banks.dtsi |  72 ++++++++++
 arch/arm/boot/dts/exynos4210.dtsi               |   4 -
 drivers/pinctrl/pinctrl-exynos.c                | 118 +++++------------
 drivers/pinctrl/pinctrl-exynos.h                |  12 --
 drivers/pinctrl/pinctrl-samsung.c               | 168 ++++++++++++++----------
 drivers/pinctrl/pinctrl-samsung.h               |  18 ++-
 6 files changed, 220 insertions(+), 172 deletions(-)

-- 
1.7.12
