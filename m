From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 11 Oct 2012 10:11:06 +0200
Subject: [PATCH v2 00/15] pinctrl: samsung: Usability and extensibiltiy
 improvements
Message-ID: <1349943081-27939-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is a work on improving usability and extensibiltiy of
the pinctrl-samsung driver. It consists of three main parts:
 - improving flexibility of SoC-specific data specification
 - converting the driver to one GPIO chip and IRQ domain per pin bank
 - improving wake-up IRQ setup and handling

1) What the first part does, in addition to various related fixes, is
removing any unnecessary static data from pinctrl-exynos driver.

This is achieved mostly thanks to assigning pin numbers dynamically,
with help of only pin counts of particular banks. It also simplifies
adding next SoC variants, since much less static data needs to be
specified.

2) The second part attempts to simplify usage of the driver and fix several
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

3) Third part is focused on removing the hard-coded description of wake-up
interrupt layout.

It moves wake-up interrupt description to bank struct and device tree,
which allows to specify which pin banks support wake-up interrupts and
how they are handled (direct or multiplexed/chained).

See particular patches for more detailed descriptions and the last patch for
updated device tree bindings.

Changes since v1:
 - dropped moving SoC-specific data to device tree
   (might be added in further patches)
 - dropped per-bank specification of configuration register offsets
   (thus limiting scope of the driver to Exynos SoCs; will be added in
    further patches)

Tomasz Figa (15):
  pinctrl: samsung: Detect and handle unsupported configuration types
  pinctrl: samsung: Do not pass gpio_chip to pin_to_reg_bank
  pinctrl: samsung: Assing pin numbers dynamically
  pinctrl: samsung: Remove static pin enumerations
  pinctrl: samsung: Distinguish between pin group and bank nodes
  ARM: dts: exynos4210-pinctrl: Add nodes for pin banks
  pinctrl: samsung: Match pin banks with their device nodes
  pinctrl: samsung: Hold pointer to driver data in bank struct
  pinctrl: samsung: Include bank-specific eint offset in bank struct
  pinctrl: exynos: Use one IRQ domain per pin bank
  pinctrl: samsung: Use one GPIO chip per pin bank
  pinctrl: samsung: Use per-bank IRQ domain for wake-up interrupts
  pinctrl: exynos: Set pin function to EINT in irq_set_type of wake-up
    EINT
  pinctrl: samsung: Add GPIO to IRQ translation
  Documentation: Update samsung-pinctrl device tree bindings
    documentation

 .../bindings/pinctrl/samsung-pinctrl.txt           | 118 +++++--
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi          | 278 ++++++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi                  | 241 +-------------
 drivers/pinctrl/pinctrl-exynos.c                   | 367 ++++++++++-----------
 drivers/pinctrl/pinctrl-exynos.h                   | 170 ++--------
 drivers/pinctrl/pinctrl-samsung.c                  | 203 ++++++++----
 drivers/pinctrl/pinctrl-samsung.h                  |  29 +-
 7 files changed, 741 insertions(+), 665 deletions(-)

-- 
1.7.12
